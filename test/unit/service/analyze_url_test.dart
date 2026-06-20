import 'package:flutter_test/flutter_test.dart';
import 'package:freader/service/analyze_url.dart';

void main() {
  group('AnalyzeUrl.resolveUrl', () {
    test('已是绝对 http(s) 原样返回', () {
      expect(AnalyzeUrl.resolveUrl('https://a.com/', 'http://b.com/x'), 'http://b.com/x');
      expect(AnalyzeUrl.resolveUrl('https://a.com/', 'https://b.com/y'), 'https://b.com/y');
    });

    test('baseUrl 为 null/空时原样返回 url（不崩）', () {
      expect(AnalyzeUrl.resolveUrl(null, '/path'), '/path');
      expect(AnalyzeUrl.resolveUrl('', '//cdn/y'), '//cdn/y');
    });

    test('// 协议相对 → 补 scheme', () {
      expect(AnalyzeUrl.resolveUrl('https://a.com/', '//cdn.com/y'), 'https://cdn.com/y');
    });

    test('/ 根路径相对 → 补 host', () {
      expect(AnalyzeUrl.resolveUrl('https://a.com/dir/page', '/book/1'), 'https://a.com/book/1');
    });

    test('相对路径 → 拼接 base 目录', () {
      expect(AnalyzeUrl.resolveUrl('https://a.com/dir/page', 'next'), 'https://a.com/dir/next');
    });
  });

  group('AnalyzeUrl.parseHeader', () {
    test('null/空 返回 null', () {
      expect(AnalyzeUrl.parseHeader(null), isNull);
      expect(AnalyzeUrl.parseHeader(''), isNull);
    });

    test('JSON 对象 → Map<String,String>', () {
      final h = AnalyzeUrl.parseHeader('{"User-Agent":"Mozilla","Token":"abc"}');
      expect(h, isNotNull);
      expect(h!['User-Agent'], 'Mozilla');
      expect(h['Token'], 'abc');
    });

    test('数字值被转为字符串', () {
      final h = AnalyzeUrl.parseHeader('{"X-Count":123}');
      expect(h?['X-Count'], '123');
    });

    test('非 JSON 字符串 返回 null', () {
      expect(AnalyzeUrl.parseHeader('not a json'), isNull);
    });

    test('JSON 数组（非对象）返回 null', () {
      expect(AnalyzeUrl.parseHeader('[1,2,3]'), isNull);
    });
  });
}
