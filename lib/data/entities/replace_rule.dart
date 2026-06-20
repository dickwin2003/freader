import 'package:json_annotation/json_annotation.dart';

part 'replace_rule.g.dart';

/// 替换规则实体
@JsonSerializable(explicitToJson: true)
class ReplaceRule {
  /// 规则 ID
  @JsonKey(name: 'id')
  final int? id;

  /// 排序序号
  @JsonKey(name: 'order')
  final int order;

  /// 是否启用
  @JsonKey(name: 'isEnabled')
  final bool isEnabled;

  /// 正则表达式
  @JsonKey(name: 'regex')
  final String regex;

  /// 替换内容
  @JsonKey(name: 'replacement')
  final String replacement;

  /// 适用范围（书源 URL，逗号分隔，空=全部）
  @JsonKey(name: 'scope')
  final String? scope;

  /// 规则名称
  @JsonKey(name: 'name')
  final String? name;

  /// 分组
  @JsonKey(name: 'group')
  final String? group;

  /// 是否正则模式
  @JsonKey(name: 'isRegex')
  final bool isRegex;

  /// 是否作用于标题
  @JsonKey(name: 'act')
  final bool act;

  /// 示例文本
  @JsonKey(name: 'example')
  final String? example;

  const ReplaceRule({
    this.id,
    this.order = 0,
    this.isEnabled = true,
    required this.regex,
    this.replacement = '',
    this.scope,
    this.name,
    this.group,
    this.isRegex = true,
    this.act = true,
    this.example,
  });

  factory ReplaceRule.fromJson(Map<String, dynamic> json) =>
      _$ReplaceRuleFromJson(json);

  Map<String, dynamic> toJson() => _$ReplaceRuleToJson(this);
}
