import 'package:drift/drift.dart';

/// 书籍表
class Books extends Table {
  /// 书籍 URL（主键）
  TextColumn get bookUrl => text()();

  /// 目录页 URL
  TextColumn get tocUrl => text()();

  /// 来源书源 URL
  TextColumn get origin => text()();

  /// 来源书源名称
  TextColumn get originName => text()();

  /// 书名
  TextColumn get name => text()();

  /// 作者
  TextColumn get author => text()();

  /// 分类标签
  TextColumn get kind => text().nullable()();

  /// 用户自定义标签
  TextColumn get customTag => text().nullable()();

  /// 封面 URL
  TextColumn get coverUrl => text().nullable()();

  /// 自定义封面 URL
  TextColumn get customCoverUrl => text().nullable()();

  /// 简介
  TextColumn get intro => text().nullable()();

  /// 自定义简介
  TextColumn get customIntro => text().nullable()();

  /// 字符编码
  TextColumn get charset => text().nullable()();

  /// 书籍类型
  IntColumn get type => integer().withDefault(const Constant(0))();

  /// 所属分组
  IntColumn get group => integer().withDefault(const Constant(0))();

  /// 最新章节标题
  TextColumn get latestChapterTitle => text().nullable()();

  /// 最新章节时间
  IntColumn get latestChapterTime => integer().nullable()();

  /// 总章节数
  IntColumn get totalChapterNum =>
      integer().withDefault(const Constant(0))();

  /// 当前阅读章节索引
  IntColumn get durChapterIndex =>
      integer().withDefault(const Constant(0))();

  /// 当前阅读章节标题
  TextColumn get durChapterTitle => text().nullable()();

  /// 当前阅读位置
  IntColumn get durChapterPos =>
      integer().withDefault(const Constant(0))();

  /// 当前阅读时间
  IntColumn get durChapterTime =>
      integer().withDefault(const Constant(0))();

  /// 字数
  TextColumn get wordCount => text().nullable()();

  /// 是否可以更新
  BoolColumn get canUpdate => boolean().withDefault(const Constant(true))();

  /// 变量
  TextColumn get variable => text().nullable()();

  /// 阅读配置（JSON）
  TextColumn get readConfig => text().nullable()();

  /// 同步时间
  IntColumn get syncTime => integer().nullable()();

  /// 是否本地书籍
  BoolColumn get local => boolean().withDefault(const Constant(false))();

  /// 是否在书架中
  BoolColumn get inBookshelf =>
      boolean().withDefault(const Constant(false))();

  /// 用户评分（0-5，0 表示未评分）
  IntColumn get score => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {bookUrl};
}
