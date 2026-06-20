import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:freader/data/entities/book_source.dart';
import 'package:freader/data/entities/book.dart';
import 'package:freader/data/entities/book_chapter.dart';
import 'package:freader/data/entities/search_book.dart';
import 'package:freader/data/entities/rules/search_rule.dart';
import 'package:freader/data/entities/rules/explore_rule.dart';
import 'package:freader/data/entities/rules/book_info_rule.dart';
import 'package:freader/data/entities/rules/toc_rule.dart';
import 'package:freader/data/entities/rules/content_rule.dart';
import 'package:freader/service/rule_engine.dart';
import 'package:freader/service/analyze_url.dart';

/// 网络书籍服务
/// 负责使用书源规则从网络获取书籍信息
class WebBook {
  final Dio _dio;

  WebBook(this._dio);

  /// 搜索书籍
  Future<List<SearchBook>> searchBook(
    BookSource source,
    String keyword,
  ) async {
    if (source.searchUrl == null || source.ruleSearch == null) {
      return [];
    }

    final analyzeUrl = AnalyzeUrl(_dio);
    final headerMap = AnalyzeUrl.parseHeader(source.header);

    // 构建搜索 URL
    final searchUrl = source.searchUrl!;
    final variables = <String, String>{
      'key': keyword,
      'keyword': keyword,
      'page': '1',
    };

    try {
      final content = await analyzeUrl.fetchUrl(
        searchUrl,
        variables: variables,
        extraHeaders: headerMap,
        sourceUrl: source.bookSourceUrl,
      );

      return _parseSearchResults(content, source);
    } catch (e) {
      return [];
    }
  }

  /// 解析搜索结果
  List<SearchBook> _parseSearchResults(String content, BookSource source) {
    final rule = source.ruleSearch!;
    final results = <SearchBook>[];

    // 获取书籍列表元素
    final elements = RuleEngine.getElements(content, rule.bookList);
    if (elements.isEmpty) return [];

    for (final element in elements) {
      try {
        final name = RuleEngine.getString(element, rule.name) ?? '';
        final author = RuleEngine.getString(element, rule.author) ?? '';
        if (name.isEmpty) continue;

        String? bookUrl = RuleEngine.getString(element, rule.bookUrl);
        if (bookUrl != null) {
          bookUrl = RuleEngine.resolveUrl(source.bookSourceUrl, bookUrl);
        }
        if (bookUrl == null || bookUrl.isEmpty) continue;

        String? coverUrl = RuleEngine.getString(element, rule.coverUrl);
        if (coverUrl != null && !coverUrl.startsWith('http')) {
          coverUrl = RuleEngine.resolveUrl(source.bookSourceUrl, coverUrl);
        }

        results.add(SearchBook(
          bookUrl: bookUrl,
          origin: source.bookSourceUrl,
          originName: source.bookSourceName,
          name: name,
          author: author,
          kind: RuleEngine.getString(element, rule.kind),
          coverUrl: coverUrl,
          intro: RuleEngine.getString(element, rule.intro),
          wordCount: RuleEngine.getString(element, rule.wordCount),
          latestChapter: RuleEngine.getString(element, rule.lastChapter),
          updateTime: RuleEngine.getString(element, rule.updateTime),
          searchTime: DateTime.now().millisecondsSinceEpoch,
          originOrder: 0,
        ));
      } catch (_) {
        continue;
      }
    }

    return results;
  }

  /// 探索/发现书籍
  Future<List<SearchBook>> exploreBook(
    BookSource source,
    String exploreUrl,
  ) async {
    if (source.ruleExplore == null) return [];

    final analyzeUrl = AnalyzeUrl(_dio);
    final headerMap = AnalyzeUrl.parseHeader(source.header);

    try {
      final content = await analyzeUrl.fetchUrl(
        exploreUrl,
        extraHeaders: headerMap,
        sourceUrl: source.bookSourceUrl,
      );

      return _parseExploreResults(content, source);
    } catch (e) {
      return [];
    }
  }

