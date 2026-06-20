import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:freader/core/database/app_database.dart';
import 'package:freader/providers/app_providers.dart';
import 'package:freader/providers/book_source_providers.dart' show dioProvider;

/// RSS 源列表 Provider
final rssSourceListProvider = StreamProvider<List<RssSource>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.rssSources)
        ..orderBy([
          (t) => OrderingTerm.asc(t.customOrder),
        ]))
      .watch();
});

/// RSS 源搜索 Provider
final rssSourceSearchProvider =
    StateProvider<String>((ref) => '');

/// 过滤后的 RSS 源列表
final rssSourceFilteredProvider =
    StreamProvider<List<RssSource>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final query = ref.watch(rssSourceSearchProvider);

  var queryExpr = db.rssSources.sourceName;
  final select = db.select(db.rssSources);

  if (query.isNotEmpty) {
    select.where((t) => t.sourceName.like('%$query%'));
  }

  select.orderBy([
    (t) => OrderingTerm.asc(t.customOrder),
  ]);

  return select.watch();
});

/// 订阅源管理页面
class RssSourceManagePage extends ConsumerStatefulWidget {
  const RssSourceManagePage({super.key});

  @override
  ConsumerState<RssSourceManagePage> createState() =>
      _RssSourceManagePageState();
}

