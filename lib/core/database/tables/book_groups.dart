import 'package:drift/drift.dart';

/// 书籍分组表
class BookGroups extends Table {
  IntColumn get groupId => integer()();
  TextColumn get groupName => text()();
  IntColumn get order => integer().withDefault(const Constant(0))();
  BoolColumn get show => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {groupId};
}
