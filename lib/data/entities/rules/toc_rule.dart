import 'package:json_annotation/json_annotation.dart';

part 'toc_rule.g.dart';

/// 目录规则
@JsonSerializable(explicitToJson: true)
class TocRule {
  @JsonKey(name: 'preUpdateJs')
  final String? preUpdateJs;

  @JsonKey(name: 'chapterList')
  final String? chapterList;

  @JsonKey(name: 'chapterName')
  final String? chapterName;

  @JsonKey(name: 'chapterUrl')
  final String? chapterUrl;

  @JsonKey(name: 'formatJs')
  final String? formatJs;

  @JsonKey(name: 'isVolume')
  final String? isVolume;

  @JsonKey(name: 'isVip')
  final String? isVip;

  @JsonKey(name: 'isPay')
  final String? isPay;

  @JsonKey(name: 'updateTime')
  final String? updateTime;

  @JsonKey(name: 'nextTocUrl')
  final String? nextTocUrl;

  const TocRule({
    this.preUpdateJs,
    this.chapterList,
    this.chapterName,
    this.chapterUrl,
    this.formatJs,
    this.isVolume,
    this.isVip,
    this.isPay,
    this.updateTime,
    this.nextTocUrl,
  });

  factory TocRule.fromJson(Map<String, dynamic> json) =>
      _$TocRuleFromJson(json);

  Map<String, dynamic> toJson() => _$TocRuleToJson(this);
}
