import 'package:json_annotation/json_annotation.dart';

part 'search_keyword.g.dart';

/// 搜索关键词实体
@JsonSerializable(explicitToJson: true)
class SearchKeyword {
  /// 关键词（主键）
  @JsonKey(name: 'word')
  final String word;

  /// 使用次数
  @JsonKey(name: 'usage')
  final int usage;

  /// 最后使用时间
  @JsonKey(name: 'lastUseTime')
  final int lastUseTime;

  const SearchKeyword({
    required this.word,
    this.usage = 0,
    required this.lastUseTime,
  });

  factory SearchKeyword.fromJson(Map<String, dynamic> json) =>
      _$SearchKeywordFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeywordToJson(this);
}
