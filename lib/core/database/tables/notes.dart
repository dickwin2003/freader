import 'package:drift/drift.dart';

/// 笔记表 - 心得/读后感（可关联书与章节）
class Notes extends Table {
  /// 主键（自增）
  IntColumn get id => integer().autoIncrement()();

  /// 标题
  TextColumn get title => text().withDefault(const Constant(''))();

  /// 正文
  TextColumn get content => text().withDefault(const Constant(''))();

  /// 关联书籍 URL（可空，表示未关联书）
  TextColumn get bookUrl => text().nullable()();

  /// 关联书籍名称（冗余，便于列表展示）
  TextColumn get bookName => text().nullable()();

  /// 关联章节索引（可空）
  IntColumn get chapterIndex => integer().nullable()();

  /// 创建时间（毫秒）
  IntColumn get createTime => integer()();

  /// 更新时间（毫秒）
  IntColumn get updateTime => integer()();
}
