import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freader/data/entities/book.dart' as dto;
import 'package:freader/data/entities/book_chapter.dart' as dto;
import 'package:freader/data/repositories/book_repository.dart';
import 'package:freader/data/repositories/book_source_repository.dart';
import 'package:freader/service/local_file_reader.dart';
import 'package:freader/service/web_book.dart';

import 'app_providers.dart';
import 'book_source_providers.dart';

/// 书籍仓库 Provider
final bookRepositoryProvider = Provider<BookRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return BookRepository(db);
});

/// WebBook 服务 Provider
final webBookProvider = Provider<WebBook>((ref) {
  final dio = ref.watch(dioProvider);
  return WebBook(dio);
});

/// 书架书籍列表
final bookshelfProvider = StreamProvider<List<dto.Book>>((ref) {
  return ref.watch(bookRepositoryProvider).watchBookshelf();
});

/// 书籍详情 Provider（通过 family 传参）
final bookDetailProvider =
    FutureProvider.family<dto.Book, String>((ref, bookUrl) async {
  final repo = ref.watch(bookRepositoryProvider);
  final book = await repo.getBook(bookUrl);
  return book ?? dto.Book(
    bookUrl: bookUrl,
    tocUrl: '',
    origin: '',
    originName: '',
    name: '未知',
    author: '',
  );
});

/// 章节列表 Provider
final chapterListProvider =
    FutureProvider.family<List<dto.BookChapter>, String>((ref, bookUrl) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getChapters(bookUrl);
});

/// 书籍操作 Provider
final bookActionsProvider = Provider<BookActions>((ref) {
  return BookActions(ref);
});

/// 书籍操作类
class BookActions {
  final Ref _ref;
  BookActions(this._ref);

  BookRepository get _repo => _ref.read(bookRepositoryProvider);
  WebBook get _webBook => _ref.read(webBookProvider);
  BookSourceRepository get _sourceRepo =>
      _ref.read(bookSourceRepositoryProvider);

  /// 加入书架
  Future<void> addToBookshelf(dto.Book book) async {
    final shelfBook = dto.Book(
      bookUrl: book.bookUrl,
      tocUrl: book.tocUrl,
      origin: book.origin,
      originName: book.originName,
      name: book.name,
      author: book.author,
      kind: book.kind,
      coverUrl: book.coverUrl,
      intro: book.intro,
      wordCount: book.wordCount,
      latestChapterTitle: book.latestChapterTitle,
      totalChapterNum: book.totalChapterNum,
      type: book.type,
      inBookshelf: true,
      local: book.local,
      score: book.score,
    );
    await _repo.saveBook(shelfBook);
  }

  /// 从书架移除
  Future<void> removeFromBookshelf(String bookUrl) async {
    await _repo.deleteBook(bookUrl);
  }

  /// 检查是否在书架中
  Future<bool> isInBookshelf(String bookUrl) async {
    final book = await _repo.getBook(bookUrl);
    return book?.inBookshelf ?? false;
  }

  /// 加载章节列表并缓存
  Future<List<dto.BookChapter>> loadChapterList(dto.Book book) async {
    // 先检查缓存（本地书籍在导入时已保存章节）
    final cached = await _repo.getChapters(book.bookUrl);
    if (cached.isNotEmpty) return cached;

    // 本地书籍没有缓存则重新解析
    if (book.local) {
      return await _reparseLocalBook(book);
    }

    // 从网络加载
    final source = await _sourceRepo.getByUrl(book.origin);
    if (source == null) return [];

    final chapters = await _webBook.getChapterList(source, book);
    if (chapters.isNotEmpty) {
      await _repo.saveChapters(book.bookUrl, chapters);
      // 更新书籍总章节数
      await _repo.updateBookInfo(dto.Book(
        bookUrl: book.bookUrl,
        tocUrl: book.tocUrl,
        origin: book.origin,
        originName: book.originName,
        name: book.name,
        author: book.author,
        totalChapterNum: chapters.length,
        inBookshelf: true,
      ));
    }
    return chapters;
  }

  /// 重新解析本地书籍
  Future<List<dto.BookChapter>> _reparseLocalBook(dto.Book book) async {
    // 需要延迟导入避免循环依赖
    final result = await LocalFileReader.readTextContent(
        book.bookUrl, knownCharset: book.charset);
    final chapters = LocalFileReader.buildChapters(
        result.content, book.bookUrl, book.name);
    if (chapters.isNotEmpty) {
      await _repo.saveChapters(book.bookUrl, chapters);
    }
    return chapters;
  }

  /// 获取章节内容
  Future<String> loadContent(dto.Book book, dto.BookChapter chapter) async {
    final source = await _sourceRepo.getByUrl(book.origin);
    if (source == null) return '';

    return _webBook.getContent(source, chapter.url);
  }

  /// 更新阅读进度
  Future<void> updateProgress(
    String bookUrl, {
    required int chapterIndex,
    String? chapterTitle,
    int chapterPos = 0,
  }) async {
    await _repo.updateReadProgress(
      bookUrl,
      chapterIndex: chapterIndex,
      chapterTitle: chapterTitle,
      chapterPos: chapterPos,
    );
  }

  /// 更新用户评分（0-5）
  Future<void> updateScore(String bookUrl, int score) async {
    await _repo.updateScore(bookUrl, score);
  }
}
