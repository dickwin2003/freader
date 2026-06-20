import 'package:json_annotation/json_annotation.dart';

part 'book_group.g.dart';

/// 书籍分组实体 - 对应 Legado BookGroup
@JsonSerializable(explicitToJson: true)
class BookGroup {
  /// 分组 ID（主键）
  @JsonKey(name: 'groupId')
  final int groupId;

  /// 分组名称
  @JsonKey(name: 'groupName')
  final String groupName;

  /// 排序序号
  @JsonKey(name: 'order')
  final int order;

  /// 是否显示
  @JsonKey(name: 'show')
  final bool show;

  const BookGroup({
    required this.groupId,
    required this.groupName,
    this.order = 0,
    this.show = true,
  });

  factory BookGroup.fromJson(Map<String, dynamic> json) =>
      _$BookGroupFromJson(json);

  Map<String, dynamic> toJson() => _$BookGroupToJson(this);
}
