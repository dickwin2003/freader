import 'package:drift/drift.dart';

/// 替换规则表
class ReplaceRules extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get order => integer().withDefault(const Constant(0))();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  TextColumn get regex => text()();
  TextColumn get replacement => text().withDefault(const Constant(''))();
  TextColumn get scope => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get group => text().nullable()();
  BoolColumn get isRegex => boolean().withDefault(const Constant(true))();
  BoolColumn get act => boolean().withDefault(const Constant(true))();
  TextColumn get example => text().nullable()();
}
