import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:freader/core/database/app_database.dart';
import 'package:freader/data/entities/book.dart' as book_dto;
import 'package:freader/data/entities/note.dart' as note_dto;
import 'package:freader/data/repositories/book_repository.dart';
import 'package:freader/data/repositories/note_repository.dart';
import 'package:freader/providers/app_providers.dart';

/// SharedPreferences keys for WebDAV settings
class WebDavConfigKeys {
  static const url = 'webdav_url';
  static const account = 'webdav_account';
  static const password = 'webdav_password';
  static const directory = 'webdav_directory';
  static const lastBackupTime = 'webdav_last_backup_time';
}

/// WebDAV 设置页面
class WebDavSettingsPage extends ConsumerStatefulWidget {
  const WebDavSettingsPage({super.key});

  @override
  ConsumerState<WebDavSettingsPage> createState() =>
      _WebDavSettingsPageState();
}

class _WebDavSettingsPageState extends ConsumerState<WebDavSettingsPage> {
  final _urlController = TextEditingController();
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dirController = TextEditingController(text: '/freader_backup');

  bool _loading = true;
  bool _testing = false;
  bool _backingUp = false;
  bool _restoring = false;
  String? _lastBackupTime;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _urlController.dispose();
    _accountController.dispose();
    _passwordController.dispose();
    _dirController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _urlController.text = prefs.getString(WebDavConfigKeys.url) ?? '';
        _accountController.text =
            prefs.getString(WebDavConfigKeys.account) ?? '';
        _passwordController.text =
            prefs.getString(WebDavConfigKeys.password) ?? '';
        _dirController.text =
            prefs.getString(WebDavConfigKeys.directory) ?? '/freader_backup';
        _lastBackupTime =
            prefs.getString(WebDavConfigKeys.lastBackupTime);
        _loading = false;
      });
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        WebDavConfigKeys.url, _urlController.text.trim());
    await prefs.setString(
        WebDavConfigKeys.account, _accountController.text.trim());
    await prefs.setString(
        WebDavConfigKeys.password, _passwordController.text);
    await prefs.setString(
        WebDavConfigKeys.directory, _dirController.text.trim());
  }

  Dio _createDio() {
    final dio = Dio();
    final credentials =
        '${_accountController.text.trim()}:${_passwordController.text}';
    final encoded = base64Encode(utf8.encode(credentials));
    dio.options.headers['Authorization'] = 'Basic $encoded';
    dio.options.connectTimeout = const Duration(seconds: 15);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    return dio;
  }

  String _buildUrl(String path) {
    var baseUrl = _urlController.text.trim();
    if (!baseUrl.endsWith('/')) baseUrl += '/';
    var dir = _dirController.text.trim();
    if (dir.startsWith('/')) dir = dir.substring(1);
    if (!dir.endsWith('/')) dir += '/';
    return '$baseUrl$dir$path';
  }

  Future<void> _testConnection() async {
    if (_urlController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请填写 WebDAV 地址')),
      );
      return;
    }
    if (_accountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请填写账号')),
      );
      return;
    }

    setState(() => _testing = true);
    try {
      final dio = _createDio();
      final url = _buildUrl('');
      await dio.request(
        url,
        options: Options(
          method: 'PROPFIND',
          headers: {
            'Depth': '0',
            'Content-Type': 'application/xml',
          },
        ),
        data: '<?xml version="1.0" encoding="utf-8"?>'
            '<propfind xmlns="DAV:">'
            '<prop><resourcetype/></prop>'
            '</propfind>',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('连接成功'),
              backgroundColor: Colors.green),
        );
      }
    } on DioException catch (e) {
      final msg = switch (e.response?.statusCode) {
        401 => '认证失败，请检查账号密码',
        404 => '目录不存在，请检查路径',
        _ => '连接失败: ${e.message}',
      };
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(msg), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('连接失败: $e'),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _testing = false);
    }
  }

  Future<void> _backup() async {
    setState(() => _backingUp = true);
    try {
      final db = ref.read(appDatabaseProvider);
      final sources = await (db.select(db.bookSources)).get();
      final books = await (db.select(db.books)).get();
      final notes = await (db.select(db.notes)).get();
      final bookmarks = await (db.select(db.bookmarks)).get();
      final replaceRules = await (db.select(db.replaceRules)).get();

      final dump = <String, dynamic>{
        'version': 3,
        'createdAt': DateTime.now().toIso8601String(),
        'bookSources': sources.map((r) => r.toJson()).toList(),
        'books': books.map((r) => r.toJson()).toList(),
        'notes': notes.map((r) => r.toJson()).toList(),
        'bookmarks': bookmarks.map((r) => r.toJson()).toList(),
        'replaceRules': replaceRules.map((r) => r.toJson()).toList(),
      };
      final jsonStr = const JsonEncoder.withIndent('  ').convert(dump);

      final dio = _createDio();
      final url = _buildUrl('freader_backup.json');
      await dio.put(url, data: jsonStr);

      // Save last backup time
      final now = DateTime.now().toIso8601String();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(WebDavConfigKeys.lastBackupTime, now);
      await _saveSettings();

      if (mounted) {
        setState(() => _lastBackupTime = now);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  '备份成功：${sources.length} 书源 / ${books.length} 书 / ${notes.length} 笔记'),
              backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('备份失败: $e'),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _backingUp = false);
    }
  }

  Future<void> _restore() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认恢复'),
        content: const Text('从 WebDAV 恢复书源数据，这将导入备份的书源。是否继续？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('恢复'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    setState(() => _restoring = true);
    try {
      final dio = _createDio();
      final url = _buildUrl('freader_backup.json');
      final response = await dio.get<String>(url);

      if (response.data == null || response.data!.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('备份文件为空'), backgroundColor: Colors.orange),
          );
        }
        return;
      }

      final decoded = jsonDecode(response.data!);
      // 兼容旧格式（纯 List = 仅书源）与新格式（Map 全量 dump）
      final List sourceList;
      final List bookList;
      final List noteList;
      if (decoded is List) {
        sourceList = decoded;
        bookList = const [];
        noteList = const [];
      } else if (decoded is Map) {
        sourceList = (decoded['bookSources'] as List?) ?? const [];
        bookList = (decoded['books'] as List?) ?? const [];
        noteList = (decoded['notes'] as List?) ?? const [];
      } else {
        sourceList = const [];
        bookList = const [];
        noteList = const [];
      }

      final db = ref.read(appDatabaseProvider);
      // 书源
      int srcCount = 0;
      for (final item in sourceList) {
        final map = item as Map<String, dynamic>;
        await db.into(db.bookSources).insertOnConflictUpdate(
              BookSourcesCompanion(
                bookSourceUrl: Value(map['bookSourceUrl'] as String),
                bookSourceName:
                    Value(map['bookSourceName'] as String? ?? ''),
                bookSourceGroup:
                    Value(map['bookSourceGroup'] as String?),
                bookSourceType:
                    Value(map['bookSourceType'] as int? ?? 0),
                enabled: Value(map['enabled'] as bool? ?? true),
              ),
            );
        srcCount++;
      }
      // 书籍（含阅读进度）
      final bookRepo = BookRepository(db);
      for (final item in bookList) {
        try {
          await bookRepo.saveBook(
              book_dto.Book.fromJson(item as Map<String, dynamic>));
        } catch (_) {}
      }
      // 笔记
      final noteRepo = NoteRepository(db);
      for (final item in noteList) {
        try {
          await noteRepo.save(
              note_dto.Note.fromJson(item as Map<String, dynamic>));
        } catch (_) {}
      }

      final msg = bookList.isEmpty && noteList.isEmpty
          ? '恢复成功，共导入 $srcCount 个书源'
          : '恢复成功：$srcCount 书源 / ${bookList.length} 书 / ${noteList.length} 笔记';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: Colors.green),
        );
      }
    } on DioException catch (e) {
      final msg = switch (e.response?.statusCode) {
        404 => '备份文件不存在',
        401 => '认证失败',
        _ => '恢复失败: ${e.message}',
      };
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(msg), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('恢复失败: $e'),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _restoring = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('WebDAV 设置')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ===== 服务器配置 =====
          Text('服务器配置',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),

          TextField(
            controller: _urlController,
            decoration: const InputDecoration(
              labelText: 'WebDAV 地址',
              hintText: '例如: https://dav.example.com',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.cloud_outlined),
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 12),

          TextField(
            controller: _accountController,
            decoration: const InputDecoration(
              labelText: '账号',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: '密码',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock_outline),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 12),

          TextField(
            controller: _dirController,
            decoration: const InputDecoration(
              labelText: '备份目录',
              hintText: '例如: /freader_backup',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.folder_outlined),
            ),
          ),
          const SizedBox(height: 16),

          // 测试连接
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _testing ? null : _testConnection,
              icon: _testing
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child:
                          CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.wifi_find),
              label: Text(_testing ? '连接中...' : '测试连接'),
            ),
          ),

          const SizedBox(height: 8),

          // 保存按钮
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () async {
                await _saveSettings();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('设置已保存')),
                  );
                }
              },
              icon: const Icon(Icons.save),
              label: const Text('保存设置'),
            ),
          ),

          const Divider(height: 32),

          // ===== 备份恢复 =====
          Text('备份与恢复',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),

          if (_lastBackupTime != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '上次备份时间: $_lastBackupTime',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),

          SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(
              onPressed: _backingUp ? null : _backup,
              icon: _backingUp
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child:
                          CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.cloud_upload),
              label:
                  Text(_backingUp ? '备份中...' : '立即备份'),
            ),
          ),
          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _restoring ? null : _restore,
              icon: _restoring
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child:
                          CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.cloud_download),
              label:
                  Text(_restoring ? '恢复中...' : '从云端恢复'),
            ),
          ),

          const Divider(height: 32),

          // ===== 提示 =====
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      Text('使用说明',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '支持的 WebDAV 服务：坚果云、NextCloud 等。\n'
                    '备份内容为书源数据的 JSON 文件。\n'
                    '首次使用请先测试连接确保配置正确。',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
