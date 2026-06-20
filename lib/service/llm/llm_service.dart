import 'dart:typed_data';

/// LLM 调用异常
class LlmException implements Exception {
  final String message;
  const LlmException(this.message);
  const LlmException.notConfigured()
      : message = '尚未配置 AI，请到「我的 → AI 设置」';

  @override
  String toString() => message;
}

/// 统一 LLM 接口。云（OpenAI 兼容）与端侧（flutter_gemma）各自实现。
abstract class LlmService {
  /// 文本对话，返回助手消息文本。
  Future<String> chat({
    required String userPrompt,
    String? systemPrompt,
    double? temperature,
    int? maxTokens,
  });

  /// 图片识别（多模态）。非多模态后端抛 [LlmException]。
  Future<String> chatWithImage({
    required String userPrompt,
    required Uint8List image,
    String? systemPrompt,
    double? temperature,
  });

  /// 生成摘要（低温、限 token）。
  Future<String> summarize(String text, {String? instruction});

  /// 连通性/可用性测试。
  Future<String> ping();

  /// 当前后端是否就绪（云=已配置；端侧=模型已下载）。
  bool get isReady;
}
