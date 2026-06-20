import 'package:json_annotation/json_annotation.dart';

part 'book_chapter.g.dart';

/// 书籍章节实体
@JsonSerializable(explicitToJson: true)
class BookChapter {
  /// 章节 URL（联合主键）
  @JsonKey(name: 'url')
  final String url;

  /// 章节标题
  @JsonKey(name: 'title')
  final String title;

  /// 是否为卷标
  @JsonKey(name: 'isVolume')
  final bool isVolume;

  /// 基础 URL
  @JsonKey(name: 'baseUrl')
  final String? baseUrl;

  /// 所属书籍 URL（联合主键）
  @JsonKey(name: 'bookUrl')
  final String bookUrl;

  /// 章节索引
  @JsonKey(name: 'index')
  final int index;

  /// 是否 VIP 章节
  @JsonKey(name: 'isVip')
  final bool isVip;

  /// 是否付费章节
  @JsonKey(name: 'isPay')
  final bool isPay;

  /// 资源 URL
  @JsonKey(name: 'resourceUrl')
  final String? resourceUrl;

  /// 标签
  @JsonKey(name: 'tag')
  final String? tag;

  /// 字数
  @JsonKey(name: 'wordCount')
  final String? wordCount;

  /// 起始位置（EPUB 用）
  @JsonKey(name: 'start')
  final int? start;

  /// 结束位置（EPUB 用）
  @JsonKey(name: 'end')
  final int? end;

  /// 起始片段 ID（EPUB 用）
  @JsonKey(name: 'startFragmentId')
  final String? startFragmentId;

  /// 结束片段 ID（EPUB 用）
  @JsonKey(name: 'endFragmentId')
  final String? endFragmentId;

  /// 变量存储
  @JsonKey(name: 'variable')
  final String? variable;

  const BookChapter({
    required this.url,
    required this.title,
    required this.bookUrl,
    required this.index,
    this.isVolume = false,
    this.baseUrl,
    this.isVip = false,
    this.isPay = false,
    this.resourceUrl,
    this.tag,
    this.wordCount,
    this.start,
    this.end,
    this.startFragmentId,
    this.endFragmentId,
    this.variable,
  });

  factory BookChapter.fromJson(Map<String, dynamic> json) =>
      _$BookChapterFromJson(json);

  Map<String, dynamic> toJson() => _$BookChapterToJson(this);
}
