import 'package:drift/drift.dart';

/// 书签表
class Bookmarks extends Table {
  IntColumn get time => integer()();
  TextColumn get bookUrl => text()();
  TextColumn get bookName => text()();
  IntColumn get chapterIndex => integer()();
  IntColumn get chapterPos => integer()();
  TextColumn get bookText => text()();
  TextColumn get content => text().nullable()();

  @override
  Set<Column> get primaryKey => {time};
}
