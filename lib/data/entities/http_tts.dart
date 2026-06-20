import 'package:json_annotation/json_annotation.dart';

part 'http_tts.g.dart';

/// HTTP TTS 引擎实体 - 对应 Legado HttpTTS
@JsonSerializable(explicitToJson: true)
class HttpTTS {
  /// TTS ID
  @JsonKey(name: 'id')
  final int? id;

  /// TTS 名称
  @JsonKey(name: 'name')
  final String name;

  /// TTS URL
  @JsonKey(name: 'url')
  final String url;

  /// 请求头
  @JsonKey(name: 'header')
  final String? header;

  /// 登录检查
  @JsonKey(name: 'loginCheckJs')
  final String? loginCheckJs;

  /// 登录 URL
  @JsonKey(name: 'loginUrl')
  final String? loginUrl;

  /// 登录 UI
  @JsonKey(name: 'loginUi')
  final String? loginUi;

  /// 备注
  @JsonKey(name: 'comment')
  final String? comment;

  /// 分组
  @JsonKey(name: 'group')
  final String? group;

  /// 排序
  @JsonKey(name: 'sortNumber')
  final int sortNumber;

  /// 是否启用
  @JsonKey(name: 'enabled')
  final bool enabled;

  const HttpTTS({
    this.id,
    required this.name,
    required this.url,
    this.header,
    this.loginCheckJs,
    this.loginUrl,
    this.loginUi,
    this.comment,
    this.group,
    this.sortNumber = 0,
    this.enabled = true,
  });

  factory HttpTTS.fromJson(Map<String, dynamic> json) =>
      _$HttpTTSFromJson(json);

  Map<String, dynamic> toJson() => _$HttpTTSToJson(this);
}
