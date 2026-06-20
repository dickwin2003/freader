import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_gemma/flutter_gemma.dart' hide CancelToken;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// 端侧模型管理：自实现的 **断点续传** 下载（dio + HTTP Range），
/// 下完用 flutter_gemma 的 `fromFile` 注册（不复制文件，不占双倍空间）。
class OnDeviceModelManager {
  OnDeviceModelManager(this._dio);

  final Dio _dio;
  CancelToken? _cancelToken;
  bool _downloading = false;
  bool _pauseRequested = false;
  // 当前选定的模型类型（决定对话模板，影响输出质量）
  ModelType _modelType = ModelType.gemmaIt;

  bool get isDownloading => _downloading;
  ModelType get modelType => _modelType;
  set modelType(ModelType t) => _modelType = t;

  String _filenameFromUrl(String url) {
    final uri = Uri.parse(url);
    // ModelScope 等：文件名在 FilePath= query 参数里
    final fp = uri.queryParameters['FilePath'];
    if (fp != null && fp.isNotEmpty) {
      final n = Uri.parse(fp).pathSegments.last;
      if (n.isNotEmpty) return n;
    }
    final segs = uri.pathSegments;
    final name = segs.isEmpty ? '' : segs.last;
    // 兜底：若无扩展名，补 .task
    if (name.isEmpty) return 'model.task';
    if (!p.extension(name).toLowerCase().contains('.')) return '$name.task';
    return name;
  }

  /// 修正历史坏文件名（如 ModelScope URL 取错段导致的无扩展名文件），
  /// 把已下载内容 salvage 为正确文件名。返回是否做了改名。
  Future<bool> ensureCorrectName(String url) async {
    final dir = await _modelsDir();
    final correct = File(p.join(dir.path, _filenameFromUrl(url)));
    if (await correct.exists()) return false;
    const supported = ['.task', '.bin', '.tflite', '.litertlm'];
    try {
      await for (final ent in dir.list()) {
        if (ent is! File) continue;
        final name = p.basename(ent.path);
        if (name.endsWith('.part')) continue;
        if (!supported.contains(p.extension(name).toLowerCase())) {
          await ent.rename(correct.path);
          return true;
        }
      }
    } catch (_) {}
    return false;
  }

  /// 用本地完整文件注册为活跃模型（不重新下载、不复制）。对外暴露以便修正后重注册。
  Future<void> register(String url) => _register(url);

  Future<Directory> _modelsDir() async {
    final appDir = await getApplicationDocumentsDirectory();
    final d = Directory(p.join(appDir.path, 'ai_models'));
    if (!await d.exists()) await d.create(recursive: true);
    return d;
  }

  Future<File> _partFile(String url) async =>
      File(p.join((await _modelsDir()).path, '${_filenameFromUrl(url)}.part'));

  Future<File> _finalFile(String url) async =>
      File(p.join((await _modelsDir()).path, _filenameFromUrl(url)));

  /// 已下载的部分字节数（用于断点续传/进度展示）。
  Future<int> partialBytes(String url) async {
    final f = await _partFile(url);
    return (await f.exists()) ? await f.length() : 0;
  }

  /// 是否已下载完成（先尝试 salvage 历史坏文件名）。
  Future<bool> isFullyDownloaded(String url) async {
    await ensureCorrectName(url);
    return (await _finalFile(url)).exists();
  }

  /// 暂停当前下载（保留已下部分，可续传）。
  void pause() {
    _pauseRequested = true;
    _cancelToken?.cancel('user paused');
  }

