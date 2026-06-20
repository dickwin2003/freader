import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:freader/core/database/app_database.dart';
import 'package:freader/providers/app_providers.dart';

/// 替换规则列表 Provider
final replaceRuleListProvider = StreamProvider<List<ReplaceRule>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.replaceRules)
        ..orderBy([
          (t) => OrderingTerm.asc(t.order),
        ]))
      .watch();
});

/// 替换净化页面 - 管理替换规则
class ReplaceRulePage extends ConsumerWidget {
  const ReplaceRulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rulesAsync = ref.watch(replaceRuleListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('替换净化'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (action) =>
                _handleMenuAction(context, ref, action),
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 'import_clipboard', child: Text('从剪贴板导入')),
              const PopupMenuItem(
                  value: 'export_all', child: Text('导出全部规则')),
            ],
          ),
        ],
      ),
      body: rulesAsync.when(
        data: (rules) {
          if (rules.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.find_replace_outlined,
                      size: 80,
                      color: Theme.of(context).colorScheme.outlineVariant),
                  const SizedBox(height: 16),
                  Text('暂无替换规则',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.outline)),
                  const SizedBox(height: 8),
                  Text('点击右下角按钮添加规则',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.outline)),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: rules.length,
            itemBuilder: (context, index) {
              final rule = rules[index];
              return _ReplaceRuleTile(rule: rule);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('加载失败: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'replace_rule_fab',
        onPressed: () => _showAddDialog(context, ref),
        tooltip: '添加规则',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _handleMenuAction(
      BuildContext context, WidgetRef ref, String action) async {
    switch (action) {
      case 'import_clipboard':
        _importFromClipboard(context, ref);
        break;
      case 'export_all':
        _exportAll(context, ref);
        break;
    }
  }

  void _importFromClipboard(BuildContext context, WidgetRef ref) async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      final text = clipboardData?.text?.trim();
      if (text == null || text.isEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('剪贴板为空，请先复制规则 JSON')),
          );
        }
        return;
      }
      final list = jsonDecode(text) as List;
      final db = ref.read(appDatabaseProvider);
      int count = 0;
      for (final item in list) {
        final map = item as Map<String, dynamic>;
        await db.into(db.replaceRules).insert(
              ReplaceRulesCompanion.insert(
                regex: map['regex'] as String? ?? '',
                replacement: Value(map['replacement'] as String? ?? ''),
                name: Value(map['name'] as String?),
                scope: Value(map['scope'] as String?),
                isEnabled: Value(map['isEnabled'] as bool? ?? true),
                isRegex: Value(map['isRegex'] as bool? ?? true),
                act: Value(map['act'] as bool? ?? true),
                group: Value(map['group'] as String?),
                example: Value(map['example'] as String?),
                order: Value(map['order'] as int? ?? 0),
              ),
            );
        count++;
      }
      if (context.mounted) {
        ref.invalidate(replaceRuleListProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('成功导入 $count 条规则')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导入失败: $e')),
        );
      }
    }
  }

  void _exportAll(BuildContext context, WidgetRef ref) async {
    try {
      final db = ref.read(appDatabaseProvider);
      final rules = await (db.select(db.replaceRules)).get();
      final jsonList = rules.map((r) {
        return <String, dynamic>{
          'id': r.id,
          'order': r.order,
          'isEnabled': r.isEnabled,
          'regex': r.regex,
          'replacement': r.replacement,
          'scope': r.scope,
          'name': r.name,
          'group': r.group,
          'isRegex': r.isRegex,
          'act': r.act,
          'example': r.example,
        };
      }).toList();
      final jsonStr =
          const JsonEncoder.withIndent('  ').convert(jsonList);
      await Clipboard.setData(ClipboardData(text: jsonStr));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('已导出 ${rules.length} 条规则到剪贴板')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导出失败: $e')),
        );
      }
    }
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    _showEditDialog(context, ref, null);
  }
}

/// 替换规则列表项
class _ReplaceRuleTile extends ConsumerWidget {
  final ReplaceRule rule;

  const _ReplaceRuleTile({required this.rule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(rule.name ?? '未命名规则',
          style: TextStyle(
              color: rule.isEnabled ? null : Theme.of(context).disabledColor)),
      subtitle: Text(
        '${rule.isRegex ? "正则" : "普通"}: ${rule.regex} -> ${rule.replacement.isEmpty ? "(删除)" : rule.replacement}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 12,
            color: rule.isEnabled
                ? Theme.of(context).colorScheme.outline
                : Theme.of(context).disabledColor),
      ),
      trailing: Switch(
        value: rule.isEnabled,
        onChanged: (value) async {
          final db = ref.read(appDatabaseProvider);
          await (db.update(db.replaceRules)
                ..where((t) => t.id.equals(rule.id)))
              .write(ReplaceRulesCompanion(isEnabled: Value(value)));
          ref.invalidate(replaceRuleListProvider);
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
                _showEditDialog(context, ref, rule);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('删除', style: TextStyle(color: Colors.red)),
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
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除规则「${rule.name ?? rule.regex}」吗？'),
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
              await (db.delete(db.replaceRules)
                    ..where((t) => t.id.equals(rule.id)))
                  .go();
              ref.invalidate(replaceRuleListProvider);
            },
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}

/// 添加/编辑替换规则对话框
void _showEditDialog(
    BuildContext context, WidgetRef ref, ReplaceRule? existing) {
  final nameCtrl = TextEditingController(text: existing?.name ?? '');
  final regexCtrl = TextEditingController(text: existing?.regex ?? '');
  final replacementCtrl =
      TextEditingController(text: existing?.replacement ?? '');
  bool isRegex = existing?.isRegex ?? true;

  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) => AlertDialog(
        title: Text(existing == null ? '添加替换规则' : '编辑替换规则'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: '规则名称',
                  hintText: '可选，方便识别',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: regexCtrl,
                decoration: const InputDecoration(
                  labelText: '匹配内容',
                  hintText: '正则表达式或普通文本',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: replacementCtrl,
                decoration: const InputDecoration(
                  labelText: '替换为',
                  hintText: '留空表示删除匹配内容',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                title: const Text('正则模式'),
                value: isRegex,
                onChanged: (v) => setState(() => isRegex = v),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              final regex = regexCtrl.text.trim();
              if (regex.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('匹配内容不能为空')),
                );
                return;
              }
              Navigator.pop(ctx);
              final db = ref.read(appDatabaseProvider);
              if (existing == null) {
                await db.into(db.replaceRules).insert(
                      ReplaceRulesCompanion.insert(
                        regex: regex,
                        replacement: Value(replacementCtrl.text),
                        name: Value(nameCtrl.text.trim().isEmpty
                            ? null
                            : nameCtrl.text.trim()),
                        isRegex: Value(isRegex),
                      ),
                    );
              } else {
                await (db.update(db.replaceRules)
                      ..where((t) => t.id.equals(existing.id)))
                    .write(ReplaceRulesCompanion(
                  regex: Value(regex),
                  replacement: Value(replacementCtrl.text),
                  name: Value(nameCtrl.text.trim().isEmpty
                      ? null
                      : nameCtrl.text.trim()),
                  isRegex: Value(isRegex),
                ));
              }
              ref.invalidate(replaceRuleListProvider);
            },
            child: const Text('保存'),
          ),
        ],
      ),
    ),
  );
}
