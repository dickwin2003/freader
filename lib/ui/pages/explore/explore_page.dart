import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:freader/data/entities/book_source.dart' as dto;
import 'package:freader/providers/book_source_providers.dart';
import 'package:freader/providers/book_providers.dart';
import 'package:freader/service/rule_engine.dart';

/// 发现页面
/// 显示有发现规则的书源，点击浏览分类内容
class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sourcesAsync = ref.watch(exploreBookSourcesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('发现'),
        actions: [
          // 搜索书源
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
            tooltip: '搜索书源',
          ),
          // 管理书源
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.pushNamed('bookSource'),
            tooltip: '书源管理',
          ),
        ],
      ),
      body: sourcesAsync.when(
        data: (sources) {
          // 过滤
          var filtered = sources;
          if (_searchQuery.isNotEmpty) {
            final q = _searchQuery.toLowerCase();
            filtered = sources
                .where((s) =>
                    s.bookSourceName.toLowerCase().contains(q) ||
                    (s.bookSourceGroup ?? '').toLowerCase().contains(q))
                .toList();
          }

          if (filtered.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.explore_outlined, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    sources.isEmpty ? '暂无发现书源' : '未找到匹配的书源',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                  const SizedBox(height: 8),
                  if (sources.isEmpty)
                    FilledButton.tonal(
                      onPressed: () => context.pushNamed('bookSource'),
                      child: const Text('去导入书源'),
                    ),
                ],
              ),
            );
          }

          // 书源网格
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.75,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              return _ExploreSourceItem(
                source: filtered[index],
                onTap: () => _openSource(context, filtered[index]),
                onLongPress: () => _showSourceMenu(context, filtered[index]),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('加载失败: $e', textAlign: TextAlign.center),
              const SizedBox(height: 8),
              FilledButton.tonal(
                onPressed: () => ref.invalidate(exploreBookSourcesProvider),
                child: const Text('重试'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('搜索书源'),
        content: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(hintText: '输入书源名称或分组'),
          onSubmitted: (v) {
            setState(() => _searchQuery = v);
            Navigator.pop(ctx);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _searchQuery = '');
              Navigator.pop(ctx);
            },
            child: const Text('清除'),
          ),
          FilledButton(
            onPressed: () {
              setState(() => _searchQuery = _searchController.text);
              Navigator.pop(ctx);
            },
            child: const Text('搜索'),
          ),
        ],
      ),
    );
  }

  void _openSource(BuildContext context, dto.BookSource source) {
    final categories = RuleEngine.parseExploreUrl(source.exploreUrl);
    if (categories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('该书源没有配置发现规则')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _ExploreCategoryPage(source: source, categories: categories),
      ),
    );
  }

  void _showSourceMenu(BuildContext context, dto.BookSource source) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(source.bookSourceName,
                  style: Theme.of(ctx).textTheme.titleMedium),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.visibility_off),
              title: const Text('禁用书源'),
              onTap: () async {
                Navigator.pop(ctx);
                await ref.read(bookSourceActionsProvider).setEnabled(source.bookSourceUrl, false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('删除书源'),
              onTap: () async {
                Navigator.pop(ctx);
                await ref.read(bookSourceActionsProvider).delete(source.bookSourceUrl);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 书源图标项
class _ExploreSourceItem extends StatelessWidget {
  final dto.BookSource source;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _ExploreSourceItem({
    required this.source,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标 - 显示书源网站 favicon 或首字母
          CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Text(
              source.bookSourceName.isNotEmpty ? source.bookSourceName[0] : '?',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            source.bookSourceName,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// 发现分类页面
class _ExploreCategoryPage extends StatelessWidget {
  final dto.BookSource source;
  final List<ExploreCategory> categories;

  const _ExploreCategoryPage({required this.source, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(source.bookSourceName)),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return FilledButton.tonal(
            onPressed: () => _openCategory(context, cat),
            child: Text(cat.name, textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14)),
          );
        },
      ),
    );
  }

  void _openCategory(BuildContext context, ExploreCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _ExploreResultPage(source: source, category: category),
      ),
    );
  }
}

/// 发现结果页面 - 显示分类下的书籍
class _ExploreResultPage extends ConsumerStatefulWidget {
  final dto.BookSource source;
  final ExploreCategory category;

  const _ExploreResultPage({required this.source, required this.category});

  @override
  ConsumerState<_ExploreResultPage> createState() => _ExploreResultPageState();
}

class _ExploreResultPageState extends ConsumerState<_ExploreResultPage> {
  List<dynamic> _books = []; // List<SearchBook>
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final webBook = ref.read(webBookProvider);
    try {
      setState(() { _isLoading = true; _error = null; });
      final books = await webBook.exploreBook(widget.source, widget.category.url);
      if (mounted) {
        setState(() {
          _books = books;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.name)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text('加载失败', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(_error!, style: const TextStyle(fontSize: 13, color: Colors.grey),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      FilledButton.tonal(
                        onPressed: _loadBooks,
                        child: const Text('重试'),
                      ),
                    ],
                  ),
                )
              : _books.isEmpty
                  ? const Center(child: Text('暂无内容'))
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.52,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _books.length,
                  itemBuilder: (context, index) {
                    final book = _books[index];
                    return _ExploreBookItem(
                      name: book.name as String,
                      author: book.author as String,
                      coverUrl: book.coverUrl as String?,
                      onTap: () => context.push('/book_info', extra: {
                        'bookUrl': book.bookUrl,
                        'origin': book.origin,
                        'originName': book.originName,
                        'name': book.name,
                        'author': book.author,
                        'kind': book.kind,
                        'coverUrl': book.coverUrl,
                        'intro': book.intro,
                        'wordCount': book.wordCount,
                        'latestChapter': book.latestChapter,
                      }),
                    );
                  },
                ),
    );
  }
}

/// 发现书籍项
class _ExploreBookItem extends StatelessWidget {
  final String name;
  final String author;
  final String? coverUrl;
  final VoidCallback onTap;

  const _ExploreBookItem({
    required this.name,
    required this.author,
    this.coverUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: coverUrl != null && coverUrl!.isNotEmpty
                  ? Image.network(coverUrl!, fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _defaultCover(context))
                  : _defaultCover(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 12),
              maxLines: 2, overflow: TextOverflow.ellipsis),
          Text(author, style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _defaultCover(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(name, textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              maxLines: 4, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
