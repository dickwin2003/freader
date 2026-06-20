import 'package:drift/drift.dart';

/// 搜索结果表
class SearchBooks extends Table {
  TextColumn get bookUrl => text()();
  TextColumn get origin => text()();
  TextColumn get originName => text()();
  TextColumn get name => text()();
  TextColumn get author => text()();
  TextColumn get kind => text().nullable()();
  TextColumn get coverUrl => text().nullable()();
  TextColumn get intro => text().nullable()();
  TextColumn get wordCount => text().nullable()();
  TextColumn get latestChapter => text().nullable()();
  TextColumn get updateTime => text().nullable()();
  IntColumn get searchTime => integer().nullable()();
  TextColumn get variable => text().nullable()();
  IntColumn get originOrder =>
      integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {bookUrl, origin};
}
