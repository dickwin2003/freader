import 'dart:convert';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

/// 规则解析引擎
/// 支持 CSS 选择器、JSONPath、XPath(基础) 和正则表达式
class RuleEngine {
  /// 从内容中获取单个字符串值
  static String? getString(dynamic content, String? rule) {
    if (rule == null || rule.isEmpty) return null;
    if (content == null) return null;

    // 处理 || 替代规则（按顺序尝试，返回第一个非空结果）
    if (rule.contains('||')) {
      for (final r in rule.split('||')) {
        final result = getString(content, r.trim());
        if (result != null && result.isNotEmpty) return result;
      }
      return null;
    }

    // 处理 ## 分割（主规则 ## 替换规则）
    String mainRule = rule;
    String? replacement;
    final hashIndex = rule.indexOf('##');
    if (hashIndex >= 0) {
      mainRule = rule.substring(0, hashIndex);
      replacement = rule.substring(hashIndex + 2);
    }

    String? result;

    // 根据规则前缀选择解析器
    if (mainRule.startsWith('@json:')) {
      result = _parseJsonPath(content, mainRule.substring(6));
    } else if (mainRule.startsWith('@css:')) {
      result = _parseCss(content, mainRule.substring(5));
    } else if (mainRule.startsWith('@xpath:')) {
      result = _parseXPath(content, mainRule.substring(7));
    } else if (mainRule.startsWith('@js:')) {
      return null; // JavaScript 暂不支持
    } else if (mainRule.startsWith('\$') || mainRule.startsWith('..')) {
      result = _parseJsonPath(content, mainRule);
    } else if (mainRule.startsWith('//')) {
      result = _parseXPath(content, mainRule);
    } else {
      // 默认：JSON 内容用 JSONPath，HTML 内容用 CSS
      if (content is String && _isJson(content)) {
        result = _parseJsonPath(content, mainRule);
      } else {
        result = _parseCss(content, mainRule);
      }
    }

    // 应用替换规则
    if (result != null && replacement != null) {
      result = applyReplacement(result, replacement);
    }

    return result?.trim();
  }

  /// 获取字符串列表
  static List<String> getStringList(dynamic content, String? rule) {
    if (rule == null || rule.isEmpty) return [];
    if (content == null) return [];

    String mainRule = rule;
    String? replacement;
    final hashIndex = rule.indexOf('##');
    if (hashIndex >= 0) {
      mainRule = rule.substring(0, hashIndex);
      replacement = rule.substring(hashIndex + 2);
    }

    List<String> results;

    if (mainRule.startsWith('@json:')) {
      results = _parseJsonPathList(content, mainRule.substring(6));
    } else if (mainRule.startsWith('@css:')) {
      results = _parseCssList(content, mainRule.substring(5));
    } else if (mainRule.startsWith('\$') || mainRule.startsWith('..')) {
      results = _parseJsonPathList(content, mainRule);
    } else {
      if (content is String && _isJson(content)) {
        results = _parseJsonPathList(content, mainRule);
      } else {
        results = _parseCssList(content, mainRule);
      }
    }

    if (replacement != null) {
      results = results.map((r) => applyReplacement(r, replacement!)).toList();
    }

    return results.map((r) => r.trim()).where((r) => r.isNotEmpty).toList();
  }

  /// 获取元素列表（用于遍历，如书单列表）
  static List<dynamic> getElements(dynamic content, String? rule) {
    if (rule == null || rule.isEmpty) return [];
    if (content == null) return [];

    String mainRule = rule;
    final hashIndex = rule.indexOf('##');
    if (hashIndex >= 0) {
      mainRule = rule.substring(0, hashIndex);
    }

    if (mainRule.startsWith('@json:')) {
      return _getJsonElements(content, mainRule.substring(6));
    } else if (mainRule.startsWith('@css:')) {
      return _getCssElements(content, mainRule.substring(5));
    } else if (mainRule.startsWith('\$') || mainRule.startsWith('..')) {
      return _getJsonElements(content, mainRule);
    } else {
      if (content is String && _isJson(content)) {
        return _getJsonElements(content, mainRule);
      } else {
        return _getCssElements(content, mainRule);
      }
    }
  }

  // ===== CSS 选择器解析 =====

  static String? _parseCss(dynamic content, String rule) {
    final cssRule = _CssRule.parse(rule);
    String htmlStr;
    if (content is dom.Element) {
      htmlStr = content.outerHtml;
    } else {
      htmlStr = content.toString();
    }
    final document = html_parser.parse(htmlStr);
    final elements = document.querySelectorAll(cssRule.selector);
    if (elements.isEmpty) return null;
    return _extractElementValue(elements.first, cssRule.attr);
  }

  static List<String> _parseCssList(dynamic content, String rule) {
    final cssRule = _CssRule.parse(rule);
    String htmlStr;
    if (content is dom.Element) {
      htmlStr = content.outerHtml;
    } else {
      htmlStr = content.toString();
    }
    final document = html_parser.parse(htmlStr);
    final elements = document.querySelectorAll(cssRule.selector);
    return elements
        .map((e) => _extractElementValue(e, cssRule.attr) ?? '')
        .where((s) => s.isNotEmpty)
        .toList();
  }

