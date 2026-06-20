// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_tts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpTTS _$HttpTTSFromJson(Map<String, dynamic> json) => HttpTTS(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  url: json['url'] as String,
  header: json['header'] as String?,
  loginCheckJs: json['loginCheckJs'] as String?,
  loginUrl: json['loginUrl'] as String?,
  loginUi: json['loginUi'] as String?,
  comment: json['comment'] as String?,
  group: json['group'] as String?,
  sortNumber: (json['sortNumber'] as num?)?.toInt() ?? 0,
  enabled: json['enabled'] as bool? ?? true,
);

Map<String, dynamic> _$HttpTTSToJson(HttpTTS instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'url': instance.url,
  'header': instance.header,
  'loginCheckJs': instance.loginCheckJs,
  'loginUrl': instance.loginUrl,
  'loginUi': instance.loginUi,
  'comment': instance.comment,
  'group': instance.group,
  'sortNumber': instance.sortNumber,
  'enabled': instance.enabled,
};
