import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

import 'service/dev/app_logger.dart';
import 'ui/routes/app_router.dart';
import 'ui/theme/app_theme.dart';
import 'providers/app_providers.dart';
import 'providers/intent_providers.dart';
import 'providers/llm_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 日志采集优先初始化，捕获后续所有错误
  await AppLogger.instance.init();
  appLog('App 启动', persistImmediately: true);
  await _initOnDeviceLlm();
  runApp(const ProviderScope(child: FReaderApp()));
}

/// 初始化端侧推理（flutter_gemma）。失败不阻塞 App，云 LLM 仍可用。
Future<void> _initOnDeviceLlm() async {
  try {
    await FlutterGemma.initialize();
  } catch (e) {
    debugPrint('FlutterGemma 初始化失败（端侧推理不可用）: $e');
  }
}

/// FReader 应用入口
class FReaderApp extends ConsumerStatefulWidget {
  const FReaderApp({super.key});

  @override
  ConsumerState<FReaderApp> createState() => _FReaderAppState();
}

class _FReaderAppState extends ConsumerState<FReaderApp> {
  @override
  void initState() {
    super.initState();
    // 在首帧渲染后处理文件 Intent
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleInitialIntent();
      _listenForNewIntents();
      _preloadLocalModel();
    });
  }

  /// 启动一段时间后自动预加载本地模型（仅当来源选了"本地 Gemma"且有模型时），
  /// 这样切到 AI 助手/翻译时无需手动点"加载"。
  Future<void> _preloadLocalModel() async {
    await Future.delayed(const Duration(seconds: 4));
    if (!mounted) return;
    try {
      final source = ref.read(aiSourceProvider).valueOrNull;
      if (source != LlmSource.onDevice) return;
      final has = ref.read(onDeviceModelManagerProvider).hasModel;
      appLog('启动预加载本地模型: hasModel=$has', persistImmediately: true);
      if (has) {
        await ref.read(onDeviceLlmServiceProvider).load();
        appLog('本地模型预加载完成', persistImmediately: true);
      }
    } catch (e) {
      appLog('本地模型预加载失败: $e', level: LogLevel.error, persistImmediately: true);
    }
  }

  Future<void> _handleInitialIntent() async {
    final filePath = await ref.read(intentHandlerProvider).getInitialUri();
    if (filePath != null && mounted) {
      handleIncomingFile(ref, filePath);
    }
  }

  void _listenForNewIntents() {
    ref.read(intentHandlerProvider).uriStream.listen((filePath) {
      if (mounted) {
        handleIncomingFile(ref, filePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'FReader',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
