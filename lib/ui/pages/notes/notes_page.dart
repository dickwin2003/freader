import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:freader/data/entities/book.dart' as dto;
import 'package:freader/data/entities/note.dart' as note_dto;
import 'package:freader/providers/book_providers.dart';
import 'package:freader/providers/llm_providers.dart';
import 'package:freader/providers/note_providers.dart';
import 'package:freader/ui/pages/notes/note_edit_page.dart';
import 'package:freader/ui/widgets/loading_dialog.dart';

// 笔记搜索状态（笔记 tab 全局唯一，文件级持有即可）
String _searchQuery = '';
final _searchController = TextEditingController();

/// 笔记 tab - 心得/读后感列表，可关联书，AI 一键总结。
class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(noteListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('笔记'),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome_outlined),
            tooltip: '总结读后感',
            onPressed: () => _summarize(context, ref),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'notes_fab',
        onPressed: () => _openEditor(context),
        icon: const Icon(Icons.edit_note),
        label: const Text('新建笔记'),
      ),
      body: notesAsync.when(
        data: (notes) {
          if (notes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_note,
                      size: 64,
                      color: Theme.of(context).colorScheme.outlineVariant),
                  const SizedBox(height: 16),
                  Text('还没有笔记',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline)),
                  const SizedBox(height: 8),
                  const Text('记下读书心得、摘录或灵感',
                      style: TextStyle(fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () => _openEditor(context),
                    icon: const Icon(Icons.add),
                    label: const Text('新建笔记'),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => summarizeBookToNote(context, ref),
                    icon: const Icon(Icons.auto_awesome_outlined, size: 18),
                    label: const Text('从书架选书 AI 总结'),
                  ),
                ],
              ),
            );
          }
          return StatefulBuilder(builder: (context, setSt) {
            final q = _searchQuery.toLowerCase().trim();
            final filtered = q.isEmpty
                ? notes
                : notes
                    .where((n) =>
                        n.title.toLowerCase().contains(q) ||
                        n.content.toLowerCase().contains(q) ||
                        (n.bookName ?? '').toLowerCase().contains(q))
                    .toList();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: '搜索标题/正文/书名',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setSt(() => _searchQuery = '');
                              },
                            )
                          : null,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (v) => setSt(() => _searchQuery = v),
                  ),
                ),
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Text(q.isEmpty ? '' : '无匹配笔记',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outline)),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(12, 4, 12, 80),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final n = filtered[index];
                            return _NoteCard(
                              note: n,
                              onTap: () => _openEditor(context, note: n),
                              onDelete: () async {
                                final ok = await _confirmDelete(context, n);
                                if (ok) {
                                  await ref
                                      .read(noteActionsProvider)
                                      .delete(n.id);
                                }
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          });
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败: $e')),
      ),
    );
  }

  void _openEditor(BuildContext context, {note_dto.Note? note}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => NoteEditPage(note: note),
          fullscreenDialog: true),
    );
    // 数据通过 StreamProvider 自动刷新，无需手动处理返回值
  }

  Future<bool> _confirmDelete(BuildContext context, note_dto.Note n) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除笔记'),
        content: Text(n.title.isEmpty ? '确定删除这条笔记？' : '确定删除「${n.title}」？'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('删除')),
        ],
      ),
    );
    return ok == true;
  }

  /// 弹出选书对话框；返回选中的书。
  Future<dto.Book?> _pickBook(BuildContext context, WidgetRef ref,
      {required String title}) async {
    final books = await ref.read(bookRepositoryProvider).getBookshelf();
    if (!context.mounted) return null;
    if (books.isEmpty) {
      _snack(context, '书架为空');
      return null;
    }
    return showDialog<dto.Book>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: books.length,
            itemBuilder: (_, i) {
              final b = books[i];
              return ListTile(
                leading: const Icon(Icons.menu_book_outlined),
                title: Text(b.name,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text(b.author,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                onTap: () => Navigator.pop(ctx, b),
              );
            },
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
        ],
      ),
    );
  }

  /// 选一本书 → AI 读取该书正文生成摘要 → 存为笔记。
  Future<void> summarizeBookToNote(BuildContext context, WidgetRef ref,
      {dto.Book? book}) async {
    if (!ref.read(llmReadyProvider)) {
      _snack(context, '请先到「我的 → AI 设置」配置或下载模型');
      return;
    }
    final b = book ?? await _pickBook(context, ref, title: '选书 AI 总结为笔记');
    if (b == null || !context.mounted) return;
    // 加载对话框
    String? error;
    await showLoadingDialog(
      context,
      ref.read(noteActionsProvider).summarizeBookContent(b),
      message: '正在读取《${b.name}》并 AI 总结…',
      onError: (e) => error = e,
    );
    // 笔记列表由 StreamProvider 自动刷新
    if (!context.mounted) return;
    if (error != null) {
      _snack(context, '总结失败：$error');
    } else {
      _snack(context, '已生成《${b.name}》摘要笔记');
    }
  }

  /// 选一本书 → AI 总结该书所有笔记为读后感
  Future<void> _summarize(BuildContext context, WidgetRef ref) async {
    if (!ref.read(llmReadyProvider)) {
      _snack(context, '请先到「我的 → AI 设置」配置或下载模型');
      return;
    }
    final books = await ref.read(bookRepositoryProvider).getBookshelf();
    if (!context.mounted) return;
    if (books.isEmpty) {
      _snack(context, '书架为空');
      return;
    }
    final book = await showDialog<dto.Book>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('选择书籍总结'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: books.length,
            itemBuilder: (_, i) {
              final b = books[i];
              return ListTile(
                leading: const Icon(Icons.menu_book_outlined),
                title: Text(b.name,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                onTap: () => Navigator.pop(ctx, b),
              );
            },
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
        ],
      ),
    );
    if (book == null || !context.mounted) return;

    // 加载 + 展示结果（结果在对话框内展示）
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _SummaryDialog(
        future: ref
            .read(noteActionsProvider)
            .summarizeBook(book.bookUrl, bookName: book.name),
        bookName: book.name,
        onDone: (_, _) {},
      ),
    );
  }

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

