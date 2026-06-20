// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bookmark _$BookmarkFromJson(Map<String, dynamic> json) => Bookmark(
  time: (json['time'] as num).toInt(),
  bookUrl: json['bookUrl'] as String,
  bookName: json['bookName'] as String,
  chapterIndex: (json['chapterIndex'] as num).toInt(),
  chapterPos: (json['chapterPos'] as num).toInt(),
  bookText: json['bookText'] as String,
  content: json['content'] as String?,
);

Map<String, dynamic> _$BookmarkToJson(Bookmark instance) => <String, dynamic>{
  'time': instance.time,
  'bookUrl': instance.bookUrl,
  'bookName': instance.bookName,
  'chapterIndex': instance.chapterIndex,
  'chapterPos': instance.chapterPos,
  'bookText': instance.bookText,
  'content': instance.content,
};
