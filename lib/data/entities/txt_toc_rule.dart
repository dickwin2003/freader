import 'package:json_annotation/json_annotation.dart';

part 'txt_toc_rule.g.dart';

/// TXT 目录规则实体
@JsonSerializable(explicitToJson: true)
class TxtTocRule {
  /// 规则 ID
  @JsonKey(name: 'id')
  final int? id;

  /// 规则名称
  @JsonKey(name: 'name')
  final String name;

  /// 规则内容（正则表达式）
  @JsonKey(name: 'rule')
  final String rule;

  /// 是否启用
  @JsonKey(name: 'enabled')
  final bool enabled;

  /// 排序序号
  @JsonKey(name: 'serialNumber')
  final int serialNumber;

  /// 示例文本
  @JsonKey(name: 'example')
  final String? example;

  const TxtTocRule({
    this.id,
    required this.name,
    required this.rule,
    this.enabled = true,
    this.serialNumber = 0,
    this.example,
  });

  factory TxtTocRule.fromJson(Map<String, dynamic> json) =>
      _$TxtTocRuleFromJson(json);

  Map<String, dynamic> toJson() => _$TxtTocRuleToJson(this);
}
