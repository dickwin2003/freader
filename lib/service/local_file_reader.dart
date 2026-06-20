import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:charset/charset.dart';
import 'package:path/path.dart' as p;
import 'package:archive/archive.dart';
import 'package:epubx/epubx.dart' as epub;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:freader/data/entities/book_chapter.dart';
import 'package:freader/service/mobi/mobi_reader.dart';
import 'package:freader/service/mobi/mobi_book.dart';
import 'package:freader/service/mobi/kf6_book.dart';
import 'package:freader/service/mobi/kf8_book.dart';

/// 本地文件读取器 - 支持 TXT/MD/HTML/EPUB/MOBI 格式
class LocalFileReader {
  /// 纯文本格式
  static const _textExtensions = ['.txt', '.md', '.html', '.htm'];
  /// EPUB 格式（有自己的解码器）
  static const _epubExtensions = ['.epub'];
  /// PDF 格式（通过平台通道渲染）
  static const _pdfExtensions = ['.pdf'];
  /// MOBI 格式（AZW/AZW3 同属 MOBI）
  static const _mobiExtensions = ['.mobi', '.azw', '.azw3'];
  /// Office 文档（Word）
  static const _officeExtensions = ['.doc', '.docx'];
  /// 暂不支持的格式
  static const _unsupportedExtensions = ['.umd'];
  /// 压缩包格式（zip 可解压导入；rar/7z 暂不支持）
  static const _zipExtensions = ['.zip'];
  /// RAR 格式（通过 unRAR native 库解压）
  static const _rarExtensions = ['.rar'];
  /// 7z 格式（通过 LZMA SDK native 库解压）
  static const _sevenZipExtensions = ['.7z'];

  static bool isTextFile(String filePath) {
    final ext = p.extension(filePath).toLowerCase();
    return _textExtensions.contains(ext);
  }

  static bool isEpubFile(String filePath) {
    final ext = p.extension(filePath).toLowerCase();
    return _epubExtensions.contains(ext);
  }

  static bool isPdfFile(String filePath) {
    final ext = p.extension(filePath).toLowerCase();
    return _pdfExtensions.contains(ext);
  }

  static bool isUnsupportedFormat(String filePath) {
    final ext = p.extension(filePath).toLowerCase();
    return _unsupportedExtensions.contains(ext);
  }

  static bool isMobiFile(String filePath) {
    final ext = p.extension(filePath).toLowerCase();
    return _mobiExtensions.contains(ext);
  }

  static String getUnsupportedFormatName(String filePath) {
    final ext = p.extension(filePath).toUpperCase();
    return ext.replaceAll('.', '');
  }

  static bool isSupportedFile(String filePath) {
    final ext = p.extension(filePath).toLowerCase();
    return [..._textExtensions, ..._epubExtensions, ..._pdfExtensions, ..._mobiExtensions, ..._unsupportedExtensions, ..._zipExtensions, ..._rarExtensions, ..._sevenZipExtensions].contains(ext);
  }

  static bool isZipFile(String filePath) {
    final ext = p.extension(filePath).toLowerCase();
    return _zipExtensions.contains(ext);
  }

  static bool isRarFile(String filePath) {
    final ext = p.extension(filePath).toLowerCase();
    return _rarExtensions.contains(ext);
  }

  static bool is7zFile(String filePath) {
    final ext = p.extension(filePath).toLowerCase();
    return _sevenZipExtensions.contains(ext);
  }

  /// 是否为可直接打开的书籍扩展名（不含 umd/zip）
  static bool isBookExtension(String ext) {
    return [
      ..._textExtensions,
      ..._epubExtensions,
      ..._pdfExtensions,
      ..._mobiExtensions,
      ..._officeExtensions,
    ].contains(ext.toLowerCase());
  }

  static bool isDocxFile(String filePath) =>
      p.extension(filePath).toLowerCase() == '.docx';

  static bool isDocFile(String filePath) =>
      p.extension(filePath).toLowerCase() == '.doc';

