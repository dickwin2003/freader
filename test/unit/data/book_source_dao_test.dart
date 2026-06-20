import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freader/core/database/app_database.dart';
import 'package:freader/data/repositories/book_source_repository.dart';
import 'package:freader/data/entities/book_source.dart' as dto;
import 'package:freader/data/entities/rules/search_rule.dart';

void main() {
  late AppDatabase database;
  late BookSourceRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = BookSourceRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('BookSource CRUD 测试', () {
    final testSource = dto.BookSource(
      bookSourceUrl: 'https://test1.com',
      bookSourceName: '测试书源1',
      bookSourceGroup: '小说;热门',
      enabled: true,
      enabledExplore: true,
      searchUrl: '/search?q={{key}}',
      ruleSearch: const SearchRule(
        bookList: '@css:div.list > li',
        name: '@css:h2 @text',
        author: '@css:span.author @text',
      ),
    );

    final testSource2 = dto.BookSource(
      bookSourceUrl: 'https://test2.com',
      bookSourceName: '测试书源2',
      bookSourceGroup: '漫画',
      enabled: true,
      enabledExplore: false,
    );

    final testSource3 = dto.BookSource(
      bookSourceUrl: 'https://test3.com',
      bookSourceName: '测试书源3',
      enabled: false,
      enabledExplore: false,
    );

    test('保存和获取书源', () async {
      await repository.save(testSource);

      final all = await repository.getAll();
      expect(all.length, 1);
      expect(all.first.bookSourceUrl, 'https://test1.com');
      expect(all.first.bookSourceName, '测试书源1');
      expect(all.first.bookSourceGroup, '小说;热门');
    });

    test('批量保存书源', () async {
      await repository.saveAll([testSource, testSource2, testSource3]);

      final all = await repository.getAll();
      expect(all.length, 3);
    });

    test('按 URL 获取书源', () async {
      await repository.saveAll([testSource, testSource2]);

      final found = await repository.getByUrl('https://test2.com');
      expect(found, isNotNull);
      expect(found!.bookSourceName, '测试书源2');
    });

    test('按 URL 获取不存在返回 null', () async {
      final found = await repository.getByUrl('https://notexist.com');
      expect(found, isNull);
    });

    test('启用/禁用书源', () async {
      await repository.save(testSource);
      await repository.setEnabled('https://test1.com', false);

      final found = await repository.getByUrl('https://test1.com');
      expect(found!.enabled, false);
    });

    test('删除书源', () async {
      await repository.saveAll([testSource, testSource2]);
      expect(await repository.getCount(), 2);

      await repository.deleteByUrl('https://test1.com');
      expect(await repository.getCount(), 1);

      final remaining = await repository.getAll();
      expect(remaining.first.bookSourceUrl, 'https://test2.com');
    });

    test('批量删除书源', () async {
      await repository.saveAll([testSource, testSource2, testSource3]);
      expect(await repository.getCount(), 3);

      await repository.deleteByUrls(['https://test1.com', 'https://test3.com']);
      expect(await repository.getCount(), 1);
    });

    test('获取所有分组', () async {
      await repository.saveAll([testSource, testSource2, testSource3]);

      final groups = await repository.getAllGroups();
      expect(groups, containsAll(['小说', '热门', '漫画']));
    });

    test('获取书源数量', () async {
      expect(await repository.getCount(), 0);

      await repository.save(testSource);
      expect(await repository.getCount(), 1);

      await repository.saveAll([testSource2, testSource3]);
      expect(await repository.getCount(), 3);
    });

    test('规则对象正确持久化和恢复', () async {
      await repository.save(testSource);

      final found = await repository.getByUrl('https://test1.com');
      expect(found!.ruleSearch, isNotNull);
      expect(found.ruleSearch!.bookList, '@css:div.list > li');
      expect(found.ruleSearch!.name, '@css:h2 @text');
      expect(found.ruleSearch!.author, '@css:span.author @text');
    });

    test('导入 JSON 书源', () async {
      const json = '''
      [
        {
          "bookSourceUrl": "https://import1.com",
          "bookSourceName": "导入书源1",
          "bookSourceType": 0,
          "enabled": true,
          "ruleSearch": {"bookList": "@css:li", "name": "@css:h3"}
        },
        {
          "bookSourceUrl": "https://import2.com",
          "bookSourceName": "导入书源2",
          "bookSourceType": 0,
          "enabled": true
        }
      ]
      ''';

      final count = await repository.importFromJson(json);
      expect(count, 2);
      expect(await repository.getCount(), 2);

      final imported = await repository.getByUrl('https://import1.com');
      expect(imported!.ruleSearch!.bookList, '@css:li');
    });

    test('导入无效 JSON 不崩溃', () async {
      const invalidJson = 'not valid json';
      expect(() => repository.importFromJson(invalidJson), throwsA(isA<FormatException>()));
    });

    test('导入部分有效的 JSON 跳过无效条目', () async {
      const json = '''
      [
        {"bookSourceUrl": "https://valid.com", "bookSourceName": "有效书源"},
        {"invalid": "data"},
        {"bookSourceUrl": "https://valid2.com", "bookSourceName": "有效书源2"}
      ]
      ''';

      final count = await repository.importFromJson(json);
      expect(count, 2);
    });

    test('导出书源 JSON', () async {
      await repository.save(testSource);

      final exported = await repository.exportToJson();
      expect(exported, contains('测试书源1'));
      expect(exported, contains('https://test1.com'));
    });

    test('覆盖导入（同 URL 替换）', () async {
      await repository.save(testSource);

      const updatedJson = '''
      [{
        "bookSourceUrl": "https://test1.com",
        "bookSourceName": "更新后的书源",
        "bookSourceType": 0,
        "enabled": true
      }]
      ''';

      await repository.importFromJson(updatedJson);
      expect(await repository.getCount(), 1);

      final found = await repository.getByUrl('https://test1.com');
      expect(found!.bookSourceName, '更新后的书源');
    });
  });
}
