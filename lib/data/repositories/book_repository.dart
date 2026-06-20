import 'package:drift/drift.dart';
import 'package:freader/core/database/app_database.dart' as db;
import 'package:freader/data/entities/book.dart' as dto;
import 'package:freader/data/entities/book_chapter.dart' as dto;
import 'package:freader/data/entities/search_keyword.dart' as dto;

/// 书籍仓库 - 封装 Book/Chapter/SearchKeyword 数据操作
class BookRepository {
  final db.AppDatabase _db;

  BookRepository(this._db);

  // ===== Book 操作 =====

  /// 保存书籍（新增或更新）
  Future<void> saveBook(dto.Book book) async {
    await _db.into(_db.books).insertOnConflictUpdate(_toBookCompanion(book));
  }

  /// 批量保存书籍
  Future<void> saveBooks(List<dto.Book> books) async {
    await _db.batch((b) {
      b.insertAllOnConflictUpdate(
        _db.books,
        books.map(_toBookCompanion).toList(),
      );
    });
  }

  /// 获取单本书籍
  Future<dto.Book?> getBook(String bookUrl) async {
    final query = _db.select(_db.books)
      ..where((t) => t.bookUrl.equals(bookUrl));
    final row = await query.getSingleOrNull();
    return row != null ? _toBookDto(row) : null;
  }

  /// 监听书架中的所有书籍
  Stream<List<dto.Book>> watchBookshelf() {
    final query = _db.select(_db.books)
      ..where((t) => t.inBookshelf.equals(true))
      ..orderBy([
        (t) => OrderingTerm.desc(t.durChapterTime),
      ]);
    return query.watch().map((rows) => rows.map(_toBookDto).toList());
  }

  /// 获取所有书架书籍（非流式）
  Future<List<dto.Book>> getBookshelf() async {
    final query = _db.select(_db.books)
      ..where((t) => t.inBookshelf.equals(true))
      ..orderBy([
        (t) => OrderingTerm.desc(t.durChapterTime),
      ]);
    final rows = await query.get();
    return rows.map(_toBookDto).toList();
  }

  /// 设置书架状态
  Future<void> setInBookshelf(String bookUrl, bool inBookshelf) async {
    final query = _db.update(_db.books)
      ..where((t) => t.bookUrl.equals(bookUrl));
    await query.write(db.BooksCompanion(inBookshelf: Value(inBookshelf)));
  }

  /// 更新用户评分（0-5）
  Future<void> updateScore(String bookUrl, int score) async {
    final query = _db.update(_db.books)
      ..where((t) => t.bookUrl.equals(bookUrl));
    await query.write(db.BooksCompanion(score: Value(score.clamp(0, 5))));
  }

  /// 更新阅读进度
  Future<void> updateReadProgress(
    String bookUrl, {
    required int chapterIndex,
    String? chapterTitle,
    int chapterPos = 0,
  }) async {
    final query = _db.update(_db.books)
      ..where((t) => t.bookUrl.equals(bookUrl));
    await query.write(db.BooksCompanion(
      durChapterIndex: Value(chapterIndex),
      durChapterTitle: Value(chapterTitle),
      durChapterPos: Value(chapterPos),
      durChapterTime: Value(DateTime.now().millisecondsSinceEpoch),
    ));
  }

  /// 更新书籍信息
  Future<void> updateBookInfo(dto.Book book) async {
    final query = _db.update(_db.books)
      ..where((t) => t.bookUrl.equals(book.bookUrl));
    await query.write(db.BooksCompanion(
      name: Value(book.name),
      author: Value(book.author),
      coverUrl: Value(book.coverUrl),
      intro: Value(book.intro),
      kind: Value(book.kind),
      latestChapterTitle: Value(book.latestChapterTitle),
      totalChapterNum: Value(book.totalChapterNum),
      wordCount: Value(book.wordCount),
      tocUrl: Value(book.tocUrl),
    ));
  }

  /// 删除书籍
  Future<void> deleteBook(String bookUrl) async {
    await (_db.delete(_db.books)..where((t) => t.bookUrl.equals(bookUrl))).go();
    await (_db.delete(_db.bookChapters)..where((t) => t.bookUrl.equals(bookUrl)))
        .go();
  }

  // ===== Chapter 操作 =====

  /// 保存章节列表（替换该书籍的所有章节）
  Future<void> saveChapters(
      String bookUrl, List<dto.BookChapter> chapters) async {
    // 先删除旧章节
    await (_db.delete(_db.bookChapters)
          ..where((t) => t.bookUrl.equals(bookUrl)))
        .go();
    // 插入新章节
    if (chapters.isNotEmpty) {
      await _db.batch((b) {
        b.insertAllOnConflictUpdate(
          _db.bookChapters,
          chapters.map(_toChapterCompanion).toList(),
        );
      });
    }
  }

  /// 获取章节列表
  Future<List<dto.BookChapter>> getChapters(String bookUrl) async {
    final query = _db.select(_db.bookChapters)
      ..where((t) => t.bookUrl.equals(bookUrl))
      ..orderBy([(t) => OrderingTerm.asc(t.chapterIndex)]);
    final rows = await query.get();
    return rows.map(_toChapterDto).toList();
  }

  /// 获取单个章节
  Future<dto.BookChapter?> getChapter(String bookUrl, int index) async {
    final query = _db.select(_db.bookChapters)
      ..where((t) => t.bookUrl.equals(bookUrl) & t.chapterIndex.equals(index));
    final row = await query.getSingleOrNull();
    return row != null ? _toChapterDto(row) : null;
  }

