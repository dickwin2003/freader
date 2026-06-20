// ignore_for_file: experimental_member_use

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freader/data/entities/book.dart' as dto;
import 'package:freader/data/entities/book_chapter.dart' as dto;
import 'package:freader/data/entities/bookmark.dart' as bookmark_dto;
import 'package:freader/providers/book_providers.dart';
import 'package:freader/providers/bookmark_providers.dart';
import 'package:freader/service/dev/app_logger.dart';
import 'package:freader/service/tts/edge_tts_service.dart';
import 'package:freader/ui/pages/settings/read_config_page.dart';
import 'package:freader/service/local_file_reader.dart';
import 'package:freader/service/mobi/mobi_book.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:freader/ui/theme/app_theme.dart';

/// 阅读器页面
class ReaderPage extends ConsumerStatefulWidget {
  final dto.Book book;
  final List<dto.BookChapter> chapters;
  final int startIndex;
  final String? localContent;
  final bool isEpubFile;
  final dynamic epubBook;
  final bool isPdfFile;
  final bool isMobiFile;
  final dynamic mobiBook;

  const ReaderPage({
    super.key,
    required this.book,
    required this.chapters,
    required this.startIndex,
    this.localContent,
    this.isEpubFile = false,
    this.epubBook,
    this.isPdfFile = false,
    this.isMobiFile = false,
    this.mobiBook,
  });

  @override
  ConsumerState<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends ConsumerState<ReaderPage> {
  late int _currentChapterIndex;
  String _content = '';
  List<String> _contentParagraphs = []; // 按段落拆分，支持懒加载渲染
  bool _isLoading = true;
  String? _error;
  PdfViewerController? _pdfController; // pdfrx 控制器
  Timer? _pdfSaveDebounce; // PDF 滚动保存去抖
  int _currentPdfPage = 1; // PDF 当前页（1-based，pdfrx 原生语义）

  bool _showMenu = false;
  bool _showSettings = false;
  bool _showToc = false;
  bool _tocShowBookmarks = false;

  double _fontSize = 18.0;
  double _lineHeight = 1.8;
  Color _bgColor = const Color(0xFFFFFDE7);
  Color _textColor = const Color(0xFF212121);

  // 朗读
  final AudioPlayer _ttsPlayer = AudioPlayer();
  FlutterTts? _sysTts; // Edge 失败时回退系统 TTS
  bool _preparingSpeech = false;
  bool _isSpeaking = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentChapterIndex = widget.startIndex;
    _scrollController.addListener(_onScroll);
    _loadReadConfig();
    _loadContent();
  }

  /// 滑到本章底部 → 自动加载下一章（连续阅读）
  void _onScroll() {
    if (_isLoading || !_scrollController.hasClients) return;
    if (_currentChapterIndex >= widget.chapters.length - 1) return; // 末章
    final pos = _scrollController.position.pixels;
    final max = _scrollController.position.maxScrollExtent;
    if (max > 0 && pos >= max - 24) {
      _nextChapter();
    }
  }

