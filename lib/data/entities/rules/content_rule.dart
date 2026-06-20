import 'package:json_annotation/json_annotation.dart';

part 'content_rule.g.dart';

/// 正文内容规则
@JsonSerializable(explicitToJson: true)
class ContentRule {
  @JsonKey(name: 'content')
  final String? content;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'nextContentUrl')
  final String? nextContentUrl;

  @JsonKey(name: 'webJs')
  final String? webJs;

  @JsonKey(name: 'sourceRegex')
  final String? sourceRegex;

  @JsonKey(name: 'replaceRegex')
  final String? replaceRegex;

  @JsonKey(name: 'imageStyle')
  final String? imageStyle;

  @JsonKey(name: 'imageDecode')
  final String? imageDecode;

  @JsonKey(name: 'payAction')
  final String? payAction;

  const ContentRule({
    this.content,
    this.title,
    this.nextContentUrl,
    this.webJs,
    this.sourceRegex,
    this.replaceRegex,
    this.imageStyle,
    this.imageDecode,
    this.payAction,
  });

  factory ContentRule.fromJson(Map<String, dynamic> json) =>
      _$ContentRuleFromJson(json);

  Map<String, dynamic> toJson() => _$ContentRuleToJson(this);
}
