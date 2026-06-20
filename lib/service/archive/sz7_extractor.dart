import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

/// 7z 解压 —— 通过 LZMA SDK 编译的 libsz7.so（extract7z C wrapper）+ dart:ffi。
/// 仅在有 libsz7.so 的平台可用（Android 三架构随 apk 打包）。

typedef _Extract7zNative = Int32 Function(Pointer<Utf8> arcPath, Pointer<Utf8> outDir);
typedef _Extract7zDart = int Function(Pointer<Utf8> arcPath, Pointer<Utf8> outDir);

DynamicLibrary? _lib;
DynamicLibrary _sz7Lib() {
  _lib ??= DynamicLibrary.open('libsz7.so');
  return _lib!;
}

/// 解压 7z 到 [outDir]，返回 outDir 下所有文件路径。
/// 失败（加密/损坏/非7z/平台无 libsz7.so）返回空列表。
List<String> extract7zToDir(String szPath, String outDir) {
  final DynamicLibrary lib;
  try {
    lib = _sz7Lib();
  } catch (_) {
    return [];
  }
  final extract = lib.lookupFunction<_Extract7zNative, _Extract7zDart>('extract7z');

  Directory(outDir).createSync(recursive: true);

  final arc = szPath.toNativeUtf8();
  final dir = outDir.toNativeUtf8();
  final outFiles = <String>[];
  try {
    final count = extract(arc, dir);
    if (count < 0) return []; // 错误
    for (final ent in Directory(outDir).listSync(recursive: true)) {
      if (ent is File) outFiles.add(ent.path);
    }
  } catch (_) {
    // FFI 异常
  } finally {
    calloc.free(arc);
    calloc.free(dir);
  }
  return outFiles;
}
