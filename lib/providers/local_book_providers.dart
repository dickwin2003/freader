import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freader/service/file_scanner.dart';
import 'package:freader/service/local_book_opener.dart';
import 'package:freader/providers/book_providers.dart';

/// 文件扫描器 Provider
final fileScannerProvider = Provider<FileScanner>((ref) {
  return FileScanner();
});

/// 扫描状态
class ScanState {
  final bool isScanning;
  final List<FileInfo> foundFiles;
  final Set<String> selectedPaths;
  final bool isImporting;
  final int importedCount;
  final int totalToImport;
  final String? error;
  final int foundCount;

  const ScanState({
    this.isScanning = false,
    this.foundFiles = const [],
    this.selectedPaths = const {},
    this.isImporting = false,
    this.importedCount = 0,
    this.totalToImport = 0,
    this.error,
    this.foundCount = 0,
  });

  ScanState copyWith({
    bool? isScanning,
    List<FileInfo>? foundFiles,
    Set<String>? selectedPaths,
    bool? isImporting,
    int? importedCount,
    int? totalToImport,
    String? error,
    int? foundCount,
  }) {
    return ScanState(
      isScanning: isScanning ?? this.isScanning,
      foundFiles: foundFiles ?? this.foundFiles,
      selectedPaths: selectedPaths ?? this.selectedPaths,
      isImporting: isImporting ?? this.isImporting,
      importedCount: importedCount ?? this.importedCount,
      totalToImport: totalToImport ?? this.totalToImport,
      error: error,
      foundCount: foundCount ?? this.foundCount,
    );
  }
}

/// 扫描状态管理
class ScanNotifier extends StateNotifier<ScanState> {
  final FileScanner _scanner;
  final Ref _ref;

  ScanNotifier(this._scanner, this._ref) : super(const ScanState());

  /// 扫描设备
  Future<void> startScan() async {
    state = state.copyWith(isScanning: true, error: null, foundCount: 0);
    try {
      final files = await _scanner.scanDevice(onFound: (n) {
        state = state.copyWith(foundCount: n);
      });
      state = state.copyWith(isScanning: false, foundFiles: files);
    } catch (e) {
      state = state.copyWith(isScanning: false, error: e.toString());
    }
  }

  /// 通过文件选择器选择文件（已移除 file_picker，使用扫描代替）
  Future<void> pickFiles() async {
    await startScan();
  }

  /// 切换文件选中状态
  void toggleSelection(String path) {
    final selected = Set<String>.from(state.selectedPaths);
    if (selected.contains(path)) {
      selected.remove(path);
    } else {
      selected.add(path);
    }
    state = state.copyWith(selectedPaths: selected);
  }

  /// 全选
  void selectAll() {
    state = state.copyWith(
      selectedPaths: Set.from(state.foundFiles.map((f) => f.path)),
    );
  }

  /// 取消全选
  void selectNone() {
    state = state.copyWith(selectedPaths: const {});
  }

  /// 导入选中的文件
  Future<void> importSelected() async {
    if (state.selectedPaths.isEmpty) return;

    state = state.copyWith(
      isImporting: true,
      totalToImport: state.selectedPaths.length,
      importedCount: 0,
    );

    final bookRepo = _ref.read(bookRepositoryProvider);
    final opener = LocalBookOpener(bookRepo);
    var count = 0;

    for (final path in state.selectedPaths) {
      try {
        await opener.openFile(path);
      } catch (_) {
        // 跳过导入失败的文件
      }
      count++;
      state = state.copyWith(importedCount: count);
    }

    // 刷新书架
    _ref.invalidate(bookshelfProvider);

    state = state.copyWith(
      isImporting: false,
      selectedPaths: const {},
    );
  }
}

/// 扫描 Provider
final scanProvider = StateNotifierProvider<ScanNotifier, ScanState>((ref) {
  return ScanNotifier(ref.read(fileScannerProvider), ref);
});