  /// 下载（支持断点续传）。返回是否真正下载完成并注册成功
  /// （暂停时返回 false，已下部分保留）。
  Future<bool> download({
    required String url,
    String? token,
    required void Function(int downloaded, int total) onProgress,
  }) async {
    if (_downloading) return false;
    _downloading = true;
    _pauseRequested = false;
    try {
      final finalFile = await _finalFile(url);
      if (await finalFile.exists()) {
        await _deleteOtherModels(_filenameFromUrl(url));
        await _register(url);
        final sz = await finalFile.length();
        onProgress(sz, sz);
        return true;
      }

      // 切换模型：先清掉其它已下载的模型文件（单模型策略，避免 gemma/qwen 混淆）
      await _deleteOtherModels(_filenameFromUrl(url));

      final partFile = await _partFile(url);
      final start = (await partFile.exists()) ? await partFile.length() : 0;

      _cancelToken = CancelToken();
      final headers = <String, dynamic>{
        if (token != null && token.trim().isNotEmpty)
          'Authorization': 'Bearer ${token.trim()}',
        if (start > 0) 'range': 'bytes=$start-',
      };

      final resp = await _dio.get<ResponseBody>(
        url,
        options: Options(
          responseType: ResponseType.stream,
          headers: headers,
          // 流式下载：放宽数据间隔超时
          receiveTimeout: const Duration(seconds: 90),
        ),
        cancelToken: _cancelToken,
      );

      // 从 Content-Range 取总大小；否则用 Content-Length
      int full = 0;
      final cr = resp.headers.value('content-range');
      if (cr != null) {
        final m = RegExp(r'/(\d+)\s*$').firstMatch(cr);
        if (m != null) full = int.tryParse(m.group(1)!) ?? 0;
      }
      if (full <= 0) {
        final cl = resp.headers.value('content-length');
        if (cl != null) full = int.tryParse(cl) ?? 0;
      }

      final sink = partFile.openWrite(mode: FileMode.append);
      var received = start;
      final sw = Stopwatch()..start();
      var lastEmit = 0;
      try {
        await for (final chunk in resp.data!.stream) {
          if (_pauseRequested) break;
          sink.add(chunk);
          received += chunk.length;
          // 节流：至少间隔 300ms 回调一次进度
          if (sw.elapsedMilliseconds - lastEmit >= 300) {
            onProgress(received, full);
            lastEmit = sw.elapsedMilliseconds;
          }
        }
        await sink.flush();
        await sink.close();
        if (_pauseRequested) {
          onProgress(received, full);
          return false; // 暂停，保留 part
        }
        // 下载完成：part -> final，并注册
        if (await finalFile.exists()) await finalFile.delete();
        await partFile.rename(finalFile.path);
        await _register(url);
        onProgress(await finalFile.length(), full > 0 ? full : await finalFile.length());
        return true;
      } catch (e) {
        try {
          await sink.close();
        } catch (_) {}
        rethrow;
      }
    } on DioException catch (e) {
      // 暂停(取消) 或网络错误：都保留已下部分，不删
      if (_pauseRequested || e.type == DioExceptionType.cancel) {
        return false;
      }
      throw Exception('下载失败: ${e.message ?? e.type.name}');
    } finally {
      _downloading = false;
      _pauseRequested = false;
    }
  }

  /// 用本地完整文件注册为活跃模型（不重新下载、不复制）。
  Future<void> _register(String url) async {
    final finalFile = await _finalFile(url);
    if (!await finalFile.exists()) {
      throw Exception('模型文件不存在: ${finalFile.path}');
    }
    await FlutterGemma.installModel(
      modelType: _modelType,
      fileType: ModelFileType.task,
    ).fromFile(finalFile.path).install();
  }

  /// 删除 ai_models 目录下除 [keepName] 外的所有模型文件（.task/.bin/.tflite/.litertlm）。
  /// 用于"切换模型"时清理旧模型，保证当前活跃模型唯一明确。
  Future<void> _deleteOtherModels(String keepName) async {
    const supported = ['.task', '.bin', '.tflite', '.litertlm'];
    try {
      final dir = await _modelsDir();
      await for (final ent in dir.list()) {
        if (ent is! File) continue;
        final name = p.basename(ent.path);
        if (name == keepName) continue;
        if (supported.contains(p.extension(name).toLowerCase())) {
          await ent.delete();
        }
      }
    } catch (_) {}
  }

  /// 是否已有活跃模型。
  bool get hasModel => FlutterGemma.hasActiveModel();

  /// 删除所有本地模型文件（含未完成的 part）。
  Future<void> deleteAll() async {
    if (_downloading) pause();
    final dir = await _modelsDir();
    if (await dir.exists()) {
      try {
        await dir.delete(recursive: true);
      } catch (_) {}
    }
  }
}
