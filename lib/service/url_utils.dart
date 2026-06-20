/// 相对 URL 解析（RuleEngine 与 AnalyzeUrl 共用，消除重复实现）。
///
/// - 已是 http(s) 绝对地址：原样返回
/// - baseUrl 为空：原样返回 url
/// - `//` 协议相对：补 scheme
/// - `/` 根路径相对：补 host
/// - 其他：按 baseUrl 所在目录拼接
String resolveRelativeUrl(String? baseUrl, String url) {
  if (url.startsWith('http://') || url.startsWith('https://')) {
    return url;
  }
  if (baseUrl == null || baseUrl.isEmpty) return url;
  if (url.startsWith('//')) {
    return '${Uri.parse(baseUrl).scheme}:$url';
  }
  if (url.startsWith('/')) {
    final uri = Uri.parse(baseUrl);
    return '${uri.scheme}://${uri.host}$url';
  }
  final base = baseUrl.substring(0, baseUrl.lastIndexOf('/') + 1);
  return '$base$url';
}
