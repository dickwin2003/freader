import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gemma/flutter_gemma.dart' show ModelType;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:freader/providers/llm_providers.dart';
import 'package:freader/service/llm/llm_config.dart';
import 'package:freader/service/llm/llm_service.dart';
import 'package:freader/service/llm/cloud_llm_service.dart';

/// AI 设置页 - 模型来源（云端 OpenAI 兼容 / 本地 Gemma 3n）+ 各自配置。
class AiSettingsPage extends ConsumerStatefulWidget {
  const AiSettingsPage({super.key});

  @override
  ConsumerState<AiSettingsPage> createState() => _AiSettingsPageState();
}

/// 可选模型下载源（国内源优先；均实测可达）。每个源带对应 ModelType（决定对话模板）。
class _ModelSource {
  final String label;
  final String url;
  final bool needsToken;
  final String note;
  final ModelType modelType;
  const _ModelSource(this.label, this.url, this.needsToken, this.note, this.modelType);
}

const List<_ModelSource> _kModelSources = [
  _ModelSource(
    'Gemma 3n E2B（推荐，多模态）',
    'https://modelscope.cn/api/v1/models/google/gemma-3n-E2B-it-litert-preview/repo?Revision=master&FilePath=gemma-3n-E2B-it-int4.task',
    false,
    '国内直连 ~9MB/s，2.9GB，免 Token；支持图片/音频',
    ModelType.gemmaIt,
  ),
  _ModelSource(
    'Qwen2.5-1.5B（纯文本备选）',
    'https://modelscope.cn/api/v1/models/litert-community/Qwen2.5-1.5B-Instruct/repo?Revision=master&FilePath=Qwen2.5-1.5B-Instruct_multi-prefill-seq_q8_ekv1280.task',
    false,
    '1.6GB，免 Token；纯文本',
    ModelType.qwen,
  ),
];

class _AiSettingsPageState extends ConsumerState<AiSettingsPage> {
  // 来源
  LlmSource _source = LlmSource.cloud;
  final bool _isMobile = Platform.isAndroid || Platform.isIOS;

  // 云端配置
  final _baseUrlController = TextEditingController();
  final _apiKeyController = TextEditingController();
  final _modelController = TextEditingController(text: 'gpt-4o-mini');
  final _systemPromptController = TextEditingController();
  double _temperature = 0.7;
  LlmProtocol _protocol = LlmProtocol.openai;

  // 本地模型
  final _modelUrlController = TextEditingController();
  final _modelTokenController = TextEditingController();
  bool _hasLocalModel = false;
  // 下载状态：idle / downloading / paused / registered
  String _dlStatus = 'idle';
  int _downloaded = 0; // 已下载字节
  int _total = 0; // 总字节
  String? _dlError;
  bool _testingLocal = false;
  bool _obscureToken = true;

