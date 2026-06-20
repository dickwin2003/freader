import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:freader/providers/llm_providers.dart';
import 'package:freader/service/llm/llm_service.dart';
import 'package:freader/service/ocr/ocr_service.dart';
import 'package:freader/service/dev/app_logger.dart';
import 'package:freader/service/translate/translate_service.dart';
import 'package:freader/service/tts/edge_tts_service.dart';
import 'package:freader/ui/pages/settings/ai_settings_page.dart';

/// 翻译页：文本翻译(LLM) + 语音转文字(STT) + 文字转语音(TTS)，适合旅游场景。
class AiTranslatePage extends ConsumerStatefulWidget {
  const AiTranslatePage({super.key});

  @override
  ConsumerState<AiTranslatePage> createState() => _AiTranslatePageState();
}

class _AiTranslatePageState extends ConsumerState<AiTranslatePage> {
  final _inputController = TextEditingController();
  final _speech = SpeechToText();
  late final FlutterTts _tts;
  final _player = AudioPlayer();

  String _fromLang = 'auto';
  String _toLang = 'English';

  String _result = '';
  bool _translating = false;
  String? _error;

  bool _speechReady = false;
  bool _listening = false;
  double _level = 0;

  bool _ttsReady = false;
  bool _speaking = false;

  bool _ocring = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _initTts();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _speech.cancel();
    _tts.stop();
    super.dispose();
  }

  Future<void> _initSpeech() async {
    try {
      _speechReady = await _speech.initialize(onError: (e) {
        if (mounted) setState(() => _listening = false);
      });
      if (mounted) setState(() {});
    } catch (_) {}
  }

  Future<void> _initTts() async {
    _tts = FlutterTts();
    try {
      await _tts.awaitSpeakCompletion(true);
      _tts.setCompletionHandler(() {
        if (mounted) setState(() => _speaking = false);
      });
      _tts.setErrorHandler((_) {
        if (mounted) setState(() => _speaking = false);
      });
      _ttsReady = true;
      if (mounted) setState(() {});
    } catch (_) {}
  }

  Future<void> _toggleListen() async {
    if (!_speechReady) {
      _snack('语音识别不可用，请检查系统语音权限/服务');
      return;
    }
    if (_listening) {
      await _speech.stop();
      setState(() => _listening = false);
      return;
    }
    setState(() => _listening = true);
    // 用源语言推断语音识别 locale（auto→系统默认）
    final localeId = _fromLang == 'auto' ? null : _localeIdFor(_fromLang);
    await _speech.listen(
      onResult: (r) {
        // 实时把听到的填进输入框
        _inputController.text = r.recognizedWords;
        setState(() {});
      },
      onSoundLevelChange: (lv) => setState(() => _level = lv),
      listenOptions: SpeechListenOptions(
        listenFor: const Duration(seconds: 15),
        pauseFor: const Duration(seconds: 3),
        localeId: localeId,
        partialResults: true,
        listenMode: ListenMode.dictation,
        cancelOnError: true,
        autoPunctuation: true,
      ),
    );
  }

  /// LLM 语言名 → BCP47 locale（speech_to_text 用）
  String? _localeIdFor(String promptName) {
    const m = {
      'Chinese': 'zh_CN',
      'English': 'en_US',
      'Japanese': 'ja_JP',
      'Korean': 'ko_KR',
      'French': 'fr_FR',
      'German': 'de_DE',
      'Spanish': 'es_ES',
      'Russian': 'ru_RU',
      'Thai': 'th_TH',
      'Vietnamese': 'vi_VN',
      'Arabic': 'ar_SA',
      'Portuguese': 'pt_BR',
      'Italian': 'it_IT',
    };
    return m[promptName];
  }

  /// 拍照/选图 → OCR 取字 → 填入输入框（可再翻译）。旅游拍菜单/路牌利器。
  Future<void> _ocrFromGallery() async {
    if (_ocring) return;
    final picker = ImagePicker();
    appLog('选图: 打开相册', persistImmediately: true);
    final XFile? xfile;
    try {
      xfile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1280,
        maxHeight: 1280,
        imageQuality: 85,
      );
    } catch (e, st) {
      appLog('选图异常: $e\n$st', level: LogLevel.error, persistImmediately: true);
      rethrow;
    }
    appLog('选图完成: ${xfile?.path}', persistImmediately: true);
    if (xfile == null) return;
    setState(() => _ocring = true);
    try {
      final text = await ref.read(ocrServiceProvider).recognize(xfile.path);
      setState(() {
        _inputController.text = text;
      });
      if (text.isEmpty) {
        _snack('没识别到文字，换张更清晰、文字更突出的图试试');
      }
    } catch (e) {
      _snack('OCR 失败: $e');
    } finally {
      if (mounted) setState(() => _ocring = false);
    }
  }

  Future<void> _translate() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    if (!ref.read(llmReadyProvider)) {
      _snack('请先到「我的 → AI 设置」配置或下载模型');
      return;
    }
    setState(() {
      _translating = true;
      _error = null;
      _result = '';
    });
    try {
      final out = await ref.read(translateServiceProvider).translate(
            text: text,
            fromPromptName: _fromLang,
            toPromptName: _toLang,
          );
      setState(() => _result = out);
    } on LlmException catch (e) {
      setState(() => _error = e.message);
    } catch (e) {
      setState(() => _error = '翻译失败: $e');
    } finally {
      if (mounted) setState(() => _translating = false);
    }
  }

  Future<void> _speak(String text, {bool isResult = false}) async {
    if (text.isEmpty) return;
    // 朗读结果时用目标语言，朗读原文用源语言
    final lang = isResult ? _toLang : (_fromLang == 'auto' ? 'English' : _fromLang);
    final bcp = _localeIdFor(lang) ?? 'en_US';
    setState(() => _speaking = true);
    try {
      // 优先云端 Edge TTS（神经语音，质量高）
      final mp3 = await ref.read(edgeTtsServiceProvider).synthesize(
            text: text,
            voice: EdgeTtsService.voiceFor(bcp),
          );
      await _player.setAudioSource(_BytesSource(mp3));
      await _player.play();
      await _player.processingStateStream
          .firstWhere((s) => s == ProcessingState.completed);
    } catch (e) {
      // Edge 失败 → 回退系统 TTS
      if (_ttsReady) {
        await _tts.setLanguage(bcp);
        final r = await _tts.speak(text);
        if (r != 1) {
          _snack('语音合成失败（云端+系统均失败）：$e');
        }
      } else {
        _snack('语音合成失败：$e');
      }
    } finally {
      if (mounted) setState(() => _speaking = false);
    }
  }

  Future<void> _stopSpeak() async {
    await _tts.stop();
    await _player.stop();
    setState(() => _speaking = false);
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('翻译'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'AI 设置',
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AiSettingsPage())),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildLangBar(),
          const SizedBox(height: 12),
          _buildInputCard(),
          const SizedBox(height: 12),
          _buildResultCard(),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(Icons.info_outline,
                        size: 18, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Text('使用说明',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary)),
                  ]),
                  const SizedBox(height: 8),
                  const Text(
                    '· 文本翻译走你配置的 AI（云端 LongCat / 本地 gemma-3n）。\n'
                    '· 语音识别/合成用系统自带（可装离线语音包，出国断网也能用）。\n'
                    '· 点 🎤 说话→自动填入并翻译；点 🔊 把结果朗读出来给对方听。\n'
                    '· 源语言选「自动检测」时语音识别用系统默认语言。',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLangBar() {
    return Row(
      children: [
        Expanded(child: _langDropdown('源', _fromLang, (v) => setState(() => _fromLang = v))),
        IconButton(
          tooltip: '交换',
          icon: const Icon(Icons.swap_horiz),
          onPressed: () {
            if (_fromLang == 'auto') return; // 自动不可交换
            setState(() {
              final t = _fromLang;
              _fromLang = _toLang;
              _toLang = t;
            });
          },
        ),
        Expanded(child: _langDropdown('译为', _toLang, (v) => setState(() => _toLang = v))),
      ],
    );
  }

  Widget _langDropdown(String hint, String value, ValueChanged<String> onChanged) {
    return InputDecorator(
      decoration: InputDecoration(
        isDense: true,
        labelText: hint,
        border: const OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          items: kLangOptions
              .map((l) => DropdownMenuItem(
                    value: l.promptName,
                    child: Text(l.label, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _inputController,
              minLines: 2,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: '输入要翻译的文本…',
                border: const OutlineInputBorder(),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_inputController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: () {
                          _inputController.clear();
                          setState(() {});
                        },
                      ),
                    IconButton(
                      tooltip: _listening ? '停止' : '语音输入',
                      icon: Icon(_listening ? Icons.stop : Icons.mic_none_outlined,
                          color: _listening
                              ? Colors.red
                              : Theme.of(context).colorScheme.primary),
                      onPressed: _toggleListen,
                    ),
                  ],
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            if (_listening)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: LinearProgressIndicator(
                  value: (_level.abs() / 20).clamp(0.0, 1.0),
                ),
              ),
            const SizedBox(height: 8),
            Row(children: [
              IconButton.outlined(
                tooltip: '拍照取字（OCR）',
                onPressed: _ocring ? null : _ocrFromGallery,
                icon: _ocring
                    ? const SizedBox(
                        width: 18, height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.photo_camera_outlined),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _translating ? null : _translate,
                  icon: _translating
                      ? const SizedBox(
                          width: 16, height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.translate),
                  label: Text(_translating ? '翻译中…' : '翻译'),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.outlined(
                tooltip: '朗读原文',
                icon: Icon(_speaking ? Icons.volume_up : Icons.volume_up_outlined),
                onPressed: () =>
                    _speaking ? _stopSpeak() : _speak(_inputController.text),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: [
              Text('译文',
                  style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              if (_result.isNotEmpty)
                IconButton(
                  tooltip: _speaking ? '停止' : '朗读译文',
                  icon: Icon(_speaking ? Icons.stop : Icons.record_voice_over,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: () =>
                      _speaking ? _stopSpeak() : _speak(_result, isResult: true),
                ),
              if (_result.isNotEmpty)
                IconButton(
                  tooltip: '复制',
                  icon: const Icon(Icons.copy_outlined, size: 20),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: _result));
                    _snack('已复制译文');
                  },
                ),
            ]),
            const SizedBox(height: 4),
            if (_translating && _result.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red))
            else if (_result.isEmpty)
              Text('译文会显示在这里',
                  style: TextStyle(color: Theme.of(context).colorScheme.outline))
            else
              SelectableText(_result,
                  style: const TextStyle(fontSize: 17, height: 1.5)),
          ],
        ),
      ),
    );
  }
}

/// 把内存里的 mp3 字节喂给 just_audio。
class _BytesSource extends StreamAudioSource {
  _BytesSource(Uint8List bytes)
      : _bytes = bytes,
        super(tag: 'TTS');
  final Uint8List _bytes;

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= _bytes.length;
    return StreamAudioResponse(
      sourceLength: _bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(Uint8List.sublistView(_bytes, start, end)),
      contentType: 'audio/mpeg',
    );
  }
}
