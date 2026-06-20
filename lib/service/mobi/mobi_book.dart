import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'byte_buffer_utils.dart';
import 'entities.dart';
import 'pdb_file.dart';
import 'decompress.dart';

/// MOBI 书籍基类 — 处理通用逻辑：文本记录读取、解压、INDX/NCX、封面
abstract class MobiBook {
  final PdbFile pdbFile;
  final MobiEntryHeaders headers;
  final int kf8BoundaryOffset;
  final int resourceStart;

  MobiHeader get mobi => headers.mobi;
  PalmDocHeader get palmdoc => headers.palmdoc;
  Map<String, dynamic> get exth => headers.exth;

  late final Encoding charset;
  late final Decompressor _decompressor;
  late final List<int> _textRecordOffsets;
  List<TOC>? toc;

  MobiBook(this.pdbFile, this.headers, this.kf8BoundaryOffset, this.resourceStart) {
    charset = mobi.encoding == 65001 ? utf8 : latin1;
    _decompressor = _createDecompressor();
    _buildTextRecordOffsets();
  }

  Decompressor _createDecompressor() {
    switch (palmdoc.compression) {
      case 1:
        return PlainDecompressor();
      case 2:
        return Lz77Decompressor(max(4096, palmdoc.recordSize));
      case 17480:
        // HuffCDIC: 需要先读取 HUFF 和 CDIC 记录
        final huffRecord = getRecord(mobi.huffcdic);
        final cdicRecords = <Uint8List>[];
        for (int i = 1; i < mobi.numHuffcdic; i++) {
          cdicRecords.add(getRecord(mobi.huffcdic + i));
        }
        return HuffcdicDecompressor(huffRecord, cdicRecords);
      default:
        throw FormatException('Unknown compression: ${palmdoc.compression}');
    }
  }

  void _buildTextRecordOffsets() {
    _textRecordOffsets = [];
    int offset = 0;
    for (int i = 0; i < palmdoc.numTextRecords; i++) {
      offset += getTextRecord(i).length;
      _textRecordOffsets.add(offset);
    }
  }

  /// 按索引读取 PDB 记录（考虑 KF8 boundary 偏移）
  Uint8List getRecord(int index) {
    return pdbFile.getRecordData(kf8BoundaryOffset + index);
  }

  /// 读取文本记录：获取原始记录 → 去除 trailing entries → 解压
  Uint8List getTextRecord(int index) {
    if (index < 0 || index >= palmdoc.numTextRecords) {
      throw RangeError('Text record index $index out of bounds');
    }
    var content = getRecord(index + 1);
    content = _removeTrailingEntries(content);
    return _decompressor.decompress(content);
  }

  /// 去除 MOBI 记录末尾的 trailing entries
  Uint8List _removeTrailingEntries(Uint8List data) {
    final trailingFlags = mobi.trailingFlags;
    if (trailingFlags == 0) return data;

    final multibyte = (trailingFlags & 1) != 0;
    final numTrailingEntries = _countOneBits(trailingFlags >> 1);
    int extraSize = 0;

    for (int i = 0; i < numTrailingEntries; i++) {
      int value = 0;
      for (int j = max(0, data.length - 4 - extraSize);
          j <= max(0, data.length - extraSize - 1);
          j++) {
        final byte = data[j];
        if ((byte & 0x80) != 0) {
          value = 0;
        }
        value = (value << 7) | (byte & 0x7F);
      }
      extraSize += value;
    }

    if (multibyte && data.length > extraSize) {
      final byte = data[data.length - 1 - extraSize];
      extraSize += (byte & 0x03) + 1;
    }

    if (extraSize > 0 && extraSize < data.length) {
      return Uint8List.fromList(data.sublist(0, data.length - extraSize));
    }
    return data;
  }

  int _countOneBits(int value) {
    int count = 0;
    while (value != 0) {
      count += value & 1;
      value >>= 1;
    }
    return count;
  }

  /// 获取文本记录的虚拟输入流（简化版：返回全部文本的字节列表）
  Uint8List _getAllTextBytes() {
    final builder = BytesBuilder();
    for (int i = 0; i < palmdoc.numTextRecords; i++) {
      builder.add(getTextRecord(i));
    }
    return builder.toBytes();
  }

  /// 获取指定范围的文本字节
  Uint8List getTextBytes(int start, int length) {
    final allBytes = _getAllTextBytes();
    final end = min(start + length, allBytes.length);
    if (start >= allBytes.length) return Uint8List(0);
    return Uint8List.fromList(allBytes.sublist(start, end));
  }

