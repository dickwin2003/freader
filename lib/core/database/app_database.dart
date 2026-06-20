import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/book_sources.dart';
import 'tables/books.dart';
import 'tables/book_chapters.dart';
import 'tables/book_groups.dart';
import 'tables/bookmarks.dart';
import 'tables/replace_rules.dart';
import 'tables/search_books.dart';
import 'tables/rss_sources.dart';
import 'tables/rss_articles.dart';
import 'tables/search_keywords.dart';
import 'tables/txt_toc_rules.dart';
import 'tables/http_tts.dart';
import 'tables/dict_rules.dart';
import 'tables/notes.dart';

part 'app_database.g.dart';

/// FReader 数据库
/// 独立 schema，兼容常见书源 JSON 格式便于导入
@DriftDatabase(tables: [
  BookSources,
  Books,
  BookChapters,
  BookGroups,
  Bookmarks,
  ReplaceRules,
  SearchBooks,
  RssSources,
  RssArticles,
  SearchKeywords,
  TxtTocRules,
  HttpTts,
  DictRules,
  Notes,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.addColumn(books, books.score);
          }
          if (from < 3) {
            await m.createTable(notes);
          }
        },
      );
}

/// 创建数据库连接
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'freader.db'));
    return NativeDatabase.createInBackground(file);
  });
}
