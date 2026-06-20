import 'package:json_annotation/json_annotation.dart';
import 'rules/search_rule.dart';
import 'rules/explore_rule.dart';
import 'rules/book_info_rule.dart';
import 'rules/toc_rule.dart';
import 'rules/content_rule.dart';
import 'rules/review_rule.dart';

part 'book_source.g.dart';

/// 书源类型
class BookSourceType {
  static const int text = 0;
  static const int audio = 1;
  static const int image = 2;
  static const int file = 3;
}

/// 书源实体 - 对应 Legado BookSource
/// 这是整个应用最核心的实体，定义了如何从网站抓取书籍信息的规则
@JsonSerializable(explicitToJson: true)
class BookSource {
  /// 书源地址（主键）
  @JsonKey(name: 'bookSourceUrl')
  final String bookSourceUrl;

  /// 书源名称
  @JsonKey(name: 'bookSourceName')
  final String bookSourceName;

  /// 书源分组（分号分隔）
  @JsonKey(name: 'bookSourceGroup')
  final String? bookSourceGroup;

  /// 书源备注
  @JsonKey(name: 'bookSourceComment')
  final String? bookSourceComment;

  /// 是否启用评论
  @JsonKey(name: 'enabledReview')
  final bool? enabledReview;

  /// 书源类型：0=文本, 1=音频, 2=图片, 3=文件
  @JsonKey(name: 'bookSourceType')
  final int bookSourceType;

  /// 书籍详情页 URL 匹配正则
  @JsonKey(name: 'bookUrlPattern')
  final String? bookUrlPattern;

  /// 自定义排序序号
  @JsonKey(name: 'customOrder')
  final int customOrder;

  /// 是否启用
  @JsonKey(name: 'enabled')
  final bool enabled;

  /// 是否启用发现
  @JsonKey(name: 'enabledExplore')
  final bool enabledExplore;

  /// 是否启用 Cookie 管理
  @JsonKey(name: 'enabledCookieJar')
  final bool enabledCookieJar;

  /// 共享 JS 库代码
  @JsonKey(name: 'jsLib')
  final String? jsLib;

  /// 并发速率限制
  @JsonKey(name: 'concurrentRate')
  final String? concurrentRate;

  /// 自定义 HTTP 头
  @JsonKey(name: 'header')
  final String? header;

  /// 登录 URL
  @JsonKey(name: 'loginUrl')
  final String? loginUrl;

  /// 登录 UI 配置
  @JsonKey(name: 'loginUi')
  final String? loginUi;

  /// 登录检查 JS
  @JsonKey(name: 'loginCheckJs')
  final String? loginCheckJs;

  /// 搜索 URL（含模板表达式）
  @JsonKey(name: 'searchUrl')
  final String? searchUrl;

  /// 发现 URL（含模板表达式）
  @JsonKey(name: 'exploreUrl')
  final String? exploreUrl;

  /// 发现页面配置
  @JsonKey(name: 'exploreScreen')
  final String? exploreScreen;

  /// 搜索规则
  @JsonKey(name: 'ruleSearch')
  final SearchRule? ruleSearch;

  /// 发现规则
  @JsonKey(name: 'ruleExplore')
  final ExploreRule? ruleExplore;

  /// 书籍详情规则
  @JsonKey(name: 'ruleBookInfo')
  final BookInfoRule? ruleBookInfo;

  /// 目录规则
  @JsonKey(name: 'ruleToc')
  final TocRule? ruleToc;

  /// 正文内容规则
  @JsonKey(name: 'ruleContent')
  final ContentRule? ruleContent;

  /// 评论规则
  @JsonKey(name: 'ruleReview')
  final ReviewRule? ruleReview;

  /// 响应时间（用于排序）
  @JsonKey(name: 'respondTime')
  final int respondTime;

  /// 最后更新时间
  @JsonKey(name: 'lastUpdateTime')
  final int? lastUpdateTime;

  /// 变量存储（JSON Map）
  @JsonKey(name: 'variable')
  final String? variable;

  /// 权重
  @JsonKey(name: 'weight')
  final int weight;

  const BookSource({
    required this.bookSourceUrl,
    required this.bookSourceName,
    this.bookSourceGroup,
    this.bookSourceComment,
    this.enabledReview,
    this.bookSourceType = BookSourceType.text,
    this.bookUrlPattern,
    this.customOrder = 0,
    this.enabled = true,
    this.enabledExplore = true,
    this.enabledCookieJar = false,
    this.jsLib,
    this.concurrentRate,
    this.header,
    this.loginUrl,
    this.loginUi,
    this.loginCheckJs,
    this.searchUrl,
    this.exploreUrl,
    this.exploreScreen,
    this.ruleSearch,
    this.ruleExplore,
    this.ruleBookInfo,
    this.ruleToc,
    this.ruleContent,
    this.ruleReview,
    this.respondTime = 180000,
    this.lastUpdateTime,
    this.variable,
    this.weight = 0,
  });

  factory BookSource.fromJson(Map<String, dynamic> json) {
    // 修复空规则对象 {} 的类型转换问题
    // Legado 书源 JSON 中空规则是 {} 而非 null
    final fixed = json.map((k, v) {
      if (v is Map) {
        return MapEntry(k, Map<String, dynamic>.from(v));
      }
      return MapEntry(k, v);
    });
    return _$BookSourceFromJson(fixed);
  }

  Map<String, dynamic> toJson() => _$BookSourceToJson(this);

  /// 获取分组列表
  List<String> get groups {
    if (bookSourceGroup == null || bookSourceGroup!.isEmpty) return [];
    return bookSourceGroup!
        .split(';')
        .where((s) => s.isNotEmpty)
        .toList();
  }
}
