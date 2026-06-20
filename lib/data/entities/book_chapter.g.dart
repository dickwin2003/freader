// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookChapter _$BookChapterFromJson(Map<String, dynamic> json) => BookChapter(
  url: json['url'] as String,
  title: json['title'] as String,
  bookUrl: json['bookUrl'] as String,
  index: (json['index'] as num).toInt(),
  isVolume: json['isVolume'] as bool? ?? false,
  baseUrl: json['baseUrl'] as String?,
  isVip: json['isVip'] as bool? ?? false,
  isPay: json['isPay'] as bool? ?? false,
  resourceUrl: json['resourceUrl'] as String?,
  tag: json['tag'] as String?,
  wordCount: json['wordCount'] as String?,
  start: (json['start'] as num?)?.toInt(),
  end: (json['end'] as num?)?.toInt(),
  startFragmentId: json['startFragmentId'] as String?,
  endFragmentId: json['endFragmentId'] as String?,
  variable: json['variable'] as String?,
);

Map<String, dynamic> _$BookChapterToJson(BookChapter instance) =>
    <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'isVolume': instance.isVolume,
      'baseUrl': instance.baseUrl,
      'bookUrl': instance.bookUrl,
      'index': instance.index,
      'isVip': instance.isVip,
      'isPay': instance.isPay,
      'resourceUrl': instance.resourceUrl,
      'tag': instance.tag,
      'wordCount': instance.wordCount,
      'start': instance.start,
      'end': instance.end,
      'startFragmentId': instance.startFragmentId,
      'endFragmentId': instance.endFragmentId,
      'variable': instance.variable,
    };
