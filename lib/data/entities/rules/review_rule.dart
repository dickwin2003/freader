import 'package:json_annotation/json_annotation.dart';

part 'review_rule.g.dart';

/// 评论规则
@JsonSerializable(explicitToJson: true)
class ReviewRule {
  @JsonKey(name: 'reviewUrl')
  final String? reviewUrl;

  @JsonKey(name: 'avatarRule')
  final String? avatarRule;

  @JsonKey(name: 'contentRule')
  final String? contentRule;

  @JsonKey(name: 'postUrl')
  final String? postUrl;

  const ReviewRule({
    this.reviewUrl,
    this.avatarRule,
    this.contentRule,
    this.postUrl,
  });

  factory ReviewRule.fromJson(Map<String, dynamic> json) =>
      _$ReviewRuleFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewRuleToJson(this);
}
