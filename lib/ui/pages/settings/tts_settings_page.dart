import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 朗读设置页面 - TTS 配置
/// 纯 SharedPreferences 存储，朗读功能通过平台 TTS 实现
class TtsSettingsPage extends StatefulWidget {
  const TtsSettingsPage({super.key});

  @override
  State<TtsSettingsPage> createState() => _TtsSettingsPageState();
}

class _TtsSettingsPageState extends State<TtsSettingsPage> {
  double _speechRate = 0.5;
  double _pitch = 1.0;
  String _language = 'zh-CN';
  bool _followSystem = true;
  bool _ignoreAudioFocus = false;
  int _timer = 0; // 分钟, 0=不自动停止

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _speechRate = prefs.getDouble('tts_speech_rate') ?? 0.5;
        _pitch = prefs.getDouble('tts_pitch') ?? 1.0;
        _language = prefs.getString('tts_language') ?? 'zh-CN';
        _followSystem = prefs.getBool('tts_follow_system') ?? true;
        _ignoreAudioFocus = prefs.getBool('tts_ignore_audio_focus') ?? false;
        _timer = prefs.getInt('tts_timer') ?? 0;
      });
    }
  }

  Future<void> _save(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('朗读设置')),
      body: ListView(
        children: [
          // ===== 语音参数 =====
          _section('语音参数'),
          SwitchListTile(
            title: const Text('跟随系统语速'),
            subtitle: const Text('使用系统 TTS 引擎的默认语速'),
            value: _followSystem,
            onChanged: (v) {
              setState(() => _followSystem = v);
              _save('tts_follow_system', v);
            },
          ),
          if (!_followSystem) ...[
            _sliderTile(
              '语速',
              _speechRate,
              0.0, 1.0,
              divisions: 10,
              onChanged: (v) {
                setState(() => _speechRate = v);
                _save('tts_speech_rate', v);
              },
            ),
          ],
          _sliderTile(
            '音调',
            _pitch,
            0.5, 2.0,
            divisions: 15,
            onChanged: (v) {
              setState(() => _pitch = v);
              _save('tts_pitch', v);
            },
          ),
          // 语言选择
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DropdownButtonFormField<String>(
              initialValue: _language,
              decoration: const InputDecoration(
                labelText: '朗读语言',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'zh-CN', child: Text('中文（简体）')),
                DropdownMenuItem(value: 'zh-TW', child: Text('中文（繁体）')),
                DropdownMenuItem(value: 'en-US', child: Text('英语（美式）')),
                DropdownMenuItem(value: 'en-GB', child: Text('英语（英式）')),
                DropdownMenuItem(value: 'ja-JP', child: Text('日语')),
                DropdownMenuItem(value: 'ko-KR', child: Text('韩语')),
              ],
              onChanged: (v) {
                if (v != null) {
                  setState(() => _language = v);
                  _save('tts_language', v);
                }
              },
            ),
          ),

          const Divider(indent: 16, endIndent: 16),

          // ===== 播放控制 =====
          _section('播放控制'),
          SwitchListTile(
            title: const Text('忽略音频焦点'),
            subtitle: const Text('有其他音频播放时不暂停朗读'),
            value: _ignoreAudioFocus,
            onChanged: (v) {
              setState(() => _ignoreAudioFocus = v);
              _save('tts_ignore_audio_focus', v);
            },
          ),
          SwitchListTile(
            title: const Text('通话时暂停'),
            subtitle: const Text('来电时自动暂停朗读'),
            value: true,
            onChanged: null, // 默认开启
          ),
          SwitchListTile(
            title: const Text('保持屏幕常亮'),
            subtitle: const Text('朗读时防止屏幕休眠'),
            value: true,
            onChanged: null,
          ),

          const Divider(indent: 16, endIndent: 16),

          // ===== 定时关闭 =====
          _section('定时关闭'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DropdownButtonFormField<int>(
              initialValue: _timer,
              decoration: const InputDecoration(
                labelText: '自动停止时间',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 0, child: Text('不自动停止')),
                DropdownMenuItem(value: 10, child: Text('10 分钟')),
                DropdownMenuItem(value: 15, child: Text('15 分钟')),
                DropdownMenuItem(value: 20, child: Text('20 分钟')),
                DropdownMenuItem(value: 30, child: Text('30 分钟')),
                DropdownMenuItem(value: 45, child: Text('45 分钟')),
                DropdownMenuItem(value: 60, child: Text('60 分钟')),
                DropdownMenuItem(value: 90, child: Text('90 分钟')),
              ],
              onChanged: (v) {
                if (v != null) {
                  setState(() => _timer = v);
                  _save('tts_timer', v);
                }
              },
            ),
          ),

          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 18,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '朗读功能使用系统 TTS 引擎。请确保设备已安装 TTS 引擎（如 Google 文字转语音引擎）。\n'
                        '可在系统设置 → 语言和输入法 → 文字转语音 中配置系统 TTS 引擎。',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              )),
    );
  }

  Widget _sliderTile(
    String title, double value, double min, double max, {
    int divisions = 10,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 14)),
              Text(
                value.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          Slider(
            value: value, min: min, max: max,
            divisions: divisions,
            label: value.toStringAsFixed(1),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
