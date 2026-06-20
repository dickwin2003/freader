import 'dart:convert';
import 'package:dio/dio.dart';

/// URL 分析与请求构建
/// 处理 URL 模板、请求头、POST 请求等
class AnalyzeUrl {
  final Dio _dio;

  AnalyzeUrl(this._dio);

  /// 发起 HTTP 请求并返回响应内容
  Future<String> fetchUrl(
    String urlTemplate, {
    Map<String, String>? variables,
    Map<String, String>? extraHeaders,
    String? sourceUrl,
  }) async {
    // 解析 URL 模板
    final urlInfo = _parseUrlTemplate(urlTemplate, variables ?? {});
    final url = _resolveUrl(sourceUrl, urlInfo.url);

    // 构建请求头
    final headers = <String, String>{
      'User-Agent':
          'Mozilla/5.0 (Linux; Android 14) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
    };
    if (extraHeaders != null) {
      headers.addAll(extraHeaders);
    }
    if (urlInfo.headers != null) {
      headers.addAll(urlInfo.headers!);
    }

    // 发起请求
    final options = Options(
      method: urlInfo.method,
      headers: headers,
      responseType: ResponseType.plain,
      receiveTimeout: const Duration(seconds: 20),
    );

    Object? body;
    if (urlInfo.body != null) {
      body = urlInfo.body;
    }

    final response = await _dio.request<String>(
      url,
      data: body,
      options: options,
    );

    return response.data ?? '';
  }

  /// 解析 URL 模板
  /// 格式: "url" 或 "url,{JSON配置}"
  _UrlInfo _parseUrlTemplate(
      String template, Map<String, String> variables) {
    String url = template.trim();
    String method = 'GET';
    Map<String, String>? headers;
    String? body;

    // 替换模板变量 {{key}}
    for (final entry in variables.entries) {
      url = url.replaceAll('{{${entry.key}}}', entry.value);
      url = url.replaceAll('\${${entry.key}}', entry.value);
    }

    // 检查是否包含 JSON 配置（逗号分隔）
    // 格式: "url,{\"method\":\"POST\",\"body\":\"...\"}"
    if (url.contains(',{')) {
      final commaIdx = url.indexOf(',{');
      final urlPart = url.substring(0, commaIdx);
      final configStr = url.substring(commaIdx + 1);

      try {
        final config = jsonDecode(configStr) as Map<String, dynamic>;

        url = urlPart;

        if (config.containsKey('method')) {
          method = (config['method'] as String).toUpperCase();
        }
        if (config.containsKey('body')) {
          body = config['body'] as String;
          // 替换 body 中的模板变量
          for (final entry in variables.entries) {
            body = body!
                .replaceAll('{{${entry.key}}}', entry.value)
                .replaceAll('\${${entry.key}}', entry.value);
          }
          if (method == 'GET') method = 'POST';
        }
        if (config.containsKey('headers')) {
          final h = config['headers'];
          if (h is Map) {
            headers = Map<String, String>.from(
              h.map((k, v) => MapEntry(k.toString(), v.toString())),
            );
          }
        }
        if (config.containsKey('webView')) {
          // WebView 配置暂不处理
        }
      } catch (_) {
        // JSON 解析失败，使用原始 URL
      }
    }

    return _UrlInfo(
      url: url,
      method: method,
      headers: headers,
      body: body,
    );
  }

  /// 解析相对 URL
  static String resolveUrl(String? baseUrl, String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    if (baseUrl == null || baseUrl.isEmpty) return url;
    if (url.startsWith('//')) {
      final uri = Uri.parse(baseUrl);
      return '${uri.scheme}:$url';
    }
    if (url.startsWith('/')) {
      final uri = Uri.parse(baseUrl);
      return '${uri.scheme}://${uri.host}$url';
    }
    final base = baseUrl.substring(0, baseUrl.lastIndexOf('/') + 1);
    return '$base$url';
  }

  String _resolveUrl(String? baseUrl, String url) {
    return resolveUrl(baseUrl, url);
  }

  /// 解析书源 header 字段
  static Map<String, String>? parseHeader(String? headerStr) {
    if (headerStr == null || headerStr.isEmpty) return null;
    try {
      final decoded = jsonDecode(headerStr);
      if (decoded is Map) {
        return Map<String, String>.from(
          decoded.map((k, v) => MapEntry(k.toString(), v.toString())),
        );
      }
    } catch (_) {
      // 非 JSON 格式，忽略
    }
    return null;
  }
}

/// URL 解析结果
class _UrlInfo {
  final String url;
  final String method;
  final Map<String, String>? headers;
  final String? body;

  const _UrlInfo({
    required this.url,
    this.method = 'GET',
    this.headers,
    this.body,
  });
}
