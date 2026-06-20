import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:freader/data/entities/book.dart' as dto;
import 'package:freader/providers/book_providers.dart';
import 'package:freader/providers/llm_providers.dart';
import 'package:freader/providers/note_providers.dart';
import 'package:freader/ui/widgets/loading_dialog.dart';
import 'package:freader/service/local_file_reader.dart';
import 'package:freader/service/local_book_opener.dart';
import 'package:freader/ui/widgets/star_rating.dart';

/// 排序模式
enum SortMode {
  readTime('按阅读时间'),
  updateTime('按更新时间'),
  bookName('按书名'),
  author('按作者');

  final String label;
  const SortMode(this.label);
}

/// 书架页面
class BookshelfPage extends ConsumerStatefulWidget {
  const BookshelfPage({super.key});

  @override
  ConsumerState<BookshelfPage> createState() => _BookshelfPageState();
}

class _BookshelfPageState extends ConsumerState<BookshelfPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSearching = false;
  String _searchQuery = '';
  SortMode _sortMode = SortMode.readTime;
  bool _isGrid = true;
  final _searchController = TextEditingController();

  // Tab: 全部(0), 本地(1)
  static const _tabs = ['全部', '本地'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookshelfAsync = ref.watch(bookshelfProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: '搜索书名或作者...',
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 16),
                onChanged: (v) => setState(() => _searchQuery = v),
              )
            : const Text('书架'),
        actions: [
          // 发现（从书源浏览分类内容）
          IconButton(
            icon: const Icon(Icons.explore_outlined),
            onPressed: () => context.push('/explore'),
            tooltip: '发现',
          ),
          // 导入本地文件
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () => context.push('/local_import'),
            tooltip: '导入本地文件',
          ),
          // 搜索/关闭
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = '';
                  _searchController.clear();
                }
              });
            },
          ),
          // 排序
          PopupMenuButton<SortMode>(
            icon: const Icon(Icons.sort),
            onSelected: (mode) => setState(() => _sortMode = mode),
            itemBuilder: (_) => SortMode.values
                .map((m) => PopupMenuItem(
                      value: m,
                      child: Row(children: [
                        if (_sortMode == m) const Icon(Icons.check, size: 18),
                        if (_sortMode == m) const SizedBox(width: 8),
                        Text(m.label),
                      ]),
                    ))
                .toList(),
          ),
          // 网格/列表切换
          IconButton(
            icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => _isGrid = !_isGrid),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: bookshelfAsync.when(
        data: (books) {
          return TabBarView(
            controller: _tabController,
            children: [
              _buildBookList(context, books, isLocal: false),
              _buildBookList(context, books, isLocal: true),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('加载失败: $e'),
              const SizedBox(height: 8),
              FilledButton.tonal(
                onPressed: () => ref.invalidate(bookshelfProvider),
                child: const Text('重试'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'bookshelf_fab',
        onPressed: () => context.push('/search'),
        tooltip: '搜索添加书籍',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBookList(
      BuildContext context, List<dto.Book> books,
      {required bool isLocal}) {
    // 过滤
    var filtered = isLocal
        ? books.where((b) => b.local).toList()
        : books;

    // 搜索过滤
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      filtered = filtered
          .where((b) =>
              b.name.toLowerCase().contains(q) ||
              b.author.toLowerCase().contains(q))
          .toList();
    }

    // 排序
    switch (_sortMode) {
      case SortMode.readTime:
        filtered.sort((a, b) => b.durChapterTime.compareTo(a.durChapterTime));
        break;
      case SortMode.updateTime:
        filtered.sort((a, b) =>
            (b.latestChapterTime ?? 0).compareTo(a.latestChapterTime ?? 0));
        break;
      case SortMode.bookName:
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortMode.author:
        filtered.sort((a, b) => a.author.compareTo(b.author));
        break;
    }

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book_outlined, size: 64,
                color: Theme.of(context).colorScheme.outlineVariant),
            const SizedBox(height: 16),
            Text(
              isLocal ? '暂无本地书籍' : '书架空空如也',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
            const SizedBox(height: 12),
            if (isLocal) ...[
              FilledButton.tonal(
                onPressed: () => context.push('/local_import'),
                child: const Text('导入本地文件'),
              ),
            ] else ...[
              FilledButton.tonal(
                onPressed: () => context.push('/search'),
                child: const Text('去搜索添加'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => context.push('/local_import'),
                child: const Text('导入本地文件'),
              ),
            ],
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(bookshelfProvider),
      child: _isGrid
          ? _buildGridView(context, filtered)
          : _buildListView(context, filtered),
    );
  }

  /// 网格视图
  Widget _buildGridView(BuildContext context, List<dto.Book> books) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.55,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) =>
          _BookGridItem(book: books[index], onTap: () => _openBook(books[index]),
            onLongPress: () => _showBookMenu(books[index])),
    );
  }

  /// 列表视图
  Widget _buildListView(BuildContext context, List<dto.Book> books) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: books.length,
      itemBuilder: (context, index) =>
          _BookListItem(book: books[index], onTap: () => _openBook(books[index]),
            onLongPress: () => _showBookMenu(books[index])),
    );
  }

  void _openBook(dto.Book book) async {
    // 不支持的格式本地书籍提示用户
    if (book.local && LocalFileReader.isUnsupportedFormat(book.bookUrl)) {
      if (mounted) {
        final formatName = LocalFileReader.getUnsupportedFormatName(book.bookUrl);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$formatName 格式暂不支持，仅支持 TXT/MD/HTML/EPUB/PDF')),
        );
      }
      return;
    }

    // 本地文件：重新解析获取格式专用数据（epubBook/mobiBook/fullContent）
    if (book.local) {
      try {
        final bookRepo = ref.read(bookRepositoryProvider);
        final opener = LocalBookOpener(bookRepo);
        final result = await opener.openFile(book.bookUrl);
        if (mounted) {
          context.push('/reader', extra: {
            'book': result.book,
            'chapters': result.chapters,
            'startIndex': result.book.durChapterIndex,
            'localContent': result.fullContent,
            'isEpubFile': result.isEpubFile,
            'epubBook': result.epubBook,
            'isPdfFile': result.isPdfFile,
            'isMobiFile': result.isMobiFile,
            'mobiBook': result.mobiBook,
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('打开失败: $e')),
          );
        }
      }
      return;
    }

    // 在线书籍
    final actions = ref.read(bookActionsProvider);
    final chapters = await actions.loadChapterList(book);
    if (chapters.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('无法加载章节列表，请检查书源')),
        );
      }
      return;
    }
    if (mounted) {
      context.push('/reader', extra: {
        'book': book,
        'chapters': chapters,
        'startIndex': book.durChapterIndex,
      });
    }
  }

  void _showBookMenu(dto.Book book) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(book.name,
                      style: Theme.of(ctx).textTheme.titleMedium,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(book.author,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.auto_stories),
              title: const Text('继续阅读'),
              subtitle: book.durChapterTitle != null
                  ? Text(book.durChapterTitle!, maxLines: 1,
                      overflow: TextOverflow.ellipsis)
                  : null,
              onTap: () {
                Navigator.pop(ctx);
                _openBook(book);
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_awesome_outlined),
              title: const Text('AI 总结为笔记'),
              subtitle: const Text('读取该书正文，AI 生成摘要并存入笔记'),
              onTap: () {
                Navigator.pop(ctx);
                _summarizeBookToNote(book);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('查看详情'),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/book_info', extra: {
                  'bookUrl': book.bookUrl,
                  'origin': book.origin,
                  'originName': book.originName,
                  'name': book.name,
                  'author': book.author,
                  'kind': book.kind,
                  'coverUrl': book.displayCoverUrl,
                  'intro': book.displayIntro,
                  'wordCount': book.wordCount,
                  'latestChapter': book.latestChapterTitle,
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error),
              title: Text('移出书架',
                  style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () async {
                Navigator.pop(ctx);
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (d) => AlertDialog(
                    title: const Text('确认移除'),
                    content: Text('确定将《${book.name}》从书架移除？'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('取消')),
                      TextButton(onPressed: () => Navigator.pop(d, true), child: const Text('确定')),
                    ],
                  ),
                );
                if (ok == true) {
                  await ref.read(bookActionsProvider).removeFromBookshelf(book.bookUrl);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  /// AI 读取该书正文生成摘要 → 存为笔记
  Future<void> _summarizeBookToNote(dto.Book book) async {
    if (!ref.read(llmReadyProvider)) {
      _snack('请先到「我的 → AI 设置」配置或下载模型');
      return;
    }
    String? error;
    await showLoadingDialog(
      context,
      ref.read(noteActionsProvider).summarizeBookContent(book),
      message: '正在读取《${book.name}》并 AI 总结…',
      onError: (e) => error = e,
    );
    if (!mounted) return;
    _snack(error == null ? '已生成《${book.name}》摘要笔记' : '总结失败：$error');
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

/// 书籍格式描述（图标/标签/配色），用于本地文件区分显示。
class _BookFormat {
  final IconData icon;
  final String label;
  final Color color;
  const _BookFormat(this.icon, this.label, this.color);
}

_BookFormat _formatOf(dto.Book book) {
  // 在线书源
  if (!book.local) {
    return const _BookFormat(Icons.cloud_outlined, '在线', Color(0xFF1976D2));
  }
  final ext = book.bookUrl.contains('.')
      ? book.bookUrl.substring(book.bookUrl.lastIndexOf('.')).toLowerCase()
      : '';
  switch (ext) {
    case '.pdf':
      return const _BookFormat(Icons.picture_as_pdf_outlined, 'PDF', Color(0xFFD32F2F));
    case '.epub':
      return const _BookFormat(Icons.book_outlined, 'EPUB', Color(0xFF388E3C));
    case '.mobi':
    case '.azw':
    case '.azw3':
      return const _BookFormat(Icons.bookmark_outlined, 'MOBI', Color(0xFFE65100));
    case '.txt':
    case '.md':
      return const _BookFormat(Icons.text_snippet_outlined, 'TXT', Color(0xFF00838F));
    case '.html':
    case '.htm':
      return const _BookFormat(Icons.html_outlined, 'HTML', Color(0xFF7B1FA2));
    case '.docx':
      return const _BookFormat(Icons.description_outlined, 'DOCX', Color(0xFF1565C0));
    case '.doc':
      return const _BookFormat(Icons.description_outlined, 'DOC', Color(0xFF1565C0));
    default:
      return const _BookFormat(Icons.menu_book_outlined, '本地', Color(0xFF616161));
  }
}

/// 书架网格项
class _BookGridItem extends StatelessWidget {
  final dto.Book book;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _BookGridItem({
    required this.book,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildCover(context),
                  // 书名叠在封面底部
                  Positioned(
                    left: 0, right: 0, bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                        ),
                      ),
                      child: Text(
                        book.name,
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                        maxLines: 2, overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            book.durChapterTitle ?? '未阅读',
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            maxLines: 1, overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildCover(BuildContext context) {
    final url = book.displayCoverUrl;
    if (url != null && url.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        memCacheWidth: 300,
        placeholder: (_, _) => _defaultCover(context),
        errorWidget: (_, _, _) => _defaultCover(context),
      );
    }
    return _defaultCover(context);
  }

  Widget _defaultCover(BuildContext context) {
    final fmt = _formatOf(book);
    return Container(
      color: fmt.color.withValues(alpha: 0.14),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(fmt.icon, size: 30, color: fmt.color),
                  const SizedBox(height: 6),
                  Text(book.name, textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: fmt.color),
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ),
          // 格式角标
          Positioned(
            right: 4, top: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: fmt.color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(fmt.label,
                  style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

/// 书架列表项
class _BookListItem extends StatelessWidget {
  final dto.Book book;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _BookListItem({
    required this.book,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // 小封面
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                width: 44, height: 60,
                child: (book.displayCoverUrl != null && book.displayCoverUrl!.isNotEmpty)
                    ? CachedNetworkImage(
                        imageUrl: book.displayCoverUrl!,
                        fit: BoxFit.cover,
                        memCacheWidth: 120,
                        placeholder: (_, _) => _defaultCover(context),
                        errorWidget: (_, _, _) => _defaultCover(context),
                      )
                    : _defaultCover(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(book.author,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  if (book.durChapterTitle != null) ...[
                    const SizedBox(height: 2),
                    Text('读到: ${book.durChapterTitle}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ],
              ),
            ),
            // 章节进度 + 评分
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${book.durChapterIndex}/${book.totalChapterNum}',
                    style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                Text(
                    book.totalChapterNum == 0
                        ? '0%'
                        : '${((book.durChapterIndex + 1) / book.totalChapterNum * 100).round()}%',
                    style: TextStyle(fontSize: 10, color: Colors.grey[400])),
                if (book.score > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: StarRating(rating: book.score, size: 11),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _defaultCover(BuildContext context) {
    final fmt = _formatOf(book);
    return Container(
      color: fmt.color.withValues(alpha: 0.16),
      child: Stack(children: [
        Center(child: Icon(fmt.icon, size: 22, color: fmt.color)),
        Positioned(
          right: 2, bottom: 2,
          child: Text(fmt.label,
              style: TextStyle(
                  color: fmt.color, fontSize: 8, fontWeight: FontWeight.w700)),
        ),
      ]),
    );
  }
}
