import 'package:json_annotation/json_annotation.dart';

part 'bookmark.g.dart';

/// 书签实体 - 对应 Legado Bookmark
@JsonSerializable(explicitToJson: true)
class Bookmark {
  /// 书签 ID
  @JsonKey(name: 'time')
  final int time;

  /// 书籍 URL
  @JsonKey(name: 'bookUrl')
  final String bookUrl;

  /// 书名
  @JsonKey(name: 'bookName')
  final String bookName;

  /// 章节索引
  @JsonKey(name: 'chapterIndex')
  final int chapterIndex;

  /// 章节标题
  @JsonKey(name: 'chapterPos')
  final int chapterPos;

  /// 书签名称
  @JsonKey(name: 'bookText')
  final String bookText;

  /// 内容文本
  @JsonKey(name: 'content')
  final String? content;

  const Bookmark({
    required this.time,
    required this.bookUrl,
    required this.bookName,
    required this.chapterIndex,
    required this.chapterPos,
    required this.bookText,
    this.content,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkToJson(this);
}