  bool _loading = true;
  bool _testing = false;
  bool _obscureKey = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _baseUrlController.dispose();
    _apiKeyController.dispose();
    _modelController.dispose();
    _systemPromptController.dispose();
    _modelUrlController.dispose();
    _modelTokenController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _source = (prefs.getString(AiPrefsKeys.source) ?? 'cloud') == 'onDevice'
        ? LlmSource.onDevice
        : LlmSource.cloud;
    _baseUrlController.text = prefs.getString(LlmConfig.kBaseUrl) ?? '';
    _apiKeyController.text = prefs.getString(LlmConfig.kApiKey) ?? '';
    _modelController.text =
        prefs.getString(LlmConfig.kModel) ?? 'gpt-4o-mini';
    _systemPromptController.text =
        prefs.getString(LlmConfig.kSystemPrompt) ?? '';
    _temperature = prefs.getDouble(LlmConfig.kTemperature) ?? 0.7;
    _protocol = (prefs.getString(LlmConfig.kProtocol) ?? 'openai') == 'anthropic'
        ? LlmProtocol.anthropic
        : LlmProtocol.openai;
    _modelUrlController.text = prefs.getString(AiPrefsKeys.modelUrl) ??
        _kModelSources.first.url;
    _modelTokenController.text = prefs.getString(AiPrefsKeys.modelToken) ?? '';
    _applyModelTypeFromUrl();
    try {
      _hasLocalModel = ref.read(onDeviceModelManagerProvider).hasModel;
    } catch (_) {
      _hasLocalModel = false;
    }
    await _refreshDlStatus();
    if (mounted) setState(() => _loading = false);
  }

  /// 根据当前 URL 命中的源设置 manager 的 modelType（决定对话模板）。
  void _applyModelTypeFromUrl() {
    final match = _kModelSources.firstWhere(
      (s) => s.url == _modelUrlController.text,
      orElse: () => _kModelSources.first,
    );
    ref.read(onDeviceModelManagerProvider).modelType = match.modelType;
    ref.read(onDeviceLlmServiceProvider).modelType = match.modelType;
  }

  /// 根据本地文件刷新下载状态
  Future<void> _refreshDlStatus() async {
    final mgr = ref.read(onDeviceModelManagerProvider);
    final url = _modelUrlController.text.trim();
    if (url.isEmpty) return;
    try {
      final salvaged = await mgr.ensureCorrectName(url);
      if (await mgr.isFullyDownloaded(url)) {
        if (salvaged) {
          // 历史坏文件名已修正，重新注册为活跃模型
          await mgr.register(url);
        }
        setState(() {
          _dlStatus = 'registered';
          _hasLocalModel = mgr.hasModel;
        });
        return;
      }
      final part = await mgr.partialBytes(url);
      setState(() {
        _downloaded = part;
        _dlStatus = part > 0 ? 'paused' : 'idle';
      });
    } catch (_) {}
  }

  Future<void> _setSource(LlmSource s) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        AiPrefsKeys.source, s == LlmSource.onDevice ? 'onDevice' : 'cloud');
    setState(() => _source = s);
    ref.invalidate(aiSourceProvider);
  }

  Future<void> _saveCloudSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LlmConfig.kBaseUrl, _baseUrlController.text.trim());
    await prefs.setString(LlmConfig.kApiKey, _apiKeyController.text.trim());
    await prefs.setString(LlmConfig.kModel, _modelController.text.trim());
    await prefs.setString(LlmConfig.kSystemPrompt, _systemPromptController.text);
    await prefs.setDouble(LlmConfig.kTemperature, _temperature);
    await prefs.setString(LlmConfig.kProtocol,
        _protocol == LlmProtocol.anthropic ? 'anthropic' : 'openai');
    await prefs.setString(AiPrefsKeys.modelUrl, _modelUrlController.text.trim());
    await prefs.setString(
        AiPrefsKeys.modelToken, _modelTokenController.text.trim());
    ref.invalidate(llmConfigProvider);
  }

  Future<void> _testConnection() async {
    final cfg = LlmConfig(
      baseUrl: _baseUrlController.text.trim(),
      apiKey: _apiKeyController.text.trim(),
      model: _modelController.text.trim(),
      temperature: _temperature,
      systemPrompt: _systemPromptController.text,
      protocol: _protocol,
    );
    if (!cfg.isConfigured) {
      _snack('请填写 Base URL、API Key、模型', Colors.red);
      return;
    }
    setState(() => _testing = true);
    try {
      final svc = CloudLlmService(Dio(), cfg);
      await svc.ping();
      if (mounted) _snack('连接成功', Colors.green);
    } on LlmException catch (e) {
      if (mounted) _snack(e.message, Colors.red);
    } catch (e) {
      if (mounted) _snack('连接失败: $e', Colors.red);
    } finally {
      if (mounted) setState(() => _testing = false);
    }
  }

  String _fmtBytes(int b) {
    if (b <= 0) return '0 B';
    const u = ['B', 'KB', 'MB', 'GB'];
    var i = (b.bitLength - 1) ~/ 10;
    if (i >= u.length) i = u.length - 1;
    return '${(b / (1 << (i * 10))).toStringAsFixed(i == 0 ? 0 : 1)} ${u[i]}';
  }

  /// 当前 URL 命中的源说明；未命中返回通用提示
  String _matchingSourceNote() {
    final match = _kModelSources.firstWhere(
      (s) => s.url == _modelUrlController.text,
      orElse: () => const _ModelSource('', '', false, '', ModelType.gemmaIt),
    );
    if (match.label.isEmpty) {
      return 'gemma-3n 多模态（~2.9GB），自定义直链；需支持 HTTP Range 断点续传。';
    }
    final tok = match.needsToken ? '· 需填 Token' : '· 免 Token';
    return '${match.note} $tok';
  }

  /// 开始或继续下载（断点续传）
  Future<void> _startOrResumeDownload() async {
    final url = _modelUrlController.text.trim();
    if (url.isEmpty) {
      _snack('请填写模型下载 URL', Colors.red);
      return;
    }
    // 保存当前 URL/Token，便于续传
    await _saveCloudSettings();
    setState(() {
      _dlStatus = 'downloading';
      _dlError = null;
    });
    final mgr = ref.read(onDeviceModelManagerProvider);
    try {
      final done = await mgr.download(
        url: url,
        token: _modelTokenController.text.trim().isEmpty
            ? null
            : _modelTokenController.text.trim(),
        onProgress: (d, t) {
          if (mounted) setState(() { _downloaded = d; _total = t; });
        },
      );
      if (!mounted) return;
      if (done) {
        setState(() {
          _dlStatus = 'registered';
          _hasLocalModel = true;
        });
        _snack('下载完成', Colors.green);
      } else {
        // 暂停（保留已下部分）
        setState(() => _dlStatus = 'paused');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _dlStatus = 'paused';
          _dlError = e.toString();
        });
        _snack('下载失败（已保留进度，可继续）: $e', Colors.red);
      }
    }
  }

  Future<void> _pauseDownload() async {
    ref.read(onDeviceModelManagerProvider).pause();
    setState(() => _dlStatus = 'paused');
  }

  Future<void> _releaseMemory() async {
    try {
      await ref.read(onDeviceLlmServiceProvider).release();
      if (mounted) _snack('已释放模型内存', Colors.green);
    } catch (e) {
      if (mounted) _snack('释放失败: $e', Colors.red);
    }
  }

  /// 下载后：显式加载模型到内存 + ping 自测（首次加载耗时数秒~数十秒）。
  Future<void> _loadAndTestModel() async {
    setState(() => _testingLocal = true);
    try {
      // 1) 先加载（注册本地文件 + 载入内存）
      await ref.read(onDeviceLlmServiceProvider).load();
      // 2) 再 ping
      final reply = await ref.read(llmServiceProvider).ping();
      if (mounted) {
        _snack('模型加载并响应正常：${reply.isEmpty ? "OK" : reply}', Colors.green);
      }
    } on LlmException catch (e) {
      if (mounted) _snack(e.message, Colors.red);
    } catch (e) {
      if (mounted) _snack('加载/测试失败: $e', Colors.red);
    } finally {
      if (mounted) setState(() => _testingLocal = false);
    }
  }

  Future<void> _deleteModel() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除本地模型'),
        content: const Text('将删除已下载的模型文件，释放存储空间。确定？'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('删除')),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await ref.read(onDeviceModelManagerProvider).deleteAll();
      if (mounted) {
        setState(() {
          _hasLocalModel = false;
          _dlStatus = 'idle';
          _downloaded = 0;
          _total = 0;
        });
        _snack('已删除', Colors.green);
      }
    } catch (e) {
      if (mounted) _snack('删除失败: $e', Colors.red);
    }
  }

  void _snack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('AI 设置')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ===== 模型来源 =====
          Text('模型来源',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<LlmSource>(
              segments: const [
                ButtonSegment(
                    value: LlmSource.cloud,
                    label: Text('云端 LLM'),
                    icon: Icon(Icons.cloud_outlined)),
                ButtonSegment(
                    value: LlmSource.onDevice,
                    label: Text('本地 Gemma'),
                    icon: Icon(Icons.phone_android_outlined)),
              ],
              selected: {_source},
              onSelectionChanged: (s) => _setSource(s.first),
            ),
          ),
          const SizedBox(height: 16),

          if (_source == LlmSource.cloud)
            _buildCloudSection()
          else
            _buildLocalSection(),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ===== 云端配置 =====
  Widget _buildCloudSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('云端协议',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<LlmProtocol>(
            segments: const [
              ButtonSegment(
                  value: LlmProtocol.openai, label: Text('OpenAI 兼容')),
              ButtonSegment(
                  value: LlmProtocol.anthropic, label: Text('Anthropic 兼容')),
            ],
            selected: {_protocol},
            onSelectionChanged: (s) => setState(() => _protocol = s.first),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _baseUrlController,
          decoration: const InputDecoration(
            labelText: 'Base URL',
            hintText: '例如: https://api.deepseek.com/v1',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.link),
          ),
          keyboardType: TextInputType.url,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _apiKeyController,
          decoration: InputDecoration(
            labelText: 'API Key',
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.key),
            suffixIcon: IconButton(
              icon: Icon(_obscureKey
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined),
              onPressed: () => setState(() => _obscureKey = !_obscureKey),
            ),
          ),
          obscureText: _obscureKey,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _modelController,
          decoration: const InputDecoration(
            labelText: '模型',
            hintText: '例如: deepseek-chat, gpt-4o-mini',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.memory),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('采样温度'),
            Expanded(
              child: Slider(
                value: _temperature,
                min: 0,
                max: 1,
                divisions: 10,
                label: _temperature.toStringAsFixed(1),
                onChanged: (v) => setState(() => _temperature = v),
              ),
            ),
            SizedBox(
                width: 40, child: Text(_temperature.toStringAsFixed(1))),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _systemPromptController,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: '系统提示词（可选）',
            hintText: '为所有 AI 功能预设的通用系统提示',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.edit_note),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _testing ? null : _testConnection,
            icon: _testing
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.wifi_find),
            label: Text(_testing ? '连接中...' : '测试连接'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () async {
              await _saveCloudSettings();
              if (mounted) _snack('设置已保存', Colors.green);
            },
            icon: const Icon(Icons.save),
            label: const Text('保存设置'),
          ),
        ),
      ],
    );
  }

  // ===== 本地模型 =====
  Widget _buildLocalSection() {
    if (!_isMobile) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.warning_amber_outlined,
                  size: 40, color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 8),
              const Text('本地推理仅支持 Android / iOS',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              const Text('桌面端暂不支持端侧 Gemma，请使用「云端 LLM」。',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(_hasLocalModel ? Icons.check_circle : Icons.download,
                    color: _hasLocalModel
                        ? Colors.green
                        : Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _hasLocalModel ? '模型已下载，可直接使用' : '尚未下载模型',
                    style: TextStyle(
                        color: _hasLocalModel ? Colors.green : null),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // 模型源下拉（gemma-3n 多模态，国内源优先）
        DropdownButtonFormField<_ModelSource>(
          isExpanded: true,
          decoration: const InputDecoration(
            labelText: '模型下载源',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.cloud_queue),
          ),
          initialValue: _kModelSources.firstWhere(
            (s) => s.url == _modelUrlController.text,
            orElse: () => _kModelSources.first,
          ),
          items: _kModelSources
              .map((s) => DropdownMenuItem(
                    value: s,
                    child: Text(s.label, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: (s) async {
            if (s == null) return;
            setState(() => _modelUrlController.text = s.url);
            _applyModelTypeFromUrl();
            // 切换源后刷新下载状态：未下载的源会显示「下载」按钮
            await _refreshDlStatus();
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 8),
          child: Text(
            _matchingSourceNote(),
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),
        TextField(
          controller: _modelUrlController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: '模型下载 URL（.task，可手动修改）',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.link),
          ),
          keyboardType: TextInputType.url,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _modelTokenController,
          decoration: InputDecoration(
            labelText: '下载 Token（可选，gated 模型用）',
            hintText: 'HuggingFace access token，公开镜像可留空',
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.vpn_key_outlined),
            suffixIcon: IconButton(
              icon: Icon(_obscureToken
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined),
              onPressed: () => setState(() => _obscureToken = !_obscureToken),
            ),
          ),
          obscureText: _obscureToken,
        ),
        const SizedBox(height: 8),
        if (_dlStatus == 'downloading') ...[
          Row(children: [
            Expanded(
              child: LinearProgressIndicator(
                value: _total > 0 ? (_downloaded / _total).clamp(0.0, 1.0) : null,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 86,
              child: Text(
                _total > 0
                    ? '${((_downloaded / _total) * 100).toStringAsFixed(0)}%'
                    : _fmtBytes(_downloaded),
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Text(
              _total > 0
                  ? '${_fmtBytes(_downloaded)} / ${_fmtBytes(_total)}　下载中…（可暂停，已下部分会保留）'
                  : '下载中… ${_fmtBytes(_downloaded)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _pauseDownload,
              icon: const Icon(Icons.pause_circle_outline),
              label: const Text('暂停'),
            ),
          ),
        ] else if (_dlStatus == 'paused') ...[
          if (_total > 0 || _downloaded > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                _total > 0
                    ? '已下载 ${_fmtBytes(_downloaded)} / ${_fmtBytes(_total)}（${((_downloaded / _total) * 100).toStringAsFixed(0)}%）'
                    : '已下载 ${_fmtBytes(_downloaded)}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          if (_dlError != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text('上次中断：$_dlError',
                  style: const TextStyle(fontSize: 11, color: Colors.red),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _startOrResumeDownload,
              icon: const Icon(Icons.play_arrow),
              label: Text(
                  _downloaded > 0 ? '继续下载（断点续传）' : '开始下载'),
            ),
          ),
        ] else if (_dlStatus != 'registered') ...[
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _startOrResumeDownload,
              icon: const Icon(Icons.cloud_download_outlined),
              label: const Text('下载模型'),
            ),
          ),
        ],
        if (_dlStatus == 'registered') ...[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _testingLocal ? null : _loadAndTestModel,
              icon: _testingLocal
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.play_arrow),
              label: Text(_testingLocal ? '加载中（首次需载入内存，请稍候）...' : '加载并测试模型'),
            ),
          ),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _releaseMemory,
                icon: const Icon(Icons.memory),
                label: const Text('释放内存'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _deleteModel,
                icon: const Icon(Icons.delete_outline),
                label: const Text('删除模型'),
              ),
            ),
          ]),
        ],
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.info_outline,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Text('使用说明',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary)),
                ]),
                const SizedBox(height: 8),
                const Text(
                  '本地 Gemma 完全离线运行，适合阅读摘要、问答与图片识别。\n'
                  '推荐 Gemma 3n E2B（多模态，含图片识别），体积约 3-6GB。\n'
                  '首次下载较慢（取决于网速），下载后即可断网使用。\n'
                  '手机上推理每条摘要约数秒~数十秒，属正常。\n'
                  '默认 URL 用的是国内 hf-mirror.com 镜像；若仍下载失败，'
                  '可换成 ModelScope 或其它可用直链。HuggingFace 官方 gated 模型需填 Token。\n'
                  '支持断点续传：下载中可暂停，已下部分保留，网络中断后再点「继续下载」从断点接着下。',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
