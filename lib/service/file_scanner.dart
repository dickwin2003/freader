import 'dart:io';
import 'package:path/path.dart' as p;

/// 文件信息
class FileInfo {
  final String path;
  final String name;
  final String extension;
  final int size;
  final DateTime modified;

  const FileInfo({
    required this.path,
    required this.name,
    required this.extension,
    required this.size,
    required this.modified,
  });

  /// 格式化文件大小
  String get sizeText {
    if (size < 1024) return '$size B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)} KB';
    return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

/// 文件扫描器 - 扫描设备中的可读文件
/// 参考 Legado AppPattern.kt 支持的格式
class FileScanner {
  /// 本地书籍支持的格式 - 参考 Legado
  static const _supportedExtensions = [
    '.txt', '.epub', '.umd', '.pdf', '.mobi',
    '.azw3', '.azw', '.md', '.html', '.htm',
    '.doc', '.docx',
  ];

  /// 压缩文件格式
  static const _archiveExtensions = ['.zip', '.rar', '.7z'];

  /// 所有可扫描格式
  static const _allExtensions = [
    ..._supportedExtensions,
    ..._archiveExtensions,
  ];

  /// 需要跳过的目录（系统目录，扫描会出错或无意义）
  static const _skipDirs = {
    'Android', '.android', '.Android', 'lost+found',
    'MIUI', '.tmfs', '.DataStorage', '.PasswordVault',
    'backups', '.device_features', '.databases',
  };

  /// 扫描设备常见目录中的文件
  Future<List<FileInfo>> scanDevice({void Function(int found)? onFound}) async {
    final results = <FileInfo>[];
    final seenPaths = <String>{};

    // 只扫描主要存储路径，避免访问无权限目录
    // /storage/emulated/0 是 Android 最主要的用户存储路径
    final scanDirs = <String>[
      '/storage/emulated/0',
    ];

    for (final dirPath in scanDirs) {
      await _scanDirectory(dirPath, results, seenPaths, onFound, depth: 0);
    }

    // 去重（避免符号链接重复）
    final uniqueResults = <String, FileInfo>{};
    for (final f in results) {
      uniqueResults[f.path] = f;
    }

    // 按修改时间排序
    final sorted = uniqueResults.values.toList()
      ..sort((a, b) => b.modified.compareTo(a.modified));
    return sorted;
  }

  /// 递归扫描单个目录，每层都 try-catch 防止权限异常
  Future<void> _scanDirectory(
    String dirPath,
    List<FileInfo> results,
    Set<String> seenPaths,
    void Function(int)? onFound, {
    required int depth,
  }) async {
    // 限制递归深度为5层
    if (depth > 5) return;

    Directory dir;
    try {
      dir = Directory(dirPath);
      // exists() 可能在某些路径抛异常，用 try-catch 包裹
    } catch (_) {
      return;
    }

    bool exists;
    try {
      exists = await dir.exists();
    } catch (_) {
      return;
    }
    if (!exists) return;

    // 尝试列出目录内容
    List<FileSystemEntity> entities;
    try {
      entities = await dir.list(followLinks: false).toList();
    } catch (_) {
      // 权限不足或目录不可访问，直接跳过
      return;
    }

    for (final entity in entities) {
      try {
        if (entity is Directory) {
          final dirName = p.basename(entity.path);
          // 跳过隐藏目录和系统目录
          if (dirName.startsWith('.') || _skipDirs.contains(dirName)) continue;
          // 递归扫描子目录
          await _scanDirectory(
            entity.path, results, seenPaths, onFound,
            depth: depth + 1,
          );
        } else if (entity is File) {
          final fileName = p.basename(entity.path);
          // 跳过隐藏文件
          if (fileName.startsWith('.')) continue;

          final ext = p.extension(entity.path).toLowerCase();
          if (_supportedExtensions.contains(ext) || ext == '.zip' || ext == '.rar' || ext == '.7z') {
            if (seenPaths.contains(entity.path)) continue;
            seenPaths.add(entity.path);

            try {
              final stat = await entity.stat();
              results.add(FileInfo(
                path: entity.path,
                name: fileName,
                extension: ext,
                size: stat.size,
                modified: stat.modified,
              ));
              onFound?.call(results.length);
            } catch (_) {
              // 跳过无法读取状态的文件
            }
          }
        }
      } catch (_) {
        // 单个文件/目录访问失败不影响整体扫描
        continue;
      }
    }
  }

  /// 检查是否为支持的书籍格式（可被阅读器打开）
  static bool isReadableFormat(String ext) {
    return _supportedExtensions.contains(ext.toLowerCase());
  }

  /// 获取格式支持列表文本
  static String get supportedFormatsText {
    return _supportedExtensions.join(', ').toUpperCase();
  }
}