  /// 解压 zip 到临时目录，返回内部可打开的书籍文件路径列表
  static Future<List<String>> extractZip(String zipPath) async {
    final file = File(zipPath);
    if (!await file.exists()) return [];
    try {
      final bytes = await file.readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);
      final cacheDir = Directory('${Directory.systemTemp.path}/freader_zip');
      if (!await cacheDir.exists()) await cacheDir.create(recursive: true);
      final outPaths = <String>[];
      for (final entry in archive) {
        if (!entry.isFile) continue;
        final name = entry.name;
        if (!isBookExtension(p.extension(name))) continue;
        final safeName = '${zipPath.hashCode}_${p.basename(name)}';
        final outPath = '${cacheDir.path}/$safeName';
        await File(outPath).writeAsBytes(entry.content as List<int>);
        outPaths.add(outPath);
      }
      return outPaths;
    } catch (_) {
      return [];
    }
  }

  /// ============ TXT/MD/HTML 文本读取 ============

  /// 读取文本内容，自动检测编码
  /// [filePath] 文件路径
  /// [knownCharset] 已知编码（缓存），不为空时直接使用
  /// 返回 (文本内容, 检测到的编码名称)
  static Future<({String content, String charset})> readTextContent(
      String filePath, {String? knownCharset}) async {
    final file = File(filePath);
    if (!await file.exists()) throw Exception('文件不存在: $filePath');

    final bytes = await file.readAsBytes();

    // 跳过 BOM
    int start = 0;
    if (bytes.length >= 3 && bytes[0] == 0xEF && bytes[1] == 0xBB && bytes[2] == 0xBF) {
      start = 3;
    } else if (bytes.length >= 2 && bytes[0] == 0xFF && bytes[1] == 0xFE) {
      start = 2;
    } else if (bytes.length >= 2 && bytes[0] == 0xFE && bytes[1] == 0xFF) {
      start = 2;
    }

    final contentBytes = bytes.sublist(start);

    // 如果已知编码，直接使用
    if (knownCharset != null && knownCharset.isNotEmpty) {
      final decoded = _decodeWithEncodingName(contentBytes, knownCharset);
      return (content: decoded, charset: knownCharset);
    }

    // 自动检测编码
    final detected = _detectEncoding(contentBytes);
    final decoded = _decodeWithEncoding(contentBytes, detected.encoding);
    return (content: decoded, charset: detected.name);
  }

  /// 编码检测结果
  static ({Encoding encoding, String name}) _detectEncoding(List<int> bytes) {
    // 第一步：尝试 UTF-8 严格解码
    try {
      final decoded = utf8.decode(bytes, allowMalformed: false);
      final badCount = decoded.codeUnits.where((c) => c == 0xFFFD).length;
      if (badCount < decoded.length * 0.01) {
        return (encoding: utf8, name: 'UTF-8');
      }
    } catch (_) {}

    // 第二步：用 charset 库检测（支持 GBK/GB2312/GB18030/EUC-KR/EUC-JP/Shift-JIS 等）
    try {
      final detected = Charset.detect(
        bytes,
        defaultEncoding: utf8,
        orders: [ascii, gbk, eucKr, eucJp, shiftJis],
      );
      if (detected != null && detected != ascii) {
        final name = detected.name;
        return (encoding: detected, name: name);
      }
    } catch (_) {}

    // 第三步：fallback GBK（中文环境最常见的非 UTF 编码）
    try {
      return (encoding: gbk, name: 'GBK');
    } catch (_) {}

    return (encoding: utf8, name: 'UTF-8');
  }

  /// 用 Encoding 对象解码
  static String _decodeWithEncoding(List<int> bytes, Encoding encoding) {
    try {
      return encoding.decode(bytes);
    } catch (_) {
      return utf8.decode(bytes, allowMalformed: true);
    }
  }

  /// 用编码名称解码（用于缓存命中时）
  static String _decodeWithEncodingName(List<int> bytes, String charsetName) {
    // 先尝试从 charset 库查找
    final encoding = Charset.getByName(charsetName);
    if (encoding != null) {
      return _decodeWithEncoding(bytes, encoding);
    }
    // fallback: utf8
    return utf8.decode(bytes, allowMalformed: true);
  }

  /// ============ EPUB 解析 ============

  /// 解析 EPUB 文件，返回章节列表
  static Future<EpubParseResult> parseEpub(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) throw Exception('文件不存在: $filePath');

    final bytes = await file.readAsBytes();
    final epubBook = await epub.EpubReader.readBook(Uint8List.fromList(bytes));

    // 提取书籍信息
    final title = epubBook.Title ?? LocalFileReader.getFileName(filePath);
    final author = epubBook.Author ?? '未知';
    String? coverPath;

    // 保存封面到临时文件
    final coverImage = epubBook.CoverImage;
    if (coverImage != null) {
      try {
        final coverBytes = coverImage.getBytes();
        final cacheDir = Directory('${Directory.systemTemp.path}/freader_covers');
        if (!await cacheDir.exists()) await cacheDir.create(recursive: true);
        final coverFile = File('${cacheDir.path}/${filePath.hashCode}.jpg');
        await coverFile.writeAsBytes(coverBytes);
        coverPath = coverFile.path;
      } catch (_) {}
    }

    // 提取章节 - 先尝试 TOC，再 fallback 到 HTML 文件列表
    final chapters = <LocalEpubChapter>[];

    // 方法1: 从 TOC 提取
    final tocRefs = epubBook.Chapters ?? [];
    if (tocRefs.isNotEmpty) {
      _flattenEpubToc(tocRefs, chapters);
    }

    // 方法2: fallback 从 HTML 内容提取
    if (chapters.isEmpty) {
      final htmlMap = epubBook.Content?.Html ?? {};
      final htmlKeys = htmlMap.keys.toList();
      for (int i = 0; i < htmlKeys.length; i++) {
        final htmlFile = htmlMap[htmlKeys[i]]!;
        chapters.add(LocalEpubChapter(
          title: '第 ${i + 1} 章',
          contentFileName: htmlFile.FileName ?? htmlKeys[i],
          index: i,
        ));
      }
    }

    return EpubParseResult(
      title: title,
      author: author,
      coverPath: coverPath,
      chapters: chapters,
      epubBook: epubBook,
    );
  }

  /// 递归展平 TOC 树
  static void _flattenEpubToc(List<epub.EpubChapter> refs, List<LocalEpubChapter> out) {
    for (final ref in refs) {
      if (ref.Title != null && ref.Title!.isNotEmpty) {
        out.add(LocalEpubChapter(
          title: ref.Title!,
          contentFileName: ref.ContentFileName ?? '',
          index: out.length,
          isVolume: ref.SubChapters != null && ref.SubChapters!.isNotEmpty,
        ));
      }
      if (ref.SubChapters != null && ref.SubChapters!.isNotEmpty) {
        _flattenEpubToc(ref.SubChapters!, out);
      }
    }
  }

  /// 读取 EPUB 章节内容 - 从 Html map 或 HtmlContent 提取纯文本
  static Future<String> readEpubChapterContent(
      epub.EpubBook epubBook, String contentFileName) async {
    try {
      // 方法1: 从 Content.Html map 中查找
      final htmlMap = epubBook.Content?.Html ?? {};

      for (final entry in htmlMap.entries) {
        final key = entry.key;
        final htmlFile = entry.value;
        // 匹配文件名
        if (key == contentFileName ||
            key.endsWith('/$contentFileName') ||
            contentFileName.endsWith(key)) {
          if (htmlFile.Content != null) {
            return _htmlToPlainText(htmlFile.Content!);
          }
        }
      }

      // 方法2: 如果 TOC 章节自带 HtmlContent
      final tocChapters = epubBook.Chapters ?? [];
      for (final ch in tocChapters) {
        if (ch.ContentFileName == contentFileName && ch.HtmlContent != null) {
          return _htmlToPlainText(ch.HtmlContent!);
        }
      }

      return '暂无内容';
    } catch (e) {
      return '内容加载失败: $e';
    }
  }

  /// HTML 转纯文本（公开，供 HTML 文件阅读用）
  static String htmlToPlainText(String html) => _htmlToPlainText(html);

  /// 读取 .docx 文件正文：解压取 word/document.xml，提取 `<w:t>` 文字。
  static Future<String> readDocxText(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) throw Exception('文件不存在: $filePath');
    final bytes = await file.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);
    ArchiveFile? docFile;
    for (final f in archive) {
      if (f.name.toLowerCase() == 'word/document.xml') {
        docFile = f;
        break;
      }
    }
    if (docFile == null) {
      throw Exception('无效的 .docx（未找到 word/document.xml）');
    }
    final xmlStr = utf8.decode(docFile.content as List<int>);
    return _docxXmlToText(xmlStr);
  }

  /// 把 word/document.xml 的 XML 提取为纯文本（段落用换行）。
  static String _docxXmlToText(String xml) {
    var t = xml;
    t = t.replaceAll(RegExp(r'<w:tab\b[^>]*/?>'), '\t');
    t = t.replaceAll(RegExp(r'<w:br\b[^>]*/?>'), '\n');
    t = t.replaceAll(RegExp(r'</w:p>'), '\n');
    // 删除剩余标签，<w:t> 文字留在标签之间
    t = t.replaceAll(RegExp(r'<[^>]+>'), '');
    t = t
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&apos;', "'");
    t = t.replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
    return t;
  }

  /// 简易 HTML 转纯文本
  static String _htmlToPlainText(String html) {
    var text = html;
    // 移除 script/style
    text = text.replaceAll(RegExp(r'<script[^>]*>.*?</script>', dotAll: true), '');
    text = text.replaceAll(RegExp(r'<style[^>]*>.*?</style>', dotAll: true), '');
    // 提取 body 内容
    final bodyMatch = RegExp(r'<body[^>]*>(.*?)</body>', dotAll: true).firstMatch(text);
    if (bodyMatch != null) text = bodyMatch.group(1)!;
    // 移除 HTML 标签
    text = text.replaceAll(RegExp(r'<br\s*/?\s*>'), '\n');
    text = text.replaceAll(RegExp(r'</p>'), '\n\n');
    text = text.replaceAll(RegExp(r'</div>'), '\n');
    text = text.replaceAll(RegExp(r'</h[1-6]>'), '\n\n');
    text = text.replaceAll(RegExp(r'<[^>]+>'), '');
    // 解码 HTML 实体
    text = text.replaceAll('&nbsp;', ' ');
    text = text.replaceAll('&amp;', '&');
    text = text.replaceAll('&lt;', '<');
    text = text.replaceAll('&gt;', '>');
    text = text.replaceAll('&quot;', '"');
    text = text.replaceAll('&#39;', "'");
    text = text.replaceAllMapped(RegExp(r'&#(\d+);'), (m) {
      final code = int.tryParse(m.group(1) ?? '');
      return code != null ? String.fromCharCode(code) : '';
    });
    // 清理多余空白
    text = text.replaceAll(RegExp(r'\n{3,}'), '\n\n');
    text = text.trim();
    return text;
  }

  /// ============ MOBI 解析 ============

  /// 解析 MOBI 文件，返回章节列表和书籍信息
  static Future<MobiParseResult> parseMobi(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) throw Exception('文件不存在: $filePath');

    final bytes = await file.readAsBytes();
    // 在 Isolate 中解析 MOBI，避免卡死主线程
    final mobiBook = await Isolate.run(() => MobiReader.read(bytes));

    final metadata = mobiBook.metadata;
    String? coverPath;

    // 保存封面
    try {
      final coverBytes = mobiBook.getCover();
      if (coverBytes != null) {
        final cacheDir = Directory('${Directory.systemTemp.path}/freader_covers');
        if (!await cacheDir.exists()) await cacheDir.create(recursive: true);
        final coverFile = File('${cacheDir.path}/${filePath.hashCode}.jpg');
        await coverFile.writeAsBytes(coverBytes);
        coverPath = coverFile.path;
      }
    } catch (_) {}

    final chapters = <BookChapter>[];
    // MOBI 统一按 sections 分章：内容用整 section（getSectionText），避免 KF8 fragment
    // 范围提取（getTextByHref）不准导致"只显示第一页/段"。sections 覆盖整本书。
    if (mobiBook is KF6Book) {
      final sections = mobiBook.sections;
      for (int i = 0; i < sections.length; i++) {
        chapters.add(BookChapter(
          bookUrl: filePath,
          title: '分段 $i',
          url: sections[i].href,
          index: i,
          variable: 'mobi',
        ));
      }
    } else if (mobiBook is KF8Book) {
      final sections = mobiBook.sections;
      for (int i = 0; i < sections.length; i++) {
        chapters.add(BookChapter(
          bookUrl: filePath,
          title: '分段 $i',
          url: sections[i].href,
          index: i,
          variable: 'mobi',
        ));
      }
    }

    if (chapters.isEmpty) {
      chapters.add(BookChapter(
        bookUrl: filePath,
        title: metadata.title.isNotEmpty ? metadata.title : getFileName(filePath),
        url: '',
        index: 0,
        variable: 'mobi',
      ));
    }

    final kindDesc = p.extension(filePath).toLowerCase() == '.azw3' ? 'AZW3' : 'MOBI';

    return MobiParseResult(
      title: metadata.title.isNotEmpty ? metadata.title : getFileName(filePath),
      author: metadata.author.isNotEmpty ? metadata.author.first : '未知',
      coverPath: coverPath,
      intro: metadata.description.isNotEmpty ? _htmlToPlainText(metadata.description) : null,
      chapters: chapters,
      mobiBook: mobiBook,
      kind: kindDesc,
    );
  }

  /// 读取 MOBI 章节内容
  static String readMobiChapterContent(MobiBook mobiBook, String url) {
    try {
      // url 格式: "href:::nextHref" 或 "href"
      final parts = url.split(':::');
      final href = parts[0];

      if (mobiBook is KF8Book) {
        // 直接取整 section：getTextByHref 的 fragment 范围提取不准会导致只显示第一段
        final section = mobiBook.getSectionByHref(href);
        if (section != null) {
          return _htmlToPlainText(mobiBook.getSectionText(section));
        }
      } else if (mobiBook is KF6Book) {
        final section = mobiBook.getSectionByHref(href);
        if (section != null) {
          return _htmlToPlainText(mobiBook.getSectionText(section));
        }
      }

      return '暂无内容';
    } catch (e) {
      return '内容加载失败: $e';
    }
  }

  /// ============ 通用工具方法 ============

  static String getFileName(String filePath) {
    final name = p.basename(filePath);
    final ext = p.extension(filePath);
    return name.replaceAll(ext, '');
  }

  static String? getFileExtension(String filePath) {
    final ext = p.extension(filePath).toLowerCase();
    return ext.isNotEmpty ? ext : null;
  }

  /// 从文本内容构建章节列表
  static List<BookChapter> buildChapters(String content, String bookUrl, String bookName) {
    final chapters = <BookChapter>[];

    final chapterRegex = RegExp(
      r'^[\s]*(第[零一二三四五六七八九十百千万〇０-９\d]{1,7}[章节回卷集部篇]\s*.+)',
      multiLine: true,
    );

    final matches = chapterRegex.allMatches(content);

    if (matches.isEmpty) {
      final lines = content.split('\n');
      if (lines.length <= 200) {
        chapters.add(BookChapter(
          bookUrl: bookUrl, title: bookName,
          url: '$bookUrl#0', index: 0,
          variable: '{"start":0,"end":${content.length}}',
        ));
      } else {
        final chunkSize = 100;
        for (int i = 0; i < lines.length; i += chunkSize) {
          final startChar = _lineOffset(lines, i);
          final endChar = _lineOffset(lines, (i + chunkSize).clamp(0, lines.length));
          chapters.add(BookChapter(
            bookUrl: bookUrl, title: '第 ${chapters.length + 1} 部分',
            url: '$bookUrl#${chapters.length}', index: chapters.length,
            variable: '{"start":$startChar,"end":$endChar}',
          ));
        }
      }
      return chapters;
    }

    final matchList = matches.toList();
    for (int i = 0; i < matchList.length; i++) {
      final match = matchList[i];
      final title = match.group(1)?.trim() ?? '第${i + 1}章';
      final start = match.start;
      final end = i + 1 < matchList.length ? matchList[i + 1].start : content.length;
      chapters.add(BookChapter(
        bookUrl: bookUrl, title: title,
        url: '$bookUrl#${chapters.length}', index: chapters.length,
        variable: '{"start":$start,"end":$end}',
      ));
    }

    if (matchList.isNotEmpty && matchList[0].start > 100) {
      chapters.insert(0, BookChapter(
        bookUrl: bookUrl, title: '序',
        url: '$bookUrl#prologue', index: 0,
        variable: '{"start":0,"end":${matchList[0].start}}',
      ));
      for (int i = 1; i < chapters.length; i++) {
        final ch = chapters[i];
        chapters[i] = BookChapter(
          bookUrl: ch.bookUrl, title: ch.title,
          url: '${ch.bookUrl}#$i', index: i,
          variable: ch.variable,
        );
      }
    }

    return chapters;
  }

  static int _lineOffset(List<String> lines, int lineIndex) {
    int offset = 0;
    for (int i = 0; i < lineIndex && i < lines.length; i++) {
      offset += lines[i].length + 1;
    }
    return offset;
  }

  static String extractChapterContent(String fullContent, BookChapter chapter) {
    try {
      final variableStr = chapter.variable;
      if (variableStr == null || variableStr.isEmpty) return fullContent;

      final startMatch = RegExp(r'"start"\s*:\s*(\d+)').firstMatch(variableStr);
      final endMatch = RegExp(r'"end"\s*:\s*(\d+)').firstMatch(variableStr);

      if (startMatch != null && endMatch != null) {
        final start = int.parse(startMatch.group(1)!);
        final end = int.parse(endMatch.group(1)!);
        if (start < fullContent.length && end <= fullContent.length && start < end) {
          return fullContent.substring(start, end).trim();
        }
      }
    } catch (_) {}
    return fullContent;
  }

  /// 用外部应用打开
  static Future<bool> openWithExternalApp(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) return false;
    try {
      return await launchUrlString('file://$filePath', mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}

/// EPUB 解析结果
class EpubParseResult {
  final String title;
  final String author;
  final String? coverPath;
  final List<LocalEpubChapter> chapters;
  final epub.EpubBook epubBook;

  const EpubParseResult({
    required this.title,
    required this.author,
    this.coverPath,
    required this.chapters,
    required this.epubBook,
  });
}

/// 本地 EPUB 章节信息
class LocalEpubChapter {
  final String title;
  final String contentFileName;
  final int index;
  final bool isVolume;

  const LocalEpubChapter({
    required this.title,
    required this.contentFileName,
    required this.index,
    this.isVolume = false,
  });
}

/// MOBI 解析结果
class MobiParseResult {
  final String title;
  final String author;
  final String? coverPath;
  final String? intro;
  final List<BookChapter> chapters;
  final MobiBook mobiBook;
  final String kind;

  const MobiParseResult({
    required this.title,
    required this.author,
    this.coverPath,
    this.intro,
    required this.chapters,
    required this.mobiBook,
    required this.kind,
  });
}