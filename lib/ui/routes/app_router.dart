import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:freader/data/entities/book.dart' as dto;
import 'package:freader/data/entities/book_chapter.dart' as dto;

import '../pages/bookshelf/bookshelf_page.dart';
import '../pages/book_source/book_source_list_page.dart';
import '../pages/book_info/book_info_page.dart';
import '../pages/explore/explore_page.dart';
import '../pages/reader/reader_page.dart';
import '../pages/notes/notes_page.dart';
import '../pages/ai_hub/ai_hub_page.dart';
import '../pages/search/search_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/local_import/local_import_page.dart';
import '../widgets/app_shell.dart';

/// 应用路由配置
final appRouter = GoRouter(
  initialLocation: '/bookshelf',
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('FReader')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('无法打开该内容', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          FilledButton.tonal(
            onPressed: () => context.go('/bookshelf'),
            child: const Text('返回书架'),
          ),
        ],
      ),
    ),
  ),
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        // 书架
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/bookshelf',
            name: 'bookshelf',
            builder: (context, state) => const BookshelfPage(),
          ),
        ]),
        // 笔记
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/notes',
            name: 'notes',
            builder: (context, state) => const NotesPage(),
          ),
        ]),
        // AI（助手 + 翻译 hub）
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/ai',
            name: 'aiHub',
            builder: (context, state) => const AiHubPage(),
          ),
        ]),
        // 我的
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsPage(),
            routes: [
              GoRoute(
                path: 'book_source',
                name: 'bookSource',
                builder: (context, state) => const BookSourceListPage(),
              ),
            ],
          ),
        ]),
      ],
    ),
    // 发现页面（全屏，从书架入口进入）
    GoRoute(
      path: '/explore',
      name: 'explore',
      builder: (context, state) => const ExplorePage(),
    ),
    // 搜索页面（全屏）
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => const SearchPage(),
    ),
    // 本地文件导入页面（全屏）
    GoRoute(
      path: '/local_import',
      name: 'localImport',
      builder: (context, state) => const LocalImportPage(),
    ),
    // 书籍详情页（全屏）- 接受 Map 参数
    GoRoute(
      path: '/book_info',
      name: 'bookInfo',
      builder: (context, state) {
        final extra = state.extra!;
        if (extra is Map<String, dynamic>) {
          return BookInfoPage(
            bookUrl: extra['bookUrl'] as String,
            origin: extra['origin'] as String,
            originName: extra['originName'] as String,
            name: extra['name'] as String,
            author: extra['author'] as String,
            kind: extra['kind'] as String?,
            coverUrl: extra['coverUrl'] as String?,
            intro: extra['intro'] as String?,
            wordCount: extra['wordCount'] as String?,
            latestChapter: extra['latestChapter'] as String?,
          );
        }
        // 兼容旧的 SearchBook 对象传入方式
        // 从 SearchBook 对象读取字段
        final sb = extra;
        return BookInfoPage(
          bookUrl: _getField(sb, 'bookUrl') ?? '',
          origin: _getField(sb, 'origin') ?? '',
          originName: _getField(sb, 'originName') ?? '',
          name: _getField(sb, 'name') ?? '未知',
          author: _getField(sb, 'author') ?? '',
          kind: _getField(sb, 'kind'),
          coverUrl: _getField(sb, 'coverUrl'),
          intro: _getField(sb, 'intro'),
          wordCount: _getField(sb, 'wordCount'),
          latestChapter: _getField(sb, 'latestChapter'),
        );
      },
    ),
    // 阅读器页面（全屏）
    GoRoute(
      path: '/reader',
      name: 'reader',
      builder: (context, state) {
        final extra = state.extra! as Map<String, dynamic>;
        return ReaderPage(
          book: extra['book'] as dto.Book,
          chapters: extra['chapters'] as List<dto.BookChapter>,
          startIndex: extra['startIndex'] as int? ?? 0,
          localContent: extra['localContent'] as String?,
          isEpubFile: extra['isEpubFile'] as bool? ?? false,
          epubBook: extra['epubBook'],
          isPdfFile: extra['isPdfFile'] as bool? ?? false,
          isMobiFile: extra['isMobiFile'] as bool? ?? false,
          mobiBook: extra['mobiBook'],
        );
      },
    ),
  ],
);

/// 从对象获取字段值（兼容 SearchBook 和 Map）
String? _getField(dynamic obj, String field) {
  if (obj is Map) return obj[field]?.toString();
  try {
    // 使用 dynamic 访问属性
    final val = (obj as dynamic)[field];
    return val?.toString();
  } catch (_) {
    return null;
  }
}
