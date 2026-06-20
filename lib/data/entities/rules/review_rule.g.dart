// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewRule _$ReviewRuleFromJson(Map<String, dynamic> json) => ReviewRule(
  reviewUrl: json['reviewUrl'] as String?,
  avatarRule: json['avatarRule'] as String?,
  contentRule: json['contentRule'] as String?,
  postUrl: json['postUrl'] as String?,
);

Map<String, dynamic> _$ReviewRuleToJson(ReviewRule instance) =>
    <String, dynamic>{
      'reviewUrl': instance.reviewUrl,
      'avatarRule': instance.avatarRule,
      'contentRule': instance.contentRule,
      'postUrl': instance.postUrl,
    };
