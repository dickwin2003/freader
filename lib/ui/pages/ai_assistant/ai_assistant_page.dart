import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:freader/data/entities/book.dart' as dto;
import 'package:freader/data/entities/book_chapter.dart' as dto;
import 'package:freader/providers/book_providers.dart';
import 'package:freader/providers/llm_providers.dart';
import 'package:freader/service/llm/llm_service.dart';
import 'package:freader/service/local_file_reader.dart';
import 'package:freader/service/ocr/ocr_service.dart';
import 'package:freader/service/dev/app_logger.dart';
import 'package:freader/ui/pages/settings/ai_settings_page.dart';

/// AI 阅读助手 - 基于当前/最近在读的书，提供章节速读、全书梗概、自由问答。
class AiAssistantPage extends ConsumerStatefulWidget {
  const AiAssistantPage({super.key});

  @override
  ConsumerState<AiAssistantPage> createState() => _AiAssistantPageState();
}

class _AiAssistantPageState extends ConsumerState<AiAssistantPage> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [];
  bool _sending = false;
  bool _ocring = false;

  // 阅读上下文
  bool _loadingContext = true;
  String? _contextError;
  dto.Book? _book;
  String? _chapterTitle;
  String? _chapterText; // 已截断的当前章节正文

  @override
  void initState() {
    super.initState();
    _resolveContext();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// 解析最近在读的书与当前章节正文
  Future<void> _resolveContext() async {
    setState(() {
      _loadingContext = true;
      _contextError = null;
      _book = null;
      _chapterTitle = null;
      _chapterText = null;
    });
    try {
      final books = await ref.read(bookRepositoryProvider).getBookshelf();
      if (books.isEmpty) {
        setState(() {
          _contextError = '书架为空，先把书加入书架并读一会儿吧';
          _loadingContext = false;
        });
        return;
      }
      final book = books.first; // 已按 durChapterTime DESC 排序
      if (LocalFileReader.isPdfFile(book.bookUrl)) {
        setState(() {
          _book = book;
          _contextError = '暂不支持 PDF 内容提取，AI 助手无法读取 PDF 正文';
          _loadingContext = false;
        });
        return;
      }

      final chapters = await ref.read(bookActionsProvider).loadChapterList(book);
      if (chapters.isEmpty) {
        setState(() {
          _book = book;
          _contextError = '无法获取这本书的章节列表';
          _loadingContext = false;
        });
        return;
      }
      final idx = book.durChapterIndex.clamp(0, chapters.length - 1);
      final chapter = chapters[idx];
      var text = (await _loadChapterText(book, chapter)) ?? '';
      // 端侧模型内存/上下文有限：大书截短，降低 OOM 崩溃风险
      if (text.length > 4000) text = text.substring(0, 4000);

      setState(() {
        _book = book;
        _chapterTitle = chapter.title;
        _chapterText = text;
        _loadingContext = false;
      });
    } catch (e) {
      setState(() {
        _contextError = '加载阅读上下文失败: $e';
        _loadingContext = false;
      });
    }
  }

  /// 按书籍来源/本地格式取当前章节干净正文
  Future<String?> _loadChapterText(
      dto.Book book, dto.BookChapter chapter) async {
    try {
      if (!book.local) {
        return await ref.read(bookActionsProvider).loadContent(book, chapter);
      }
      final path = book.bookUrl;
      if (LocalFileReader.isTextFile(path)) {
        final r = await LocalFileReader.readTextContent(path,
            knownCharset: book.charset);
        return LocalFileReader.extractChapterContent(r.content, chapter);
      }
      if (LocalFileReader.isEpubFile(path)) {
        final parsed = await LocalFileReader.parseEpub(path);
        return await LocalFileReader.readEpubChapterContent(
            parsed.epubBook, chapter.url);
      }
      if (LocalFileReader.isMobiFile(path)) {
        final parsed = await LocalFileReader.parseMobi(path);
        return LocalFileReader.readMobiChapterContent(parsed.mobiBook, chapter.url);
      }
    } catch (_) {}
    return null;
  }

  String _buildContext() {
    final b = _book;
    if (b == null || _chapterText == null || _chapterText!.isEmpty) return '';
    final intro = (b.intro ?? '').trim();
    return [
      '【当前阅读上下文】',
      '书名：${b.name}',
      '作者：${b.author}',
      if (intro.isNotEmpty) '简介：$intro',
      '当前章节：${_chapterTitle ?? b.durChapterTitle ?? ''}',
      '正文：',
      _chapterText!,
    ].join('\n');
  }

  Future<void> _send(String text) async {
    final userText = text.trim();
    if (userText.isEmpty || _sending) return;

    if (!ref.read(llmReadyProvider)) {
      _snack('请先到「我的 → AI 设置」配置或下载模型');
      return;
    }

    // 拼装 prompt：首轮带阅读上下文 + 近 3 轮历史（多轮记忆，云/本地通用）
    final buf = StringBuffer();
    if (_messages.isEmpty) {
      final ctx = _buildContext();
      if (ctx.isNotEmpty) {
        buf.writeln(ctx);
        buf.writeln();
      }
    }
    final history = _messages.length > 6
        ? _messages.sublist(_messages.length - 6)
        : _messages;
    for (final m in history) {
      buf.writeln(m.isUser ? '用户：${m.text}' : '助手：${m.text}');
      buf.writeln();
    }
    buf.writeln('用户：$userText');
    final prompt = buf.toString();

    setState(() {
      _messages.add(_ChatMessage(true, userText));
      _sending = true;
    });
    _scrollToBottom();

    try {
      final reply = await ref
          .read(llmServiceProvider)
          .chat(userPrompt: prompt);
      if (mounted) {
        setState(() => _messages.add(_ChatMessage(false, reply)));
        _scrollToBottom();
      }
    } on LlmException catch (e) {
      if (mounted) {
        setState(() => _messages.add(_ChatMessage(false, '⚠️ ${e.message}')));
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _messages.add(_ChatMessage(false, '⚠️ 发生错误: $e')));
        _scrollToBottom();
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  /// 拍照/选图 → OCR(ML Kit) 提取文字 → 填入输入框（不走大模型）
  Future<void> _ocrToInput() async {
    final picker = ImagePicker();
    appLog('选图(助手): 打开相册', persistImmediately: true);
    final XFile? xfile;
    try {
      xfile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1280,
        maxHeight: 1280,
        imageQuality: 85,
      );
    } catch (e, st) {
      appLog('选图(助手)异常: $e\n$st', level: LogLevel.error, persistImmediately: true);
      rethrow;
    }
    appLog('选图(助手)完成: ${xfile?.path}', persistImmediately: true);
    if (xfile == null) return;
    setState(() => _ocring = true);
    try {
      final text = await ref.read(ocrServiceProvider).recognize(xfile.path);
      if (text.isEmpty) {
        _snack('没识别到文字，换张更清晰的图');
      } else {
        setState(() => _inputController.text =
            _inputController.text.isEmpty ? text : '${_inputController.text}\n$text');
      }
    } catch (e) {
      _snack('OCR 失败: $e');
    } finally {
      if (mounted) setState(() => _ocring = false);
    }
  }

  /// 发送当前输入框文本
  Future<void> _submit() async {
    final text = _inputController.text.trim();
    if (text.isEmpty || _sending) return;
    _inputController.clear();
    await _send(text);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI 阅读助手'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '刷新上下文',
            onPressed: _loadingContext ? null : _resolveContext,
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'AI 设置',
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AiSettingsPage())),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildContextBar(),
          Expanded(child: _buildBody()),
          _buildInputBar(),
        ],
      ),
    );
  }

  /// 顶部上下文信息条
  Widget _buildContextBar() {
    if (_loadingContext) {
      return const ListTile(
        dense: true,
        leading: SizedBox(
            width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
        title: Text('正在加载阅读上下文...'),
      );
    }
    if (_book != null) {
      return Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.secondaryContainer,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(Icons.menu_book,
                size: 18, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _contextError != null
                    ? _contextError!
                    : '${_book!.name} · ${_chapterTitle ?? _book!.durChapterTitle ?? ''}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildBody() {
    if (_loadingContext) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_contextError != null && _messages.isEmpty && _book == null) {
      // 无书的空状态
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_stories_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.outlineVariant),
            const SizedBox(height: 16),
            Text(_contextError!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline)),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AiSettingsPage())),
              child: const Text('去配置 AI'),
            ),
          ],
        ),
      );
    }
    if (_messages.isEmpty) {
      return _buildSuggestions();
    }
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      itemCount: _messages.length,
      itemBuilder: (context, index) => _buildBubble(_messages[index]),
    );
  }

  /// 空对话时的快捷动作建议
  Widget _buildSuggestions() {
    final actions = [
      ('本章速读', '请对本章生成 5 条要点速读。', Icons.bolt_outlined),
      ('全书梗概', '请基于当前已知信息，生成这本书的整体梗概（信息不足时请说明）。',
          Icons.summarize_outlined),
      ('人物梳理', '请梳理当前章节出现的主要人物及其关系。', Icons.groups_outlined),
    ];
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome_outlined,
                size: 56,
                color: Theme.of(context).colorScheme.outlineVariant),
            const SizedBox(height: 16),
            Text('问问关于这本书的内容',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline)),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                ...actions.map((a) => ActionChip(
                      avatar: Icon(a.$3, size: 18),
                      label: Text(a.$1),
                      onPressed: () => _send(a.$2),
                    )),
                ActionChip(
                  avatar: _ocring
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.document_scanner_outlined, size: 18),
                  label: const Text('拍照取字'),
                  onPressed: _ocring ? null : _ocrToInput,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBubble(_ChatMessage msg) {
    final isUser = msg.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        decoration: BoxDecoration(
          color: isUser
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
        ),
        child: SelectableText(
          msg.text,
          style: TextStyle(
            color: isUser
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    minLines: 1,
                    maxLines: 5,
                    textInputAction: TextInputAction.send,
                    decoration: const InputDecoration(
                      hintText: '问点什么...',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _submit(),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton.filled(
                  onPressed: _sending ? null : _submit,
                  icon: _sending
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  final bool isUser;
  final String text;
  _ChatMessage(this.isUser, this.text);
}