  // ===== SearchKeyword 操作 =====

  /// 保存搜索关键词
  Future<void> saveSearchKeyword(String word) async {
    if (word.trim().isEmpty) return;
    final query = _db.select(_db.searchKeywords)
      ..where((t) => t.word.equals(word));
    final existing = await query.getSingleOrNull();
    if (existing != null) {
      final updateQuery = _db.update(_db.searchKeywords)
        ..where((t) => t.word.equals(word));
      await updateQuery.write(db.SearchKeywordsCompanion(
        usage: Value(existing.usage + 1),
        lastUseTime: Value(DateTime.now().millisecondsSinceEpoch),
      ));
    } else {
      await _db.into(_db.searchKeywords).insert(
            db.SearchKeywordsCompanion(
              word: Value(word),
              usage: const Value(1),
              lastUseTime: Value(DateTime.now().millisecondsSinceEpoch),
            ),
          );
    }
  }

  /// 获取搜索历史
  Future<List<dto.SearchKeyword>> getSearchHistory() async {
    final query = _db.select(_db.searchKeywords)
      ..orderBy([
        (t) => OrderingTerm.desc(t.lastUseTime),
      ])
      ..limit(20);
    final rows = await query.get();
    return rows.map(_toSearchKeywordDto).toList();
  }

  /// 清空搜索历史
  Future<void> clearSearchHistory() async {
    await _db.delete(_db.searchKeywords).go();
  }

  // ===== 类型转换 =====

  dto.Book _toBookDto(db.Book row) {
    return dto.Book(
      bookUrl: row.bookUrl,
      tocUrl: row.tocUrl,
      origin: row.origin,
      originName: row.originName,
      name: row.name,
      author: row.author,
      kind: row.kind,
      customTag: row.customTag,
      coverUrl: row.coverUrl,
      customCoverUrl: row.customCoverUrl,
      intro: row.intro,
      customIntro: row.customIntro,
      charset: row.charset,
      type: row.type,
      group: row.group,
      latestChapterTitle: row.latestChapterTitle,
      latestChapterTime: row.latestChapterTime,
      totalChapterNum: row.totalChapterNum,
      durChapterIndex: row.durChapterIndex,
      durChapterTitle: row.durChapterTitle,
      durChapterPos: row.durChapterPos,
      durChapterTime: row.durChapterTime,
      wordCount: row.wordCount,
      canUpdate: row.canUpdate,
      variable: row.variable,
      readConfig: row.readConfig,
      syncTime: row.syncTime,
      local: row.local,
      inBookshelf: row.inBookshelf,
      score: row.score,
    );
  }

  db.BooksCompanion _toBookCompanion(dto.Book book) {
    return db.BooksCompanion(
      bookUrl: Value(book.bookUrl),
      tocUrl: Value(book.tocUrl),
      origin: Value(book.origin),
      originName: Value(book.originName),
      name: Value(book.name),
      author: Value(book.author),
      kind: Value(book.kind),
      customTag: Value(book.customTag),
      coverUrl: Value(book.coverUrl),
      customCoverUrl: Value(book.customCoverUrl),
      intro: Value(book.intro),
      customIntro: Value(book.customIntro),
      charset: Value(book.charset),
      type: Value(book.type),
      group: Value(book.group),
      latestChapterTitle: Value(book.latestChapterTitle),
      latestChapterTime: Value(book.latestChapterTime),
      totalChapterNum: Value(book.totalChapterNum),
      durChapterIndex: Value(book.durChapterIndex),
      durChapterTitle: Value(book.durChapterTitle),
      durChapterPos: Value(book.durChapterPos),
      durChapterTime: Value(book.durChapterTime),
      wordCount: Value(book.wordCount),
      canUpdate: Value(book.canUpdate),
      variable: Value(book.variable),
      readConfig: Value(book.readConfig),
      syncTime: Value(book.syncTime),
      local: Value(book.local),
      inBookshelf: Value(book.inBookshelf),
      score: Value(book.score),
    );
  }

  dto.BookChapter _toChapterDto(db.BookChapter row) {
    return dto.BookChapter(
      url: row.url,
      title: row.title,
      bookUrl: row.bookUrl,
      index: row.chapterIndex,
      isVolume: row.isVolume,
      baseUrl: row.baseUrl,
      isVip: row.isVip,
      isPay: row.isPay,
      resourceUrl: row.resourceUrl,
      tag: row.tag,
      wordCount: row.wordCount,
      variable: row.variable,
    );
  }

  db.BookChaptersCompanion _toChapterCompanion(dto.BookChapter chapter) {
    return db.BookChaptersCompanion(
      url: Value(chapter.url),
      title: Value(chapter.title),
      bookUrl: Value(chapter.bookUrl),
      chapterIndex: Value(chapter.index),
      isVolume: Value(chapter.isVolume),
      baseUrl: Value(chapter.baseUrl),
      isVip: Value(chapter.isVip),
      isPay: Value(chapter.isPay),
      resourceUrl: Value(chapter.resourceUrl),
      tag: Value(chapter.tag),
      wordCount: Value(chapter.wordCount),
      variable: Value(chapter.variable),
    );
  }

  dto.SearchKeyword _toSearchKeywordDto(db.SearchKeyword row) {
    return dto.SearchKeyword(
      word: row.word,
      usage: row.usage,
      lastUseTime: row.lastUseTime,
    );
  }
}
