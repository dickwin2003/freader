import 'package:json_annotation/json_annotation.dart';

part 'book_progress.g.dart';

/// 阅读进度实体 - 对应 Legado BookProgress
@JsonSerializable(explicitToJson: true)
class BookProgress {
  /// 书籍 URL
  @JsonKey(name: 'bookUrl')
  final String bookUrl;

  /// 书名
  @JsonKey(name: 'name')
  final String name;

  /// 作者
  @JsonKey(name: 'author')
  final String author;

  /// 总章节数
  @JsonKey(name: 'totalChapterNum')
  final int totalChapterNum;

  /// 当前章节索引
  @JsonKey(name: 'durChapterIndex')
  final int durChapterIndex;

  /// 当前章节标题
  @JsonKey(name: 'durChapterTitle')
  final String? durChapterTitle;

  /// 当前位置
  @JsonKey(name: 'durChapterPos')
  final int durChapterPos;

  /// 设备名称
  @JsonKey(name: 'deviceName')
  final String? deviceName;

  /// 设备 ID
  @JsonKey(name: 'deviceGroupId')
  final String? deviceGroupId;

  /// 最后阅读时间
  @JsonKey(name: 'lastReadTime')
  final int lastReadTime;

  const BookProgress({
    required this.bookUrl,
    required this.name,
    required this.author,
    required this.totalChapterNum,
    required this.durChapterIndex,
    this.durChapterTitle,
    required this.durChapterPos,
    this.deviceName,
    this.deviceGroupId,
    required this.lastReadTime,
  });

  factory BookProgress.fromJson(Map<String, dynamic> json) =>
      _$BookProgressFromJson(json);

  Map<String, dynamic> toJson() => _$BookProgressToJson(this);
}
