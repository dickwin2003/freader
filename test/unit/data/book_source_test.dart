import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:freader/data/entities/book_source.dart' as dto;
import 'package:freader/data/entities/rules/search_rule.dart';
import 'package:freader/data/entities/rules/toc_rule.dart';

void main() {
  group('BookSource JSON 序列化测试', () {
    late List<Map<String, dynamic>> sampleSources;

    setUpAll(() {
      final file = File('test/goldens/fixtures/sample_book_source.json');
      final content = file.readAsStringSync();
      sampleSources =
          (jsonDecode(content) as List).cast<Map<String, dynamic>>();
    });

    test('能解析笔趣阁书源（CSS 规则）', () {
      final source = dto.BookSource.fromJson(sampleSources[0]);

      expect(source.bookSourceUrl, 'https://www.xbiquge.so');
      expect(source.bookSourceName, '笔趣阁(xbiquge.so)');
      expect(source.bookSourceType, 0);
      expect(source.enabled, true);
      expect(source.enabledExplore, false);
      expect(source.customOrder, 10);
      expect(source.weight, 0);

      // 验证搜索规则
      expect(source.ruleSearch, isNotNull);
      expect(source.ruleSearch!.bookList, '@css:div.novelslistss > li');
      expect(source.ruleSearch!.name, '@css:span.s2 @text');
      expect(source.ruleSearch!.author, '@css:span.s4 @text');
      expect(source.ruleSearch!.bookUrl, '@css:span.s2 > a @href');

      // 验证详情规则
      expect(source.ruleBookInfo, isNotNull);
      expect(source.ruleBookInfo!.name,
          '@css:meta[property="og:novel:book_name"] @content');

      // 验证目录规则（XPath）
      expect(source.ruleToc, isNotNull);
      expect(source.ruleToc!.chapterList,
          '//div[@id="list"]/dl/dt[2]/following-sibling::dd/a');
      expect(source.ruleToc!.chapterName, 'text');
      expect(source.ruleToc!.chapterUrl, 'href');

      // 验证内容规则
      expect(source.ruleContent, isNotNull);
      expect(source.ruleContent!.content, '@css:div#content @html');

      // 验证搜索 URL 模板
      expect(source.searchUrl,
          '/modules/article/search.php?searchkey={{java.encodeURI(key, "gbk")}}');
    });

    test('能解析拷贝漫画书源（JSONPath 规则）', () {
      final source = dto.BookSource.fromJson(sampleSources[1]);

      expect(source.bookSourceUrl, 'https://www.copymanga.site/h5');
      expect(source.bookSourceName, '拷貝漫畫H5');
      expect(source.enabledExplore, true);
      expect(source.bookSourceGroup, '漫画');

      // 验证 JSONPath 规则
      expect(source.ruleSearch!.bookList, r'$.results.list[*]');
      expect(source.ruleSearch!.name, r'$.name');
      expect(source.ruleBookInfo!.author, r'$.results.comic.author[*]name ##\s##,');

      // 验证内容规则含图片样式
      expect(source.ruleContent!.imageStyle, 'FULL');
    });

    test('fromJson -> toJson 往返一致性', () {
      for (var i = 0; i < sampleSources.length; i++) {
        final original = sampleSources[i];
        final source = dto.BookSource.fromJson(original);
        final output = source.toJson();

        // 关键字段必须一致
        expect(output['bookSourceUrl'], original['bookSourceUrl'],
            reason: 'Source $i: bookSourceUrl mismatch');
        expect(output['bookSourceName'], original['bookSourceName'],
            reason: 'Source $i: bookSourceName mismatch');
        expect(output['bookSourceType'], original['bookSourceType'],
            reason: 'Source $i: bookSourceType mismatch');
        expect(output['enabled'], original['enabled'],
            reason: 'Source $i: enabled mismatch');
        expect(output['enabledExplore'], original['enabledExplore'],
            reason: 'Source $i: enabledExplore mismatch');
        expect(output['weight'], original['weight'],
            reason: 'Source $i: weight mismatch');
      }
    });

    test('规则子对象正确序列化', () {
      final source = dto.BookSource.fromJson(sampleSources[0]);

      // SearchRule 往返
      final searchJson = source.ruleSearch!.toJson();
      final searchBack = SearchRule.fromJson(searchJson);
      expect(searchBack.bookList, source.ruleSearch!.bookList);
      expect(searchBack.name, source.ruleSearch!.name);
      expect(searchBack.author, source.ruleSearch!.author);

      // TocRule 往返
      final tocJson = source.ruleToc!.toJson();
      final tocBack = TocRule.fromJson(tocJson);
      expect(tocBack.chapterList, source.ruleToc!.chapterList);
      expect(tocBack.chapterName, source.ruleToc!.chapterName);
    });

    test('空规则对象不会崩溃', () {
      final source = dto.BookSource.fromJson({
        'bookSourceUrl': 'https://test.com',
        'bookSourceName': '测试',
        'ruleSearch': {},
        'ruleExplore': {},
        'ruleBookInfo': {},
        'ruleToc': {},
        'ruleContent': {},
      });

      expect(source.bookSourceUrl, 'https://test.com');
      // 空规则对象应被解析为带有 null 字段的对象
      expect(source.ruleSearch, isNotNull);
      expect(source.ruleSearch!.bookList, isNull);
    });

    test('缺失字段使用默认值', () {
      final source = dto.BookSource.fromJson({
        'bookSourceUrl': 'https://minimal.com',
        'bookSourceName': '最小书源',
      });

      expect(source.bookSourceType, 0);
      expect(source.customOrder, 0);
      expect(source.enabled, true);
      expect(source.enabledExplore, true);
      expect(source.enabledCookieJar, false);
      expect(source.respondTime, 180000);
      expect(source.weight, 0);
    });

    test('分组解析正确', () {
      final source = dto.BookSource.fromJson({
        'bookSourceUrl': 'https://test.com',
        'bookSourceName': '测试',
        'bookSourceGroup': '漫画;日漫;热门',
      });

      expect(source.groups, ['漫画', '日漫', '热门']);
    });
  });
}
