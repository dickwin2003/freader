import 'package:json_annotation/json_annotation.dart';

part 'search_rule.g.dart';

/// 书源搜索规则 - 对应 Legado SearchRule
@JsonSerializable(explicitToJson: true)
class SearchRule {
  @JsonKey(name: 'bookList')
  final String? bookList;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'author')
  final String? author;

  @JsonKey(name: 'intro')
  final String? intro;

  @JsonKey(name: 'kind')
  final String? kind;

  @JsonKey(name: 'lastChapter')
  final String? lastChapter;

  @JsonKey(name: 'updateTime')
  final String? updateTime;

  @JsonKey(name: 'bookUrl')
  final String? bookUrl;

  @JsonKey(name: 'coverUrl')
  final String? coverUrl;

  @JsonKey(name: 'wordCount')
  final String? wordCount;

  const SearchRule({
    this.bookList,
    this.name,
    this.author,
    this.intro,
    this.kind,
    this.lastChapter,
    this.updateTime,
    this.bookUrl,
    this.coverUrl,
    this.wordCount,
  });

  factory SearchRule.fromJson(Map<String, dynamic> json) =>
      _$SearchRuleFromJson(json);

  Map<String, dynamic> toJson() => _$SearchRuleToJson(this);
}
