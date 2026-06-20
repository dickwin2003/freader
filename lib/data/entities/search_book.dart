import 'package:json_annotation/json_annotation.dart';

part 'search_book.g.dart';

/// 搜索结果实体 - 对应 Legado SearchBook
@JsonSerializable(explicitToJson: true)
class SearchBook {
  /// 书籍 URL
  @JsonKey(name: 'bookUrl')
  final String bookUrl;

  /// 来源书源 URL
  @JsonKey(name: 'origin')
  final String origin;

  /// 来源书源名称
  @JsonKey(name: 'originName')
  final String originName;

  /// 书名
  @JsonKey(name: 'name')
  final String name;

  /// 作者
  @JsonKey(name: 'author')
  final String author;

  /// 分类标签
  @JsonKey(name: 'kind')
  final String? kind;

  /// 封面 URL
  @JsonKey(name: 'coverUrl')
  final String? coverUrl;

  /// 简介
  @JsonKey(name: 'intro')
  final String? intro;

  /// 字数
  @JsonKey(name: 'wordCount')
  final String? wordCount;

  /// 最新章节
  @JsonKey(name: 'latestChapter')
  final String? latestChapter;

  /// 更新时间
  @JsonKey(name: 'updateTime')
  final String? updateTime;

  /// 搜索时间戳
  @JsonKey(name: 'searchTime')
  final int? searchTime;

  /// 变量
  @JsonKey(name: 'variable')
  final String? variable;

  /// 来源分组
  @JsonKey(name: 'originOrder')
  final int originOrder;

  const SearchBook({
    required this.bookUrl,
    required this.origin,
    required this.originName,
    required this.name,
    required this.author,
    this.kind,
    this.coverUrl,
    this.intro,
    this.wordCount,
    this.latestChapter,
    this.updateTime,
    this.searchTime,
    this.variable,
    this.originOrder = 0,
  });

  factory SearchBook.fromJson(Map<String, dynamic> json) =>
      _$SearchBookFromJson(json);

  Map<String, dynamic> toJson() => _$SearchBookToJson(this);
}
