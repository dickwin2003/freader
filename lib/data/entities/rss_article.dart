import 'package:json_annotation/json_annotation.dart';

part 'rss_article.g.dart';

/// RSS 文章实体
@JsonSerializable(explicitToJson: true)
class RssArticle {
  /// 文章 URL（联合主键）
  @JsonKey(name: 'url')
  final String url;

  /// 源 URL
  @JsonKey(name: 'origin')
  final String origin;

  /// 源名称
  @JsonKey(name: 'originName')
  final String originName;

  /// 分类
  @JsonKey(name: 'sort')
  final String? sort;

  /// 文章标题
  @JsonKey(name: 'title')
  final String title;

  /// 文章顺序
  @JsonKey(name: 'order')
  final int order;

  /// 发布时间
  @JsonKey(name: 'pubDate')
  final String? pubDate;

  /// 描述
  @JsonKey(name: 'description')
  final String? description;

  /// 图片
  @JsonKey(name: 'image')
  final String? image;

  /// 链接
  @JsonKey(name: 'link')
  final String? link;

  /// 内容
  @JsonKey(name: 'content')
  final String? content;

  /// 变量
  @JsonKey(name: 'variable')
  final String? variable;

  /// 是否已读
  @JsonKey(name: 'read')
  final bool read;

  const RssArticle({
    required this.url,
    required this.origin,
    required this.originName,
    required this.title,
    this.sort,
    this.order = 0,
    this.pubDate,
    this.description,
    this.image,
    this.link,
    this.content,
    this.variable,
    this.read = false,
  });

  factory RssArticle.fromJson(Map<String, dynamic> json) =>
      _$RssArticleFromJson(json);

  Map<String, dynamic> toJson() => _$RssArticleToJson(this);
}
