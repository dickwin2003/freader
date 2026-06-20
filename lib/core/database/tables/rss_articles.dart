import 'package:drift/drift.dart';

/// RSS 文章表
class RssArticles extends Table {
  TextColumn get url => text()();
  TextColumn get origin => text()();
  TextColumn get originName => text()();
  TextColumn get title => text()();
  TextColumn get sort => text().nullable()();
  IntColumn get order => integer().withDefault(const Constant(0))();
  TextColumn get pubDate => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get image => text().nullable()();
  TextColumn get link => text().nullable()();
  TextColumn get content => text().nullable()();
  TextColumn get variable => text().nullable()();
  BoolColumn get read => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {url, origin};
}
