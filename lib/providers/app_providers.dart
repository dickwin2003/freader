import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/app_database.dart';

/// 全局数据库 Provider
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

/// 主题模式 Provider
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});
