// ignore_for_file: deprecated_member_use
// Radio 暂未迁移到 Flutter 3.32 的 RadioGroup 新 API（行为等价，待 API 稳定后再迁）

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:freader/ui/theme/app_theme.dart';

/// SharedPreferences keys for read config
class ReadConfigKeys {
  static const fontSize = 'read_config_font_size';
  static const lineHeight = 'read_config_line_height';
  static const letterSpacing = 'read_config_letter_spacing';
  static const keepScreenOn = 'read_config_keep_screen_on';
  static const hideStatusBar = 'read_config_hide_status_bar';
  static const volumeKeyPageTurn = 'read_config_volume_key_page_turn';
  static const pageAnimMode = 'read_config_page_anim_mode';
  static const bgColor = 'read_config_bg_color';
  static const textJustify = 'read_config_text_justify';
  static const chineseLayout = 'read_config_chinese_layout';
}

/// Page animation mode enum
enum PageAnimMode {
  none('无'),
  slide('滑动'),
  cover('覆盖'),
  scroll('滚动');

  final String label;
  const PageAnimMode(this.label);
}

/// 阅读配置页面 - 读者设置
class ReadConfigPage extends ConsumerStatefulWidget {
  const ReadConfigPage({super.key});

  @override
  ConsumerState<ReadConfigPage> createState() => _ReadConfigPageState();
}

class _ReadConfigPageState extends ConsumerState<ReadConfigPage> {
  double _fontSize = 18.0;
  double _lineHeight = 1.8;
  double _letterSpacing = 0.5;
  bool _keepScreenOn = true;
  bool _hideStatusBar = false;
  bool _volumeKeyPageTurn = false;
  PageAnimMode _pageAnimMode = PageAnimMode.slide;
  Color _bgColor = const Color(0xFFFFFDE7);
  bool _textJustify = true;
  bool _chineseLayout = false;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _fontSize = prefs.getDouble(ReadConfigKeys.fontSize) ?? 18.0;
        _lineHeight = prefs.getDouble(ReadConfigKeys.lineHeight) ?? 1.8;
        _letterSpacing =
            prefs.getDouble(ReadConfigKeys.letterSpacing) ?? 0.5;
        _keepScreenOn =
            prefs.getBool(ReadConfigKeys.keepScreenOn) ?? true;
        _hideStatusBar =
            prefs.getBool(ReadConfigKeys.hideStatusBar) ?? false;
        _volumeKeyPageTurn =
            prefs.getBool(ReadConfigKeys.volumeKeyPageTurn) ?? false;
        _pageAnimMode = PageAnimMode
            .values[prefs.getInt(ReadConfigKeys.pageAnimMode) ?? 1];
        final bgColorValue =
            prefs.getInt(ReadConfigKeys.bgColor);
        if (bgColorValue != null) {
          _bgColor = Color(bgColorValue);
        }
        _textJustify =
            prefs.getBool(ReadConfigKeys.textJustify) ?? true;
        _chineseLayout =
            prefs.getBool(ReadConfigKeys.chineseLayout) ?? false;
        _loading = false;
      });
    }
  }

  Future<void> _save<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('阅读配置')),
      body: ListView(
        children: [
          // ===== 字体排版 =====
          _section('字体排版'),
          // 字体大小
          _sliderTile(
            '字体大小',
            _fontSize,
            14,
            32,
            divisions: 18,
            unit: '',
            displayValue: _fontSize.round().toString(),
            onChanged: (v) {
              setState(() => _fontSize = v);
              _save(ReadConfigKeys.fontSize, v);
            },
          ),
          // 行高
          _sliderTile(
            '行高',
            _lineHeight,
            1.0,
            3.0,
            divisions: 20,
            displayValue: _lineHeight.toStringAsFixed(1),
            onChanged: (v) {
              setState(() => _lineHeight = v);
              _save(ReadConfigKeys.lineHeight, v);
            },
          ),
          // 字间距
          _sliderTile(
            '字间距',
            _letterSpacing,
            0.0,
            2.0,
            divisions: 20,
            displayValue: _letterSpacing.toStringAsFixed(1),
            onChanged: (v) {
              setState(() => _letterSpacing = v);
              _save(ReadConfigKeys.letterSpacing, v);
            },
          ),
          // 文字两端对齐
          SwitchListTile(
            title: const Text('文字两端对齐'),
            subtitle: const Text('正文内容左右对齐'),
            value: _textJustify,
            onChanged: (v) {
              setState(() => _textJustify = v);
              _save(ReadConfigKeys.textJustify, v);
            },
          ),
          // 中文排版模式
          SwitchListTile(
            title: const Text('中文排版优化'),
            subtitle: const Text('中英文间自动加空格、优化标点挤压'),
            value: _chineseLayout,
            onChanged: (v) {
              setState(() => _chineseLayout = v);
              _save(ReadConfigKeys.chineseLayout, v);
            },
          ),

          const Divider(indent: 16, endIndent: 16),

          // ===== 翻页设置 =====
          _section('翻页设置'),
          // 翻页动画模式
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text('翻页动画',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.outline)),
          ),
          ...PageAnimMode.values.map((mode) => RadioListTile<PageAnimMode>(
                title: Text(mode.label),
                value: mode,
                groupValue: _pageAnimMode,
                onChanged: (v) {
                  if (v != null) {
                    setState(() => _pageAnimMode = v);
                    _save(ReadConfigKeys.pageAnimMode, v.index);
                  }
                },
              )),

          const Divider(indent: 16, endIndent: 16),

          // ===== 阅读体验 =====
          _section('阅读体验'),
          SwitchListTile(
            title: const Text('保持屏幕常亮'),
            subtitle: const Text('阅读时防止屏幕自动关闭'),
            value: _keepScreenOn,
            onChanged: (v) {
              setState(() => _keepScreenOn = v);
              _save(ReadConfigKeys.keepScreenOn, v);
            },
          ),
          SwitchListTile(
            title: const Text('隐藏状态栏'),
            subtitle: const Text('阅读时隐藏顶部状态栏，获得沉浸体验'),
            value: _hideStatusBar,
            onChanged: (v) {
              setState(() => _hideStatusBar = v);
              _save(ReadConfigKeys.hideStatusBar, v);
            },
          ),
          SwitchListTile(
            title: const Text('音量键翻页'),
            subtitle: const Text('使用音量键控制上下翻页'),
            value: _volumeKeyPageTurn,
            onChanged: (v) {
              setState(() => _volumeKeyPageTurn = v);
              _save(ReadConfigKeys.volumeKeyPageTurn, v);
            },
          ),

          const Divider(indent: 16, endIndent: 16),

          // ===== 阅读背景 =====
          _section('阅读背景'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              children: AppTheme.readerBgColors.map((color) {
                final isSelected = _bgColor == color;
                return GestureDetector(
                  onTap: () {
                    setState(() => _bgColor = color);
                    _save(ReadConfigKeys.bgColor, color.toARGB32());
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 3)
                          : Border.all(
                              color: Colors.grey.withValues(alpha: 0.3)),
                    ),
                    child: isSelected
                        ? Icon(Icons.check,
                            size: 20,
                            color: color.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white)
                        : null,
                  ),
                );
              }).toList(),
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
    String title,
    double value,
    double min,
    double max, {
    int divisions = 20,
    String unit = '',
    String? displayValue,
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
                displayValue ?? '${value.toStringAsFixed(1)}$unit',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: displayValue ?? value.toStringAsFixed(1),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
