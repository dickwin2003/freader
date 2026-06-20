import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:freader/data/entities/book_source.dart' as dto;
import 'package:freader/data/entities/book.dart' as dto;
import 'package:freader/service/web_book.dart';

class _MockDio extends Mock implements Dio {}

dto.BookSource _source(Map<String, dynamic> extra) =>
    dto.BookSource.fromJson({
      'bookSourceUrl': 'https://test.com',
      'bookSourceName': '测试书源',
      ...extra,
    });

dto.Book _book(String name, [String author = '']) => dto.Book.fromJson({
      'bookUrl': 'https://test.com/b',
      'tocUrl': '',
      'origin': '',
      'originName': '',
      'name': name,
      'author': author,
    });

void main() {
  late _MockDio dio;

  setUp(() {
    dio = _MockDio();
    registerFallbackValue(Options());
  });

  // ===== 空规则短路：不应触发网络请求 =====
  group('WebBook 空规则短路', () {
    test('searchUrl 缺失 → searchBook 返回空', () async {
      final wb = WebBook(dio);
      expect(await wb.searchBook(_source({}), '关键词'), isEmpty);
      verifyNever(() => dio.request<String>(any(),
          data: any(named: 'data'), options: any(named: 'options')));
    });

    test('ruleSearch 缺失（仅有 searchUrl）→ searchBook 返回空', () async {
      final wb = WebBook(dio);
      final source = _source({'searchUrl': 'https://test.com/s?q={{key}}'});
      expect(await wb.searchBook(source, '关键词'), isEmpty);
    });

    test('ruleExplore 缺失 → exploreBook 返回空', () async {
      final wb = WebBook(dio);
      expect(await wb.exploreBook(_source({}), '/explore'), isEmpty);
    });

    test('ruleBookInfo 缺失 → getBookInfo 原样返回 book', () async {
      final wb = WebBook(dio);
      final result = await wb.getBookInfo(_source({}), _book('原书', '作者'));
      expect(result.name, '原书');
      expect(result.author, '作者');
    });

    test('ruleToc 缺失 → getChapterList 返回空', () async {
      final wb = WebBook(dio);
      expect(await wb.getChapterList(_source({}), _book('x')), isEmpty);
    });

    test('ruleContent 缺失 → getContent 返回空', () async {
      final wb = WebBook(dio);
      expect(await wb.getContent(_source({}), 'https://test.com/c'), '');
    });
  });

  // ===== 网络异常容错：不向上抛 =====
  group('WebBook 网络异常容错', () {
    void stubThrow() {
      when(() => dio.request<String>(any(),
              data: any(named: 'data'), options: any(named: 'options')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));
    }

    test('searchBook 网络异常 → 返回空', () async {
      stubThrow();
      final wb = WebBook(dio);
      final source = _source({
        'searchUrl': 'https://test.com/s?q={{key}}',
        'ruleSearch': {'bookList': '.item', 'name': '.t', 'bookUrl': '.l@href'},
      });
      expect(await wb.searchBook(source, '关键词'), isEmpty);
    });

    test('getContent 网络异常 → 返回空', () async {
      stubThrow();
      final wb = WebBook(dio);
      final source = _source({
        'ruleContent': {'content': '.content'},
      });
      expect(await wb.getContent(source, 'https://test.com/c'), '');
    });

    test('getBookInfo 网络异常 → 返回原 book', () async {
      stubThrow();
      final wb = WebBook(dio);
      final source = _source({
        'ruleBookInfo': {'name': '.title'},
      });
      final result = await wb.getBookInfo(source, _book('原名'));
      expect(result.name, '原名');
    });
  });
}
