import 'dart:math';
import 'dart:typed_data';
import 'byte_buffer_utils.dart';
import 'entities.dart';

/// 解压器接口
abstract class Decompressor {
  Uint8List decompress(Uint8List data);
}

/// 无压缩
class PlainDecompressor implements Decompressor {
  @override
  Uint8List decompress(Uint8List data) => data;
}

/// PalmDOC LZ77 解压
class Lz77Decompressor implements Decompressor {
  final int textRecordSize;

  Lz77Decompressor(this.textRecordSize);

  @override
  Uint8List decompress(Uint8List data) {
    final out = <int>[];
    int i = 0;
    while (i < data.length) {
      int c = data[i++] & 0xFF;
      if (c >= 0x01 && c <= 0x08) {
        // 复制接下来 c 个字节
        for (int j = 0; j < c && i < data.length; j++) {
          out.add(data[i++]);
        }
      } else if (c <= 0x7F) {
        // 直接输出
        out.add(c);
      } else if (c >= 0xC0) {
        // 空格 + (c ^ 0x80)
        out.add(0x20);
        out.add(c ^ 0x80);
      } else {
        // 回溯复制
        if (i < data.length) {
          c = (c << 8) | (data[i++] & 0xFF);
          final length = (c & 0x0007) + 3;
          final location = (c >> 3) & 0x7FF;
          if (location >= 1 && location <= out.length) {
            for (int j = 0; j < length; j++) {
              final idx = out.length - location;
              if (idx >= 0 && idx < out.length) {
                out.add(out[idx]);
              }
            }
          }
        }
      }
    }
    return Uint8List.fromList(out);
  }
}

/// HuffCDIC 字典压缩解压
class HuffcdicDecompressor implements Decompressor {
  final int offset1;
  final int offset2;
  final List<int> table1;
  final List<int> mincodeTable = List.filled(33, 0);
  final List<int> maxcodeTable = List.filled(33, 0);
  final List<CdicEntry> dictionary = [];

  HuffcdicDecompressor(Uint8List huffRecord, List<Uint8List> cdicRecords)
      : offset1 = readUint32(huffRecord, 8),
        offset2 = readUint32(huffRecord, 12),
        table1 = readInt32Array(huffRecord, readUint32(huffRecord, 8), 256) {
    // 读取 mincode/maxcode 表
    int pos = offset2;
    for (int i = 1; i <= 32; i++) {
      final mincode = readUint32(huffRecord, pos);
      final maxcode = readUint32(huffRecord, pos + 4);
      pos += 8;
      // Dart 没有 64-bit shift，用 BigInt 或限制范围
      // mincodeTable[i] = (mincode << (32 - i)) 的低 32 位
      // mincodeTable[i] = mincode shl (32 - i)
      //         maxcodeTable[i] = ((maxcode + 1) shl (32 - i)) - 1
      // 但这些值用于 64-bit 比较，这里简化处理
      mincodeTable[i] = mincode;
      maxcodeTable[i] = maxcode;
    }

    // 读取 CDIC 字典记录
    for (final record in cdicRecords) {
      final length = readUint32(record, 4);
      final numEntries = readUint32(record, 8);
      final codeLength = readUint32(record, 12);
      final n = min(1 << codeLength, numEntries - dictionary.length);

      for (int j = 0; j < n; j++) {
        final entryOffset = readUint16(record, length + j * 2);
        final x = readUint16(record, length + entryOffset);
        final len = x & 0x7FFF;
        final decompressed = (x & 0x8000) != 0;
        final entryData = record.sublist(length + entryOffset + 2, length + entryOffset + 2 + len);
        dictionary.add(CdicEntry(entryData.toList(), decompressed));
      }
    }
  }

  @override
  Uint8List decompress(Uint8List data) {
    final out = <int>[];

    // 实现是每次读 32 bits (4 bytes)，然后用 bitcount 追踪
    int pos = 0;
    int bitsLeft = data.length * 8;

    int readXBits(int count) {
      int value = 0;
      int remaining = count;
      while (remaining > 0 && pos < data.length) {
        value = (value << 8) | (data[pos] & 0xFF);
        pos++;
        remaining -= 8;
      }
      return value;
    }

    // 简化版：使用 byte 级别的读取
    pos = 0;
    bitsLeft = data.length * 8;
    int x = readXBits(4);
    int bitCount = 32;

    while (true) {
      if (bitCount <= 0) {
        pos += 4;
        x = _readUIntX(data, pos, 4);
        bitCount += 32;
      }

      final code = (x >> bitCount) & 0xFFFFFFFF;
      final t1 = table1[(code >> 24) & 0xFF];
      int codeLen = t1 & 0x1F;
      int maxCode = (((t1 >> 8) + 1) << (32 - codeLen)) - 1;

      if ((t1 & 0x80) == 0) {
        while (code < (mincodeTable[codeLen] << (32 - codeLen))) {
          codeLen++;
        }
        maxCode = (maxcodeTable[codeLen] << (32 - codeLen)) | ((1 << (32 - codeLen)) - 1);
      }

      bitCount -= codeLen;
      bitsLeft -= codeLen;

      if (bitsLeft < 0) break;

      final index = (maxCode - code) >> (32 - codeLen);
      if (index < 0 || index >= dictionary.length) break;

      final entry = dictionary[index];
      if (!entry.decompressed) {
        entry.data = decompress(Uint8List.fromList(entry.data)).toList();
        entry.decompressed = true;
      }
      out.addAll(entry.data);
    }

    return Uint8List.fromList(out);
  }

  int _readUIntX(Uint8List data, int offset, int maxLen) {
    if (offset + maxLen > data.length) return 0;
    int value = 0;
    for (int i = 0; i < maxLen; i++) {
      value = (value << 8) | (data[offset + i] & 0xFF);
    }
    return value;
  }
}