  /// 获取资源记录
  Uint8List getResource(int index) {
    return pdbFile.getRecordData(resourceStart + index);
  }

  /// 获取封面
  Uint8List? getCover() {
    final coverOffset = exth['coverOffset'];
    final thumbnailOffset = exth['thumbnailOffset'];

    if (coverOffset != null && coverOffset is int && coverOffset != -1) {
      return getResource(coverOffset);
    }
    if (thumbnailOffset != null && thumbnailOffset is int && thumbnailOffset != -1) {
      return getResource(thumbnailOffset);
    }
    return null;
  }

  /// 获取元数据
  late final MobiMetadata metadata = MobiMetadata(
    identifier: mobi.uid.toString(),
    title: _toSingleString(exth['title']) ?? mobi.title,
    author: _toStringList(exth['creator']),
    publisher: _toSingleString(exth['publisher']) ?? '',
    language: _toSingleString(exth['language']) ?? mobi.language,
    published: _toSingleString(exth['date']) ?? '',
    description: _toSingleString(exth['description']) ?? '',
    subject: _toStringList(exth['subject']),
    rights: _toSingleString(exth['rights']) ?? '',
  );

  /// 取 EXTH 单值字段，兼容 String 与 List<String>
  /// （language 等 many 字段在某些 MOBI 里会重复出现，被解析为 List）
  String? _toSingleString(dynamic value) {
    if (value is String) return value;
    if (value is List && value.isNotEmpty) {
      final first = value.first;
      return first is String ? first : first?.toString();
    }
    return null;
  }

  List<String> _toStringList(dynamic value) {
    if (value is List) return value.cast<String>();
    if (value is String) return [value];
    return [];
  }

  /// ============ INDX / TAGX / NCX 系统 ============

  /// 读取 INDX 索引数据
  IndexData getIndexData(int indxIndex) {
    final indxRecord = getRecord(indxIndex);
    final indx = _readIndxHeader(indxRecord);
    final tagxBuffer = Uint8List.fromList(indxRecord.sublist(indx.length));
    final tagx = _readTagxHeader(tagxBuffer);
    final tagTable = _readTagxTags(tagx, tagxBuffer);
    final cncx = _readCncx(indxIndex, indx);

    final table = <IndexEntry>[];
    for (int i = 0; i < indx.numRecords; i++) {
      final record = getRecord(indxIndex + 1 + i);
      final recordIndx = _readIndxHeader(record);
      final idxt = _readIdxt(record, recordIndx);
      for (int j = 0; j < recordIndx.numRecords; j++) {
        if (j < idxt.length) {
          final entry = _readIndexEntry(record, tagx, tagTable, idxt[j]);
          table.add(entry);
        }
      }
    }

    return IndexData(table, cncx);
  }

  /// 获取 NCX 目录
  List<NCX>? getNCX() {
    final indxIndex = mobi.indx;
    if (indxIndex == -1) return null;

    final indexData = getIndexData(indxIndex);
    final items = <NCX>[];

    for (int idx = 0; idx < indexData.table.length; idx++) {
      final entry = indexData.table[idx];
      final tagMap = entry.tagMap;

      items.add(NCX(
        index: idx,
        offset: tagMap[1]?.values.firstOrNull,
        size: tagMap[2]?.values.firstOrNull,
        label: indexData.cncx[tagMap[3]?.values[0] ?? -1] ?? '',
        headingLevel: tagMap[4]?.values.firstOrNull,
        pos: tagMap[6]?.values,
        parent: tagMap[21]?.values.firstOrNull,
        firstChild: tagMap[22]?.values.firstOrNull,
        lastChild: tagMap[23]?.values.firstOrNull,
      ));
    }

    // 构建树形结构
    final parentItemMap = <int, List<NCX>>{};
    for (final item in items) {
      final parent = item.parent;
      if (parent != null) {
        parentItemMap.putIfAbsent(parent, () => []).add(item);
      }
    }

    NCX buildTree(NCX item) {
      if (item.firstChild == null) return item;
      item.children = parentItemMap[item.index]?.map(buildTree).toList();
      return item;
    }

    return items.where((it) => it.headingLevel == 0).map(buildTree).toList();
  }

  // --- INDX 内部方法 ---

  IndxHeader _readIndxHeader(Uint8List data) {
    final magic = readString(data, 0, 4);
    return IndxHeader(
      magic: magic,
      length: readUint32(data, 4),
      type: readUint32(data, 8),
      idxt: readUint32(data, 20),
      numRecords: readUint32(data, 24),
      encoding: readUint32(data, 28),
      language: readUint32(data, 32),
      total: readUint32(data, 36),
      ordt: readUint32(data, 40),
      ligt: readUint32(data, 44),
      numLigt: readUint32(data, 48),
      numCncx: readUint32(data, 52),
    );
  }

