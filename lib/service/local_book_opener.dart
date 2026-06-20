import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:freader/data/entities/book.dart';
import 'package:freader/data/entities/book_chapter.dart';
import 'package:freader/data/repositories/book_repository.dart';
import 'package:freader/service/local_file_reader.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:freader/service/archive/rar_extractor.dart';
import 'package:freader/service/archive/sz7_extractor.dart';

/// 本地书籍打开结果
class LocalBookResult {
  final Book book;
  final List<BookChapter> chapters;
  final String? fullContent; // null for EPUB/PDF/MOBI
  final bool isTextFile; // TXT/MD/HTML
  final bool isEpubFile; // EPUB
  final bool isPdfFile; // PDF
  final bool isMobiFile; // MOBI/AZW/AZW3
  final bool isUnsupported; // UMD
  final String? unsupportedFormatName;
  // EPUB 专用
  final dynamic epubBook; // EpubBook
  final List<LocalEpubChapter>? epubChapters;
  // MOBI 专用
  final dynamic mobiBook; // MobiBook

  const LocalBookResult({
    required this.book,
    required this.chapters,
    this.fullContent,
    this.isTextFile = false,
    this.isEpubFile = false,
    this.isPdfFile = false,
    this.isMobiFile = false,
    this.isUnsupported = false,
    this.unsupportedFormatName,
    this.epubBook,
    this.epubChapters,
    this.mobiBook,
  });
}

/// 本地书籍打开器
class LocalBookOpener {
  final BookRepository _bookRepo;

  LocalBookOpener(this._bookRepo);

  /// 读取已有的阅读进度，避免 saveBook 时覆盖
  Future<Book?> _getExistingBook(String filePath) async {
    try {
      return await _bookRepo.getBook(filePath);
    } catch (_) {
      return null;
    }
  }

  /// 创建 Book 实体时保留已有的阅读进度
  Book _preserveProgress(Book newBook, Book? existing) {
    if (existing == null) return newBook;
    return Book(
      bookUrl: newBook.bookUrl,
      tocUrl: newBook.tocUrl,
      origin: newBook.origin,
      originName: newBook.originName,
      name: newBook.name,
      author: newBook.author,
      kind: newBook.kind,
      customTag: newBook.customTag,
      coverUrl: newBook.coverUrl,
      customCoverUrl: newBook.customCoverUrl,
      intro: newBook.intro,
      customIntro: newBook.customIntro,
      charset: newBook.charset,
      type: newBook.type,
      group: newBook.group,
      latestChapterTitle: newBook.latestChapterTitle,
      latestChapterTime: newBook.latestChapterTime,
      totalChapterNum: newBook.totalChapterNum,
      // 保留阅读进度
      durChapterIndex: existing.durChapterIndex,
      durChapterTitle: existing.durChapterTitle,
      durChapterPos: existing.durChapterPos,
      durChapterTime: existing.durChapterTime > 0
          ? existing.durChapterTime
          : DateTime.now().millisecondsSinceEpoch,
      wordCount: newBook.wordCount,
      canUpdate: newBook.canUpdate,
      variable: newBook.variable,
      readConfig: newBook.readConfig,
      syncTime: newBook.syncTime,
      local: newBook.local,
      inBookshelf: newBook.inBookshelf,
      score: existing.score,
    );
  }

