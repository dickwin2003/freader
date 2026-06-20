import 'package:shared_preferences/shared_preferences.dart';

/// 云端 LLM 协议
enum LlmProtocol { openai, anthropic }

/// LLM 配置（云端 OpenAI / Anthropic 兼容接口）
class LlmConfig {
  /// SharedPreferences keys（命名风格对齐 WebDavConfigKeys）
  static const kBaseUrl = 'ai_base_url';
  static const kApiKey = 'ai_api_key';
  static const kModel = 'ai_model';
  static const kTemperature = 'ai_temperature';
  static const kSystemPrompt = 'ai_system_prompt';
  static const kProtocol = 'ai_protocol'; // openai / anthropic

  /// 接口地址，需含到版本前缀，如 https://api.deepseek.com/v1
  final String baseUrl;

  /// API Key / Token
  final String apiKey;

  /// 模型名，如 deepseek-chat / gpt-4o-mini / LongCat-2.0-Preview
  final String model;

  /// 采样温度
  final double temperature;

  /// 全局系统提示词（可选）
  final String systemPrompt;

  /// 云端协议（OpenAI 兼容 / Anthropic 兼容）
  final LlmProtocol protocol;

  const LlmConfig({
    required this.baseUrl,
    required this.apiKey,
    required this.model,
    this.temperature = 0.7,
    this.systemPrompt = '',
    this.protocol = LlmProtocol.openai,
  });

  /// 三项必填字段是否齐全
  bool get isConfigured =>
      baseUrl.isNotEmpty && apiKey.isNotEmpty && model.isNotEmpty;

  /// 从 SharedPreferences 读取
  static Future<LlmConfig> load(SharedPreferences prefs) async {
    return LlmConfig(
      baseUrl: prefs.getString(kBaseUrl) ?? '',
      apiKey: prefs.getString(kApiKey) ?? '',
      model: prefs.getString(kModel) ?? '',
      temperature: prefs.getDouble(kTemperature) ?? 0.7,
      systemPrompt: prefs.getString(kSystemPrompt) ?? '',
      protocol: (prefs.getString(kProtocol) ?? 'openai') == 'anthropic'
          ? LlmProtocol.anthropic
          : LlmProtocol.openai,
    );
  }

  /// 写入 SharedPreferences
  Future<void> save(SharedPreferences prefs) async {
    await prefs.setString(kBaseUrl, baseUrl);
    await prefs.setString(kApiKey, apiKey);
    await prefs.setString(kModel, model);
    await prefs.setDouble(kTemperature, temperature);
    await prefs.setString(kSystemPrompt, systemPrompt);
    await prefs.setString(
        kProtocol, protocol == LlmProtocol.anthropic ? 'anthropic' : 'openai');
  }
}
