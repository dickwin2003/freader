import 'package:drift/drift.dart';
import 'package:freader/core/database/app_database.dart' as db;
import 'package:freader/data/entities/bookmark.dart' as dto;

/// 书签仓库 - 封装 Bookmarks 表操作
class BookmarkRepository {
  final db.AppDatabase _db;

  BookmarkRepository(this._db);

  /// 监听某本书的书签（按时间倒序）
  Stream<List<dto.Bookmark>> watchByBook(String bookUrl) {
    final query = _db.select(_db.bookmarks)
      ..where((t) => t.bookUrl.equals(bookUrl))
      ..orderBy([
        (t) => OrderingTerm.desc(t.time),
      ]);
    return query.watch().map((rows) => rows.map(_toDto).toList());
  }

  /// 新增书签（time 作主键，传 0 自动用当前时间）
  Future<void> add(dto.Bookmark b) async {
    final t = b.time == 0 ? DateTime.now().millisecondsSinceEpoch : b.time;
    await _db.into(_db.bookmarks).insertOnConflictUpdate(
          db.BookmarksCompanion(
            time: Value(t),
            bookUrl: Value(b.bookUrl),
            bookName: Value(b.bookName),
            chapterIndex: Value(b.chapterIndex),
            chapterPos: Value(b.chapterPos),
            bookText: Value(b.bookText),
            content: Value(b.content),
          ),
        );
  }

  Future<void> delete(int time) async {
    await (_db.delete(_db.bookmarks)..where((t) => t.time.equals(time))).go();
  }

  dto.Bookmark _toDto(db.Bookmark row) {
    return dto.Bookmark(
      time: row.time,
      bookUrl: row.bookUrl,
      bookName: row.bookName,
      chapterIndex: row.chapterIndex,
      chapterPos: row.chapterPos,
      bookText: row.bookText,
      content: row.content,
    );
  }
}