  /// 读取全局阅读配置（字号/行距/背景），让「我的→阅读配置」真正生效
  Future<void> _loadReadConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!mounted) return;
      setState(() {
        _fontSize = prefs.getDouble(ReadConfigKeys.fontSize) ?? 18.0;
        _lineHeight = prefs.getDouble(ReadConfigKeys.lineHeight) ?? 1.8;
        final bg = prefs.getInt(ReadConfigKeys.bgColor);
        _bgColor = bg != null ? Color(bg) : const Color(0xFFFFFDE7);
      });
    } catch (_) {}
  }

  /// 持久化当前阅读配置（字号/行距/背景）
  Future<void> _saveReadConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(ReadConfigKeys.fontSize, _fontSize);
      await prefs.setDouble(ReadConfigKeys.lineHeight, _lineHeight);
      await prefs.setInt(ReadConfigKeys.bgColor, _bgColor.toARGB32());
    } catch (_) {}
  }

  @override
  void dispose() {
    _pdfSaveDebounce?.cancel();
    _scrollController.removeListener(_onScroll);
    _saveProgress();
    _scrollController.dispose();
    _ttsPlayer.dispose();
    _sysTts?.stop();
    super.dispose();
  }

  // ===== 朗读（Edge TTS 神经语音，失败回退系统 TTS）=====
  Future<void> _toggleSpeak() async {
    if (_isSpeaking) {
      await _ttsPlayer.stop();
      await _sysTts?.stop();
      if (mounted) setState(() => _isSpeaking = false);
      return;
    }
    if (_content.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('当前章节无可朗读的文本（PDF 不支持）')));
      return;
    }
    setState(() => _preparingSpeech = true);
    try {
      final mp3 = await ref.read(edgeTtsServiceProvider).synthesize(
            text: _content,
            voice: EdgeTtsService.voiceFor('zh_CN'),
          );
      await _ttsPlayer.setAudioSource(_TtsBytesSource(mp3));
      if (mounted) setState(() { _preparingSpeech = false; _isSpeaking = true; });
      _ttsPlayer.playerStateStream.listen((s) {
        if (s.processingState == ProcessingState.completed && mounted) {
          setState(() => _isSpeaking = false);
        }
      });
      await _ttsPlayer.play();
    } catch (e) {
      appLog('Edge TTS 失败，回退系统 TTS: $e', level: LogLevel.error, persistImmediately: true);
      await _sysSpeak();
    }
  }

  /// 系统 TTS 兜底朗读（Edge 不可用时）
  Future<void> _sysSpeak() async {
    try {
      _sysTts ??= FlutterTts();
      await _sysTts!.setLanguage('zh-CN');
      _sysTts!.setCompletionHandler(() {
        if (mounted) setState(() => _isSpeaking = false);
      });
      if (mounted) setState(() { _preparingSpeech = false; _isSpeaking = true; });
      await _sysTts!.speak(_content);
    } catch (e) {
      if (mounted) {
        setState(() { _preparingSpeech = false; _isSpeaking = false; });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('朗读失败（Edge 与系统 TTS 均不可用）: $e')));
      }
    }
  }

  Future<void> _loadContent() async {
    if (_currentChapterIndex < 0 ||
        _currentChapterIndex >= widget.chapters.length) {
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final chapter = widget.chapters[_currentChapterIndex];
      String content;

      if (widget.isPdfFile) {
        // PDF: 由 pdfrx 的 PdfViewer 负责加载与渲染（自带页面缓存管理，根治大文件 OOM）。
        // 上次阅读页码通过 PdfViewer 的 initialPageNumber 恢复（1-based），见 _buildPdfView。
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _error = null;
        });
        _saveProgress();
        return;
      } else if (widget.isEpubFile && widget.epubBook != null) {
        // EPUB: 从 epubBook 中读取章节 HTML 内容
        content = await LocalFileReader.readEpubChapterContent(
            widget.epubBook, chapter.url);
      } else if (widget.isMobiFile && widget.mobiBook != null) {
        // MOBI: 从 mobiBook 中读取章节内容
        final mobiBook = widget.mobiBook as MobiBook;
        content = LocalFileReader.readMobiChapterContent(mobiBook, chapter.url);
      } else if (widget.book.local) {
        // TXT/MD/HTML: 从缓存的完整内容中提取章节
        if (widget.localContent != null) {
          content = LocalFileReader.extractChapterContent(
              widget.localContent!, chapter);
        } else {
          final result = await LocalFileReader.readTextContent(
              widget.book.bookUrl,
              knownCharset: widget.book.charset);
          content = LocalFileReader.extractChapterContent(
              result.content, chapter);
        }
      } else {
        // 在线书籍：通过网络加载
        final actions = ref.read(bookActionsProvider);
        content = await actions.loadContent(widget.book, chapter);
      }

      if (mounted) {
        setState(() {
          _content = content.isEmpty ? '暂无内容' : content;
          // 统一拆成 ≤800 字符的小块作为独立 ListView 项，避免超大单段渲染卡死滚动
          _contentParagraphs = _splitIntoChunks(_content);
          if (_contentParagraphs.isNotEmpty && _contentParagraphs.last.isEmpty) {
            _contentParagraphs.removeLast();
          }
          _isLoading = false;
        });
        appLog('章节 $_currentChapterIndex/${widget.chapters.length}: '
            '内容 ${content.length} 字, ${_contentParagraphs.length} 块',
            persistImmediately: true);
        // 恢复上次的滚动位置（仅首次打开的章节；偏移需在有效范围内，否则置顶）
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!_scrollController.hasClients) return;
          final maxExt = _scrollController.position.maxScrollExtent;
          final pos = widget.book.durChapterPos.toDouble();
          if (_currentChapterIndex == widget.startIndex &&
              pos > 0 &&
              pos < maxExt) {
            _scrollController.jumpTo(pos);
            appLog('恢复滚动: $pos / max $maxExt', persistImmediately: true);
          } else {
            _scrollController.jumpTo(0);
          }
        });
        _saveProgress();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = e.toString();
          _content = '';
        });
      }
    }
  }

  void _saveProgress() {
    try {
      if (_currentChapterIndex < 0 ||
          _currentChapterIndex >= widget.chapters.length) {
        return;
      }
      final actions = ref.read(bookActionsProvider);
      final chapter = widget.chapters[_currentChapterIndex];
      // PDF 存 1-based 页码（pdfrx 原生语义）；其余格式存滚动像素偏移
      final pos = widget.isPdfFile
          ? _currentPdfPage
          : (_scrollController.hasClients ? _scrollController.offset.round() : 0);
      actions.updateProgress(
        widget.book.bookUrl,
        chapterIndex: _currentChapterIndex,
        chapterTitle: chapter.title,
        chapterPos: pos,
      );
    } catch (_) {
      // dispose/卸载阶段 provider 可能已不可用，静默忽略，避免退出崩溃
    }
  }

  // ===== 书签 =====
  Future<void> _addBookmark() async {
    final ch = widget.chapters[_currentChapterIndex];
    final pos = widget.isPdfFile
        ? _currentPdfPage
        : (_scrollController.hasClients ? _scrollController.offset.round() : 0);
    // bookText 存章节标题 + 正文前几个字作预览
    final snippet = _content.replaceAll(RegExp(r'\s+'), ' ').trim();
    await ref.read(bookmarkActionsProvider).add(bookmark_dto.Bookmark(
          time: 0,
          bookUrl: widget.book.bookUrl,
          bookName: widget.book.name,
          chapterIndex: _currentChapterIndex,
          chapterPos: pos,
          bookText: ch.title,
          content: snippet.isEmpty ? null : snippet.substring(0, snippet.length.clamp(0, 40)),
        ));
    if (mounted) {
      setState(() => _tocShowBookmarks = true);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('已加入书签')));
    }
  }

  Widget _buildBookmarkList(BuildContext context) {
    final asyncBm = ref.watch(bookmarksByBookProvider(widget.book.bookUrl));
    return asyncBm.when(
      data: (list) {
        if (list.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.bookmark_border,
                    size: 48, color: Theme.of(context).colorScheme.outline),
                const SizedBox(height: 8),
                const Text('暂无书签，点右上「加书签」标记当前位置',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                    textAlign: TextAlign.center),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final b = list[index];
            final dt = DateTime.fromMillisecondsSinceEpoch(b.time);
            return ListTile(
              dense: true,
              leading: const Icon(Icons.bookmark, size: 20),
              title: Text(b.bookText.isEmpty ? '第 ${b.chapterIndex + 1} 章' : b.bookText,
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14)),
              subtitle: Text(
                  '${b.content ?? ''}\n${dt.month}/${dt.day} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, size: 18),
                onPressed: () =>
                    ref.read(bookmarkActionsProvider).delete(b.time),
              ),
              onTap: () => _goToChapter(b.chapterIndex),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('加载失败: $e')),
    );
  }

  void _goToChapter(int index) {
    if (index < 0 || index >= widget.chapters.length) return;
    // 切章停止朗读
    if (_isSpeaking) {
      _ttsPlayer.stop();
      _isSpeaking = false;
    }
    setState(() {
      _currentChapterIndex = index;
      _showToc = false;
    });
    if (widget.isPdfFile) {
      // PDF 每章 10 页（见 LocalBookOpener._openPdf），跳到该分段第一页（1-based）。
      _pdfController?.goToPage(pageNumber: index * 10 + 1);
      _saveProgress();
    } else {
      _loadContent();
    }
  }

  void _prevChapter() {
    if (_currentChapterIndex > 0) {
      _goToChapter(_currentChapterIndex - 1);
    }
  }

  void _nextChapter() {
    if (_currentChapterIndex < widget.chapters.length - 1) {
      _goToChapter(_currentChapterIndex + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chapter = widget.chapters[_currentChapterIndex];

    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => setState(() => _showMenu = !_showMenu),
          child: Stack(
            children: [
              // 内容区域
              Column(
                children: [
                  // 顶部信息栏
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    color: _bgColor,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            chapter.title,
                            style: TextStyle(
                              fontSize: 12,
                              color: _textColor.withValues(alpha: 0.5),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 正文内容
                  Expanded(
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                                color: _textColor.withValues(alpha: 0.5)))
                        : _error != null
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.error_outline,
                                        size: 48, color: Colors.red),
                                    const SizedBox(height: 16),
                                    Text('加载失败',
                                        style: TextStyle(color: _textColor)),
                                    const SizedBox(height: 8),
                                    FilledButton.tonal(
                                      onPressed: _loadContent,
                                      child: const Text('重试'),
                                    ),
                                  ],
                                ),
                              )
                            : widget.isPdfFile
                                ? _buildPdfView()
                                : _buildTextView(),
                  ),
                  // 底部信息
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    color: _bgColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.chapters.isEmpty
                              ? '${_currentChapterIndex + 1}/${widget.chapters.length}'
                              : '${_currentChapterIndex + 1}/${widget.chapters.length} · ${((_currentChapterIndex + 1) / widget.chapters.length * 100).round()}%',
                          style: TextStyle(
                              fontSize: 11, color: _textColor.withValues(alpha: 0.4)),
                        ),
                        Text(
                          widget.book.name,
                          style: TextStyle(
                              fontSize: 11, color: _textColor.withValues(alpha: 0.4)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 顶部菜单
              if (_showMenu) _buildTopBar(context),

              // 底部菜单
              if (_showMenu) _buildBottomBar(context),

              // 阅读设置面板
              if (_showSettings) _buildSettingsPanel(context),

              // 目录抽屉
              if (_showToc) _buildTocDrawer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            Expanded(
              child: Text(
                widget.book.name,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                setState(() {
                  _showMenu = false;
                  _showToc = true;
                });
              },
              tooltip: '目录',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 章节进度条
            Row(
              children: [
                Text('第 ${_currentChapterIndex + 1} 章',
                    style: const TextStyle(fontSize: 12)),
                Expanded(
                  child: Slider(
                    value: (_currentChapterIndex + 1).toDouble(),
                    min: 1,
                    max: widget.chapters.length.toDouble(),
                    onChanged: (v) {
                      _goToChapter(v.toInt() - 1);
                    },
                  ),
                ),
                Text('共 ${widget.chapters.length} 章',
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            // 操作按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MenuButton(
                  icon: Icons.navigate_before,
                  label: '上一章',
                  onTap: _prevChapter,
                  enabled: _currentChapterIndex > 0,
                ),
                _MenuButton(
                  icon: Icons.navigate_next,
                  label: '下一章',
                  onTap: _nextChapter,
                  enabled: _currentChapterIndex < widget.chapters.length - 1,
                ),
                _MenuButton(
                  icon: Icons.tune,
                  label: '设置',
                  onTap: () {
                    setState(() {
                      _showMenu = false;
                      _showSettings = true;
                    });
                  },
                ),
                _MenuButton(
                  icon: Icons.list,
                  label: '目录',
                  onTap: () {
                    setState(() {
                      _showMenu = false;
                      _showToc = true;
                    });
                  },
                ),
                _MenuButton(
                  icon: _isSpeaking
                      ? Icons.stop_circle
                      : (_preparingSpeech ? Icons.hourglass_top : Icons.record_voice_over),
                  label: _preparingSpeech
                      ? '准备中'
                      : (_isSpeaking ? '停止' : '朗读'),
                  onTap: _toggleSpeak,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsPanel(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('阅读设置',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _showSettings = false),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 字体大小
            Row(
              children: [
                const Text('字号', style: TextStyle(fontSize: 14)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    if (_fontSize > 12) {
                      setState(() => _fontSize -= 1);
                      _saveReadConfig();
                    }
                  },
                ),
                Text('${_fontSize.toInt()}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    if (_fontSize < 32) {
                      setState(() => _fontSize += 1);
                      _saveReadConfig();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            // 行距
            Row(
              children: [
                const Text('行距', style: TextStyle(fontSize: 14)),
                const Spacer(),
                Slider(
                  value: _lineHeight,
                  min: 1.0,
                  max: 3.0,
                  divisions: 20,
                  label: _lineHeight.toStringAsFixed(1),
                  onChanged: (v) {
                    setState(() => _lineHeight = v);
                    _saveReadConfig();
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 背景色选择
            const Text('背景', style: TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: AppTheme.readerBgColors.map((color) {
                final isSelected = _bgColor == color;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _bgColor = color;
                      // 自动切换文字颜色
                      final luminance = color.computeLuminance();
                      _textColor = luminance > 0.5
                          ? const Color(0xFF212121)
                          : const Color(0xFFE0E0E0);
                    });
                    _saveReadConfig();
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 3)
                          : Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTocDrawer(BuildContext context) {
    return Positioned.fill(
      child: Row(
        children: [
          // 目录/书签面板
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('目录 (${widget.chapters.length}章)',
                          style: Theme.of(context).textTheme.titleMedium),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () =>
                            setState(() => _showToc = false),
                      ),
                    ],
                  ),
                ),
                // 目录/书签 分段
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(children: [
                    ChoiceChip(
                      label: const Text('目录'),
                      selected: !_tocShowBookmarks,
                      onSelected: (_) =>
                          setState(() => _tocShowBookmarks = false),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('书签'),
                      selected: _tocShowBookmarks,
                      onSelected: (_) =>
                          setState(() => _tocShowBookmarks = true),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: _addBookmark,
                      icon: const Icon(Icons.bookmark_add_outlined, size: 18),
                      label: const Text('加书签'),
                    ),
                  ]),
                ),
                const Divider(height: 1),
                Expanded(
                  child: _tocShowBookmarks
                      ? _buildBookmarkList(context)
                      : ListView.builder(
                          itemCount: widget.chapters.length,
                          itemBuilder: (context, index) {
                            final ch = widget.chapters[index];
                            final isCurrent = index == _currentChapterIndex;
                            return ListTile(
                              dense: true,
                              selected: isCurrent,
                              selectedTileColor:
                                  Theme.of(context).colorScheme.primaryContainer,
                              title: Text(
                                ch.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ch.isVolume
                                      ? Colors.grey
                                      : isCurrent
                                          ? Theme.of(context).colorScheme.primary
                                          : null,
                                  fontWeight: ch.isVolume || isCurrent
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: ch.isVip
                                  ? const Icon(Icons.lock,
                                      size: 16, color: Colors.orange)
                                  : null,
                              onTap: () => _goToChapter(index),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          // 遮罩层
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _showToc = false),
              child: Container(
                color: Colors.black.withValues(alpha: 0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 把正文拆成 ≤[chunkSize] 字符的小块。先按换行分段，再对超长段切成多块，
  /// 每块作为独立 ListView 项——全懒加载，杜绝"单个超大项导致下面渲染不出来"。
  List<String> _splitIntoChunks(String content, {int chunkSize = 800}) {
    final result = <String>[];
    for (final line in content.split('\n')) {
      if (line.isEmpty) {
        result.add('');
        continue;
      }
      if (line.length <= chunkSize) {
        result.add(line);
      } else {
        for (int i = 0; i < line.length; i += chunkSize) {
          final end = i + chunkSize < line.length ? i + chunkSize : line.length;
          result.add(line.substring(i, end));
        }
      }
    }
    return result;
  }

  /// 文本内容视图 - 使用 ListView.builder 实现懒加载，避免超长内容渲染截断
  Widget _buildTextView() {
    if (_contentParagraphs.isEmpty) {
      return Center(
        child: Text('暂无内容', style: TextStyle(color: _textColor.withValues(alpha: 0.5))),
      );
    }

    final textStyle = TextStyle(
      fontSize: _fontSize,
      height: _lineHeight,
      color: _textColor,
      letterSpacing: 0.5,
    );

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      itemCount: _contentParagraphs.length,
      itemBuilder: (context, index) {
        final para = _contentParagraphs[index];
        // 空行用固定高度的间距代替
        if (para.isEmpty) {
          return SizedBox(height: _fontSize * _lineHeight);
        }
        return Text(para, style: textStyle);
      },
    );
  }

  /// PDF 渲染视图 - 使用 pdfrx，自带页面缓存管理与连续滚动
  Widget _buildPdfView() {
    _pdfController ??= PdfViewerController();
    // durChapterPos 存 1-based 页码（pdfrx 原生语义）；首次为 0，按第一页处理
    final initialPage = widget.book.durChapterPos > 0 ? widget.book.durChapterPos : 1;
    return PdfViewer.file(
      widget.book.bookUrl,
      controller: _pdfController,
      initialPageNumber: initialPage,
      params: PdfViewerParams(
        backgroundColor: _bgColor,
        margin: 8,
        onPageChanged: (pageNumber) {
          if (pageNumber != null) {
            _currentPdfPage = pageNumber;
            // 去抖保存，避免频繁写库
            _pdfSaveDebounce?.cancel();
            _pdfSaveDebounce = Timer(const Duration(milliseconds: 800), _saveProgress);
          }
        },
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool enabled;

  const _MenuButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Opacity(
        opacity: enabled ? 1.0 : 0.4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 24),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}

/// 把 Edge TTS 返回的 mp3 字节喂给 just_audio。
class _TtsBytesSource extends StreamAudioSource {
  _TtsBytesSource(Uint8List bytes)
      : _bytes = bytes,
        super(tag: '朗读');
  final Uint8List _bytes;

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= _bytes.length;
    return StreamAudioResponse(
      sourceLength: _bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(Uint8List.sublistView(_bytes, start, end)),
      contentType: 'audio/mpeg',
    );
  }
}
