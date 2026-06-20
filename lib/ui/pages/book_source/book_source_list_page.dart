import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:freader/data/entities/book_source.dart' as dto;
import 'package:freader/providers/book_source_providers.dart';

/// 书源管理页面
class BookSourceListPage extends ConsumerStatefulWidget {
  const BookSourceListPage({super.key});

  @override
  ConsumerState<BookSourceListPage> createState() =>
      _BookSourceListPageState();
}

class _BookSourceListPageState extends ConsumerState<BookSourceListPage> {
  String _searchQuery = '';
  String? _selectedGroup;
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sourcesAsync = _searchQuery.isNotEmpty
        ? ref.watch(bookSourceSearchProvider)
        : _selectedGroup != null
            ? ref.watch(bookSourceByGroupProvider(_selectedGroup!))
            : ref.watch(bookSourceListProvider);

    final groupsAsync = ref.watch(bookSourceGroupsProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: '搜索书源...',
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  setState(() => _searchQuery = query);
                  ref.read(bookSourceSearchProvider.notifier).search(query);
                },
              )
            : const Text('书源管理'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = '';
                  _searchController.clear();
                  ref.read(bookSourceSearchProvider.notifier).clear();
                }
              });
            },
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'import_file', child: Text('从文件导入')),
              const PopupMenuItem(value: 'import_url', child: Text('从 URL 导入')),
              const PopupMenuItem(value: 'import_clipboard', child: Text('从剪贴板导入')),
              const PopupMenuItem(value: 'export_all', child: Text('导出全部书源')),
              const PopupMenuItem(value: 'create', child: Text('新建书源')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // 分组过滤条
          SizedBox(
            height: 40,
            child: groupsAsync.when(
              data: (groups) {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    _GroupChip(
                      label: '全部',
                      selected: _selectedGroup == null,
                      onTap: () => setState(() => _selectedGroup = null),
                    ),
                    ...groups.map((group) => _GroupChip(
                          label: group,
                          selected: _selectedGroup == group,
                          onTap: () =>
                              setState(() => _selectedGroup = group),
                        )),
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
          ),
          // 书源列表
          Expanded(
            child: sourcesAsync.when(
              data: (sources) {
                if (sources.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.source_outlined,
                          size: 80,
                          color: Theme.of(context)
                              .colorScheme
                              .outlineVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '暂无书源',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '点击右上角菜单导入书源',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline,
                              ),
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    // 触发 provider 刷新
                    ref.invalidate(bookSourceListProvider);
                  },
                  child: ListView.builder(
                    itemCount: sources.length,
                    itemBuilder: (context, index) {
                      final source = sources[index];
                      return _BookSourceTile(source: source);
                    },
                  ),
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Text('加载失败: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String action) async {
    switch (action) {
      case 'import_file':
        _showImportFileDialog();
        break;
      case 'import_url':
        _showImportUrlDialog();
        break;
      case 'import_clipboard':
        _importFromClipboard();
        break;
      case 'export_all':
        _exportAll();
        break;
      case 'create':
        // TODO: 跳转编辑页面
        break;
    }
  }

  void _showImportFileDialog() async {
    try {
      // 使用简单的文本输入框模拟文件路径导入
      final controller = TextEditingController();
      final result = await showDialog<String>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('从文件导入书源'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('请输入书源 JSON 文件的完整路径：',
                  style: TextStyle(fontSize: 13)),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: '例如: /sdcard/Download/book_sources.json',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              const Text('提示：也可以使用"从剪贴板导入"更方便',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('取消'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, controller.text.trim()),
              child: const Text('导入'),
            ),
          ],
        ),
      );
      if (result == null || result.isEmpty) return;
      final file = File(result);
      if (!await file.exists()) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('文件不存在，请检查路径')),
          );
        }
        return;
      }
      final json = await file.readAsString();
      final count = await ref.read(bookSourceActionsProvider).importJson(json);
      if (mounted) {
        ref.invalidate(bookSourceListProvider);
        ref.invalidate(bookSourceGroupsProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('成功导入 $count 个书源')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('文件导入失败: $e')),
        );
      }
    }
  }

  void _showImportUrlDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('从 URL 导入书源'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '输入书源 JSON 地址',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              final url = controller.text.trim();
              if (url.isEmpty) return;
              _importFromUrl(url);
            },
            child: const Text('导入'),
          ),
        ],
      ),
    );
  }

  void _importFromUrl(String url) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('正在导入...')),
      );
      // 使用 Dio 下载 JSON
      final dio = ref.read(dioProvider);
      final response = await dio.get<String>(url);
      if (response.data != null) {
        final count = await ref
            .read(bookSourceActionsProvider)
            .importJson(response.data!);
        if (mounted) {
          ref.invalidate(bookSourceListProvider);
          ref.invalidate(bookSourceGroupsProvider);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('成功导入 $count 个书源')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导入失败: $e')),
        );
      }
    }
  }

  void _importFromClipboard() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      final text = clipboardData?.text?.trim();
      if (text == null || text.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('剪贴板为空，请先复制书源 JSON')),
          );
        }
        return;
      }
      // 尝试解析 JSON
      final count = await ref.read(bookSourceActionsProvider).importJson(text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('成功从剪贴板导入 $count 个书源')),
        );
        ref.invalidate(bookSourceListProvider);
        ref.invalidate(bookSourceGroupsProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('剪贴板导入失败: $e')),
        );
      }
    }
  }

  void _exportAll() async {
    try {
      final json = await ref.read(bookSourceActionsProvider).exportAll();
      // 复制到剪贴板
      await Clipboard.setData(ClipboardData(text: json));
      // 保存到文件
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/book_sources_${DateTime.now().millisecondsSinceEpoch}.json');
      await file.writeAsString(json);
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('导出成功'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('共导出 ${json.length} 字符的书源数据'),
                const SizedBox(height: 8),
                Text('已复制到剪贴板并保存到:\n${file.path}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('确定'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导出失败: $e')),
        );
      }
    }
  }
}

