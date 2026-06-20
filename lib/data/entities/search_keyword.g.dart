// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_keyword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchKeyword _$SearchKeywordFromJson(Map<String, dynamic> json) =>
    SearchKeyword(
      word: json['word'] as String,
      usage: (json['usage'] as num?)?.toInt() ?? 0,
      lastUseTime: (json['lastUseTime'] as num).toInt(),
    );

Map<String, dynamic> _$SearchKeywordToJson(SearchKeyword instance) =>
    <String, dynamic>{
      'word': instance.word,
      'usage': instance.usage,
      'lastUseTime': instance.lastUseTime,
    };
