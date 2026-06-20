import 'package:json_annotation/json_annotation.dart';

part 'book_info_rule.g.dart';

/// 书籍详情规则 - 对应 Legado BookInfoRule
@JsonSerializable(explicitToJson: true)
class BookInfoRule {
  @JsonKey(name: 'init')
  final String? init;

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

  @JsonKey(name: 'coverUrl')
  final String? coverUrl;

  @JsonKey(name: 'tocUrl')
  final String? tocUrl;

  @JsonKey(name: 'wordCount')
  final String? wordCount;

  @JsonKey(name: 'canReName')
  final String? canReName;

  @JsonKey(name: 'downloadUrls')
  final String? downloadUrls;

  const BookInfoRule({
    this.init,
    this.name,
    this.author,
    this.intro,
    this.kind,
    this.lastChapter,
    this.updateTime,
    this.coverUrl,
    this.tocUrl,
    this.wordCount,
    this.canReName,
    this.downloadUrls,
  });

  factory BookInfoRule.fromJson(Map<String, dynamic> json) =>
      _$BookInfoRuleFromJson(json);

  Map<String, dynamic> toJson() => _$BookInfoRuleToJson(this);
}
