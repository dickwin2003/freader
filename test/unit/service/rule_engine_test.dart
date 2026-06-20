import 'package:flutter_test/flutter_test.dart';
import 'package:freader/service/rule_engine.dart';

void main() {
  // ===== getString：CSS 选择器 =====
  group('RuleEngine.getString CSS', () {
    test('默认 HTML 内容按 CSS 提取文本', () {
      const html = '<div><h1 class="title">斗破苍穹</h1><p>正文</p></div>';
      expect(RuleEngine.getString(html, '.title'), '斗破苍穹');
    });

    test('@css: 显式前缀', () {
      const html = '<a class="book" href="/book/1">书名</a>';
      expect(RuleEngine.getString(html, '@css:.book@text'), '书名');
    });

    test('提取属性 href / src', () {
      const html = '<a class="d" href="/read/1">读</a><img class="c" src="/x.png">';
      expect(RuleEngine.getString(html, '.d@href'), '/read/1');
      expect(RuleEngine.getString(html, '.c@src'), '/x.png');
    });

    test('多个匹配只取第一个', () {
      const html = '<ul><li class="i">一</li><li class="i">二</li></ul>';
      expect(RuleEngine.getString(html, '.i'), '一');
    });

    test('无匹配返回 null', () {
      const html = '<div>无</div>';
      expect(RuleEngine.getString(html, '.not-exist'), isNull);
    });
  });

  // ===== getStringList：CSS 列表 =====
  group('RuleEngine.getStringList CSS', () {
    test('取全部匹配文本', () {
      const html = '<ul><li class="i">一</li><li class="i">二</li><li class="i">三</li></ul>';
      expect(RuleEngine.getStringList(html, '.i'), ['一', '二', '三']);
    });
  });

  // ===== JSONPath =====
  group('RuleEngine JSONPath', () {
    const json = '{"name":"斗破","author":"天蚕","list":["a","b","c"]}';

    test('\$.field 取字段', () {
      expect(RuleEngine.getString(json, r'$.name'), '斗破');
      expect(RuleEngine.getString(json, r'$.author'), '天蚕');
    });

    test('\$..field / ..field 等价', () {
      expect(RuleEngine.getString(json, r'..name'), '斗破');
    });

    test('\$.list[0] 索引', () {
      expect(RuleEngine.getString(json, r'$.list[0]'), 'a');
    });

    test('\$.list[*] 通配取全部', () {
      expect(RuleEngine.getStringList(json, r'$.list[*]'), ['a', 'b', 'c']);
    });

    test('JSON 字符串默认走 JSONPath', () {
      expect(RuleEngine.getString(json, 'name'), '斗破');
    });
  });

  // ===== ||  备选规则 =====
  group('RuleEngine ||  备选', () {
    test('第一个为空时取第二个', () {
      const html = '<div class="real">值</div>';
      expect(RuleEngine.getString(html, '.miss||.real'), '值');
    });

    test('都为空返回 null', () {
      const html = '<div>x</div>';
      expect(RuleEngine.getString(html, '.a||.b'), isNull);
    });
  });

  // ===== ## 替换规则 =====
  group('RuleEngine ## 替换', () {
    test('regex##replacement 替换', () {
      const html = '<span class="t">【精校版】书名</span>';
      expect(RuleEngine.getString(html, '.t##【精校版】'), '书名');
    });

    test('regex##replacement 带分组替换', () {
      // 去掉所有数字
      const html = '<span class="t">abc123def</span>';
      expect(RuleEngine.getString(html, r'.t##\d'), 'abcdef');
    });

    test('applyReplacement 单 regex 删除', () {
      expect(RuleEngine.applyReplacement('a1b2c3', r'\d'), 'abc');
    });

    test('applyReplacement regex##repl', () {
      expect(RuleEngine.applyReplacement('hello world', r'world##dart'), 'hello dart');
    });
  });

  // ===== resolveUrl =====
  group('RuleEngine.resolveUrl', () {
    test('已是绝对 http(s) 原样返回', () {
      expect(RuleEngine.resolveUrl('https://a.com/', 'https://b.com/x'), 'https://b.com/x');
    });

    test('// 协议相对 → 补 scheme', () {
      expect(RuleEngine.resolveUrl('https://a.com/', '//cdn.com/y'), 'https://cdn.com/y');
    });

    test('/ 根路径相对 → 补 host', () {
      expect(RuleEngine.resolveUrl('https://a.com/dir/page', '/book/1'), 'https://a.com/book/1');
    });

    test('相对路径 → 拼接 base 目录', () {
      expect(RuleEngine.resolveUrl('https://a.com/dir/page', 'next'), 'https://a.com/dir/next');
    });
  });

  // ===== parseExploreUrl =====
  group('RuleEngine.parseExploreUrl', () {
    test('正常解析多行 名称::url', () {
      final cats = RuleEngine.parseExploreUrl('玄幻::http://a/x\n都市::http://a/y');
      expect(cats.length, 2);
      expect(cats[0].name, '玄幻');
      expect(cats[0].url, 'http://a/x');
      expect(cats[1].name, '都市');
    });

    test('跳过不含 :: 的行和空行', () {
      final cats = RuleEngine.parseExploreUrl('有效::u\n无效行\n\n空::');
      expect(cats.length, 1);
      expect(cats.single.name, '有效');
    });

    test('null/空 返回空列表', () {
      expect(RuleEngine.parseExploreUrl(null), isEmpty);
      expect(RuleEngine.parseExploreUrl(''), isEmpty);
    });
  });

  // ===== htmlToPlainText =====
  group('RuleEngine.htmlToPlainText', () {
    test('去标签留文本', () {
      const html = '<div><p>第一段</p><p>第二段</p></div>';
      final text = RuleEngine.htmlToPlainText(html);
      expect(text, contains('第一段'));
      expect(text, contains('第二段'));
      expect(text.contains('<'), isFalse);
    });
  });

  // ===== 边界：空输入 =====
  group('RuleEngine 边界', () {
    test('rule 为 null/空 返回 null', () {
      expect(RuleEngine.getString('<div>x</div>', null), isNull);
      expect(RuleEngine.getString('<div>x</div>', ''), isNull);
    });

    test('content 为 null 返回 null', () {
      expect(RuleEngine.getString(null, '.x'), isNull);
    });

    test('getStringList 空输入返回空列表', () {
      expect(RuleEngine.getStringList(null, '.x'), isEmpty);
      expect(RuleEngine.getStringList('<div/>', null), isEmpty);
    });

    test('getElements 空输入返回空列表', () {
      expect(RuleEngine.getElements(null, '.x'), isEmpty);
    });
  });
}
