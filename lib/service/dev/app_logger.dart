import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// 应用内日志采集器。
///
/// 捕获：Flutter 框架错误、未捕获异步错误、可选的 print/debugPrint，
/// 以及手动 [log] 的关键操作面包屑。写入本地文件，原生崩溃闪退后，
/// 重开 App 在「我的→开发者→日志」可看到崩溃前最后记录。
class AppLogger {
  AppLogger._();
  static final AppLogger instance = AppLogger._();

  static const int _maxLines = 2000;

  final List<String> _lines = [];
  bool _capturePrints = false;
  Timer? _flushTimer;
  File? _file;
  bool _initialized = false;

  // 保存默认 debugPrint 以便还原
  final _defaultDebugPrint = debugPrint;

  bool get isInitialized => _initialized;

  /// 应用启动时调用（runApp 之前）。
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    try {
      final dir = await getApplicationDocumentsDirectory();
      _file = File('${dir.path}/dev_log.txt');
      if (await _file!.exists()) {
        final raw = await _file!.readAsString();
        final all = raw.split('\n');
        _lines.addAll(all.where((e) => e.isNotEmpty));
        if (_lines.length > _maxLines) {
          _lines.removeRange(0, _lines.length - _maxLines);
        }
      }
    } catch (_) {}

    // 捕获框架渲染/构建错误
    final original = FlutterError.onError;
    FlutterError.onError = (details) {
      log('🟥 FlutterError: ${details.exceptionAsString()}',
          level: LogLevel.error, persistImmediately: true);
      original?.call(details);
    };

    // 捕获未处理的异步错误
    PlatformDispatcher.instance.onError = (error, stack) {
      log('🟥 未捕获错误: $error\n$stack',
          level: LogLevel.error, persistImmediately: true);
      return true;
    };
  }

  /// 开发者模式：是否捕获 print/debugPrint（开启会有少量开销）。
  set capturePrints(bool v) {
    _capturePrints = v;
    if (v) {
      debugPrint = (String? message, {int? wrapWidth}) {
        log(message ?? '', level: LogLevel.print);
      };
    } else {
      debugPrint = _defaultDebugPrint;
    }
  }

  bool get capturePrints => _capturePrints;

  void log(String message,
      {LogLevel level = LogLevel.info, bool persistImmediately = false}) {
    final now = DateTime.now();
    final ts =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    final tag = switch (level) {
      LogLevel.error => 'E',
      LogLevel.info => 'I',
      LogLevel.print => 'D',
    };
    _lines.add('$ts $tag | $message');
    if (_lines.length > _maxLines) {
      _lines.removeRange(0, _lines.length - _maxLines);
    }
    if (persistImmediately) {
      // 同步写盘：确保原生崩溃杀进程前已落盘
      _flushSync();
    } else {
      _scheduleFlush();
    }
  }

  void _scheduleFlush() {
    _flushTimer?.cancel();
    _flushTimer = Timer(const Duration(seconds: 1), _flushSync);
  }

  /// 同步覆写整个日志文件（崩溃安全）。
  void _flushSync() {
    if (_file == null) return;
    try {
      _file!.writeAsStringSync(_lines.join('\n'));
    } catch (_) {}
  }

  Future<void> _flush() async => _flushSync();

  List<String> get lines => List.unmodifiable(_lines);

  Future<void> clear() async {
    _lines.clear();
    await _flush();
  }

  String export() => _lines.join('\n');
}

enum LogLevel { error, info, print }

/// 便捷全局函数，供各处打面包屑。
void appLog(String message,
    {LogLevel level = LogLevel.info, bool persistImmediately = false}) {
  AppLogger.instance.log(message, level: level, persistImmediately: persistImmediately);
}
