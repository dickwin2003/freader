import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:freader/data/entities/bookmark.dart' as dto;
import 'package:freader/data/repositories/bookmark_repository.dart';
import 'package:freader/providers/app_providers.dart';

final bookmarkRepositoryProvider = Provider<BookmarkRepository>((ref) {
  return BookmarkRepository(ref.watch(appDatabaseProvider));
});

/// 某本书的书签列表（按时间倒序）
final bookmarksByBookProvider =
    StreamProvider.family<List<dto.Bookmark>, String>((ref, bookUrl) {
  return ref.watch(bookmarkRepositoryProvider).watchByBook(bookUrl);
});

final bookmarkActionsProvider = Provider<BookmarkRepository>(
    (ref) => ref.watch(bookmarkRepositoryProvider));