class _NoteCard extends StatelessWidget {
  final note_dto.Note note;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  const _NoteCard({required this.note, required this.onTap, required this.onDelete});

  String _timeStr(int ms) {
    final d = DateTime.fromMillisecondsSinceEpoch(ms);
    return '${d.month}/${d.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onTap,
        onLongPress: () async {
          final ok = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('删除笔记'),
              content: Text(note.title.isEmpty
                  ? '确定删除这条笔记？'
                  : '确定删除「${note.title}」？'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('取消')),
                FilledButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text('删除')),
              ],
            ),
          );
          if (ok == true) onDelete();
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                  child: Text(
                    note.title.isEmpty ? '(无标题)' : note.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(_timeStr(note.updateTime),
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ]),
              if (note.content.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(note.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: Colors.black87)),
              ],
              if (note.bookName != null && note.bookName!.isNotEmpty) ...[
                const SizedBox(height: 6),
                InkWell(
                  onTap: note.bookUrl == null
                      ? null
                      : () => context.push('/book_info', extra: {
                            'bookUrl': note.bookUrl,
                            'origin': '',
                            'originName': '',
                            'name': note.bookName ?? '',
                            'author': '',
                          }),
                  child: Row(children: [
                    Icon(Icons.menu_book,
                        size: 13, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(note.bookName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary)),
                    ),
                    Icon(Icons.chevron_right,
                        size: 14, color: Theme.of(context).colorScheme.primary),
                  ]),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// 总结读后感的加载/结果对话框
class _SummaryDialog extends StatefulWidget {
  final Future<String> future;
  final String bookName;
  final void Function(String? result, String? error) onDone;
  const _SummaryDialog(
      {required this.future, required this.bookName, required this.onDone});

  @override
  State<_SummaryDialog> createState() => _SummaryDialogState();
}

class _SummaryDialogState extends State<_SummaryDialog> {
  String? _result;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    widget.future.then((r) {
      if (mounted) setState(() { _result = r; _loading = false; });
      widget.onDone(r, null);
    }).catchError((e) {
      if (mounted) setState(() { _error = e.toString(); _loading = false; });
      widget.onDone(null, e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.bookName} · 读后感'),
      content: SizedBox(
        width: double.maxFinite,
        child: _loading
            ? const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('AI 正在总结你的笔记…'),
                ],
              )
            : _error != null
                ? Text('生成失败：$_error', style: const TextStyle(color: Colors.red))
                : SingleChildScrollView(
                    child: SelectableText(_result ?? '',
                        style: const TextStyle(height: 1.5)),
                  ),
      ),
      actions: [
        if (_result != null)
          TextButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: _result!));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('已复制到剪贴板')));
              }
            },
            child: const Text('复制'),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('关闭'),
        ),
      ],
    );
  }
}
