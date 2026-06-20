import 'package:drift/drift.dart';

/// 搜索关键词表
class SearchKeywords extends Table {
  TextColumn get word => text()();
  IntColumn get usage => integer().withDefault(const Constant(0))();
  IntColumn get lastUseTime => integer()();

  @override
  Set<Column> get primaryKey => {word};
}
