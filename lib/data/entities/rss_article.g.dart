// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rss_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RssArticle _$RssArticleFromJson(Map<String, dynamic> json) => RssArticle(
  url: json['url'] as String,
  origin: json['origin'] as String,
  originName: json['originName'] as String,
  title: json['title'] as String,
  sort: json['sort'] as String?,
  order: (json['order'] as num?)?.toInt() ?? 0,
  pubDate: json['pubDate'] as String?,
  description: json['description'] as String?,
  image: json['image'] as String?,
  link: json['link'] as String?,
  content: json['content'] as String?,
  variable: json['variable'] as String?,
  read: json['read'] as bool? ?? false,
);

Map<String, dynamic> _$RssArticleToJson(RssArticle instance) =>
    <String, dynamic>{
      'url': instance.url,
      'origin': instance.origin,
      'originName': instance.originName,
      'sort': instance.sort,
      'title': instance.title,
      'order': instance.order,
      'pubDate': instance.pubDate,
      'description': instance.description,
      'image': instance.image,
      'link': instance.link,
      'content': instance.content,
      'variable': instance.variable,
      'read': instance.read,
    };
