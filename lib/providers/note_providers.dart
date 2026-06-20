import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:freader/data/entities/book.dart' as book_dto;
import 'package:freader/data/entities/note.dart' as dto;
import 'package:freader/data/repositories/note_repository.dart';
import 'package:freader/providers/app_providers.dart';
import 'package:freader/providers/book_providers.dart';
import 'package:freader/providers/llm_providers.dart';
import 'package:freader/service/llm/llm_service.dart';

/// 笔记仓库 Provider
final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  final dbb = ref.watch(appDatabaseProvider);
  return NoteRepository(dbb);
});

/// 所有笔记（按更新时间倒序）
final noteListProvider = StreamProvider<List<dto.Note>>((ref) {
  return ref.watch(noteRepositoryProvider).watchAll();
});

/// 某本书的笔记
final notesByBookProvider =
    StreamProvider.family<List<dto.Note>, String>((ref, bookUrl) {
  return ref.watch(noteRepositoryProvider).watchByBook(bookUrl);
});

/// 笔记操作
final noteActionsProvider = Provider<NoteActions>((ref) {
  return NoteActions(ref);
});

class NoteActions {
  final Ref _ref;
  NoteActions(this._ref);

  NoteRepository get _repo => _ref.read(noteRepositoryProvider);

  /// 新增或更新。新建时 note.id 应为 0。
  Future<dto.Note> save(dto.Note note) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final toSave = note.id == 0
        ? note.copyWith(createTime: now, updateTime: now)
        : note.copyWith(updateTime: now);
    await _repo.save(toSave);
    return toSave;
  }

  Future<void> delete(int id) => _repo.delete(id);

  /// 用 AI 总结某本书的所有笔记为读后感
  Future<String> summarizeBook(String bookUrl, {String? bookName}) async {
    final notes = await _repo.getByBook(bookUrl);
    if (notes.isEmpty) {
      throw const LlmException('该书暂无笔记，无法总结');
    }
    final buf = StringBuffer();
    for (final n in notes) {
      if (n.title.trim().isNotEmpty) buf.writeln('【${n.title}】');
      buf.writeln(n.content.trim());
      buf.writeln();
    }
    final reply = await _ref.read(llmServiceProvider).chat(
          userPrompt: buf.toString(),
          systemPrompt: '你是一位阅读助手。请根据下面的读书笔记，'
              '生成一篇连贯、有见地的读后感（中文，600 字以内）。'
              '${bookName == null ? "" : "书名：$bookName。"}'
              '可适当归纳、提炼主题，不要逐条罗列笔记。',
          temperature: 0.6,
          maxTokens: 1200,
        );
    return reply;
  }

  /// AI 读取一本书的正文（前几章）→ 生成内容摘要 → 存为笔记。
  /// 返回保存的笔记。
  Future<dto.Note> summarizeBookContent(book_dto.Book book) async {
    final actions = _ref.read(bookActionsProvider);
    final buf = StringBuffer();
    buf.writeln('书名：${book.name}');
    buf.writeln('作者：${book.author}');
    final intro = (book.intro ?? '').trim();
    if (intro.isNotEmpty) {
      buf.writeln('简介：${intro.length > 500 ? intro.substring(0, 500) : intro}');
    }
    try {
      final chapters = await actions.loadChapterList(book);
      final take = chapters.take(3); // 取前 3 章正文做摘要依据
      for (final c in take) {
        final text = await actions.loadContent(book, c);
        if (text.trim().isNotEmpty) {
          buf.writeln('\n【${c.title}】');
          buf.writeln(text.length > 2000 ? text.substring(0, 2000) : text);
        }
      }
    } catch (_) {
      // 取不到章节也能基于简介生成
    }

    final reply = await _ref.read(llmServiceProvider).chat(
          userPrompt: buf.toString(),
          systemPrompt: '你是一位阅读助手。请根据以下书籍信息与开头章节正文，'
              '生成一段内容摘要（中文，500 字以内），概括这本书讲什么。'
              '直接输出摘要正文，不要额外说明。',
          temperature: 0.4,
          maxTokens: 1000,
        );

    final now = DateTime.now().millisecondsSinceEpoch;
    final note = dto.Note(
      id: 0,
      title: '《${book.name}》摘要',
      content: reply.trim(),
      bookUrl: book.bookUrl,
      bookName: book.name,
      createTime: now,
      updateTime: now,
    );
    return await save(note);
  }
}
