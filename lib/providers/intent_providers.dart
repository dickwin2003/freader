import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'book_providers.dart';
import '../service/intent_handler.dart';
import '../service/local_book_opener.dart';
import '../ui/routes/app_router.dart';

/// Intent 处理器 Provider
final intentHandlerProvider = Provider<IntentHandler>((ref) {
  return IntentHandler();
});

/// 处理传入文件路径
Future<void> handleIncomingFile(WidgetRef ref, String filePath) async {
  try {
    final bookRepo = ref.read(bookRepositoryProvider);
    final opener = LocalBookOpener(bookRepo);
    final result = await opener.openFile(filePath);

    // 导航到阅读器（所有格式统一处理）
    appRouter.push('/reader', extra: {
      'book': result.book,
      'chapters': result.chapters,
      'startIndex': result.book.durChapterIndex,
      'localContent': result.fullContent,
      'isEpubFile': result.isEpubFile,
      'epubBook': result.epubBook,
      'isPdfFile': result.isPdfFile,
      'isMobiFile': result.isMobiFile,
      'mobiBook': result.mobiBook,
    });
  } catch (e) {
    appRouter.go('/bookshelf');
  }
}
