import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:freader/providers/local_book_providers.dart';
import 'package:freader/service/file_scanner.dart';

/// 本地文件导入页面
class LocalImportPage extends ConsumerStatefulWidget {
  const LocalImportPage({super.key});

  @override
  ConsumerState<LocalImportPage> createState() => _LocalImportPageState();
}

class _LocalImportPageState extends ConsumerState<LocalImportPage> {
  bool _permissionGranted = false;
  bool _isCheckingPermission = true;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    if (Platform.isAndroid) {
      // Android 11+ 需要 MANAGE_EXTERNAL_STORAGE
      final status = await Permission.manageExternalStorage.status;
      if (status.isGranted) {
        setState(() {
          _permissionGranted = true;
          _isCheckingPermission = false;
        });
        // 已授权则自动开始扫描
        ref.read(scanProvider.notifier).startScan();
      } else {
        setState(() {
          _permissionGranted = false;
          _isCheckingPermission = false;
        });
      }
    } else {
      setState(() {
        _permissionGranted = true;
        _isCheckingPermission = false;
      });
      ref.read(scanProvider.notifier).startScan();
    }
  }

  Future<void> _requestPermission() async {
    if (Platform.isAndroid) {
      // 先尝试 manageExternalStorage (Android 11+)
      var status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        // 回退到 storage 权限
        status = await Permission.storage.request();
      }
      setState(() {
        _permissionGranted = status.isGranted;
      });
      if (status.isGranted) {
        ref.read(scanProvider.notifier).startScan();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scanProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('导入本地文件'),
        actions: [
          if (state.foundFiles.isNotEmpty) ...[
            IconButton(
              icon: const Icon(Icons.select_all),
              onPressed: () => ref.read(scanProvider.notifier).selectAll(),
              tooltip: '全选',
            ),
            IconButton(
              icon: const Icon(Icons.deselect),
              onPressed: () => ref.read(scanProvider.notifier).selectNone(),
              tooltip: '取消全选',
            ),
          ],
        ],
      ),
      body: _isCheckingPermission
          ? const Center(child: CircularProgressIndicator())
          : !_permissionGranted
              ? _buildPermissionPage()
              : _buildBody(context, state),
      bottomNavigationBar: state.selectedPaths.isNotEmpty
          ? _buildBottomBar(context, state)
          : null,
    );
  }

  Widget _buildPermissionPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.folder_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('需要存储权限才能扫描文件',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Text(
              'FReader 需要访问手机存储来扫描和导入本地书籍文件。\n'
              '请在下一步中授予"所有文件访问"权限。',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _requestPermission,
              icon: const Icon(Icons.security),
              label: const Text('授予权限'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '支持格式: ${FileScanner.supportedFormatsText}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ScanState state) {
    if (state.isScanning) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(state.foundCount > 0
                ? '正在扫描... 已找到 ${state.foundCount} 个'
                : '正在扫描设备中的文件...'),
            const SizedBox(height: 8),
            const Text('这可能需要几秒钟',
                style: TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      );
    }

    if (state.isImporting) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('正在导入 ${state.importedCount}/${state.totalToImport}...'),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: state.totalToImport > 0
                  ? state.importedCount / state.totalToImport
                  : null,
            ),
          ],
        ),
      );
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('扫描失败: ${state.error}'),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: () => ref.read(scanProvider.notifier).startScan(),
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (state.foundFiles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open, size: 64,
                color: Theme.of(context).colorScheme.outlineVariant),
            const SizedBox(height: 16),
            Text('点击下方按钮扫描手机中的文件',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    )),
            const SizedBox(height: 8),
            Text('支持格式: ${FileScanner.supportedFormatsText}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    )),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => ref.read(scanProvider.notifier).startScan(),
              icon: const Icon(Icons.search),
              label: const Text('扫描手机文件'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // 操作按钮行
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => ref.read(scanProvider.notifier).startScan(),
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('重新扫描'),
                ),
              ),
            ],
          ),
        ),
        // 文件列表
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('找到 ${state.foundFiles.length} 个文件',
                  style: Theme.of(context).textTheme.titleSmall),
              Text('已选 ${state.selectedPaths.length} 个',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: state.foundFiles.length,
            itemBuilder: (context, index) {
              final file = state.foundFiles[index];
              final isSelected = state.selectedPaths.contains(file.path);
              return _FileTile(
                file: file,
                isSelected: isSelected,
                onToggle: () =>
                    ref.read(scanProvider.notifier).toggleSelection(file.path),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, ScanState state) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: FilledButton.icon(
          onPressed: () async {
            await ref.read(scanProvider.notifier).importSelected();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('导入完成！')),
              );
              context.pop();
            }
          },
          icon: const Icon(Icons.download),
          label: Text('导入选中的 ${state.selectedPaths.length} 个文件'),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
        ),
      ),
    );
  }
}

class _FileTile extends StatelessWidget {
  final FileInfo file;
  final bool isSelected;
  final VoidCallback onToggle;

  const _FileTile({
    required this.file,
    required this.isSelected,
    required this.onToggle,
  });

  IconData get _fileIcon {
    switch (file.extension) {
      case '.epub': return Icons.auto_stories;
      case '.pdf': return Icons.picture_as_pdf;
      case '.mobi':
      case '.azw':
      case '.azw3': return Icons.book;
      case '.umd': return Icons.menu_book;
      case '.md': return Icons.description;
      case '.html':
      case '.htm': return Icons.language;
      case '.zip':
      case '.rar':
      case '.7z': return Icons.folder_zip;
      default: return Icons.article;
    }
  }

  Color get _iconColor {
    switch (file.extension) {
      case '.pdf': return Colors.red;
      case '.epub': return Colors.blue;
      case '.md': return Colors.teal;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isSelected,
        onChanged: (_) => onToggle(),
      ),
      title: Text(file.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        '${file.sizeText} · ${file.path}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: Icon(_fileIcon, size: 22, color: _iconColor),
      onTap: onToggle,
    );
  }
}
