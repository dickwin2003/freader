// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'txt_toc_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TxtTocRule _$TxtTocRuleFromJson(Map<String, dynamic> json) => TxtTocRule(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  rule: json['rule'] as String,
  enabled: json['enabled'] as bool? ?? true,
  serialNumber: (json['serialNumber'] as num?)?.toInt() ?? 0,
  example: json['example'] as String?,
);

Map<String, dynamic> _$TxtTocRuleToJson(TxtTocRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rule': instance.rule,
      'enabled': instance.enabled,
      'serialNumber': instance.serialNumber,
      'example': instance.example,
    };
