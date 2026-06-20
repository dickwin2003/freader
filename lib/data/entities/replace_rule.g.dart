// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replace_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplaceRule _$ReplaceRuleFromJson(Map<String, dynamic> json) => ReplaceRule(
  id: (json['id'] as num?)?.toInt(),
  order: (json['order'] as num?)?.toInt() ?? 0,
  isEnabled: json['isEnabled'] as bool? ?? true,
  regex: json['regex'] as String,
  replacement: json['replacement'] as String? ?? '',
  scope: json['scope'] as String?,
  name: json['name'] as String?,
  group: json['group'] as String?,
  isRegex: json['isRegex'] as bool? ?? true,
  act: json['act'] as bool? ?? true,
  example: json['example'] as String?,
);

Map<String, dynamic> _$ReplaceRuleToJson(ReplaceRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'isEnabled': instance.isEnabled,
      'regex': instance.regex,
      'replacement': instance.replacement,
      'scope': instance.scope,
      'name': instance.name,
      'group': instance.group,
      'isRegex': instance.isRegex,
      'act': instance.act,
      'example': instance.example,
    };
