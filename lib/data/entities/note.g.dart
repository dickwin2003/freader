// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String? ?? '',
  content: json['content'] as String? ?? '',
  bookUrl: json['bookUrl'] as String?,
  bookName: json['bookName'] as String?,
  chapterIndex: (json['chapterIndex'] as num?)?.toInt(),
  createTime: (json['createTime'] as num).toInt(),
  updateTime: (json['updateTime'] as num).toInt(),
);

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'bookUrl': instance.bookUrl,
  'bookName': instance.bookName,
  'chapterIndex': instance.chapterIndex,
  'createTime': instance.createTime,
  'updateTime': instance.updateTime,
};
