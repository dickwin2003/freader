import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

/// RAR 解压 —— 通过 unRAR native 库（libunrar.so）+ dart:ffi 绑定。
/// 仅在有 libunrar.so 的平台可用（Android 三架构已随 apk 打包）。

const _erSuccess = 0;
const _erEndArchive = 10;
const _omExtract = 1; // RAR_OM_EXTRACT
const _opExtract = 2; // RAR_EXTRACT
const _opSkip = 0; // RAR_SKIP

/// RAROpenArchiveDataEx（C 结构 #pragma pack(1)；前部字段布局与 pack(1) 一致）
final class _RarOpenArchiveDataEx extends Struct {
  external Pointer<Utf8> ArcName;
  external Pointer<Void> ArcNameW;
  @Uint32() external int OpenMode;
  @Uint32() external int OpenResult;
  external Pointer<Void> CmtBuf;
  @Uint32() external int CmtBufSize;
  @Uint32() external int CmtSize;
  @Uint32() external int CmtState;
  @Uint32() external int Flags;
  external Pointer<Void> Callback;
  @IntPtr() external int UserData;
  @Uint32() external int OpFlags;
  external Pointer<Void> CmtBufW;
  external Pointer<Void> MarkOfTheWeb;
  @Array(23) external Array<Uint32> Reserved;
}

DynamicLibrary? _lib;
DynamicLibrary _rarLib() {
  _lib ??= DynamicLibrary.open('libunrar.so');
  return _lib!;
}

/// 解压 rar 到 [outDir]，返回 outDir 下所有文件路径。
/// 失败（加密 / 损坏 / 非 rar / 平台无 libunrar.so）返回空列表。
List<String> extractRarToDir(String rarPath, String outDir) {
  final DynamicLibrary lib;
  try {
    lib = _rarLib();
  } catch (_) {
    return [];
  }

  final open = lib.lookupFunction<
      Pointer<Void> Function(Pointer<Void>),
      Pointer<Void> Function(Pointer<Void>)>('RAROpenArchiveEx');
  final close = lib.lookupFunction<
      Int32 Function(Pointer<Void>),
      int Function(Pointer<Void>)>('RARCloseArchive');
  final readHeader = lib.lookupFunction<
      Int32 Function(Pointer<Void>, Pointer<Void>),
      int Function(Pointer<Void>, Pointer<Void>)>('RARReadHeaderEx');
  final processFile = lib.lookupFunction<
      Int32 Function(Pointer<Void>, Int32, Pointer<Utf8>, Pointer<Utf8>),
      int Function(Pointer<Void>, int, Pointer<Utf8>, Pointer<Utf8>)>(
      'RARProcessFile');

  Directory(outDir).createSync(recursive: true);

  final openData = calloc<_RarOpenArchiveDataEx>();
  final header = calloc<Uint8>(32768); // RARHeaderDataEx 足够大
  final arcName = rarPath.toNativeUtf8();
  final dest = outDir.toNativeUtf8();
  final nil = Pointer<Utf8>.fromAddress(0);
  final outFiles = <String>[];

  try {
    openData.ref.ArcName = arcName;
    openData.ref.OpenMode = _omExtract;
    final handle = open(openData.cast());
    if (handle == nullptr) return [];
    try {
      while (true) {
        final r = readHeader(handle, header.cast());
        if (r == _erEndArchive || r != _erSuccess) break;
        final code = processFile(handle, _opExtract, dest, nil);
        if (code != _erSuccess) {
          // 单文件失败（加密/损坏），跳过继续下一个
          processFile(handle, _opSkip, nil, nil);
        }
      }
    } finally {
      close(handle);
    }
    for (final ent in Directory(outDir).listSync(recursive: true)) {
      if (ent is File) outFiles.add(ent.path);
    }
  } catch (_) {
    // FFI 异常：当空结果处理
  } finally {
    calloc.free(openData);
    calloc.free(header);
    calloc.free(arcName);
    calloc.free(dest);
  }
  return outFiles;
}
