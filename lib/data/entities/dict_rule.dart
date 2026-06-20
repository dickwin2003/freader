import 'package:json_annotation/json_annotation.dart';

part 'dict_rule.g.dart';

/// 字典规则实体
@JsonSerializable(explicitToJson: true)
class DictRule {
  /// 规则名称（主键）
  @JsonKey(name: 'name')
  final String name;

  /// URL 模板
  @JsonKey(name: 'urlRule')
  final String urlRule;

  /// 是否启用
  @JsonKey(name: 'enabled')
  final bool enabled;

  /// 排序
  @JsonKey(name: 'sortNumber')
  final int sortNumber;

  /// 显示规则
  @JsonKey(name: 'showRule')
  final String? showRule;

  /// 启用 JS
  @JsonKey(name: 'enabledExplore')
  final bool enabledExplore;

  const DictRule({
    required this.name,
    required this.urlRule,
    this.enabled = true,
    this.sortNumber = 0,
    this.showRule,
    this.enabledExplore = true,
  });

  factory DictRule.fromJson(Map<String, dynamic> json) =>
      _$DictRuleFromJson(json);

  Map<String, dynamic> toJson() => _$DictRuleToJson(this);
}
