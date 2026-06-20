import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:freader/data/entities/book.dart' as dto;
import 'package:freader/data/entities/book_chapter.dart' as dto;
import 'package:freader/providers/book_providers.dart';
import 'package:freader/providers/book_source_providers.dart';
import 'package:freader/service/local_file_reader.dart';
import 'package:freader/ui/widgets/star_rating.dart';

/// 书籍详情页
class BookInfoPage extends ConsumerStatefulWidget {
  final String bookUrl;
  final String origin;
  final String originName;
  final String name;
  final String author;
  final String? kind;
  final String? coverUrl;
  final String? intro;
  final String? wordCount;
  final String? latestChapter;

  const BookInfoPage({
    super.key,
    required this.bookUrl,
    required this.origin,
    required this.originName,
    required this.name,
    required this.author,
    this.kind,
    this.coverUrl,
    this.intro,
    this.wordCount,
    this.latestChapter,
  });

  @override
  ConsumerState<BookInfoPage> createState() => _BookInfoPageState();
}

class _BookInfoPageState extends ConsumerState<BookInfoPage> {
  bool _isLoading = true;
  bool _isInBookshelf = false;
  dto.Book? _book;
  List<dto.BookChapter> _chapters = [];
  String? _error;
  int? _localScore; // 评分乐观更新；null 时取 _book.score

  @override
  void initState() {
    super.initState();
    _loadBookInfo();
  }

  Future<void> _loadBookInfo() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final actions = ref.read(bookActionsProvider);

      final book = dto.Book(
        bookUrl: widget.bookUrl,
        tocUrl: '',
        origin: widget.origin,
        originName: widget.originName,
        name: widget.name,
        author: widget.author,
        kind: widget.kind,
        coverUrl: widget.coverUrl,
        intro: widget.intro,
        wordCount: widget.wordCount,
        latestChapterTitle: widget.latestChapter,
        inBookshelf: false,
        local: false,
      );

      // 获取书源
      final sourceRepo = ref.read(bookSourceRepositoryProvider);
      final source = await sourceRepo.getByUrl(book.origin);

      // 获取详情
      dto.Book detailedBook = book;
      if (source != null) {
        final webBook = ref.read(webBookProvider);
        detailedBook = await webBook.getBookInfo(source, book);
      }

      // 加载章节列表
      final chapters = await actions.loadChapterList(detailedBook);

      // 检查是否已在书架
      final inShelf = await actions.isInBookshelf(detailedBook.bookUrl);

