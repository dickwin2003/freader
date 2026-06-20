import 'package:drift/drift.dart';

/// TXT 目录规则表
class TxtTocRules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get rule => text()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  IntColumn get serialNumber =>
      integer().withDefault(const Constant(0))();
  TextColumn get example => text().nullable()();
}
