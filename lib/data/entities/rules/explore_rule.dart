import 'package:json_annotation/json_annotation.dart';

part 'explore_rule.g.dart';

/// 书源发现规则
@JsonSerializable(explicitToJson: true)
class ExploreRule {
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

  const ExploreRule({
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

  factory ExploreRule.fromJson(Map<String, dynamic> json) =>
      _$ExploreRuleFromJson(json);

  Map<String, dynamic> toJson() => _$ExploreRuleToJson(this);
}