  List<SearchBook> _parseExploreResults(String content, BookSource source) {
    final rule = source.ruleExplore!;
    final results = <SearchBook>[];

    final elements = RuleEngine.getElements(content, rule.bookList);
    if (elements.isEmpty) return [];

    for (final element in elements) {
      try {
        final name = RuleEngine.getString(element, rule.name) ?? '';
        if (name.isEmpty) continue;

        String? bookUrl = RuleEngine.getString(element, rule.bookUrl);
        if (bookUrl != null) {
          bookUrl = RuleEngine.resolveUrl(source.bookSourceUrl, bookUrl);
        }
        if (bookUrl == null || bookUrl.isEmpty) continue;

        String? coverUrl = RuleEngine.getString(element, rule.coverUrl);
        if (coverUrl != null && !coverUrl.startsWith('http')) {
          coverUrl = RuleEngine.resolveUrl(source.bookSourceUrl, coverUrl);
        }

        results.add(SearchBook(
          bookUrl: bookUrl,
          origin: source.bookSourceUrl,
          originName: source.bookSourceName,
          name: name,
          author: RuleEngine.getString(element, rule.author) ?? '',
          kind: RuleEngine.getString(element, rule.kind),
          coverUrl: coverUrl,
          intro: RuleEngine.getString(element, rule.intro),
          wordCount: RuleEngine.getString(element, rule.wordCount),
          latestChapter: RuleEngine.getString(element, rule.lastChapter),
          updateTime: RuleEngine.getString(element, rule.updateTime),
          searchTime: DateTime.now().millisecondsSinceEpoch,
        ));
      } catch (_) {
        continue;
      }
    }

    return results;
  }

  /// 获取书籍详情
  Future<Book> getBookInfo(BookSource source, Book book) async {
    final rule = source.ruleBookInfo;
    if (rule == null) return book;

    final analyzeUrl = AnalyzeUrl(_dio);
    final headerMap = AnalyzeUrl.parseHeader(source.header);

    try {
      final content = await analyzeUrl.fetchUrl(
        book.bookUrl,
        extraHeaders: headerMap,
        sourceUrl: source.bookSourceUrl,
      );

      String name = RuleEngine.getString(content, rule.name) ?? book.name;
      String author = RuleEngine.getString(content, rule.author) ?? book.author;
      String? intro = RuleEngine.getString(content, rule.intro) ?? book.intro;
      String? coverUrl =
          RuleEngine.getString(content, rule.coverUrl) ?? book.coverUrl;
      if (coverUrl != null && !coverUrl.startsWith('http')) {
        coverUrl = RuleEngine.resolveUrl(source.bookSourceUrl, coverUrl);
      }
      String? kind = RuleEngine.getString(content, rule.kind) ?? book.kind;
      String? latestChapter = RuleEngine.getString(content, rule.lastChapter);
      String? wordCount =
          RuleEngine.getString(content, rule.wordCount) ?? book.wordCount;
      String? tocUrlStr = RuleEngine.getString(content, rule.tocUrl);
      if (tocUrlStr != null && !tocUrlStr.startsWith('http')) {
        tocUrlStr = RuleEngine.resolveUrl(source.bookSourceUrl, tocUrlStr);
      }
      String finalTocUrl = tocUrlStr ?? book.tocUrl;

      return Book(
        bookUrl: book.bookUrl,
        tocUrl: finalTocUrl.isNotEmpty ? finalTocUrl : book.bookUrl,
        origin: source.bookSourceUrl,
        originName: source.bookSourceName,
        name: name,
        author: author,
        kind: kind,
        coverUrl: coverUrl,
        intro: intro,
        wordCount: wordCount,
        latestChapterTitle: latestChapter,
        type: book.type,
        group: book.group,
        durChapterIndex: book.durChapterIndex,
        durChapterTitle: book.durChapterTitle,
        durChapterPos: book.durChapterPos,
        totalChapterNum: book.totalChapterNum,
        canUpdate: book.canUpdate,
        local: book.local,
        inBookshelf: book.inBookshelf,
      );
    } catch (e) {
      return book;
    }
  }

