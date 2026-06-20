import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:charset/charset.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('freader_test_');
  });

  tearDownAll(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  // ==========================================
  // 1. 验证 charset 包基础能力
  // ==========================================
  group('charset 包基础验证', () {
    test('GBK 编码中文能正确解码', () {
      // "你好世界" 的 GBK 编码
      final gbkBytes = gbk.encode('你好世界');
      final decoded = gbk.decode(gbkBytes);
      expect(decoded, equals('你好世界'));
    });

    test('Charset.detect 能识别 GBK 字节流', () {
      // 生成一段包含中文的 GBK 编码文本
      final text = '这是第一章节的内容。主人公走进了森林，发现了一条小路。';
      final gbkBytes = gbk.encode(text);

      final detected = Charset.detect(
        gbkBytes,
        defaultEncoding: utf8,
        orders: [ascii, gbk],
      );
      expect(detected, isNotNull);
      // GBK 能解码这些字节
      final decoded = detected!.decode(gbkBytes);
      expect(decoded, equals(text));
    });

    test('UTF-8 中文能正确检测和解码', () {
      final text = '这是一个测试文件，包含中文内容。';
      final utf8Bytes = utf8.encode(text);

      // UTF-8 严格解码应成功
      final decoded = utf8.decode(utf8Bytes, allowMalformed: false);
      expect(decoded, equals(text));
    });
  });

  // ==========================================
  // 2. 验证核心 Bug：String.fromCharCodes vs utf8.decode
  // ==========================================
  group('UTF-8 解码 Bug 验证', () {
    test('String.fromCharCodes 对中文 UTF-8 产生乱码（旧 Bug 复现）', () {
      final text = '你好世界';
      final utf8Bytes = utf8.encode(text);

      // 旧代码用 String.fromCharCodes — 会产生乱码
      final wrong = String.fromCharCodes(utf8Bytes);
      expect(wrong, isNot(equals(text)));
      // 乱码不应该包含原始中文字符
      expect(wrong.contains('你'), isFalse);
    });

    test('utf8.decode 正确处理中文（修复后）', () {
      final text = '你好世界';
      final utf8Bytes = utf8.encode(text);

      // 新代码用 utf8.decode — 正确
      final correct = utf8.decode(utf8Bytes, allowMalformed: true);
      expect(correct, equals(text));
    });

    test('GBK 文件用 utf8.decode 会失败，需 Charset.detect 兜底', () {
      final text = '这是一个GBK编码的文件内容';
      final gbkBytes = gbk.encode(text);

      // utf8 解码 GBK 字节会出错
      expect(
        () => utf8.decode(gbkBytes, allowMalformed: false),
        throwsA(isA<FormatException>()),
      );

      // 但 Charset.detect 能识别并正确解码
      final detected = Charset.detect(
        gbkBytes,
        defaultEncoding: utf8,
        orders: [ascii, gbk],
      );
      expect(detected, equals(gbk));
      final decoded = detected!.decode(gbkBytes);
      expect(decoded, equals(text));
    });
  });

  // ==========================================
  // 3. 真实文件读写测试
  // ==========================================
  group('真实文件读写', () {
    test('读取 UTF-8 编码的 MD 文件', () async {
      final content = '''# 测试标题

这是第一章的内容，包含中文文字。
主人公走进了森林，发现了一条蜿蜒的小路。

## 第一章 开始

"你好！"他说。
世界很大，风景很美。
''';
      final file = File('${tempDir.path}/test_utf8.md');
      await file.writeAsBytes(utf8.encode(content));

      // 模拟 readTextContent 的核心逻辑
      final bytes = await file.readAsBytes();
      final decoded = utf8.decode(bytes, allowMalformed: true);
      expect(decoded, equals(content));
      expect(decoded.contains('测试标题'), isTrue);
      expect(decoded.contains('你好'), isTrue);
    });

    test('读取 GBK 编码的 TXT 文件', () async {
      final content = '这是GBK编码的文件，包含中文内容。第一章 章节标题。';
      final file = File('${tempDir.path}/test_gbk.txt');
      await file.writeAsBytes(gbk.encode(content));

      // 模拟 readTextContent 的核心逻辑
      final bytes = await file.readAsBytes();

      // 先尝试 UTF-8 应该失败
      bool utf8Failed = false;
      try {
        final badCount = utf8
            .decode(bytes, allowMalformed: false)
            .codeUnits
            .where((c) => c == 0xFFFD)
            .length;
        if (badCount > 0) utf8Failed = true;
      } catch (_) {
        utf8Failed = true;
      }
      expect(utf8Failed, isTrue);

      // 用 Charset.detect 应该能正确识别
      final detected = Charset.detect(
        bytes,
        defaultEncoding: utf8,
        orders: [ascii, gbk, eucKr, eucJp, shiftJis],
      );
      expect(detected, isNotNull);
      final decoded = detected!.decode(bytes);
      expect(decoded, equals(content));
      expect(decoded.contains('GBK编码'), isTrue);
    });

    test('读取带 BOM 的 UTF-8 文件', () async {
      final content = '带BOM的UTF-8文件内容';
      final bytes = <int>[
        0xEF, 0xBB, 0xBF, // UTF-8 BOM
        ...utf8.encode(content),
      ];
      final file = File('${tempDir.path}/test_bom.txt');
      await file.writeAsBytes(bytes);

      final rawBytes = await file.readAsBytes();
      // BOM 检测
      int start = 0;
      if (rawBytes.length >= 3 &&
          rawBytes[0] == 0xEF &&
          rawBytes[1] == 0xBB &&
          rawBytes[2] == 0xBF) {
        start = 3;
      }
      expect(start, equals(3));

      final contentBytes = rawBytes.sublist(start);
      final decoded = utf8.decode(contentBytes, allowMalformed: true);
      expect(decoded, equals(content));
    });

    test('章节分割对 UTF-8 中文正常工作', () async {
      final content = '''前言内容

第一章 开始
这是第一章的内容，主人公出场了。

第二章 冒险
主人公踏上了冒险之旅。

第三章 结局
故事迎来了大结局。''';

      final file = File('${tempDir.path}/test_chapters.txt');
      await file.writeAsBytes(utf8.encode(content));
      final bytes = await file.readAsBytes();
      final decoded = utf8.decode(bytes, allowMalformed: true);

      // 验证章节正则能匹配
      final chapterRegex = RegExp(
        r'^[\s]*(第[零一二三四五六七八九十百千万〇０-９\d]{1,7}[章节回卷集部篇]\s*.+)',
        multiLine: true,
      );
      final matches = chapterRegex.allMatches(decoded);
      expect(matches.length, equals(3));

      final titles = matches.map((m) => m.group(1)?.trim()).toList();
      expect(titles[0], equals('第一章 开始'));
      expect(titles[1], equals('第二章 冒险'));
      expect(titles[2], equals('第三章 结局'));
    });

    test('混合中英文 UTF-8 文件', () async {
      final content = 'Hello World 你好世界 Testing 测试中 English and 中文 mixed content 混合内容';
      final file = File('${tempDir.path}/test_mixed.txt');
      await file.writeAsBytes(utf8.encode(content));

      final bytes = await file.readAsBytes();
      final decoded = utf8.decode(bytes, allowMalformed: true);
      expect(decoded, equals(content));
      expect(decoded.contains('Hello'), isTrue);
      expect(decoded.contains('你好'), isTrue);
      expect(decoded.contains('混合'), isTrue);
    });
  });

  // ==========================================
  // 4. 边界情况
  // ==========================================
  group('边界情况', () {
    test('空文件', () async {
      final file = File('${tempDir.path}/test_empty.txt');
      await file.writeAsBytes([]);

      final bytes = await file.readAsBytes();
      final decoded = utf8.decode(bytes, allowMalformed: true);
      expect(decoded, equals(''));
    });

    test('纯 ASCII 文件（UTF-8 兼容）', () async {
      final content = 'Hello World! This is a pure ASCII file.';
      final file = File('${tempDir.path}/test_ascii.txt');
      await file.writeAsBytes(utf8.encode(content));

      final bytes = await file.readAsBytes();
      final decoded = utf8.decode(bytes, allowMalformed: true);
      expect(decoded, equals(content));
    });

    test('大文件（10KB+ 中文）', () async {
      final buffer = StringBuffer();
      for (int i = 0; i < 500; i++) {
        buffer.writeln('第$i行 这是测试内容，包含中文字符和数字123。');
      }
      final content = buffer.toString();
      expect(content.length, greaterThan(10000));

      final file = File('${tempDir.path}/test_large.txt');
      await file.writeAsBytes(utf8.encode(content));

      final bytes = await file.readAsBytes();
      final decoded = utf8.decode(bytes, allowMalformed: true);
      expect(decoded, equals(content));
      expect(decoded.contains('第0行'), isTrue);
      expect(decoded.contains('第499行'), isTrue);
    });
  });
}