  /// 打开本地文件，根据格式分发处理
  Future<LocalBookResult> openFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) throw Exception('文件不存在: $filePath');

    final fileName = LocalFileReader.getFileName(filePath);

    // EPUB 格式
    if (LocalFileReader.isEpubFile(filePath)) {
      return await _openEpub(filePath, fileName);
    }

    // PDF 格式
    if (LocalFileReader.isPdfFile(filePath)) {
      return await _openPdf(filePath, fileName);
    }

    // MOBI 格式
    if (LocalFileReader.isMobiFile(filePath)) {
      return await _openMobi(filePath, fileName);
    }

    // Word .docx
    if (LocalFileReader.isDocxFile(filePath)) {
      return await _openDocx(filePath, fileName);
    }
    // Word .doc（旧版二进制，暂不支持）
    if (LocalFileReader.isDocFile(filePath)) {
      throw Exception('暂不支持旧版 .doc，请用 Word 另存为 .docx 或 PDF 后再导入');
    }

    // 不支持的格式
    if (LocalFileReader.isUnsupportedFormat(filePath)) {
      return await _openUnsupported(filePath, fileName);
    }

    // 压缩包：解压后导入内部书籍
    if (LocalFileReader.isZipFile(filePath)) {
      return await _openZip(filePath, fileName);
    }
    if (LocalFileReader.isRarFile(filePath)) {
      return await _openRar(filePath, fileName);
    }
    if (LocalFileReader.is7zFile(filePath)) {
      return await _open7z(filePath, fileName);
    }

    // 文本格式 (TXT/MD/HTML)
    return await _openText(filePath, fileName);
  }

  /// 处理 EPUB 文件
  Future<LocalBookResult> _openEpub(String filePath, String fileName) async {
    final result = await LocalFileReader.parseEpub(filePath);

    // 创建 BookChapter 列表
    final chapters = <BookChapter>[];
    for (final epubChapter in result.chapters) {
      chapters.add(BookChapter(
        bookUrl: filePath,
        title: epubChapter.title,
        url: epubChapter.contentFileName,
        index: chapters.length,
        isVolume: epubChapter.isVolume,
        variable: 'epub', // 标记为 EPUB 章节
      ));
    }

    // 如果没有找到章节，创建一个占位章节
    if (chapters.isEmpty) {
      chapters.add(BookChapter(
        bookUrl: filePath,
        title: fileName,
        url: '0',
        index: 0,
        variable: 'epub',
      ));
    }

    final book = Book(
      bookUrl: filePath,
      tocUrl: '',
      origin: 'local',
      originName: '本地文件',
      name: result.title,
      author: result.author,
      kind: 'EPUB',
      coverUrl: result.coverPath,
      intro: null,
      totalChapterNum: chapters.length,
      type: BookType.file,
      inBookshelf: true,
      local: true,
    );

    final savedBook = _preserveProgress(book, await _getExistingBook(filePath));
    await _bookRepo.saveBook(savedBook);
    await _bookRepo.saveChapters(filePath, chapters);

    return LocalBookResult(
      book: savedBook,
      chapters: chapters,
      isEpubFile: true,
      epubBook: result.epubBook,
      epubChapters: result.chapters,
    );
  }

  /// 处理 PDF 文件
  Future<LocalBookResult> _openPdf(String filePath, String fileName) async {
    // 通过 pdfrx 获取页数（替代原生平台通道，跨平台）
    int pageCount;
    final doc = await PdfDocument.openFile(filePath);
    try {
      pageCount = doc.pages.length;
    } finally {
      doc.dispose();
    }

    // PDF 每10页为一章，参考 Legado
    final pageSize = 10;
    final chapterCount = (pageCount / pageSize).ceil();

    final chapters = <BookChapter>[];
    for (int i = 0; i < chapterCount; i++) {
      chapters.add(BookChapter(
        bookUrl: filePath,
        title: '分段 $i',
        url: 'pdf_$i',
        index: i,
        variable: 'pdf',
      ));
    }

    if (chapters.isEmpty) {
      chapters.add(BookChapter(
        bookUrl: filePath,
        title: fileName,
        url: 'pdf_0',
        index: 0,
        variable: 'pdf',
      ));
    }

    final book = Book(
      bookUrl: filePath,
      tocUrl: '',
      origin: 'local',
      originName: '本地文件',
      name: fileName,
      author: '未知',
      kind: 'PDF',
      intro: 'PDF 文件, 共 $pageCount 页',
      totalChapterNum: chapters.length,
      type: BookType.file,
      inBookshelf: true,
      local: true,
    );

    final savedBook = _preserveProgress(book, await _getExistingBook(filePath));
    await _bookRepo.saveBook(savedBook);
    await _bookRepo.saveChapters(filePath, chapters);

    return LocalBookResult(
      book: savedBook,
      chapters: chapters,
      isPdfFile: true,
    );
  }

  /// 处理 MOBI/AZW/AZW3 文件
  Future<LocalBookResult> _openMobi(String filePath, String fileName) async {
    final result = await LocalFileReader.parseMobi(filePath);

    final book = Book(
      bookUrl: filePath,
      tocUrl: '',
      origin: 'local',
      originName: '本地文件',
      name: result.title,
      author: result.author,
      kind: result.kind,
      coverUrl: result.coverPath,
      intro: result.intro,
      totalChapterNum: result.chapters.length,
      type: BookType.file,
      inBookshelf: true,
      local: true,
    );

    final savedBook = _preserveProgress(book, await _getExistingBook(filePath));
    await _bookRepo.saveBook(savedBook);
    await _bookRepo.saveChapters(filePath, result.chapters);

    return LocalBookResult(
      book: savedBook,
      chapters: result.chapters,
      isMobiFile: true,
      mobiBook: result.mobiBook,
    );
  }

  /// 不支持的格式
  Future<LocalBookResult> _openUnsupported(String filePath, String fileName) async {
    final formatName = LocalFileReader.getUnsupportedFormatName(filePath);

    final book = Book(
      bookUrl: filePath,
      tocUrl: '',
      origin: 'local',
      originName: '本地文件',
      name: fileName,
      author: '未知',
      kind: formatName,
      intro: '$formatName 格式暂不支持解析',
      totalChapterNum: 0,
      type: BookType.file,
      inBookshelf: true,
      local: true,
    );

    final savedBook = _preserveProgress(book, await _getExistingBook(filePath));
    await _bookRepo.saveBook(savedBook);

    return LocalBookResult(
      book: savedBook,
      chapters: [],
      isUnsupported: true,
      unsupportedFormatName: formatName,
    );
  }

  /// 处理 zip 压缩包：解压并导入内部书籍
  Future<LocalBookResult> _openZip(String filePath, String fileName) async {
    final innerPaths = await LocalFileReader.extractZip(filePath);
    if (innerPaths.isEmpty) {
      return _openUnsupported(filePath, fileName);
    }
    // 内部书籍逐个导入；返回第一本供阅读器打开
    LocalBookResult? first;
    for (int i = 0; i < innerPaths.length; i++) {
      try {
        final result = await openFile(innerPaths[i]);
        if (i == 0) first = result;
      } catch (_) {}
    }
    return first ?? _openUnsupported(filePath, fileName);
  }

  /// 处理 rar 压缩包：通过 unRAR native 库解压并导入内部书籍
  Future<LocalBookResult> _openRar(String filePath, String fileName) async {
    final outDir = '${Directory.systemTemp.path}/freader_rar/${filePath.hashCode}';
    final files = extractRarToDir(filePath, outDir);
    final bookFiles = files.where((f) => LocalFileReader.isBookExtension(p.extension(f))).toList();
    if (bookFiles.isEmpty) {
      return _openUnsupported(filePath, fileName);
    }
    LocalBookResult? first;
    for (int i = 0; i < bookFiles.length; i++) {
      try {
        final result = await openFile(bookFiles[i]);
        if (i == 0) first = result;
      } catch (_) {}
    }
    return first ?? _openUnsupported(filePath, fileName);
  }

  /// 处理 7z 压缩包：通过 LZMA SDK native 库解压并导入内部书籍
  Future<LocalBookResult> _open7z(String filePath, String fileName) async {
    final outDir = '${Directory.systemTemp.path}/freader_7z/${filePath.hashCode}';
    final files = extract7zToDir(filePath, outDir);
    final bookFiles = files.where((f) => LocalFileReader.isBookExtension(p.extension(f))).toList();
    if (bookFiles.isEmpty) {
      return _openUnsupported(filePath, fileName);
    }
    LocalBookResult? first;
    for (int i = 0; i < bookFiles.length; i++) {
      try {
        final result = await openFile(bookFiles[i]);
        if (i == 0) first = result;
      } catch (_) {}
    }
    return first ?? _openUnsupported(filePath, fileName);
  }

  /// 处理文本文件 (TXT/MD/HTML)
  /// 处理 .docx：解压取正文纯文本，按章/段构建
  Future<LocalBookResult> _openDocx(String filePath, String fileName) async {
    final content = await LocalFileReader.readDocxText(filePath);
    final chapters = LocalFileReader.buildChapters(content, filePath, fileName);

    final book = Book(
      bookUrl: filePath,
      tocUrl: '',
      origin: 'local',
      originName: '本地文件',
      name: fileName,
      author: '未知',
      kind: 'DOCX',
      intro: '本地文件: ${p.basename(filePath)}',
      wordCount: content.length.toString(),
      latestChapterTitle: chapters.isNotEmpty ? chapters.last.title : null,
      totalChapterNum: chapters.length,
      type: BookType.file,
      inBookshelf: true,
      local: true,
    );

    final savedBook = _preserveProgress(book, await _getExistingBook(filePath));
    await _bookRepo.saveBook(savedBook);
    await _bookRepo.saveChapters(filePath, chapters);

    return LocalBookResult(
      book: savedBook,
      chapters: chapters,
      fullContent: content,
      isTextFile: true,
    );
  }

  Future<LocalBookResult> _openText(String filePath, String fileName) async {
    final extension = LocalFileReader.getFileExtension(filePath);

    // 查询已有书籍的缓存编码
    final existingBook = await _bookRepo.getBook(filePath);
    final cachedCharset = existingBook?.charset;

    final result = await LocalFileReader.readTextContent(
      filePath,
      knownCharset: cachedCharset,
    );
    // HTML/HTM：去除标签转为可读纯文本
    final raw = result.content;
    final content = (extension == '.html' || extension == '.htm')
        ? LocalFileReader.htmlToPlainText(raw)
        : raw;
    final detectedCharset = result.charset;

    final chapters = LocalFileReader.buildChapters(content, filePath, fileName);

    final kindDesc = extension == '.md'
        ? 'Markdown'
        : extension == '.html' || extension == '.htm'
            ? 'HTML'
            : 'TXT';

    final book = Book(
      bookUrl: filePath,
      tocUrl: '',
      origin: 'local',
      originName: '本地文件',
      name: fileName,
      author: '未知',
      kind: kindDesc,
      intro: '本地文件: ${p.basename(filePath)}',
      wordCount: content.length.toString(),
      latestChapterTitle: chapters.isNotEmpty ? chapters.last.title : null,
      totalChapterNum: chapters.length,
      type: BookType.file,
      inBookshelf: true,
      local: true,
      charset: detectedCharset,
    );

    final savedBook = _preserveProgress(book, await _getExistingBook(filePath));
    await _bookRepo.saveBook(savedBook);
    await _bookRepo.saveChapters(filePath, chapters);

    return LocalBookResult(
      book: savedBook,
      chapters: chapters,
      fullContent: content,
      isTextFile: true,
    );
  }

  Future<bool> isImported(String filePath) async {
    final book = await _bookRepo.getBook(filePath);
    return book?.local == true;
  }
}