  TagxHeader _readTagxHeader(Uint8List data) {
    final magic = readString(data, 0, 4);
    return TagxHeader(magic, readUint32(data, 4), readUint32(data, 8));
  }

  List<TagxTag> _readTagxTags(TagxHeader tagx, Uint8List data) {
    final numTags = (tagx.length - 12) ~/ 4;
    final tags = <TagxTag>[];
    for (int i = 0; i < numTags; i++) {
      final offset = 12 + i * 4;
      tags.add(TagxTag(
        data[offset] & 0xFF,
        data[offset + 1] & 0xFF,
        data[offset + 2] & 0xFF,
        data[offset + 3] & 0xFF,
      ));
    }
    return tags;
  }

  List<int> _readIdxt(Uint8List data, IndxHeader header) {
    return readUint16Array(data, header.idxt + 4, header.numRecords);
  }

  IndexEntry _readIndexEntry(
      Uint8List data, TagxHeader tagx, List<TagxTag> tagTable, int idxtOffset) {
    final len = data[idxtOffset] & 0xFF;
    final label = readString(data, idxtOffset + 1, len);

    final ptagxs = <Ptagx>[];
    final startPos = idxtOffset + 1 + len;
    int controlByteIndex = 0;
    int pos = startPos + tagx.numControlBytes;

    for (final tag in tagTable) {
      if (tag.controlByte == 1) {
        controlByteIndex++;
        continue;
      }
      final offset = startPos + controlByteIndex;
      int value = data[offset] & tag.bitmask;

      if (value == tag.bitmask) {
        if (_countOneBits(tag.bitmask) > 1) {
          int v = 0;
          for (int a = pos; a < min(pos + 4, data.length); a++) {
            final byte = data[a];
            v = (v << 7) | (byte & 0x7F);
            pos++;
            if ((byte & 0x80) != 0) break;
          }
          ptagxs.add(Ptagx(tag.tag, tag.numValues, null, v));
        } else {
          ptagxs.add(Ptagx(tag.tag, tag.numValues, 1, null));
        }
      } else {
        int mask = tag.bitmask;
        while ((mask & 1) == 0) {
          mask >>= 1;
          value >>= 1;
        }
        ptagxs.add(Ptagx(tag.tag, tag.numValues, value, null));
      }
    }

    final tags = <IndexTag>[];
    final tagMap = <int, IndexTag>{};

    for (final ptagx in ptagxs) {
      final values = <int>[];
      if (ptagx.valueCount != null) {
        for (int i = 0; i < ptagx.valueCount! * ptagx.tagValueCount; i++) {
          int v = 0;
          for (int a = pos; a < min(pos + 4, data.length); a++) {
            final byte = data[a];
            v = (v << 7) | (byte & 0x7F);
            pos++;
            if ((byte & 0x80) != 0) break;
          }
          values.add(v);
        }
      } else if (ptagx.valueBytes != null) {
        int count = 0;
        while (count < ptagx.valueBytes!) {
          int v = 0;
          for (int a = pos; a < min(pos + 4, data.length); a++) {
            final byte = data[a];
            v = (v << 7) | (byte & 0x7F);
            pos++;
            count++;
            if ((byte & 0x80) != 0) break;
          }
          values.add(v);
        }
      }
      final tag = IndexTag(ptagx.tag, values);
      tags.add(tag);
      tagMap[tag.tagId] = tag;
    }

    return IndexEntry(label, tags, tagMap);
  }

  Map<int, String> _readCncx(int indxIndex, IndxHeader indx) {
    final cncx = <int, String>{};
    int cncxRecordOffset = 0;
    for (int i = 0; i < indx.numCncx; i++) {
      final record = getRecord(indxIndex + indx.numRecords + i + 1);
      int pos = 0;
      while (pos < record.length) {
        final index = pos;
        int value = 0;
        int length = 0;
        for (int a = pos; a < min(pos + 4, record.length); a++) {
          value = (value << 7) | (record[a] & 0x7F);
          length++;
          if ((record[a] & 0x80) != 0) break;
        }
        pos += length;
        if (pos + value <= record.length) {
          cncx[cncxRecordOffset + index] = readStringWithCharset(record, pos, value, charset);
        }
        pos += value;
      }
      cncxRecordOffset += 0x10000;
    }
    return cncx;
  }
}
