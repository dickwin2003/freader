import 'dart:convert';
import 'dart:typed_data';

/// Uint8List 读取工具 — 替代 Kotlin 的 ByteBuffer 扩展
/// MOBI 格式使用大端序（Big-Endian）

int readUint8(Uint8List data, int offset) {
  return data[offset] & 0xFF;
}

int readUint16(Uint8List data, int offset) {
  return ((data[offset] & 0xFF) << 8) | (data[offset + 1] & 0xFF);
}

int readUint32(Uint8List data, int offset) {
  return ((data[offset] & 0xFF) << 24) |
      ((data[offset + 1] & 0xFF) << 16) |
      ((data[offset + 2] & 0xFF) << 8) |
      (data[offset + 3] & 0xFF);
}

/// 读取有符号 int32（保持 Kotlin getInt 语义）
int readInt32(Uint8List data, int offset) {
  final v = readUint32(data, offset);
  return v > 0x7FFFFFFF ? v - 0x100000000 : v;
}

Uint8List readBytes(Uint8List data, int offset, int len) {
  return Uint8List.fromList(data.sublist(offset, offset + len));
}

String readString(Uint8List data, int offset, int len) {
  return String.fromCharCodes(data.sublist(offset, offset + len));
}

String readStringWithCharset(Uint8List data, int offset, int len, Encoding charset) {
  return charset.decode(data.sublist(offset, offset + len));
}

/// 读取 int32 数组
List<int> readInt32Array(Uint8List data, int offset, int len) {
  return List.generate(len, (i) => readInt32(data, offset + i * 4));
}

/// 读取 uint16 数组
List<int> readUint16Array(Uint8List data, int offset, int len) {
  return List.generate(len, (i) => readUint16(data, offset + i * 2));
}
