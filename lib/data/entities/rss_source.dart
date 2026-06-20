import 'package:json_annotation/json_annotation.dart';

part 'rss_source.g.dart';

/// RSS 订阅源实体 - 对应 Legado RssSource
@JsonSerializable(explicitToJson: true)
class RssSource {
  /// 源 URL（主键）
  @JsonKey(name: 'sourceUrl')
  final String sourceUrl;

  /// 源名称
  @JsonKey(name: 'sourceName')
  final String sourceName;

  /// 源图标
  @JsonKey(name: 'sourceIcon')
  final String? sourceIcon;

  /// 分组
  @JsonKey(name: 'sourceGroup')
  final String? sourceGroup;

  /// 排序序号
  @JsonKey(name: 'customOrder')
  final int customOrder;

  /// 是否启用
  @JsonKey(name: 'enabled')
  final bool enabled;

  /// 是否启用 Cookie
  @JsonKey(name: 'enabledCookieJar')
  final bool enabledCookieJar;

  /// 并发速率限制
  @JsonKey(name: 'concurrentRate')
  final String? concurrentRate;

  /// 自定义头部
  @JsonKey(name: 'header')
  final String? header;

  /// 登录 URL
  @JsonKey(name: 'loginUrl')
  final String? loginUrl;

  /// 登录 UI
  @JsonKey(name: 'loginUi')
  final String? loginUi;

  /// 登录检查 JS
  @JsonKey(name: 'loginCheckJs')
  final String? loginCheckJs;

  /// 文章列表规则
  @JsonKey(name: 'ruleArticles')
  final String? ruleArticles;

  /// 下一页规则
  @JsonKey(name: 'ruleNextPage')
  final String? ruleNextPage;

  /// 文章标题规则
  @JsonKey(name: 'ruleTitle')
  final String? ruleTitle;

  /// 文章日期规则
  @JsonKey(name: 'rulePubDate')
  final String? rulePubDate;

  /// 文章描述规则
  @JsonKey(name: 'ruleDescription')
  final String? ruleDescription;

  /// 文章图片规则
  @JsonKey(name: 'ruleImage')
  final String? ruleImage;

  /// 文章内容规则
  @JsonKey(name: 'ruleContent')
  final String? ruleContent;

  /// 文章链接规则
  @JsonKey(name: 'ruleLink')
  final String? ruleLink;

  /// 分类规则
  @JsonKey(name: 'ruleCategories')
  final String? ruleCategories;

  /// 排序类型
  @JsonKey(name: 'sortUrl')
  final String? sortUrl;

  /// 文章样式
  @JsonKey(name: 'articleStyle')
  final int articleStyle;

  /// 是否单 url
  @JsonKey(name: 'singleUrl')
  final bool singleUrl;

  /// 启用 JS
  @JsonKey(name: 'enableJs')
  final bool enableJs;

  /// 加载 WebView
  @JsonKey(name: 'loadWithBaseUrl')
  final bool loadWithBaseUrl;

  /// JS 库
  @JsonKey(name: 'jsLib')
  final String? jsLib;

  /// 变量
  @JsonKey(name: 'variable')
  final String? variable;

  /// 最后更新时间
  @JsonKey(name: 'lastUpdateTime')
  final int? lastUpdateTime;

  const RssSource({
    required this.sourceUrl,
    required this.sourceName,
    this.sourceIcon,
    this.sourceGroup,
    this.customOrder = 0,
    this.enabled = true,
    this.enabledCookieJar = false,
    this.concurrentRate,
    this.header,
    this.loginUrl,
    this.loginUi,
    this.loginCheckJs,
    this.ruleArticles,
    this.ruleNextPage,
    this.ruleTitle,
    this.rulePubDate,
    this.ruleDescription,
    this.ruleImage,
    this.ruleContent,
    this.ruleLink,
    this.ruleCategories,
    this.sortUrl,
    this.articleStyle = 0,
    this.singleUrl = false,
    this.enableJs = false,
    this.loadWithBaseUrl = false,
    this.jsLib,
    this.variable,
    this.lastUpdateTime,
  });

  factory RssSource.fromJson(Map<String, dynamic> json) =>
      _$RssSourceFromJson(json);

  Map<String, dynamic> toJson() => _$RssSourceToJson(this);
}
