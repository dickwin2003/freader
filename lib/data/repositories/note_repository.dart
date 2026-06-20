import 'package:drift/drift.dart';
import 'package:freader/core/database/app_database.dart' as db;
import 'package:freader/data/entities/note.dart' as dto;

/// 笔记仓库 - 封装 Notes 表操作
class NoteRepository {
  final db.AppDatabase _db;

  NoteRepository(this._db);

  /// 监听所有笔记（按更新时间倒序）
  Stream<List<dto.Note>> watchAll() {
    final query = _db.select(_db.notes)
      ..orderBy([
        (t) => OrderingTerm.desc(t.updateTime),
      ]);
    return query.watch().map((rows) => rows.map(_toNoteDto).toList());
  }

  /// 监听某本书的所有笔记
  Stream<List<dto.Note>> watchByBook(String bookUrl) {
    final query = _db.select(_db.notes)
      ..where((t) => t.bookUrl.equals(bookUrl))
      ..orderBy([
        (t) => OrderingTerm.desc(t.updateTime),
      ]);
    return query.watch().map((rows) => rows.map(_toNoteDto).toList());
  }

  /// 获取所有笔记（非流式）
  Future<List<dto.Note>> getAll() async {
    final query = _db.select(_db.notes)
      ..orderBy([
        (t) => OrderingTerm.desc(t.updateTime),
      ]);
    final rows = await query.get();
    return rows.map(_toNoteDto).toList();
  }

  /// 获取某本书的所有笔记（非流式，供 AI 总结用）
  Future<List<dto.Note>> getByBook(String bookUrl) async {
    final query = _db.select(_db.notes)
      ..where((t) => t.bookUrl.equals(bookUrl))
      ..orderBy([
        (t) => OrderingTerm.asc(t.createTime),
      ]);
    final rows = await query.get();
    return rows.map(_toNoteDto).toList();
  }

  /// 保存（新增或更新）
  Future<void> save(dto.Note note) async {
    await _db.into(_db.notes).insertOnConflictUpdate(_toNoteCompanion(note));
  }

  /// 删除
  Future<void> delete(int id) async {
    await (_db.delete(_db.notes)..where((t) => t.id.equals(id))).go();
  }

  // ===== 类型转换 =====

  dto.Note _toNoteDto(db.Note row) {
    return dto.Note(
      id: row.id,
      title: row.title,
      content: row.content,
      bookUrl: row.bookUrl,
      bookName: row.bookName,
      chapterIndex: row.chapterIndex,
      createTime: row.createTime,
      updateTime: row.updateTime,
    );
  }

  db.NotesCompanion _toNoteCompanion(dto.Note note) {
    return db.NotesCompanion(
      id: note.id == 0 ? const Value.absent() : Value(note.id),
      title: Value(note.title),
      content: Value(note.content),
      bookUrl: Value(note.bookUrl),
      bookName: Value(note.bookName),
      chapterIndex: Value(note.chapterIndex),
      createTime: Value(note.createTime),
      updateTime: Value(note.updateTime),
    );
  }
}
