import 'package:drift/drift.dart';

/// 书源表
class BookSources extends Table {
  /// 书源 URL（主键）
  TextColumn get bookSourceUrl => text()();

  /// 书源名称
  TextColumn get bookSourceName => text()();

  /// 书源分组
  TextColumn get bookSourceGroup => text().nullable()();

  /// 书源类型：0=文本, 1=音频, 2=图片, 3=文件
  IntColumn get bookSourceType => integer().withDefault(const Constant(0))();

  /// 书籍详情页 URL 匹配正则
  TextColumn get bookUrlPattern => text().nullable()();

  /// 自定义排序序号
  IntColumn get customOrder => integer().withDefault(const Constant(0))();

  /// 是否启用
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  /// 是否启用发现
  BoolColumn get enabledExplore =>
      boolean().withDefault(const Constant(true))();

  /// 是否启用 Cookie
  BoolColumn get enabledCookieJar =>
      boolean().withDefault(const Constant(false))();

  /// JS 库
  TextColumn get jsLib => text().nullable()();

  /// 并发速率限制
  TextColumn get concurrentRate => text().nullable()();

  /// 自定义头部
  TextColumn get header => text().nullable()();

  /// 登录 URL
  TextColumn get loginUrl => text().nullable()();

  /// 登录 UI
  TextColumn get loginUi => text().nullable()();

  /// 登录检查 JS
  TextColumn get loginCheckJs => text().nullable()();

  /// 搜索 URL
  TextColumn get searchUrl => text().nullable()();

  /// 发现 URL
  TextColumn get exploreUrl => text().nullable()();

  /// 发现页面配置
  TextColumn get exploreScreen => text().nullable()();

  /// 搜索规则（JSON）
  TextColumn get ruleSearch => text().nullable()();

  /// 发现规则（JSON）
  TextColumn get ruleExplore => text().nullable()();

  /// 书籍详情规则（JSON）
  TextColumn get ruleBookInfo => text().nullable()();

  /// 目录规则（JSON）
  TextColumn get ruleToc => text().nullable()();

  /// 正文规则（JSON）
  TextColumn get ruleContent => text().nullable()();

  /// 评论规则（JSON）
  TextColumn get ruleReview => text().nullable()();

  /// 响应时间
  IntColumn get respondTime =>
      integer().withDefault(const Constant(180000))();

  /// 最后更新时间
  IntColumn get lastUpdateTime => integer().nullable()();

  /// 变量
  TextColumn get variable => text().nullable()();

  /// 权重
  IntColumn get weight => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {bookSourceUrl};
}
