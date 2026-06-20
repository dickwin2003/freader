// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookProgress _$BookProgressFromJson(Map<String, dynamic> json) => BookProgress(
  bookUrl: json['bookUrl'] as String,
  name: json['name'] as String,
  author: json['author'] as String,
  totalChapterNum: (json['totalChapterNum'] as num).toInt(),
  durChapterIndex: (json['durChapterIndex'] as num).toInt(),
  durChapterTitle: json['durChapterTitle'] as String?,
  durChapterPos: (json['durChapterPos'] as num).toInt(),
  deviceName: json['deviceName'] as String?,
  deviceGroupId: json['deviceGroupId'] as String?,
  lastReadTime: (json['lastReadTime'] as num).toInt(),
);

Map<String, dynamic> _$BookProgressToJson(BookProgress instance) =>
    <String, dynamic>{
      'bookUrl': instance.bookUrl,
      'name': instance.name,
      'author': instance.author,
      'totalChapterNum': instance.totalChapterNum,
      'durChapterIndex': instance.durChapterIndex,
      'durChapterTitle': instance.durChapterTitle,
      'durChapterPos': instance.durChapterPos,
      'deviceName': instance.deviceName,
      'deviceGroupId': instance.deviceGroupId,
      'lastReadTime': instance.lastReadTime,
    };
