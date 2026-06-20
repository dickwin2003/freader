// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dict_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DictRule _$DictRuleFromJson(Map<String, dynamic> json) => DictRule(
  name: json['name'] as String,
  urlRule: json['urlRule'] as String,
  enabled: json['enabled'] as bool? ?? true,
  sortNumber: (json['sortNumber'] as num?)?.toInt() ?? 0,
  showRule: json['showRule'] as String?,
  enabledExplore: json['enabledExplore'] as bool? ?? true,
);

Map<String, dynamic> _$DictRuleToJson(DictRule instance) => <String, dynamic>{
  'name': instance.name,
  'urlRule': instance.urlRule,
  'enabled': instance.enabled,
  'sortNumber': instance.sortNumber,
  'showRule': instance.showRule,
  'enabledExplore': instance.enabledExplore,
};