      if (mounted) {
        setState(() {
          _book = detailedBook;
          _chapters = chapters;
          _isInBookshelf = inShelf;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _book = dto.Book(
            bookUrl: widget.bookUrl,
            tocUrl: '',
            origin: widget.origin,
            originName: widget.originName,
            name: widget.name,
            author: widget.author,
            coverUrl: widget.coverUrl,
            intro: widget.intro,
            inBookshelf: false,
            local: false,
          );
          _isLoading = false;
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = _book;

    return Scaffold(
      appBar: AppBar(
        title: Text(book?.name ?? widget.name),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, book ?? _bookFromWidget()),
                  const Divider(height: 1),
                  _buildScoreSection(context, book ?? _bookFromWidget()),
                  if (book?.displayIntro != null &&
                      book!.displayIntro!.isNotEmpty)
                    _buildSection(context, '简介',
                      Text(book.displayIntro!,
                          style: const TextStyle(fontSize: 14, height: 1.6))),
                  _buildChapterSection(context),
                  const SizedBox(height: 80),
                ],
              ),
            ),
      bottomNavigationBar: _isLoading
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isInBookshelf ? null : _addToBookshelf,
                        icon: Icon(_isInBookshelf ? Icons.check : Icons.bookmark_add_outlined),
                        label: Text(_isInBookshelf ? '已在书架' : '加入书架'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _chapters.isNotEmpty ? _startReading : null,
                        icon: const Icon(Icons.menu_book),
                        label: const Text('开始阅读'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  dto.Book _bookFromWidget() {
    return dto.Book(
      bookUrl: widget.bookUrl, tocUrl: '',
      origin: widget.origin, originName: widget.originName,
      name: widget.name, author: widget.author,
      kind: widget.kind, coverUrl: widget.coverUrl,
      intro: widget.intro, wordCount: widget.wordCount,
      latestChapterTitle: widget.latestChapter,
      inBookshelf: false, local: false,
    );
  }

  Widget _buildScoreSection(BuildContext context, dto.Book book) {
    final score = _localScore ?? book.score;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text('我的评分', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(width: 12),
          StarRating(
            rating: score,
            size: 28,
            onRatingChanged: _book == null ? null : _updateScore,
          ),
          const SizedBox(width: 8),
          Text(score == 0 ? '未评分' : '$score 星',
              style: TextStyle(fontSize: 13, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Future<void> _updateScore(int score) async {
    final book = _book;
    if (book == null) return;
    setState(() => _localScore = score);
    await ref.read(bookActionsProvider).updateScore(book.bookUrl, score);
    // 刷新详情缓存，避免离开再进看到旧分
    ref.invalidate(bookDetailProvider(widget.bookUrl));
  }

  Widget _buildHeader(BuildContext context, dto.Book book) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 90, height: 120,
              child: book.displayCoverUrl != null && book.displayCoverUrl!.isNotEmpty
                  ? Image.network(book.displayCoverUrl!, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _defaultCover(context))
                  : _defaultCover(context),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Text('作者: ${book.author}', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                if (book.kind != null && book.kind!.isNotEmpty)
                  Padding(padding: const EdgeInsets.only(top: 4),
                    child: Text('分类: ${book.kind}', style: TextStyle(fontSize: 13, color: Colors.grey[600]))),
                if (book.wordCount != null && book.wordCount!.isNotEmpty)
                  Padding(padding: const EdgeInsets.only(top: 4),
                    child: Text('字数: ${book.wordCount}', style: TextStyle(fontSize: 13, color: Colors.grey[600]))),
                if (book.latestChapterTitle != null && book.latestChapterTitle!.isNotEmpty)
                  Padding(padding: const EdgeInsets.only(top: 4),
                    child: Text('最新: ${book.latestChapterTitle}', style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                        maxLines: 1, overflow: TextOverflow.ellipsis)),
                Padding(padding: const EdgeInsets.only(top: 4),
                  child: Text('共 ${_chapters.length} 章', style: TextStyle(fontSize: 13, color: Colors.grey[600]))),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('来源: ${book.originName}',
                      style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onPrimaryContainer)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          child,
        ]),
    );
  }

  Widget _buildChapterSection(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('目录 (${_chapters.length}章)', style: Theme.of(context).textTheme.titleSmall),
              if (_chapters.length > 5)
                TextButton(onPressed: _showFullChapterList, child: const Text('查看全部')),
            ]),
        ),
        ..._chapters.take(5).map((ch) => ListTile(
              dense: true,
              title: Text(ch.title, style: const TextStyle(fontSize: 14),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: ch.isVip ? const Icon(Icons.lock, size: 16, color: Colors.orange) : null,
              onTap: () => _readChapter(ch.index),
            )),
      ]);
  }

  void _showFullChapterList() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7, minChildSize: 0.3, maxChildSize: 0.9,
        expand: false,
        builder: (context, sc) => Column(children: [
          Padding(padding: const EdgeInsets.all(16),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('目录 (${_chapters.length}章)', style: Theme.of(context).textTheme.titleMedium),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ])),
          const Divider(height: 1),
          Expanded(child: ListView.builder(
            controller: sc, itemCount: _chapters.length,
            itemBuilder: (context, i) {
              final ch = _chapters[i];
              return ListTile(
                dense: true,
                title: Text(ch.title,
                    style: TextStyle(fontSize: 14,
                        color: ch.isVolume ? Colors.grey : null,
                        fontWeight: ch.isVolume ? FontWeight.bold : FontWeight.normal),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: ch.isVip ? const Icon(Icons.lock, size: 16, color: Colors.orange) : null,
                onTap: () { Navigator.pop(context); _readChapter(ch.index); },
              );
            },
          )),
        ]),
      ),
    );
  }

  Future<void> _addToBookshelf() async {
    if (_book == null) return;
    await ref.read(bookActionsProvider).addToBookshelf(_book!);
    setState(() => _isInBookshelf = true);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已加入书架')));
    }
  }

  void _startReading() {
    if (_chapters.isEmpty) return;
    _readChapter(0);
  }

  void _readChapter(int chapterIndex) async {
    if (_book == null || _chapters.isEmpty) return;
    if (!_isInBookshelf) await _addToBookshelf();
    final idx = chapterIndex < _chapters.length ? chapterIndex : 0;
    if (mounted) {
      context.push('/reader', extra: {
        'book': _book!,
        'chapters': _chapters,
        'startIndex': idx,
        'isEpubFile': _book!.local && LocalFileReader.isEpubFile(_book!.bookUrl),
        'isPdfFile': _book!.local && LocalFileReader.isPdfFile(_book!.bookUrl),
      });
    }
  }

  Widget _defaultCover(BuildContext context) {
    return Container(
      width: 90, height: 120,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Center(child: Icon(Icons.menu_book, size: 32, color: Colors.grey)),
    );
  }
}
