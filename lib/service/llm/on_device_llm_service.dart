import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:freader/service/dev/app_logger.dart';
import 'llm_service.dart';

/// 端侧 LLM 服务（flutter_gemma + Gemma 3n，多模态）。
///
/// 模型由 [OnDeviceModelManager] 下载并设为活跃；首次调用时懒加载到内存。
/// 仅移动端（Android/iOS）原生推理可用。
class OnDeviceLlmService implements LlmService {
  InferenceModel? _model;

  @override
  bool get isReady => _model != null || FlutterGemma.hasActiveModel();

  /// 找到本地已下载的模型文件（ai_models 下唯一 .task/.bin/.tflite/.litertlm）。
  Future<String?> _findLocalModelPath() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final modelsDir = p.join(dir.path, 'ai_models');
      const supported = ['.task', '.bin', '.tflite', '.litertlm'];
      for (final ext in supported) {
        final matches = Directory(modelsDir)
            .listSync(followLinks: false)
            .whereType<File>()
            .where((f) => p.extension(f.path).toLowerCase() == ext);
        for (final f in matches) {
          return f.path;
        }
      }
    } catch (_) {}
    return null;
  }

  /// 确保模型已注册为活跃并加载到内存。
  Future<void> _ensureModel() async {
    if (_model != null) return;
    appLog('加载模型: hasActive=${FlutterGemma.hasActiveModel()}, type=$_cachedModelType',
        persistImmediately: true);
    // 没有 active 模型时，尝试用本地已下载文件注册（重装/状态丢失后自愈）
    if (!FlutterGemma.hasActiveModel()) {
      final path = await _findLocalModelPath();
      appLog('本地模型文件: $path', persistImmediately: true);
      if (path == null) {
        throw const LlmException('本地模型未下载，请到「我的 → AI 设置」下载模型');
      }
      try {
        await FlutterGemma.installModel(
          modelType: _storedModelType(),
          fileType: ModelFileType.task,
        ).fromFile(path).install();
      } catch (e) {
        appLog('模型注册失败: $e', level: LogLevel.error, persistImmediately: true);
        throw LlmException('加载本地模型失败: $e');
      }
    }
    appLog('getActiveModel 开始...', persistImmediately: true);
    // 文本模型（Qwen/DeepSeek/gemma 纯文本）不能强制开 supportImage，
    // 否则 MediaPipe 初始化 LlmVisionInferenceCalculator 失败。
    _model = await FlutterGemma.getActiveModel(maxTokens: 2048);
    appLog('模型加载完成', persistImmediately: true);
  }

  /// 主动加载模型（设置页「加载模型」按钮用）。返回是否成功。
  Future<void> load() => _ensureModel();

  /// 从 prefs 读取已下载模型的类型（兜底重注册时用）。
  ModelType _storedModelType() {
    // 同步读不到 prefs，用缓存值；默认 gemmaIt。
    return _cachedModelType;
  }

  ModelType _cachedModelType = ModelType.gemmaIt;

  /// 由设置页在选源/保存后调用，缓存当前模型类型。
  set modelType(ModelType t) => _cachedModelType = t;

  /// 模型是否已加载到内存。
  bool get isLoaded => _model != null;

  String _compose(String userPrompt, String? systemPrompt) {
    final sys = (systemPrompt ?? '').trim();
    return sys.isEmpty ? userPrompt : '$sys\n\n$userPrompt';
  }

  /// 端侧模型上下文有限，超长输入会 OOM 原生崩溃。按字符截断。
  static const _maxInputChars = 6000;

  String _cap(String s) =>
      s.length > _maxInputChars ? '${s.substring(0, _maxInputChars)}\n…（内容过长，已截断）' : s;

  @override
  Future<String> chat({
    required String userPrompt,
    String? systemPrompt,
    double? temperature,
    int? maxTokens,
  }) async {
    await _ensureModel();
    final session =
        await _model!.createSession(temperature: temperature ?? 0.7);
    try {
      await session.addQueryChunk(
          Message.text(text: _cap(_compose(userPrompt, systemPrompt)), isUser: true));
      final reply = await session.getResponse();
      return reply.trim();
    } finally {
      await session.close();
    }
  }

  @override
  Future<String> chatWithImage({
    required String userPrompt,
    required Uint8List image,
    String? systemPrompt,
    double? temperature,
  }) async {
    await _ensureModel();
    final session = await _model!.createSession(
      temperature: temperature ?? 0.7,
      enableVisionModality: true,
    );
    try {
      await session.addQueryChunk(Message.withImage(
        text: _compose(userPrompt, systemPrompt),
        imageBytes: image,
        isUser: true,
      ));
      final reply = await session.getResponse();
      return reply.trim();
    } finally {
      await session.close();
    }
  }

  @override
  Future<String> summarize(String text, {String? instruction}) {
    return chat(
      userPrompt:
          '${instruction ?? "请用中文对以下内容生成简明摘要："}\n\n$text',
      temperature: 0.3,
    );
  }

  @override
  Future<String> ping() {
    return chat(userPrompt: '回复"OK"两个字。', temperature: 0.0);
  }

  /// 释放模型内存（下次调用会重新加载）。
  Future<void> release() async {
    await _model?.close();
    _model = null;
  }
}
