import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';

import 'package:freader/providers/book_source_providers.dart';

/// 微软 Edge TTS（神经语音，免费、无 key）。走 Edge "大声朗读" 接口（非官方）。
///
/// 流程：取 auth token → WS 连 speech.platform.bing.com → 发 config+SSML
/// → 收二进制音频块拼成 mp3。
class EdgeTtsService {
  EdgeTtsService(this._dio);
  final Dio _dio;

  static const _token = '6A5AA1D4EAFF4E9FB37E23D68491D6F4';
  static const _wsHost = 'speech.platform.bing.com';
  static const _authUrl = 'https://edge.microsoft.com/translate/auth';

  /// 语音名 → 默认音色（神经）。可按需扩展。
  /// key 是 BCP47 前缀，未命中回退 en-US-JennyNeural。
  static const defaultVoices = {
    'zh': 'zh-CN-XiaoxiaoNeural',
    'en': 'en-US-JennyNeural',
    'ja': 'ja-JP-NanamiNeural',
    'ko': 'ko-KR-SunHiNeural',
    'fr': 'fr-FR-DeniseNeural',
    'de': 'de-DE-KatjaNeural',
    'es': 'es-ES-ElviraNeural',
    'ru': 'ru-RU-SvetlanaNeural',
    'th': 'th-TH-PremwadeeNeural',
    'vi': 'vi-VN-HoaiMyNeural',
    'pt': 'pt-BR-FranciscaNeural',
    'it': 'it-IT-ElsaNeural',
    'ar': 'ar-SA-ZariyahNeural',
  };

  /// 按 BCP47 前缀选默认音色。
  static String voiceFor(String bcp47) {
    final lower = bcp47.toLowerCase();
    for (final entry in defaultVoices.entries) {
      if (lower.startsWith(entry.key)) return entry.value;
    }
    return 'en-US-JennyNeural';
  }

  /// 合成语音，返回 mp3 字节。失败抛异常。
  Future<Uint8List> synthesize({
    required String text,
    required String voice,
    String rate = '+0%',
    String pitch = '+0%',
    String volume = '+0%',
  }) async {
    if (text.trim().isEmpty) {
      throw ArgumentError('text 为空');
    }

    final token = (await _dio.get<String>(_authUrl)).data;
    if (token == null || token.isEmpty) {
      throw Exception('获取 Edge TTS token 失败');
    }

    final connectionId = _uuid();

    // 显式拼 wss URL（避免 Uri 构造出 https:0 的问题）
    final wsUrl = Uri.parse(
        'wss://$_wsHost/consumer/speech/synthesize/readaloud/edge/v1'
        '?TrustedClientToken=$_token&ConnectionId=$connectionId');

    // 握手必须带 Authorization（Edge 要求，否则拒绝升级协议）
    final channel = IOWebSocketChannel.connect(
      wsUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Origin': 'chrome-extension://jdiccldimpdaibmpdkjnbmckianbfold',
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                '(KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36 Edg/130.0.0.0',
      },
      pingInterval: const Duration(seconds: 15),
    );
    try {
      // 握手 headers（部分平台会忽略；token 也作为 query 备用）
      channel.sink.add(_configMessage(connectionId));

      final done = Completer<Uint8List>();
      final sink = BytesBuilder();

      channel.stream.listen(
        (event) {
          if (event is! List<int>) {
            if (event is String && event.contains('Path:turn.end')) {
              if (!done.isCompleted) {
                done.complete(sink.takeBytes());
              }
            }
            return;
          }
          // 二进制帧：前 2 字节是大端 header 长度，其后是 header 文本，再后是音频
          final data = Uint8List.fromList(event);
          if (data.length < 2) return; // 防 short/心跳帧越界
          final headerLen = (data[0] << 8) | data[1];
          if (data.length > 2 + headerLen) {
            sink.add(Uint8List.sublistView(data, 2 + headerLen));
          }
        },
        onError: (e) {
          if (!done.isCompleted) done.completeError(Exception('Edge TTS WS 错误: $e'));
        },
        onDone: () {
          if (!done.isCompleted) {
            final b = sink.takeBytes();
            if (b.isEmpty) {
              done.completeError(Exception('Edge TTS 未返回音频'));
            } else {
              done.complete(b);
            }
          }
        },
        cancelOnError: true,
      );

      final ssml = _ssml(voice, rate, pitch, volume, text);
      channel.sink.add(_ssmlMessage(ssml));

      final result = await done.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw Exception('Edge TTS 超时'),
      );
      if (result.isEmpty) throw Exception('Edge TTS 返回空音频');
      return result;
    } finally {
      await channel.sink.close();
    }
  }

  String _configMessage(String connectionId) {
    // Edge 的 config 消息（文本）
    final now = DateTime.now().toUtc();
    return 'X-Timestamp:${now.toIso8601String()}\r\n'
        'Content-Type:application/json; charset=utf-8\r\n'
        'Path:speech.config\r\n'
        '\r\n'
        '{"context":{"synthesis":{"audio":{"metadataoptions":{"sentenceBoundaryEnabled":"false","wordBoundaryEnabled":"true"},"outputFormat":"audio-24khz-48kbitrate-mono-mp3"}}}}\r\n';
  }

  String _ssmlMessage(String ssml) {
    final now = DateTime.now().toUtc();
    return 'X-RequestId:${_uuid()}\r\n'
        'Content-Type:application/ssml+xml\r\n'
        'X-Timestamp:${now.toIso8601String()}\r\n'
        'Path:ssml\r\n'
        '\r\n'
        '$ssml\r\n';
  }

  String _ssml(String voice, String rate, String pitch, String volume, String text) {
    return '<speak version=\'1.0\' xmlns=\'http://www.w3.org/2001/10/synthesis\' xml:lang=\'en-US\'>'
        "<voice name='$voice'><prosody pitch='$pitch' rate='$rate' volume='$volume'>$text</prosody></voice>"
        '</speak>';
  }

  String _uuid() {
    final r = List<int>.generate(16, (_) => _rand.nextInt(256));
    r[6] = (r[6] & 0x0F) | 0x40;
    r[8] = (r[8] & 0x3F) | 0x80;
    final hex = r.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-'
        '${hex.substring(16, 20)}-${hex.substring(20)}';
  }

  static final _rand = _Rng();
}

class _Rng {
  int nextInt(int max) {
    // 简单确定性替代（UUID 只需唯一，不要求密码学随机）
    final t = DateTime.now().microsecondsSinceEpoch;
    return (t ^ (t >> 8) ^ (Object().hashCode & 0xffff)) % max;
  }
}

final edgeTtsServiceProvider = Provider<EdgeTtsService>(
    (ref) => EdgeTtsService(ref.watch(dioProvider)));
