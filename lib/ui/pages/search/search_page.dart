import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:freader/data/entities/search_book.dart' as dto;
import 'package:freader/providers/search_providers.dart';
import 'package:freader/providers/book_providers.dart';

/// 搜索页面
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _doSearch(String keyword) {
    if (keyword.trim().isEmpty) return;
    _focusNode.unfocus();
    ref.read(searchProvider.notifier).search(keyword.trim());
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          decoration: const InputDecoration(
            hintText: '搜索书名、作者...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          style: const TextStyle(fontSize: 16),
          textInputAction: TextInputAction.search,
          onSubmitted: _doSearch,
        ),
        actions: [
          if (searchState.isSearching)
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: () => ref.read(searchProvider.notifier).cancelSearch(),
              tooltip: '停止搜索',
            )
          else
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => _doSearch(_searchController.text),
              tooltip: '搜索',
            ),
        ],
      ),
      body: searchState.keyword.isEmpty
          ? _buildSearchHistory()
          : _buildSearchResults(searchState),
    );
  }

  /// 搜索历史
  Widget _buildSearchHistory() {
    return Consumer(builder: (context, ref, _) {
      final historyAsync = ref.watch(searchHistoryProvider);
      return historyAsync.when(
        data: (keywords) {
          if (keywords.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('输入关键词搜索书籍', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('搜索历史',
                        style: Theme.of(context).textTheme.titleSmall),
                    TextButton(
                      onPressed: () {
                        ref
                            .read(bookRepositoryProvider)
                            .clearSearchHistory();
                        ref.invalidate(searchHistoryProvider);
                      },
                      child: const Text('清空'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Wrap(
                  spacing: 8,
                  children: keywords.map((keyword) {
                    return ActionChip(
                      label: Text(keyword),
                      onPressed: () {
                        _searchController.text = keyword;
                        _doSearch(keyword);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
      );
    });
  }

  /// 搜索结果
  Widget _buildSearchResults(SearchState state) {
    return Column(
      children: [
        // 搜索进度
        if (state.isSearching || state.results.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                if (state.isSearching)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  const Icon(Icons.check_circle, size: 16, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  state.isSearching
                      ? '已搜索 ${state.searchedCount}/${state.totalSources} 个书源...'
                      : '共找到 ${state.results.length} 个结果',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

        // 结果列表
        Expanded(
          child: state.results.isEmpty && !state.isSearching
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_off,
                          size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text('未找到相关书籍',
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 16)),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: state.results.length,
                  itemBuilder: (context, index) {
                    return _SearchResultItem(
                      book: state.results[index],
                      onTap: () {
                        final book = state.results[index];
                        context.push('/book_info', extra: {
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
                        });
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}

/// 搜索结果项
class _SearchResultItem extends StatelessWidget {
  final dto.SearchBook book;
  final VoidCallback onTap;

  const _SearchResultItem({required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 封面
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                width: 56,
                height: 76,
                child: book.coverUrl != null && book.coverUrl!.isNotEmpty
                    ? Image.network(
                        book.coverUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _defaultCover(context),
                      )
                    : _defaultCover(context),
              ),
            ),
            const SizedBox(width: 12),
            // 信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (book.latestChapter != null &&
                      book.latestChapter!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      '最新: ${book.latestChapter}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (book.intro != null && book.intro!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      book.intro!,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          book.originName,
                          style: TextStyle(
                            fontSize: 10,
                            color:
                                Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      if (book.kind != null && book.kind!.isNotEmpty) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            book.kind!,
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _defaultCover(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Center(
        child: Icon(Icons.menu_book, size: 24, color: Colors.grey),
      ),
    );
  }
}
