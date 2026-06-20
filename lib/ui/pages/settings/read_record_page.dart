import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:freader/core/database/app_database.dart';
import 'package:freader/providers/app_providers.dart';

/// 阅读记录排序方式
enum ReadRecordSort {
  lastReadTime('最近阅读'),
  readDuration('阅读时长');

  final String label;
  const ReadRecordSort(this.label);
}

/// 阅读记录列表 Provider
final readRecordListProvider =
    StreamProvider<List<Book>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.books)
        ..where((t) => t.durChapterTime.isBiggerThanValue(0))
        ..orderBy([
          (t) => OrderingTerm.desc(t.durChapterTime),
        ]))
      .watch();
});

/// 阅读记录页面
class ReadRecordPage extends ConsumerStatefulWidget {
  const ReadRecordPage({super.key});

  @override
  ConsumerState<ReadRecordPage> createState() => _ReadRecordPageState();
}

class _ReadRecordPageState extends ConsumerState<ReadRecordPage> {
  ReadRecordSort _sortBy = ReadRecordSort.lastReadTime;

  @override
  Widget build(BuildContext context) {
    final booksAsync = ref.watch(readRecordListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('阅读记录')),
      body: Column(
        children: [
          // 排序选择
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                const Text('排序方式: ',
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(width: 8),
                SegmentedButton<ReadRecordSort>(
                  segments: ReadRecordSort.values
                      .map((s) => ButtonSegment(
                            value: s,
                            label: Text(s.label,
                                style: const TextStyle(fontSize: 12)),
                          ))
                      .toList(),
                  selected: {_sortBy},
                  onSelectionChanged: (selected) {
                    setState(() => _sortBy = selected.first);
                  },
                ),
              ],
            ),
          ),
          // 书籍列表
          Expanded(
            child: booksAsync.when(
              data: (books) {
                if (books.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_book_outlined,
                            size: 80,
                            color:
                                Theme.of(context).colorScheme.outlineVariant),
                        const SizedBox(height: 16),
                        Text('暂无阅读记录',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .outline)),
                        const SizedBox(height: 8),
                        Text('开始阅读后，阅读记录将显示在这里',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.outline)),
                      ],
                    ),
                  );
                }

                // 计算总阅读时间
                final totalEstimated = books.fold<int>(
                    0,
                    (sum, book) =>
                        sum + _estimateReadMinutes(book));

                // 排序
                final sorted = List<Book>.from(books);
                switch (_sortBy) {
                  case ReadRecordSort.lastReadTime:
                    sorted.sort((a, b) =>
                        b.durChapterTime.compareTo(a.durChapterTime));
                    break;
                  case ReadRecordSort.readDuration:
                    sorted.sort((a, b) => _estimateReadMinutes(b)
                        .compareTo(_estimateReadMinutes(a)));
                    break;
                }

                return Column(
                  children: [
                    // 总统计卡片
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _StatItem(
                                icon: Icons.access_time,
                                label: '总阅读时间',
                                value: _formatDuration(totalEstimated),
                              ),
                              _StatItem(
                                icon: Icons.menu_book_outlined,
                                label: '已读书籍',
                                value: '${books.length} 本',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    // 列表
                    Expanded(
                      child: ListView.builder(
                        itemCount: sorted.length,
                        itemBuilder: (context, index) {
                          final book = sorted[index];
                          return _ReadRecordTile(book: book);
                        },
                      ),
                    ),
                  ],
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('加载失败: $error')),
            ),
          ),
        ],
      ),
    );
  }

  /// 估算阅读时长（分钟）
  /// 使用 durChapterPos 作为已读字符数，估算阅读时间
  int _estimateReadMinutes(Book book) {
    // 简单估算：假设每分钟阅读 500 字
    final charCount = book.durChapterPos;
    return (charCount / 500).ceil();
  }

  String _formatDuration(int minutes) {
    if (minutes < 60) return '$minutes 分钟';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours < 24) return '$hours 小时 $mins 分钟';
    final days = hours ~/ 24;
    final remainHours = hours % 24;
    return '$days 天 $remainHours 小时';
  }
}

/// 统计项组件
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(
                fontSize: 11, color: Theme.of(context).colorScheme.outline)),
      ],
    );
  }
}

/// 阅读记录列表项
class _ReadRecordTile extends StatelessWidget {
  final Book book;

  const _ReadRecordTile({required this.book});

  @override
  Widget build(BuildContext context) {
    final lastReadTime = book.durChapterTime > 0
        ? DateTime.fromMillisecondsSinceEpoch(book.durChapterTime)
        : null;
    final estimatedMinutes = (book.durChapterPos / 500).ceil();
    final readTimeStr = _formatMinutes(estimatedMinutes);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Text(
          book.name.isNotEmpty ? book.name[0] : '?',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
      ),
      title: Text(
        book.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.author.isNotEmpty ? book.author : '未知作者',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 2),
          Text(
            '阅读约 $readTimeStr'
            '${lastReadTime != null ? " | ${_formatTime(lastReadTime)}" : ""}',
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
      trailing: Text(
        '第 ${book.durChapterIndex + 1}/${book.totalChapterNum} 章',
        style: TextStyle(
          fontSize: 11,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      onTap: () {
        // TODO: 跳转到阅读页面
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('打开《${book.name}》')),
        );
      },
    );
  }

  String _formatMinutes(int minutes) {
    if (minutes < 1) return '不到 1 分钟';
    if (minutes < 60) return '$minutes 分钟';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (mins == 0) return '$hours 小时';
    return '$hours 小时 $mins 分钟';
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return '刚刚';
    if (diff.inHours < 1) return '${diff.inMinutes} 分钟前';
    if (diff.inDays < 1) return '${diff.inHours} 小时前';
    if (diff.inDays < 7) return '${diff.inDays} 天前';
    return DateFormat('yyyy-MM-dd HH:mm').format(time);
  }
}
