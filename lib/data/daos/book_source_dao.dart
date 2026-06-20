import 'package:drift/drift.dart';
import 'package:freader/core/database/app_database.dart';
import 'package:freader/core/database/tables/book_sources.dart';

part 'book_source_dao.g.dart';

/// 书源 DAO
@DriftAccessor(tables: [BookSources])
class BookSourceDao extends DatabaseAccessor<AppDatabase>
    with _$BookSourceDaoMixin {
  BookSourceDao(super.attachedDatabase);

  /// 获取所有书源
  Future<List<BookSource>> getAll() => select(bookSources).get();

  /// 监听所有书源变化
  Stream<List<BookSource>> watchAll() => select(bookSources).watch();

  /// 获取已启用的书源
  Future<List<BookSource>> getEnabled() {
    return (select(bookSources)..where((t) => t.enabled.equals(true))).get();
  }

  /// 监听已启用书源
  Stream<List<BookSource>> watchEnabled() {
    return (select(bookSources)..where((t) => t.enabled.equals(true))).watch();
  }

  /// 获取启用发现的书源
  Stream<List<BookSource>> watchEnabledExplore() {
    return (select(bookSources)
          ..where((t) => t.enabled.equals(true) & t.enabledExplore.equals(true))
          ..orderBy([
            (t) => OrderingTerm.asc(t.customOrder),
          ]))
        .watch();
  }

  /// 根据 URL 获取书源
  Future<BookSource?> getByUrl(String url) {
    return (select(bookSources)..where((t) => t.bookSourceUrl.equals(url)))
        .getSingleOrNull();
  }

  /// 按名称搜索
  Stream<List<BookSource>> searchByName(String query) {
    return (select(bookSources)
          ..where((t) => t.bookSourceName.like('%$query%'))
          ..orderBy([
            (t) => OrderingTerm.asc(t.customOrder),
          ]))
        .watch();
  }

  /// 按分组获取书源
  Stream<List<BookSource>> watchByGroup(String group) {
    return (select(bookSources)
          ..where((t) => t.bookSourceGroup.like('%$group%'))
          ..orderBy([
            (t) => OrderingTerm.asc(t.customOrder),
          ]))
        .watch();
  }

  /// 获取所有分组
  Future<List<String>> getAllGroups() async {
    final sources = await getAll();
    final groups = <String>{};
    for (final source in sources) {
      if (source.bookSourceGroup != null &&
          source.bookSourceGroup!.isNotEmpty) {
        for (final g in source.bookSourceGroup!.split(';')) {
          if (g.isNotEmpty) groups.add(g);
        }
      }
    }
    return groups.toList()..sort();
  }

  /// 插入或替换单个书源
  Future<void> insertOrReplace(BookSourcesCompanion source) {
    return into(bookSources).insertOnConflictUpdate(source);
  }

  /// 批量插入（去重替换）
  Future<void> insertAll(List<BookSourcesCompanion> sources) {
    return batch((b) {
      b.insertAllOnConflictUpdate(bookSources, sources);
    });
  }

  /// 启用/禁用书源
  Future<void> setEnabled(String url, bool enabled) {
    return (update(bookSources)..where((t) => t.bookSourceUrl.equals(url)))
        .write(BookSourcesCompanion(enabled: Value(enabled)));
  }

  /// 删除书源
  Future<void> deleteByUrl(String url) {
    return (delete(bookSources)..where((t) => t.bookSourceUrl.equals(url)))
        .go();
  }

  /// 批量删除
  Future<void> deleteByUrls(List<String> urls) {
    return (delete(bookSources)
          ..where((t) => t.bookSourceUrl.isIn(urls)))
        .go();
  }

  /// 获取书源数量
  Future<int> getCount() async {
    final count = countAll();
    final query = selectOnly(bookSources)..addColumns([count]);
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }
}