class _RssSourceManagePageState
    extends ConsumerState<RssSourceManagePage> {
  String _searchQuery = '';
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
        ? ref.watch(rssSourceFilteredProvider)
        : ref.watch(rssSourceListProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: '搜索订阅源...',
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  setState(() => _searchQuery = query);
                  ref.read(rssSourceSearchProvider.notifier).state =
                      query;
                },
              )
            : const Text('订阅源管理'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = '';
                  _searchController.clear();
                  ref.read(rssSourceSearchProvider.notifier).state = '';
                }
              });
            },
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 'import_url', child: Text('从 URL 导入')),
              const PopupMenuItem(
                  value: 'import_clipboard', child: Text('从剪贴板导入')),
              const PopupMenuItem(
                  value: 'export_all', child: Text('导出全部')),
            ],
          ),
        ],
      ),
      body: sourcesAsync.when(
        data: (sources) {
          if (sources.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.rss_feed_outlined,
                      size: 80,
                      color:
                          Theme.of(context).colorScheme.outlineVariant),
                  const SizedBox(height: 16),
                  Text('暂无订阅源',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                              color:
                                  Theme.of(context).colorScheme.outline)),
                  const SizedBox(height: 8),
                  Text('点击右下角按钮添加订阅源',
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
          return ListView.builder(
            itemCount: sources.length,
            itemBuilder: (context, index) {
              final source = sources[index];
              return _RssSourceTile(source: source);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('加载失败: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'rss_source_fab',
        onPressed: _showAddDialog,
        tooltip: '添加订阅源',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'import_url':
        _showImportUrlDialog();
        break;
      case 'import_clipboard':
        _importFromClipboard();
        break;
      case 'export_all':
        _exportAll();
        break;
    }
  }

  void _showAddDialog() {
    final urlCtrl = TextEditingController();
    final nameCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('添加订阅源'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: urlCtrl,
              decoration: const InputDecoration(
                labelText: '源地址 (URL)',
                hintText: 'RSS 源的链接地址',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: '源名称',
                hintText: '给这个源起个名字',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              final url = urlCtrl.text.trim();
              final name = nameCtrl.text.trim();
              if (url.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('请填写源地址')),
                );
                return;
              }
              Navigator.pop(ctx);
              final db = ref.read(appDatabaseProvider);
              await db.into(db.rssSources).insert(
                    RssSourcesCompanion(
                      sourceUrl: Value(url),
                      sourceName: Value(name.isEmpty ? url : name),
                      customOrder: const Value(0),
                      enabled: const Value(true),
                      enabledCookieJar: const Value(false),
                      articleStyle: const Value(0),
                      singleUrl: const Value(false),
                      enableJs: const Value(false),
                      loadWithBaseUrl: const Value(false),
                    ),
                  );
              ref.invalidate(rssSourceListProvider);
            },
            child: const Text('添加'),
          ),
        ],
      ),
    );
  }

  void _showImportUrlDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('从 URL 导入订阅源'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '输入订阅源 JSON 地址',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
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
      final dio = ref.read(dioProvider);
      final response = await dio.get<String>(url);
      if (response.data != null) {
        final count = await _importJson(response.data!);
        if (mounted) {
          ref.invalidate(rssSourceListProvider);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('成功导入 $count 个订阅源')),
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
            const SnackBar(content: Text('剪贴板为空，请先复制订阅源 JSON')),
          );
        }
        return;
      }
      final count = await _importJson(text);
      if (mounted) {
        ref.invalidate(rssSourceListProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('成功从剪贴板导入 $count 个订阅源')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('剪贴板导入失败: $e')),
        );
      }
    }
  }

  Future<int> _importJson(String jsonStr) async {
    final list = jsonDecode(jsonStr) as List;
    final db = ref.read(appDatabaseProvider);
    int count = 0;
    for (final item in list) {
      final map = item as Map<String, dynamic>;
      await db.into(db.rssSources).insertOnConflictUpdate(
            RssSourcesCompanion(
              sourceUrl: Value(map['sourceUrl'] as String),
              sourceName:
                  Value(map['sourceName'] as String? ?? ''),
              sourceIcon: Value(map['sourceIcon'] as String?),
              sourceGroup: Value(map['sourceGroup'] as String?),
              customOrder:
                  Value(map['customOrder'] as int? ?? 0),
              enabled: Value(map['enabled'] as bool? ?? true),
              enabledCookieJar:
                  Value(map['enabledCookieJar'] as bool? ?? false),
              concurrentRate:
                  Value(map['concurrentRate'] as String?),
              header: Value(map['header'] as String?),
              loginUrl: Value(map['loginUrl'] as String?),
              loginUi: Value(map['loginUi'] as String?),
              loginCheckJs:
                  Value(map['loginCheckJs'] as String?),
              ruleArticles:
                  Value(map['ruleArticles'] as String?),
              ruleNextPage:
                  Value(map['ruleNextPage'] as String?),
              ruleTitle: Value(map['ruleTitle'] as String?),
              rulePubDate:
                  Value(map['rulePubDate'] as String?),
              ruleDescription:
                  Value(map['ruleDescription'] as String?),
              ruleImage: Value(map['ruleImage'] as String?),
              ruleContent:
                  Value(map['ruleContent'] as String?),
              ruleLink: Value(map['ruleLink'] as String?),
              ruleCategories:
                  Value(map['ruleCategories'] as String?),
              sortUrl: Value(map['sortUrl'] as String?),
              articleStyle:
                  Value(map['articleStyle'] as int? ?? 0),
              singleUrl:
                  Value(map['singleUrl'] as bool? ?? false),
              enableJs: Value(map['enableJs'] as bool? ?? false),
              loadWithBaseUrl:
                  Value(map['loadWithBaseUrl'] as bool? ?? false),
              jsLib: Value(map['jsLib'] as String?),
              variable: Value(map['variable'] as String?),
              lastUpdateTime:
                  Value(map['lastUpdateTime'] as int?),
            ),
          );
      count++;
    }
    return count;
  }

  void _exportAll() async {
    try {
      final db = ref.read(appDatabaseProvider);
      final sources = await (db.select(db.rssSources)).get();
      final jsonList = sources.map((s) {
        return <String, dynamic>{
          'sourceUrl': s.sourceUrl,
          'sourceName': s.sourceName,
          'sourceIcon': s.sourceIcon,
          'sourceGroup': s.sourceGroup,
          'customOrder': s.customOrder,
          'enabled': s.enabled,
          'enabledCookieJar': s.enabledCookieJar,
          'concurrentRate': s.concurrentRate,
          'header': s.header,
          'loginUrl': s.loginUrl,
          'loginUi': s.loginUi,
          'loginCheckJs': s.loginCheckJs,
          'ruleArticles': s.ruleArticles,
          'ruleNextPage': s.ruleNextPage,
          'ruleTitle': s.ruleTitle,
          'rulePubDate': s.rulePubDate,
          'ruleDescription': s.ruleDescription,
          'ruleImage': s.ruleImage,
          'ruleContent': s.ruleContent,
          'ruleLink': s.ruleLink,
          'ruleCategories': s.ruleCategories,
          'sortUrl': s.sortUrl,
          'articleStyle': s.articleStyle,
          'singleUrl': s.singleUrl,
          'enableJs': s.enableJs,
          'loadWithBaseUrl': s.loadWithBaseUrl,
          'jsLib': s.jsLib,
          'variable': s.variable,
          'lastUpdateTime': s.lastUpdateTime,
        };
      }).toList();
      final jsonStr =
          const JsonEncoder.withIndent('  ').convert(jsonList);
      await Clipboard.setData(ClipboardData(text: jsonStr));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('已导出 ${sources.length} 个订阅源到剪贴板')),
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

/// RSS 源列表项
class _RssSourceTile extends ConsumerWidget {
  final RssSource source;

  const _RssSourceTile({required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Icon(Icons.rss_feed,
          color:
              source.enabled ? null : Theme.of(context).disabledColor),
      title: Text(
        source.sourceName,
        style: TextStyle(
            color: source.enabled
                ? null
                : Theme.of(context).disabledColor),
      ),
      subtitle: Text(
        source.sourceUrl,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 12,
            color: source.enabled
                ? Theme.of(context).colorScheme.outline
                : Theme.of(context).disabledColor),
      ),
      trailing: Switch(
        value: source.enabled,
        onChanged: (value) async {
          final db = ref.read(appDatabaseProvider);
          await (db.update(db.rssSources)
                ..where((t) => t.sourceUrl.equals(source.sourceUrl)))
              .write(RssSourcesCompanion(enabled: Value(value)));
          ref.invalidate(rssSourceListProvider);
        },
      ),
      onLongPress: () => _showActions(context, ref),
    );
  }

  void _showActions(BuildContext context, WidgetRef ref) {
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
                _showEditDialog(context, ref);
              },
            ),
            ListTile(
              leading: Icon(source.enabled
                  ? Icons.visibility_off
                  : Icons.visibility),
              title: Text(source.enabled ? '禁用' : '启用'),
              onTap: () async {
                Navigator.pop(context);
                final db = ref.read(appDatabaseProvider);
                await (db.update(db.rssSources)
                      ..where((t) =>
                          t.sourceUrl.equals(source.sourceUrl)))
                    .write(RssSourcesCompanion(
                        enabled: Value(!source.enabled)));
                ref.invalidate(rssSourceListProvider);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.delete_outline, color: Colors.red),
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

  void _showEditDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController(text: source.sourceName);
    final urlCtrl = TextEditingController(text: source.sourceUrl);
    final groupCtrl =
        TextEditingController(text: source.sourceGroup ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('编辑订阅源'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: '源名称',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: urlCtrl,
              decoration: const InputDecoration(
                labelText: '源地址',
                border: OutlineInputBorder(),
              ),
              enabled: false, // URL is primary key, not editable
            ),
            const SizedBox(height: 12),
            TextField(
              controller: groupCtrl,
              decoration: const InputDecoration(
                labelText: '分组',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final db = ref.read(appDatabaseProvider);
              await (db.update(db.rssSources)
                    ..where(
                        (t) => t.sourceUrl.equals(source.sourceUrl)))
                  .write(RssSourcesCompanion(
                sourceName: Value(nameCtrl.text.trim()),
                sourceGroup: Value(groupCtrl.text.trim().isEmpty
                    ? null
                    : groupCtrl.text.trim()),
              ));
              ref.invalidate(rssSourceListProvider);
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除订阅源「${source.sourceName}」吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx);
              final db = ref.read(appDatabaseProvider);
              await (db.delete(db.rssSources)
                    ..where(
                        (t) => t.sourceUrl.equals(source.sourceUrl)))
                  .go();
              ref.invalidate(rssSourceListProvider);
            },
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}
