import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:freader/providers/llm_providers.dart';

/// 语言项（显示名 + 供 LLM/TTS/STT 的语言描述）
class LangOption {
  final String label; // 中文显示
  final String promptName; // 给 LLM 的语言名（英文，更稳）
  const LangOption(this.label, this.promptName);
}

const List<LangOption> kLangOptions = [
  LangOption('自动检测', 'auto'),
  LangOption('中文', 'Chinese'),
  LangOption('英语', 'English'),
  LangOption('日语', 'Japanese'),
  LangOption('韩语', 'Korean'),
  LangOption('法语', 'French'),
  LangOption('德语', 'German'),
  LangOption('西班牙语', 'Spanish'),
  LangOption('俄语', 'Russian'),
  LangOption('泰语', 'Thai'),
  LangOption('越南语', 'Vietnamese'),
  LangOption('阿拉伯语', 'Arabic'),
  LangOption('葡萄牙语', 'Portuguese'),
  LangOption('意大利语', 'Italian'),
];

/// 翻译服务：基于已配置的 LLM（云端 / 本地 gemma-3n）。
class TranslateService {
  TranslateService(this._ref);
  final Ref _ref;

  Future<String> translate({
    required String text,
    required String fromPromptName,
    required String toPromptName,
  }) async {
    final src = fromPromptName == 'auto' ? '' : fromPromptName;
    final sys = 'You are a professional translator. '
        'Translate the user text into $toPromptName. '
        '${src.isEmpty ? "" : "The source language is $src. "} '
        'Output ONLY the translation, no explanations, no quotes.';
    final reply = await _ref.read(llmServiceProvider).chat(
          userPrompt: text,
          systemPrompt: sys,
          temperature: 0.2,
        );
    return reply.trim();
  }
}

final translateServiceProvider = Provider<TranslateService>(
    (ref) => TranslateService(ref));
