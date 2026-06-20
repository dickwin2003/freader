import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:freader/providers/app_providers.dart';
import 'package:freader/providers/book_source_providers.dart';
import 'package:freader/ui/pages/settings/replace_rule_page.dart';
import 'package:freader/ui/pages/settings/read_config_page.dart';
import 'package:freader/ui/pages/settings/tts_settings_page.dart';
import 'package:freader/ui/pages/settings/webdav_settings_page.dart';
import 'package:freader/ui/pages/settings/ai_settings_page.dart';
import 'package:freader/ui/pages/settings/read_record_page.dart';
import 'package:freader/ui/pages/settings/rss_source_manage_page.dart';
import 'package:freader/ui/pages/settings/log_viewer_page.dart';
import 'package:freader/service/dev/app_logger.dart';

/// 设置 / 我的页面
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的')),
      body: ListView(
        children: [
          // ===== 内容管理 =====
          _section(context, '内容管理', [
            _tile(context, Icons.source_outlined, '书源管理', '管理在线书源',
                onTap: () => context.pushNamed('bookSource')),
            _tile(context, Icons.rss_feed_outlined, '订阅源管理', '管理 RSS 订阅源',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RssSourceManagePage()))),
            _tile(context, Icons.find_replace_outlined, '替换净化', '内容替换规则',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ReplaceRulePage()))),
          ]),

          // ===== AI =====
          _section(context, 'AI', [
            _tile(context, Icons.smart_toy_outlined, 'AI 设置', '配置 OpenAI 兼容 LLM',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AiSettingsPage()))),
          ]),

          // ===== 阅读设置 =====
          _section(context, '阅读设置', [
            _tile(context, Icons.text_fields, '阅读配置', '字体、排版、翻页动画',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ReadConfigPage()))),
            _tile(context, Icons.record_voice_over_outlined, '朗读设置', 'TTS 引擎配置',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const TtsSettingsPage()))),
            _tile(context, Icons.palette_outlined, '主题设置', '外观和配色',
                onTap: () => _showThemeDialog(context, ref)),
          ]),

          // ===== 数据管理 =====
          _section(context, '数据管理', [
            _tile(context, Icons.cloud_upload_outlined, 'WebDAV 设置', '配置云端同步',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const WebDavSettingsPage()))),
            _tile(context, Icons.backup_outlined, '备份与恢复', '备份/恢复书架和书源',
                onTap: () => _showBackupDialog(context, ref)),
          ]),

          // ===== 开发者 =====
          _section(context, '开发者', [
            _VerboseLogToggle(),
            _tile(context, Icons.article_outlined, '查看日志', '崩溃/错误记录在此',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LogViewerPage()))),
          ]),

          // ===== 关于 =====
          _section(context, '关于', [
            _tile(context, Icons.info_outline, '关于 FReader', '版本 1.0.0',
                onTap: () => _showAboutPage(context)),
            _tile(context, Icons.timeline_outlined, '阅读记录', '查看阅读统计',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ReadRecordPage()))),
            _tile(context, Icons.code, '开源许可', '查看开源组件',
                onTap: () => showLicensePage(
                      context: context,
                      applicationName: 'FReader',
                      applicationVersion: '1.0.0',
                    )),
            _tile(context, Icons.exit_to_app, '退出应用', '',
                onTap: () => _showExitConfirm(context)),
          ]),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _section(BuildContext context, String title, List<Widget> children) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                )),
      ),
      ...children,
      const Divider(indent: 16, endIndent: 16),
    ]);
  }

  Widget _tile(BuildContext context, IconData icon, String title, String? subtitle,
      {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null && subtitle.isNotEmpty ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }

  // ===== 主题切换 =====
  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    final current = ref.read(themeModeProvider);
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('选择主题'),
        children: [
          RadioListTile<ThemeMode>(
            title: const Text('跟随系统'),
            value: ThemeMode.system,
            groupValue: current,
            onChanged: (v) {
              ref.read(themeModeProvider.notifier).state = v!;
              Navigator.pop(ctx);
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('亮色模式'),
            value: ThemeMode.light,
            groupValue: current,
            onChanged: (v) {
              ref.read(themeModeProvider.notifier).state = v!;
              Navigator.pop(ctx);
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('暗色模式'),
            value: ThemeMode.dark,
            groupValue: current,
            onChanged: (v) {
              ref.read(themeModeProvider.notifier).state = v!;
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }

  // ===== 备份恢复 =====
  void _showBackupDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(padding: EdgeInsets.all(16), child: Text('备份与恢复',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.file_download),
              title: const Text('导出书源'),
              subtitle: const Text('将所有书源导出为 JSON'),
              onTap: () async {
                Navigator.pop(ctx);
                try {
                  final json = await ref.read(bookSourceActionsProvider).exportAll();
                  if (context.mounted) {
                    _showExportResult(context, json);
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('导出失败: $e')),
                    );
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_upload),
              title: const Text('导入书源'),
              subtitle: const Text('从 URL 或 JSON 导入书源'),
              onTap: () {
                Navigator.pop(ctx);
                context.pushNamed('bookSource');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showExportResult(BuildContext context, String json) async {
    // 复制到剪贴板
    await Clipboard.setData(ClipboardData(text: json));
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('导出成功'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('共导出 ${json.length} 字节的书源数据'),
            const SizedBox(height: 8),
            const Text('已复制到剪贴板（JSON 数据）'),
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

  // ===== 关于页面 =====
  void _showAboutPage(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AboutDialog(
        applicationName: 'FReader',
        applicationVersion: '1.0.0',
        applicationIcon: const FlutterLogo(size: 48),
        children: [
          const Text('FReader - 跨平台阅读器'),
          const SizedBox(height: 8),
          const Text('支持本地 TXT/EPUB/PDF/MOBI、在线书源，'
              'AI 阅读助手、翻译、OCR 与笔记。'),
          const SizedBox(height: 12),
          Text('版本 1.0.0',
              style: TextStyle(color: Theme.of(ctx).colorScheme.primary)),
        ],
      ),
    );
  }

  // ===== 退出确认 =====
  void _showExitConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('退出应用'),
        content: const Text('确定要退出 FReader 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // 真正退出应用
              SystemNavigator.pop();
            },
            child: const Text('退出'),
          ),
        ],
      ),
    );
  }

}

/// 详细日志开关（需要本地 setState，故独立 StatefulWidget）。
class _VerboseLogToggle extends StatefulWidget {
  @override
  State<_VerboseLogToggle> createState() => _VerboseLogToggleState();
}

class _VerboseLogToggleState extends State<_VerboseLogToggle> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: const Icon(Icons.bug_report_outlined),
      title: const Text('详细日志'),
      subtitle: const Text('捕获 print/调试输出（排查问题用，略增开销）'),
      value: AppLogger.instance.capturePrints,
      onChanged: (v) {
        AppLogger.instance.capturePrints = v;
        setState(() {});
      },
    );
  }
}
