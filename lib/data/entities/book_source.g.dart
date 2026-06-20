// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookSource _$BookSourceFromJson(Map<String, dynamic> json) => BookSource(
  bookSourceUrl: json['bookSourceUrl'] as String,
  bookSourceName: json['bookSourceName'] as String,
  bookSourceGroup: json['bookSourceGroup'] as String?,
  bookSourceComment: json['bookSourceComment'] as String?,
  enabledReview: json['enabledReview'] as bool?,
  bookSourceType:
      (json['bookSourceType'] as num?)?.toInt() ?? BookSourceType.text,
  bookUrlPattern: json['bookUrlPattern'] as String?,
  customOrder: (json['customOrder'] as num?)?.toInt() ?? 0,
  enabled: json['enabled'] as bool? ?? true,
  enabledExplore: json['enabledExplore'] as bool? ?? true,
  enabledCookieJar: json['enabledCookieJar'] as bool? ?? false,
  jsLib: json['jsLib'] as String?,
  concurrentRate: json['concurrentRate'] as String?,
  header: json['header'] as String?,
  loginUrl: json['loginUrl'] as String?,
  loginUi: json['loginUi'] as String?,
  loginCheckJs: json['loginCheckJs'] as String?,
  searchUrl: json['searchUrl'] as String?,
  exploreUrl: json['exploreUrl'] as String?,
  exploreScreen: json['exploreScreen'] as String?,
  ruleSearch: json['ruleSearch'] == null
      ? null
      : SearchRule.fromJson(json['ruleSearch'] as Map<String, dynamic>),
  ruleExplore: json['ruleExplore'] == null
      ? null
      : ExploreRule.fromJson(json['ruleExplore'] as Map<String, dynamic>),
  ruleBookInfo: json['ruleBookInfo'] == null
      ? null
      : BookInfoRule.fromJson(json['ruleBookInfo'] as Map<String, dynamic>),
  ruleToc: json['ruleToc'] == null
      ? null
      : TocRule.fromJson(json['ruleToc'] as Map<String, dynamic>),
  ruleContent: json['ruleContent'] == null
      ? null
      : ContentRule.fromJson(json['ruleContent'] as Map<String, dynamic>),
  ruleReview: json['ruleReview'] == null
      ? null
      : ReviewRule.fromJson(json['ruleReview'] as Map<String, dynamic>),
  respondTime: (json['respondTime'] as num?)?.toInt() ?? 180000,
  lastUpdateTime: (json['lastUpdateTime'] as num?)?.toInt(),
  variable: json['variable'] as String?,
  weight: (json['weight'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$BookSourceToJson(BookSource instance) =>
    <String, dynamic>{
      'bookSourceUrl': instance.bookSourceUrl,
      'bookSourceName': instance.bookSourceName,
      'bookSourceGroup': instance.bookSourceGroup,
      'bookSourceComment': instance.bookSourceComment,
      'enabledReview': instance.enabledReview,
      'bookSourceType': instance.bookSourceType,
      'bookUrlPattern': instance.bookUrlPattern,
      'customOrder': instance.customOrder,
      'enabled': instance.enabled,
      'enabledExplore': instance.enabledExplore,
      'enabledCookieJar': instance.enabledCookieJar,
      'jsLib': instance.jsLib,
      'concurrentRate': instance.concurrentRate,
      'header': instance.header,
      'loginUrl': instance.loginUrl,
      'loginUi': instance.loginUi,
      'loginCheckJs': instance.loginCheckJs,
      'searchUrl': instance.searchUrl,
      'exploreUrl': instance.exploreUrl,
      'exploreScreen': instance.exploreScreen,
      'ruleSearch': instance.ruleSearch?.toJson(),
      'ruleExplore': instance.ruleExplore?.toJson(),
      'ruleBookInfo': instance.ruleBookInfo?.toJson(),
      'ruleToc': instance.ruleToc?.toJson(),
      'ruleContent': instance.ruleContent?.toJson(),
      'ruleReview': instance.ruleReview?.toJson(),
      'respondTime': instance.respondTime,
      'lastUpdateTime': instance.lastUpdateTime,
      'variable': instance.variable,
      'weight': instance.weight,
    };
