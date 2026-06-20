import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'llm_config.dart';
import 'llm_service.dart';

/// 云端 LLM 服务（OpenAI 兼容 /chat/completions 或 Anthropic 兼容 /messages）。
class CloudLlmService implements LlmService {
  final Dio _dio;
  final LlmConfig _config;

  CloudLlmService(this._dio, this._config);

  @override
  bool get isReady => _config.isConfigured;

  @override
  Future<String> chat({
    required String userPrompt,
    String? systemPrompt,
    double? temperature,
    int? maxTokens,
  }) async {
    if (!_config.isConfigured) throw const LlmException.notConfigured();

    final baseSys = _config.systemPrompt.trim();
    final extraSys = (systemPrompt ?? '').trim();
    final mergedSys =
        [baseSys, extraSys].where((s) => s.isNotEmpty).join('\n\n');

    return _config.protocol == LlmProtocol.anthropic
        ? _chatAnthropic(userPrompt, mergedSys, temperature, maxTokens)
        : _chatOpenAi(userPrompt, mergedSys, temperature, maxTokens);
  }

  // ===== OpenAI 兼容 =====
  Future<String> _chatOpenAi(String userPrompt, String mergedSys,
      double? temperature, int? maxTokens) async {
    final base = _config.baseUrl.trim();
    final url = base.endsWith('/')
        ? '${base}chat/completions'
        : '$base/chat/completions';

    final messages = <Map<String, String>>[];
    if (mergedSys.isNotEmpty) {
      messages.add({'role': 'system', 'content': mergedSys});
    }
    messages.add({'role': 'user', 'content': userPrompt});

    try {
      final resp = await _dio.post<dynamic>(
        url,
        data: jsonEncode({
          'model': _config.model,
          'messages': messages,
          'temperature': temperature ?? _config.temperature,
          'max_tokens': ?maxTokens,
        }),
        options: _options(
          headers: {
            'Authorization': 'Bearer ${_config.apiKey}',
            'Content-Type': 'application/json',
          },
        ),
      );
      final map = _asMap(resp.data);
      final choices = map['choices'];
      if (choices is! List || choices.isEmpty) {
        throw LlmException(_emptyError(map));
      }
      final message = (choices[0] as Map)['message'];
      final content = message is Map ? message['content'] : null;
      return (content?.toString() ?? '').trim();
    } on LlmException {
      rethrow;
    } on DioException catch (e) {
      throw LlmException(_mapDioError(e));
    } catch (e) {
      throw LlmException('请求失败: $e');
    }
  }

  // ===== Anthropic 兼容（/messages，Authorization: Bearer） =====
  Future<String> _chatAnthropic(String userPrompt, String mergedSys,
      double? temperature, int? maxTokens) async {
    final base = _config.baseUrl.trim();
    final url = base.endsWith('/') ? '${base}messages' : '$base/messages';

    try {
      final resp = await _dio.post<dynamic>(
        url,
        data: jsonEncode({
          'model': _config.model,
          'max_tokens': maxTokens ?? 1024, // Anthropic 必填
          'messages': [
            {'role': 'user', 'content': userPrompt}
          ],
          if (mergedSys.isNotEmpty) 'system': mergedSys,
          'temperature': ?temperature,
        }),
        options: _options(
          headers: {
            'Authorization': 'Bearer ${_config.apiKey}',
            'anthropic-version': '2023-06-01',
            'Content-Type': 'application/json',
          },
        ),
      );
      final map = _asMap(resp.data);
      final content = map['content'];
      if (content is! List || content.isEmpty) {
        throw LlmException(_emptyError(map));
      }
      // content 是 [{type:'text', text:'...'}, ...]，拼接所有 text 块
      final buf = StringBuffer();
      for (final block in content) {
        if (block is Map && block['type'] == 'text') {
          buf.write(block['text']?.toString() ?? '');
        }
      }
      return buf.toString().trim();
    } on LlmException {
      rethrow;
    } on DioException catch (e) {
      throw LlmException(_mapDioError(e));
    } catch (e) {
      throw LlmException('请求失败: $e');
    }
  }

  Options _options({required Map<String, String> headers}) => Options(
        headers: headers,
        responseType: ResponseType.json,
        // LLM 请求较慢，单独放宽超时，不影响共享 Dio 的默认值
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 120),
      );

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is String) return jsonDecode(data) as Map<String, dynamic>;
    return data as Map<String, dynamic>;
  }

  String _emptyError(Map<String, dynamic> map) {
    final err = map['error'];
    final msg = err is Map ? err['message'] : null;
    return '返回结果为空${msg != null ? '：$msg' : ''}';
  }

  String _mapDioError(DioException e) {
    final code = e.response?.statusCode;
    String detail = '';
    final body = e.response?.data;
    if (body is Map && body['error'] is Map) {
      detail = (body['error'] as Map)['message']?.toString() ?? '';
    }
    final suffix = detail.isNotEmpty ? '：$detail' : '';
    if (code == 401) return 'API Key 无效 (401)$suffix';
    if (code == 403) return '无访问权限 (403)$suffix';
    if (code == 404) return '接口路径不存在 (404)，请检查 baseUrl$suffix';
    if (code == 429) return '请求过频或额度不足 (429)$suffix';
    if (code != null && code >= 500) return '服务端错误 ($code)$suffix';
    return '请求失败: ${e.message ?? e.type.name}$suffix';
  }

  @override
  Future<String> chatWithImage({
    required String userPrompt,
    required Uint8List image,
    String? systemPrompt,
    double? temperature,
  }) {
    throw const LlmException('云端 LLM 暂不支持图片识别，请切换到「本地 Gemma 3n」');
  }

  @override
  Future<String> summarize(String text, {String? instruction}) {
    return chat(
      userPrompt:
          '${instruction ?? "请用中文对以下内容生成简明摘要："}\n\n$text',
      temperature: 0.3,
      maxTokens: 800,
    );
  }

  @override
  Future<String> ping() {
    return chat(
      userPrompt: '回复"OK"两个字。',
      temperature: 0.0,
      maxTokens: 8,
    );
  }
}