/// 书源列表项
class _BookSourceTile extends ConsumerWidget {
  final dto.BookSource source;

  const _BookSourceTile({required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeIcon = switch (source.bookSourceType) {
      0 => Icons.article_outlined,
      1 => Icons.headphones_outlined,
      2 => Icons.image_outlined,
      _ => Icons.insert_drive_file_outlined,
    };

    return ListTile(
      leading: Icon(typeIcon,
          color: source.enabled ? null : Theme.of(context).disabledColor),
      title: Text(
        source.bookSourceName,
        style: TextStyle(
          color: source.enabled ? null : Theme.of(context).disabledColor,
        ),
      ),
      subtitle: Text(
        source.bookSourceUrl,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          color: source.enabled
              ? Theme.of(context).colorScheme.outline
              : Theme.of(context).disabledColor,
        ),
      ),
      trailing: Switch(
        value: source.enabled,
        onChanged: (value) {
          ref
              .read(bookSourceActionsProvider)
              .setEnabled(source.bookSourceUrl, value);
        },
      ),
      onLongPress: () {
        _showSourceActions(context, ref);
      },
    );
  }

  void _showSourceActions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('编辑'),
              onTap: () {
                Navigator.pop(context);
                // TODO: 跳转编辑页
              },
            ),
            ListTile(
              leading: Icon(
                source.enabled ? Icons.visibility_off : Icons.visibility,
              ),
              title: Text(source.enabled ? '禁用' : '启用'),
              onTap: () {
                Navigator.pop(context);
                ref.read(bookSourceActionsProvider).setEnabled(
                    source.bookSourceUrl, !source.enabled);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: const Text('调试'),
              onTap: () {
                Navigator.pop(context);
                // TODO: 跳转调试页
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('删除',
                  style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context, ref);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除书源「${source.bookSourceName}」吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              ref
                  .read(bookSourceActionsProvider)
                  .delete(source.bookSourceUrl);
            },
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}

/// 分组筛选芯片
class _GroupChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _GroupChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: ActionChip(
        label: Text(label),
        onPressed: onTap,
        backgroundColor: selected
            ? Theme.of(context).colorScheme.primaryContainer
            : null,
        labelStyle: TextStyle(
          color: selected
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : null,
        ),
      ),
    );
  }
}