  /// 获取章节列表
  Future<List<BookChapter>> getChapterList(
    BookSource source,
    Book book,
  ) async {
    final rule = source.ruleToc;
    if (rule == null) return [];

    final analyzeUrl = AnalyzeUrl(_dio);
    final headerMap = AnalyzeUrl.parseHeader(source.header);

    try {
      // 使用 tocUrl 或 bookUrl
      final url = book.tocUrl.isNotEmpty ? book.tocUrl : book.bookUrl;
      String content = await analyzeUrl.fetchUrl(
        url,
        extraHeaders: headerMap,
        sourceUrl: source.bookSourceUrl,
      );

      final chapters = <BookChapter>[];
      final chapterListRule = rule.chapterList;
      if (chapterListRule == null || chapterListRule.isEmpty) return [];

      // 获取章节元素
      final elements = RuleEngine.getElements(content, chapterListRule);

      // 处理多页目录
      String? nextTocUrl = RuleEngine.getString(content, rule.nextTocUrl);
      int pageCount = 0;
      while (nextTocUrl != null &&
          nextTocUrl.isNotEmpty &&
          pageCount < 20) {
        if (!nextTocUrl.startsWith('http')) {
          nextTocUrl =
              RuleEngine.resolveUrl(source.bookSourceUrl, nextTocUrl);
        }
        try {
          final nextContent = await analyzeUrl.fetchUrl(
            nextTocUrl,
            extraHeaders: headerMap,
            sourceUrl: source.bookSourceUrl,
          );
          elements.addAll(RuleEngine.getElements(nextContent, chapterListRule));
          nextTocUrl =
              RuleEngine.getString(nextContent, rule.nextTocUrl);
          pageCount++;
        } catch (_) {
          break;
        }
      }

      // 解析每个章节
      int index = 0;
      for (final element in elements) {
        try {
          final title =
              RuleEngine.getString(element, rule.chapterName) ?? '第${index + 1}章';
          String? chapterUrl =
              RuleEngine.getString(element, rule.chapterUrl);
          if (chapterUrl != null && !chapterUrl.startsWith('http')) {
            chapterUrl =
                RuleEngine.resolveUrl(source.bookSourceUrl, chapterUrl);
          }
          if (chapterUrl == null || chapterUrl.isEmpty) continue;

          final isVolume =
              RuleEngine.getString(element, rule.isVolume) == 'true' ||
                  RuleEngine.getString(element, rule.isVolume) == '1';

          chapters.add(BookChapter(
            url: chapterUrl,
            title: title,
            bookUrl: book.bookUrl,
            index: index++,
            isVolume: isVolume,
            isVip: RuleEngine.getString(element, rule.isVip) == 'true',
            isPay: RuleEngine.getString(element, rule.isPay) == 'true',
          ));
        } catch (_) {
          continue;
        }
      }

      return chapters;
    } catch (e) {
      return [];
    }
  }

  /// 获取章节内容
  Future<String> getContent(
    BookSource source,
    String chapterUrl,
  ) async {
    final rule = source.ruleContent;
    if (rule == null) return '';

    final analyzeUrl = AnalyzeUrl(_dio);
    final headerMap = AnalyzeUrl.parseHeader(source.header);

    try {
      String content = await analyzeUrl.fetchUrl(
        chapterUrl,
        extraHeaders: headerMap,
        sourceUrl: source.bookSourceUrl,
      );

      String? rawText = RuleEngine.getString(content, rule.content);
      if (rawText == null || rawText.isEmpty) return '';

      String text = rawText;

      // 处理下一页内容
      String? nextUrl = RuleEngine.getString(content, rule.nextContentUrl);
      int pageCount = 0;
      while (nextUrl != null && nextUrl.isNotEmpty && pageCount < 10) {
        if (!nextUrl.startsWith('http')) {
          nextUrl = RuleEngine.resolveUrl(source.bookSourceUrl, nextUrl);
        }
        try {
          final nextContent = await analyzeUrl.fetchUrl(
            nextUrl,
            extraHeaders: headerMap,
            sourceUrl: source.bookSourceUrl,
          );
          final nextText =
              RuleEngine.getString(nextContent, rule.content);
          if (nextText != null && nextText.isNotEmpty) {
            text = '$text\n$nextText';
          }
          nextUrl =
              RuleEngine.getString(nextContent, rule.nextContentUrl);
          pageCount++;
        } catch (_) {
          break;
        }
      }

      // 应用替换规则
      if (rule.replaceRegex != null && rule.replaceRegex!.isNotEmpty) {
        text = RuleEngine.applyReplacement(text, rule.replaceRegex!);
      }

      // 清理 HTML 标签
      if (text.contains('<')) {
        text = RuleEngine.htmlToPlainText(text);
      }

      // 清理特殊空白
      text = text
          .replaceAll('&nbsp;', ' ')
          .replaceAll('&lt;', '<')
          .replaceAll('&gt;', '>')
          .replaceAll('&amp;', '&')
          .replaceAll('&quot;', '"')
          .replaceAll('&#39;', "'");

      return text.trim();
    } catch (e) {
      return '';
    }
  }
}
