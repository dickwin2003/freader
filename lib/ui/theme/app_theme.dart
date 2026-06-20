import 'package:flutter/material.dart';

/// FReader 应用主题配置
class AppTheme {
  // 主色调 - 采用蓝色调
  static const Color _primaryColor = Color(0xFF2196F3);
  static const Color _primaryDarkColor = Color(0xFF1976D2);

  /// 亮色主题
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: _primaryColor,
        brightness: Brightness.light,
        fontFamily: 'NotoSansSC',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 1,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: _primaryColor,
          unselectedItemColor: Colors.grey,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
        ),
      );

  /// 暗色主题
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: _primaryDarkColor,
        brightness: Brightness.dark,
        fontFamily: 'NotoSansSC',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 1,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF64B5F6),
          unselectedItemColor: Colors.grey,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

  /// 阅读器背景预设颜色
  static const List<Color> readerBgColors = [
    Color(0xFFFFFDE7), // 羊皮纸黄
    Color(0xFFE8F5E9), // 护眼绿
    Color(0xFFE3F2FD), // 淡蓝
    Color(0xFFFFEBEE), // 淡粉
    Color(0xFFFFF8E1), // 暖黄
    Color(0xFFFAFAFA), // 纯白偏暖
    Color(0xFF212121), // 深黑
    Color(0xFF303030), // 灰黑
  ];

  /// 阅读器文字颜色预设
  static const List<Color> readerTextColors = [
    Color(0xFF212121), // 深黑
    Color(0xFF424242), // 深灰
    Color(0xFF5D4037), // 棕色
    Color(0xFF1B5E20), // 深绿
    Color(0xFFE0E0E0), // 浅灰（暗背景用）
    Color(0xFFFFFFFF), // 白色（暗背景用）
  ];
}
