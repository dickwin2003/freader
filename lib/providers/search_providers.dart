import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freader/data/entities/book_source.dart' as dto;
import 'package:freader/data/entities/search_book.dart' as dto;
import 'package:freader/data/repositories/book_repository.dart';
import 'package:freader/service/web_book.dart';

import 'app_providers.dart';
import 'book_source_providers.dart';
import 'book_providers.dart';

/// 搜索状态
class SearchState {
  final String keyword;
  final List<dto.SearchBook> results;
  final bool isSearching;
  final int searchedCount;
  final int totalSources;
  final String? error;

  const SearchState({
    this.keyword = '',
    this.results = const [],
    this.isSearching = false,
    this.searchedCount = 0,
    this.totalSources = 0,
    this.error,
  });

  SearchState copyWith({
    String? keyword,
    List<dto.SearchBook>? results,
    bool? isSearching,
    int? searchedCount,
    int? totalSources,
    String? error,
  }) {
    return SearchState(
      keyword: keyword ?? this.keyword,
      results: results ?? this.results,
      isSearching: isSearching ?? this.isSearching,
      searchedCount: searchedCount ?? this.searchedCount,
      totalSources: totalSources ?? this.totalSources,
      error: error,
    );
  }
}

/// 搜索状态管理
class SearchNotifier extends StateNotifier<SearchState> {
  final WebBook _webBook;
  final BookRepository _bookRepo;
  final Future<List<dto.BookSource>> Function() _getEnabledSources;

  SearchNotifier(this._webBook, this._bookRepo, this._getEnabledSources)
      : super(const SearchState());

  bool _cancelled = false;

  /// 搜索书籍
  Future<void> search(String keyword) async {
    if (keyword.trim().isEmpty) return;

    // 保存搜索历史
    await _bookRepo.saveSearchKeyword(keyword);

    state = SearchState(
      keyword: keyword,
      results: [],
      isSearching: true,
      searchedCount: 0,
      totalSources: 0,
    );

    _cancelled = false;

    // 获取已启用的书源
    final sources = await _getEnabledSources();
    // 只使用有搜索规则的书源
    final searchSources = sources
        .where((s) => s.searchUrl != null && s.ruleSearch != null)
        .toList();

    state = state.copyWith(totalSources: searchSources.length);

    // 并发搜索（最多 10 个同时）
    final results = <dto.SearchBook>[];
    final batchSize = 10;
    int searched = 0;

    for (int i = 0; i < searchSources.length; i += batchSize) {
      if (_cancelled) break;

      final end = i + batchSize > searchSources.length
          ? searchSources.length
          : i + batchSize;
      final batch = searchSources.sublist(i, end);

      final batchResults = await Future.wait(
        batch.map((source) => _webBook.searchBook(source, keyword)),
      );

      if (_cancelled) break;

      for (final list in batchResults) {
        results.addAll(list);
      }
      searched += batch.length;

      state = state.copyWith(
        results: List.from(results),
        searchedCount: searched,
      );
    }

    state = state.copyWith(isSearching: false);
  }

  /// 取消搜索
  void cancelSearch() {
    _cancelled = true;
    state = state.copyWith(isSearching: false);
  }

  /// 清空结果
  void clear() {
    _cancelled = true;
    state = const SearchState();
  }
}

/// 搜索 Provider
final searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  final webBook = ref.watch(webBookProvider);
  final bookRepo = ref.watch(bookRepositoryProvider);
  final sourceRepo = ref.watch(bookSourceRepositoryProvider);

  return SearchNotifier(
    webBook,
    bookRepo,
    () => sourceRepo
        .getAll()
        .then((list) => list.where((s) => s.enabled).toList()),
  );
});

/// 搜索历史 Provider
final searchHistoryProvider = FutureProvider<List<String>>((ref) {
  return ref.watch(bookRepositoryProvider).getSearchHistory().then(
      (keywords) => keywords.map((k) => k.word).toList());
});
