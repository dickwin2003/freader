import 'package:drift/drift.dart';

/// 字典规则表
class DictRules extends Table {
  TextColumn get name => text()();
  TextColumn get urlRule => text()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  IntColumn get sortNumber =>
      integer().withDefault(const Constant(0))();
  TextColumn get showRule => text().nullable()();
  BoolColumn get enabledExplore =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {name};
}