  static List<dynamic> _getCssElements(dynamic content, String rule) {
    // 对于 getElements，不提取属性，返回 Element 对象
    final cssRule = _CssRule.parse(rule);
    String htmlStr;
    if (content is dom.Element) {
      htmlStr = content.outerHtml;
    } else {
      htmlStr = content.toString();
    }
    final document = html_parser.parse(htmlStr);
    return document.querySelectorAll(cssRule.selector).toList();
  }

  static String? _extractElementValue(dom.Element element, String? attr) {
    switch (attr) {
      case 'text':
        return element.text;
      case 'html':
      case 'innerHTML':
        return element.innerHtml;
      case 'outerHtml':
        return element.outerHtml;
      case 'href':
        return element.attributes['href'] ??
            element.attributes['data-href'];
      case 'src':
        return element.attributes['src'] ?? element.attributes['data-src'];
      case 'content':
        return element.attributes['content'];
      case 'value':
        return element.attributes['value'];
      case null:
        return element.text;
      default:
        return element.attributes[attr] ?? element.text;
    }
  }

  // ===== JSONPath 解析 =====

  static String? _parseJsonPath(dynamic content, String rule) {
    final results = _evaluateJsonPath(content, rule);
    if (results.isEmpty) return null;
    return _jsonValueToString(results.first);
  }

  static List<String> _parseJsonPathList(dynamic content, String rule) {
    final results = _evaluateJsonPath(content, rule);
    return results
        .map(_jsonValueToString)
        .where((s) => s != null)
        .cast<String>()
        .toList();
  }

  static List<dynamic> _getJsonElements(dynamic content, String rule) {
    return _evaluateJsonPath(content, rule);
  }

  static List<dynamic> _evaluateJsonPath(dynamic data, String path) {
    if (data == null) return [];

    // 处理输入为字符串的情况
    dynamic json = data;
    if (data is String && _isJson(data)) {
      try {
        json = jsonDecode(data);
      } catch (_) {
        return [];
      }
    }

    // 规范化路径
    String p = path.trim();
    if (p.startsWith('\$')) {
      p = p.substring(1);
      if (p.startsWith('.')) p = p.substring(1);
    }
    if (p.isEmpty) return [json];

    List<dynamic> current = [json];
    final segments = _parseJsonPathSegments(p);

    for (final segment in segments) {
      List<dynamic> next = [];
      for (final item in current) {
        if (segment == '*') {
          if (item is List) {
            next.addAll(item);
          } else if (item is Map) {
            next.addAll(item.values);
          }
        } else if (segment is int) {
          if (item is List && segment >= 0 && segment < item.length) {
            next.add(item[segment]);
          }
        } else if (segment is String) {
          if (item is Map && item.containsKey(segment)) {
            next.add(item[segment]);
          }
        }
      }
      current = next;
    }

    return current;
  }

  static List<dynamic> _parseJsonPathSegments(String path) {
    List<dynamic> segments = [];
    StringBuffer buffer = StringBuffer();
    bool inBracket = false;

    for (int i = 0; i < path.length; i++) {
      final char = path[i];
      if (char == '[' && !inBracket) {
        if (buffer.isNotEmpty) {
          final s = buffer.toString();
          if (s.isNotEmpty && s != '.') segments.add(s);
          buffer.clear();
        }
        inBracket = true;
      } else if (char == ']' && inBracket) {
        final s = buffer.toString().trim();
        if (s == '*') {
          segments.add('*');
        } else {
          final index = int.tryParse(s);
          if (index != null) {
            segments.add(index);
          } else {
            String key = s;
            if ((key.startsWith("'") && key.endsWith("'")) ||
                (key.startsWith('"') && key.endsWith('"'))) {
              key = key.substring(1, key.length - 1);
            }
            segments.add(key);
          }
        }
        buffer.clear();
        inBracket = false;
      } else if (char == '.' && !inBracket) {
        if (buffer.isNotEmpty) {
          final s = buffer.toString();
          if (s.isNotEmpty) segments.add(s);
          buffer.clear();
        }
      } else {
        buffer.write(char);
      }
    }

    if (buffer.isNotEmpty) {
      final s = buffer.toString();
      if (s.isNotEmpty && s != '.') segments.add(s);
    }

    return segments;
  }

