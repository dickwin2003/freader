import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:freader/service/dev/app_logger.dart';

/// 应用日志查看页（开发者模式）。崩溃闪退后重开可看崩溃前最后记录。
class LogViewerPage extends StatefulWidget {
  const LogViewerPage({super.key});

  @override
  State<LogViewerPage> createState() => _LogViewerPageState();
}

class _LogViewerPageState extends State<LogViewerPage> {
  late List<String> _lines;

  @override
  void initState() {
    super.initState();
    _lines = AppLogger.instance.lines;
  }

  void _refresh() => setState(() => _lines = AppLogger.instance.lines);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('应用日志'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '刷新',
            onPressed: _refresh,
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: '复制全部',
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              await Clipboard.setData(
                  ClipboardData(text: AppLogger.instance.export()));
              if (!mounted) return;
              messenger.showSnackBar(
                  const SnackBar(content: Text('已复制全部日志')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: '清空',
            onPressed: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('清空日志'),
                  content: const Text('确定清空所有日志记录？'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('取消')),
                    FilledButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('清空')),
                  ],
                ),
              );
              if (ok == true) {
                await AppLogger.instance.clear();
                _refresh();
              }
            },
          ),
        ],
      ),
      body: _lines.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.article_outlined,
                      size: 56,
                      color: Theme.of(context).colorScheme.outlineVariant),
                  const SizedBox(height: 12),
                  const Text('暂无日志',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  const Text('操作 App 后点「刷新」查看；崩溃后重开 App 也能看',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _lines.length,
              itemBuilder: (context, index) {
                final line = _lines[index];
                final isError = line.contains(' 🟥') || line.contains(' E |');
                return Text(
                  line,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    height: 1.3,
                    color: isError ? Colors.red : null,
                  ),
                );
              },
            ),
    );
  }
}
