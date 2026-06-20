import 'package:drift/drift.dart';

/// 章节表
class BookChapters extends Table {
  /// 章节 URL
  TextColumn get url => text()();

  /// 所属书籍 URL
  TextColumn get bookUrl => text()();

  /// 章节标题
  TextColumn get title => text()();

  /// 章节索引
  IntColumn get chapterIndex => integer()();

  /// 是否为卷标
  BoolColumn get isVolume =>
      boolean().withDefault(const Constant(false))();

  /// 基础 URL
  TextColumn get baseUrl => text().nullable()();

  /// 是否 VIP
  BoolColumn get isVip => boolean().withDefault(const Constant(false))();

  /// 是否付费
  BoolColumn get isPay => boolean().withDefault(const Constant(false))();

  /// 资源 URL
  TextColumn get resourceUrl => text().nullable()();

  /// 标签
  TextColumn get tag => text().nullable()();

  /// 字数
  TextColumn get wordCount => text().nullable()();

  /// 起始位置（EPUB）
  IntColumn get start => integer().nullable()();

  /// 结束位置（EPUB）
  IntColumn get end => integer().nullable()();

  /// 起始片段 ID（EPUB）
  TextColumn get startFragmentId => text().nullable()();

  /// 结束片段 ID（EPUB）
  TextColumn get endFragmentId => text().nullable()();

  /// 变量
  TextColumn get variable => text().nullable()();

  @override
  Set<Column> get primaryKey => {url, bookUrl};
}
