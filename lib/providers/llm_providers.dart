import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:freader/service/llm/llm_config.dart';
import 'package:freader/service/llm/llm_service.dart';
import 'package:freader/service/llm/cloud_llm_service.dart';
import 'package:freader/service/llm/on_device_llm_service.dart';
import 'package:freader/service/llm/on_device_model_manager.dart';
import 'book_source_providers.dart';

/// 额外的 AI 相关 prefs 键
class AiPrefsKeys {
  static const source = 'ai_source'; // cloud / onDevice
  static const modelUrl = 'ai_model_url'; // 端侧模型下载 URL
  static const modelToken = 'ai_model_token'; // 端侧模型下载 token（gated 模型）
  static const modelType = 'ai_model_type'; // 端侧模型类型 gemmaIt/qwen/general...
}

/// LLM 后端来源
enum LlmSource { cloud, onDevice }

/// 云端 LLM 配置（从 SharedPreferences 读取；保存后 invalidate 即重建）
final llmConfigProvider = FutureProvider<LlmConfig>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return LlmConfig.load(prefs);
});

/// 当前选择的 LLM 来源
final aiSourceProvider = FutureProvider<LlmSource>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final v = prefs.getString(AiPrefsKeys.source) ?? 'cloud';
  return v == 'onDevice' ? LlmSource.onDevice : LlmSource.cloud;
});

/// 端侧推理服务（单例，持有已加载的模型）
final onDeviceLlmServiceProvider = Provider<OnDeviceLlmService>((ref) {
  return OnDeviceLlmService();
});

/// 端侧模型下载/卸载管理器（断点续传）
final onDeviceModelManagerProvider = Provider<OnDeviceModelManager>((ref) {
  return OnDeviceModelManager(ref.watch(dioProvider));
});

/// 统一 LLM 服务：按来源返回云或端侧后端。
/// 云端配置未加载完成时用空配置兜底（chat 会抛 notConfigured）。
final llmServiceProvider = Provider<LlmService>((ref) {
  final source = ref.watch(aiSourceProvider).valueOrNull ?? LlmSource.cloud;
  if (source == LlmSource.onDevice) {
    return ref.watch(onDeviceLlmServiceProvider);
  }
  final config = ref.watch(llmConfigProvider).valueOrNull ??
      const LlmConfig(baseUrl: '', apiKey: '', model: '');
  return CloudLlmService(ref.watch(dioProvider), config);
});

/// 当前后端是否就绪（云=已配置；端侧=模型已下载）
final llmReadyProvider = Provider<bool>((ref) {
  final source = ref.watch(aiSourceProvider).valueOrNull ?? LlmSource.cloud;
  if (source == LlmSource.onDevice) {
    return ref.watch(onDeviceLlmServiceProvider).isReady;
  }
  return ref.watch(llmConfigProvider).valueOrNull?.isConfigured ?? false;
});
