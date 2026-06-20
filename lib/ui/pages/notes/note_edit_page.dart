import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:freader/data/entities/book.dart' as dto;
import 'package:freader/data/entities/note.dart' as note_dto;
import 'package:freader/providers/book_providers.dart';
import 'package:freader/providers/note_providers.dart';

/// 笔记编辑页（新建/编辑）。可关联一本书。
class NoteEditPage extends ConsumerStatefulWidget {
  final note_dto.Note? note; // null = 新建
  const NoteEditPage({super.key, this.note});

  @override
  ConsumerState<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends ConsumerState<NoteEditPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  dto.Book? _linkedBook;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final n = widget.note;
    _titleController = TextEditingController(text: n?.title ?? '');
    _contentController = TextEditingController(text: n?.content ?? '');
    _linkedBook = null; // 关联书信息从 note 字段恢复（见 build 后异步）
    if (n != null && n.bookUrl != null && n.bookName != null) {
      _linkedBook = dto.Book(
        bookUrl: n.bookUrl!,
        tocUrl: '',
        origin: '',
        originName: '',
        name: n.bookName!,
        author: '',
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickBook() async {
    final books = await ref.read(bookRepositoryProvider).getBookshelf();
    if (!mounted) return;
    if (books.isEmpty) {
      _snack('书架为空，无法关联');
      return;
    }
    final picked = await showDialog<dto.Book>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('关联书籍'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: books.length,
            itemBuilder: (_, i) {
              final b = books[i];
              return ListTile(
                leading: const Icon(Icons.menu_book_outlined),
                title: Text(b.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text(b.author,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                onTap: () => Navigator.pop(ctx, b),
              );
            },
          ),
        ),
        actions: [
          if (_linkedBook != null)
            TextButton(
              onPressed: () => Navigator.pop(ctx, dto.Book(
                bookUrl: '', tocUrl: '', origin: '', originName: '',
                name: '', author: '',
              )),
              child: const Text('取消关联'),
            ),
          TextButton(
              onPressed: () => Navigator.pop(ctx, null),
              child: const Text('关闭')),
        ],
      ),
    );
    if (picked != null && mounted) {
      setState(() {
        // 用空 bookUrl 表示取消关联
        if (picked.bookUrl.isEmpty) {
          _linkedBook = null;
        } else {
          _linkedBook = picked;
        }
      });
    }
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    if (title.isEmpty && content.isEmpty) {
      _snack('请输入标题或正文');
      return;
    }
    setState(() => _saving = true);
    final now = DateTime.now().millisecondsSinceEpoch;
    final base = widget.note;
    final note = note_dto.Note(
      id: base?.id ?? 0,
      title: title,
      content: content,
      bookUrl: _linkedBook?.bookUrl,
      bookName: _linkedBook?.name,
      chapterIndex: base?.chapterIndex,
      createTime: base?.createTime ?? now,
      updateTime: now,
    );
    try {
      await ref.read(noteActionsProvider).save(note);
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) _snack('保存失败: $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    if (widget.note == null) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除笔记'),
        content: const Text('确定删除这条笔记？'),
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
    if (ok != true) return;
    try {
      await ref.read(noteActionsProvider).delete(widget.note!.id);
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) _snack('删除失败: $e');
    }
  }

  void _snack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.note != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? '编辑笔记' : '新建笔记'),
        actions: [
          if (isEdit)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: '删除',
              onPressed: _delete,
            ),
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: '保存',
            onPressed: _saving ? null : _save,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _titleController,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            decoration: const InputDecoration(
              hintText: '标题',
              border: InputBorder.none,
            ),
            textInputAction: TextInputAction.next,
          ),
          InkWell(
            onTap: _pickBook,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(children: [
                Icon(Icons.menu_book_outlined,
                    size: 18, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _linkedBook == null
                        ? '关联书籍（可选）'
                        : _linkedBook!.name,
                    style: TextStyle(
                      color: _linkedBook == null
                          ? Theme.of(context).colorScheme.outline
                          : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
              ]),
            ),
          ),
          const Divider(),
          TextField(
            controller: _contentController,
            maxLines: null,
            minLines: 8,
            decoration: const InputDecoration(
              hintText: '写下你的心得、摘录或读后感…',
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
