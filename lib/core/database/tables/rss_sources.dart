import 'package:drift/drift.dart';

/// RSS 源表
class RssSources extends Table {
  TextColumn get sourceUrl => text()();
  TextColumn get sourceName => text()();
  TextColumn get sourceIcon => text().nullable()();
  TextColumn get sourceGroup => text().nullable()();
  IntColumn get customOrder =>
      integer().withDefault(const Constant(0))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  BoolColumn get enabledCookieJar =>
      boolean().withDefault(const Constant(false))();
  TextColumn get concurrentRate => text().nullable()();
  TextColumn get header => text().nullable()();
  TextColumn get loginUrl => text().nullable()();
  TextColumn get loginUi => text().nullable()();
  TextColumn get loginCheckJs => text().nullable()();
  TextColumn get ruleArticles => text().nullable()();
  TextColumn get ruleNextPage => text().nullable()();
  TextColumn get ruleTitle => text().nullable()();
  TextColumn get rulePubDate => text().nullable()();
  TextColumn get ruleDescription => text().nullable()();
  TextColumn get ruleImage => text().nullable()();
  TextColumn get ruleContent => text().nullable()();
  TextColumn get ruleLink => text().nullable()();
  TextColumn get ruleCategories => text().nullable()();
  TextColumn get sortUrl => text().nullable()();
  IntColumn get articleStyle =>
      integer().withDefault(const Constant(0))();
  BoolColumn get singleUrl =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get enableJs =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get loadWithBaseUrl =>
      boolean().withDefault(const Constant(false))();
  TextColumn get jsLib => text().nullable()();
  TextColumn get variable => text().nullable()();
  IntColumn get lastUpdateTime => integer().nullable()();

  @override
  Set<Column> get primaryKey => {sourceUrl};
}
