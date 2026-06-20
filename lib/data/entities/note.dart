import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

/// 笔记实体 - 心得/读后感（可关联书与章节）
@JsonSerializable(explicitToJson: true)
class Note {
  /// 主键（新建时传 0，由 DB 自增）
  @JsonKey(name: 'id')
  final int id;

  /// 标题
  @JsonKey(name: 'title')
  final String title;

  /// 正文
  @JsonKey(name: 'content')
  final String content;

  /// 关联书籍 URL（可空）
  @JsonKey(name: 'bookUrl')
  final String? bookUrl;

  /// 关联书籍名称（可空）
  @JsonKey(name: 'bookName')
  final String? bookName;

  /// 关联章节索引（可空）
  @JsonKey(name: 'chapterIndex')
  final int? chapterIndex;

  /// 创建时间（毫秒）
  @JsonKey(name: 'createTime')
  final int createTime;

  /// 更新时间（毫秒）
  @JsonKey(name: 'updateTime')
  final int updateTime;

  const Note({
    required this.id,
    this.title = '',
    this.content = '',
    this.bookUrl,
    this.bookName,
    this.chapterIndex,
    required this.createTime,
    required this.updateTime,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  Note copyWith({
    int? id,
    String? title,
    String? content,
    String? bookUrl,
    String? bookName,
    int? chapterIndex,
    int? createTime,
    int? updateTime,
    bool clearBook = false,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      bookUrl: clearBook ? null : (bookUrl ?? this.bookUrl),
      bookName: clearBook ? null : (bookName ?? this.bookName),
      chapterIndex: chapterIndex ?? this.chapterIndex,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}