  static String? _jsonValueToString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is num) return value.toString();
    if (value is bool) return value.toString();
    if (value is Map || value is List) return jsonEncode(value);
    return value.toString();
  }

  // ===== XPath 基础解析（转换为 CSS） =====

  static String? _parseXPath(dynamic content, String rule) {
    // XPath 基础支持：转换为 CSS 选择器
    String css = rule;
    css = css.replaceAll(RegExp(r'^//+'), '');
    css = css.replaceAll(RegExp(r'//'), ' ');
    css = css.replaceAll(RegExp(r'/(?![^[]*\])'), ' > ');
    // [@class='xxx'] or [@class="xxx"] → .xxx
    css = css.replaceAllMapped(
      RegExp(r"\[@class='([^']*)'\]"),
      (m) => '.${m[1]!.replaceAll(' ', '.')}',
    );
    css = css.replaceAllMapped(
      RegExp(r'\[@class="([^"]*)"\]'),
      (m) => '.${m[1]!.replaceAll(' ', '.')}',
    );
    // [@id='xxx'] or [@id="xxx"] → #xxx
    css = css.replaceAllMapped(
      RegExp(r"\[@id='([^']*)'\]"),
      (m) => '#${m[1]}',
    );
    css = css.replaceAllMapped(
      RegExp(r'\[@id="([^"]*)"\]'),
      (m) => '#${m[1]}',
    );
    // [@attr='val'] → [attr="val"]
    css = css.replaceAllMapped(
      RegExp(r"\[@(\w+)='([^']*)'\]"),
      (m) => '[${m[1]}="${m[2]}"]',
    );
    css = css.replaceAllMapped(
      RegExp(r'\[@(\w+)="([^"]*)"\]'),
      (m) => '[${m[1]}="${m[2]}"]',
    );
    // [@attr] → [attr]
    css = css.replaceAllMapped(
      RegExp(r'\[@(\w+)\]'),
      (m) => '[${m[1]}]',
    );
    // text() → @text
    css = css.replaceAll('/text()', '@text');
    if (css.isNotEmpty) {
      return _parseCss(content, css);
    }
    return null;
  }

  // ===== 工具方法 =====

  static bool _isJson(String str) {
    final s = str.trim();
    return s.startsWith('{') || s.startsWith('[');
  }

  static String applyReplacement(String value, String replacement) {
    // 格式: regex##replacement 或 单个 regex（删除匹配内容）
    final parts = replacement.split('##');
    if (parts.length >= 2) {
      try {
        return value.replaceAll(RegExp(parts[0]), parts[1]);
      } catch (_) {
        return value;
      }
    } else {
      try {
        return value.replaceAll(RegExp(replacement), '');
      } catch (_) {
        return value;
      }
    }
  }

  /// 解析发现/浏览 URL 列表
  /// 格式: "名称1::url1\n名称2::url2"
  static List<ExploreCategory> parseExploreUrl(String? exploreUrl) {
    if (exploreUrl == null || exploreUrl.isEmpty) return [];
    return exploreUrl
        .split('\n')
        .where((line) => line.contains('::'))
        .map((line) {
          final idx = line.indexOf('::');
          return ExploreCategory(
            name: line.substring(0, idx).trim(),
            url: line.substring(idx + 2).trim(),
          );
        })
        .where((c) => c.name.isNotEmpty && c.url.isNotEmpty)
        .toList();
  }

  /// 清理 HTML 标签，提取纯文本
  static String htmlToPlainText(String html) {
    // 先解析 HTML 以正确处理实体
    final document = html_parser.parse(html);
    String text = document.body?.text ?? html;
    // 清理多余空白
    text = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    // 恢复换行
    text = text.replaceAllMapped(
      RegExp(r'([。！？；\n])\s*'),
      (m) => '${m[1]}\n',
    );
    return text.trim();
  }

  /// 从内容中解析 URL（处理相对路径）
  static String resolveUrl(String baseUrl, String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    if (url.startsWith('//')) {
      final uri = Uri.parse(baseUrl);
      return '${uri.scheme}://$url';
    }
    if (url.startsWith('/')) {
      final uri = Uri.parse(baseUrl);
      return '${uri.scheme}://${uri.host}$url';
    }
    // 相对路径
    final base = baseUrl.substring(0, baseUrl.lastIndexOf('/') + 1);
    return '$base$url';
  }
}

/// 发现分类
class ExploreCategory {
  final String name;
  final String url;

  const ExploreCategory({required this.name, required this.url});
}

/// CSS 规则解析结果
class _CssRule {
  final String selector;
  final String? attr;

  const _CssRule(this.selector, this.attr);

  /// 解析 CSS 规则字符串
  /// 支持格式: "selector@attr" 或 "selector"
  static _CssRule parse(String rule) {
    String selector = rule;
    String? attr;

    // 检查 @attr 后缀（但要排除 CSS 属性选择器中的 @）
    // 只匹配最后一个不在 [] 中的 @
    int lastAt = rule.lastIndexOf('@');
    if (lastAt > 0) {
      // 检查这个 @ 是否在 [] 中
      String before = rule.substring(0, lastAt);
      int openBrackets =
          '['.allMatches(before).length - ']'.allMatches(before).length;
      if (openBrackets <= 0) {
        final attrCandidate = rule.substring(lastAt + 1).trim();
        // 验证是否是合法属性名
        if (RegExp(r'^[\w]+$').hasMatch(attrCandidate)) {
          selector = rule.substring(0, lastAt);
          attr = attrCandidate;
        }
      }
    }

    return _CssRule(selector, attr);
  }
}
