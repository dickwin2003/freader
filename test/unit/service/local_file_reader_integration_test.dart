import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:charset/charset.dart';
import 'package:freader/service/local_file_reader.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('freader_integration_');
  });

  tearDownAll(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('LocalFileReader.readTextContent 集成测试', () {
    test('UTF-8 编码 MD 文件 → 自动检测为 UTF-8 → 中文正常', () async {
      final content = '# 测试标题\n\n这是第一章的内容。包含中文。';
      final file = File('${tempDir.path}/utf8.md');
      await file.writeAsBytes(utf8.encode(content));

      final result = await LocalFileReader.readTextContent(file.path);

      expect(result.content, equals(content));
      expect(result.charset, equals('UTF-8'));
      expect(result.content.contains('测试标题'), isTrue);
    });

    test('GBK 编码 TXT 文件 → 自动检测 → 中文正常', () async {
      final content = '这是GBK编码文件的内容。第一章 开始冒险。';
      final file = File('${tempDir.path}/gbk.txt');
      await file.writeAsBytes(gbk.encode(content));

      final result = await LocalFileReader.readTextContent(file.path);

      expect(result.content, equals(content));
      expect(result.content.contains('GBK编码'), isTrue);
    });

    test('带 BOM 的 UTF-8 文件 → BOM 正确跳过', () async {
      final content = '带BOM的UTF-8内容';
      final file = File('${tempDir.path}/bom.txt');
      await file.writeAsBytes([0xEF, 0xBB, 0xBF, ...utf8.encode(content)]);

      final result = await LocalFileReader.readTextContent(file.path);

      expect(result.content, equals(content));
      expect(result.charset, equals('UTF-8'));
    });

    test('传入 knownCharset 时直接使用缓存编码', () async {
      final content = '这是已知编码的文件内容';
      final file = File('${tempDir.path}/cached.txt');
      await file.writeAsBytes(utf8.encode(content));

      final result = await LocalFileReader.readTextContent(
        file.path,
        knownCharset: 'UTF-8',
      );

      expect(result.content, equals(content));
      expect(result.charset, equals('UTF-8'));
    });

    test('GBK 文件传入错误的 knownCharset=UTF-8 会尝试用 UTF-8 解码', () async {
      final content = 'GBK编码内容';
      final file = File('${tempDir.path}/gbk_cached.txt');
      await file.writeAsBytes(gbk.encode(content));

      // 模拟错误缓存场景：已知 charset 为 UTF-8，但实际是 GBK
      final result = await LocalFileReader.readTextContent(
        file.path,
        knownCharset: 'UTF-8',
      );

      // utf8.decode with allowMalformed: true 不会抛错，但结果可能不对
      // 这符合预期：缓存优先，用户可通过删除重导来修正
      expect(result.charset, equals('UTF-8'));
    });

    test('buildChapters 对 UTF-8 中文内容正常工作', () async {
      final content = '''前言内容在这里

第一章 起点
第一章的内容，主人公出场。

第二章 旅途
第二章的内容，冒险开始了。

第三章 终点
故事结束。''';
      final file = File('${tempDir.path}/chapters.txt');
      await file.writeAsBytes(utf8.encode(content));

      final result = await LocalFileReader.readTextContent(file.path);
      final chapters = LocalFileReader.buildChapters(
        result.content, file.path, 'chapters',
      );

      // buildChapters 的实际逻辑：如果第一章匹配位置 > 100 才插"序"
      // 这段内容很短，不会插"序"，但有"前言内容在这里\n\n"这些文字
      // 让我们先看实际输出再断言
      // print('Chapters: ${chapters.map((c) => c.title).toList()}');

      // 直接断言章节标题包含这三个
      final titles = chapters.map((c) => c.title).toList();
      expect(titles, containsAll(['第一章 起点', '第二章 旅途', '第三章 终点']));
      expect(chapters.length, greaterThanOrEqualTo(3));
    });

    test('extractChapterContent 能正确提取章节内容', () async {
      final content = '''前言文字在这里写一些东西让开头超过一百个字符。需要填充一些文字才能让序章生效。继续填充一些无意义的文字来增加长度。AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

第一章 标题
这是第一章的内容，非常精彩。

第二章 标题二
这是第二章的内容，也很精彩。''';
      final file = File('${tempDir.path}/extract.txt');
      await file.writeAsBytes(utf8.encode(content));

      final result = await LocalFileReader.readTextContent(file.path);
      final chapters = LocalFileReader.buildChapters(
        result.content, file.path, 'extract',
      );

      // 找到标题为"第一章 标题"的章节
      final ch1Index = chapters.indexWhere((c) => c.title.contains('第一章'));
      expect(ch1Index, greaterThanOrEqualTo(0));

      final ch1Content = LocalFileReader.extractChapterContent(
        result.content, chapters[ch1Index],
      );
      expect(ch1Content, contains('第一章的内容'));
      expect(ch1Content, isNot(contains('第二章')));
    });

    test('文件不存在时抛出异常', () async {
      expect(
        () => LocalFileReader.readTextContent('/nonexistent/file.txt'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
