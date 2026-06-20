import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freader/data/entities/book_source.dart' as dto;
import 'package:freader/data/repositories/book_source_repository.dart';
import 'app_providers.dart';

/// 全局 Dio 实例
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'User-Agent':
          'Mozilla/5.0 (Linux; Android 14) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
    },
  ));
  return dio;
});

/// 书源仓库 Provider
final bookSourceRepositoryProvider = Provider<BookSourceRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return BookSourceRepository(db);
});

/// 所有书源列表
final bookSourceListProvider = StreamProvider<List<dto.BookSource>>((ref) {
  return ref.watch(bookSourceRepositoryProvider).watchAll();
});

/// 已启用书源列表
final enabledBookSourcesProvider =
    StreamProvider<List<dto.BookSource>>((ref) {
  return ref.watch(bookSourceRepositoryProvider).watchEnabled();
});

/// 启用发现的书源列表
final exploreBookSourcesProvider =
    StreamProvider<List<dto.BookSource>>((ref) {
  return ref.watch(bookSourceRepositoryProvider).watchEnabledExplore();
});

/// 按分组获取书源列表
final bookSourceByGroupProvider =
    StreamProvider.family<List<dto.BookSource>, String>((ref, group) {
  return ref.watch(bookSourceRepositoryProvider).watchByGroup(group);
});

/// 书源搜索 Provider
final bookSourceSearchProvider = StateNotifierProvider<
    BookSourceSearchNotifier, AsyncValue<List<dto.BookSource>>>((ref) {
  return BookSourceSearchNotifier(ref.watch(bookSourceRepositoryProvider));
});

/// 书源搜索状态管理
class BookSourceSearchNotifier
    extends StateNotifier<AsyncValue<List<dto.BookSource>>> {
  final BookSourceRepository _repository;

  BookSourceSearchNotifier(this._repository)
      : super(const AsyncValue.data([]));

  StreamSubscription<List<dto.BookSource>>? _sub;

  void search(String query) {
    _sub?.cancel();
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }
    state = const AsyncValue.loading();
    _sub = _repository.searchByName(query).listen(
      (results) {
        if (mounted) {
          state = AsyncValue.data(results);
        }
      },
      onError: (error) {
        if (mounted) {
          state = AsyncValue.error(error, StackTrace.current);
        }
      },
    );
  }

  void clear() {
    _sub?.cancel();
    state = const AsyncValue.data([]);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

/// 书源分组列表
final bookSourceGroupsProvider = FutureProvider<List<String>>((ref) {
  return ref.watch(bookSourceRepositoryProvider).getAllGroups();
});

/// 书源操作 Provider
final bookSourceActionsProvider = Provider<BookSourceActions>((ref) {
  return BookSourceActions(ref);
});

/// 书源操作类
class BookSourceActions {
  final Ref _ref;
  BookSourceActions(this._ref);

  BookSourceRepository get _repo =>
      _ref.read(bookSourceRepositoryProvider);

  /// 保存书源
  Future<void> save(dto.BookSource source) async {
    await _repo.save(source);
  }

  /// 批量保存
  Future<void> saveAll(List<dto.BookSource> sources) async {
    await _repo.saveAll(sources);
  }

  /// 启用/禁用
  Future<void> setEnabled(String url, bool enabled) async {
    await _repo.setEnabled(url, enabled);
  }

  /// 删除
  Future<void> delete(String url) async {
    await _repo.deleteByUrl(url);
  }

  /// 批量删除
  Future<void> deleteAll(List<String> urls) async {
    await _repo.deleteByUrls(urls);
  }

  /// 从 JSON 导入
  Future<int> importJson(String jsonStr) async {
    return _repo.importFromJson(jsonStr);
  }

  /// 导出所有
  Future<String> exportAll() async {
    return _repo.exportToJson();
  }

  /// 导出指定书源
  String exportSources(List<dto.BookSource> sources) {
    return _repo.exportSourcesToJson(sources);
  }
}
