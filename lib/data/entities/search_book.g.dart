// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBook _$SearchBookFromJson(Map<String, dynamic> json) => SearchBook(
  bookUrl: json['bookUrl'] as String,
  origin: json['origin'] as String,
  originName: json['originName'] as String,
  name: json['name'] as String,
  author: json['author'] as String,
  kind: json['kind'] as String?,
  coverUrl: json['coverUrl'] as String?,
  intro: json['intro'] as String?,
  wordCount: json['wordCount'] as String?,
  latestChapter: json['latestChapter'] as String?,
  updateTime: json['updateTime'] as String?,
  searchTime: (json['searchTime'] as num?)?.toInt(),
  variable: json['variable'] as String?,
  originOrder: (json['originOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$SearchBookToJson(SearchBook instance) =>
    <String, dynamic>{
      'bookUrl': instance.bookUrl,
      'origin': instance.origin,
      'originName': instance.originName,
      'name': instance.name,
      'author': instance.author,
      'kind': instance.kind,
      'coverUrl': instance.coverUrl,
      'intro': instance.intro,
      'wordCount': instance.wordCount,
      'latestChapter': instance.latestChapter,
      'updateTime': instance.updateTime,
      'searchTime': instance.searchTime,
      'variable': instance.variable,
      'originOrder': instance.originOrder,
    };
