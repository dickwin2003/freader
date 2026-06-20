import 'dart:async';
import 'package:flutter/services.dart';

/// 处理 Android Intent 中的文件 URI
/// 通过 MethodChannel 与原生 MainActivity 通信
class IntentHandler {
  static const _channel = MethodChannel('io.legado.freader/intent');

  final StreamController<String> _uriController = StreamController.broadcast();
  Stream<String>? _uriStream;

  /// 获取初始 URI（冷启动时调用）
  Future<String?> getInitialUri() async {
    try {
      final uri = await _channel.invokeMethod<String>('getInitialUri');
      return uri;
    } on PlatformException {
      return null;
    }
  }

  /// 监听新 URI 流（热恢复时触发）
  Stream<String> get uriStream {
    _uriStream ??= _startListening();
    return _uriController.stream;
  }

  Stream<String> _startListening() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onNewUri') {
        final uri = call.arguments as String?;
        if (uri != null) {
          _uriController.add(uri);
        }
      }
    });
    return _uriController.stream;
  }

  void dispose() {
    _uriController.close();
  }
}
