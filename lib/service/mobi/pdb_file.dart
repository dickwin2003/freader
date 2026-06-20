import 'dart:typed_data';
import 'byte_buffer_utils.dart';

/// PDB (PalmDB) 容器文件读取
/// MOBI 文件实际上是 PDB 格式的容器
class PdbFile {
  final Uint8List _data;
  final List<int> _offsets;

  final String name;
  final String type;
  final String creator;
  final int recordCount;

  PdbFile(this._data)
      : name = readString(_data, 0, 32).replaceAll(RegExp(r'\x00'), ''),
        type = readString(_data, 60, 4),
        creator = readString(_data, 64, 4),
        recordCount = readUint16(_data, 76),
        _offsets = _readOffsets(_data, readUint16(_data, 76));

  static List<int> _readOffsets(Uint8List data, int count) {
    return List.generate(count, (i) => readUint32(data, 78 + i * 8));
  }

  /// 按索引读取一条 PDB 记录
  Uint8List getRecordData(int index) {
    if (index < 0 || index >= recordCount) {
      throw RangeError('Record index $index out of bounds (0..$recordCount)');
    }
    final start = _offsets[index];
    final end = (index + 1 < recordCount)
        ? _offsets[index + 1]
        : _data.length;
    return Uint8List.fromList(_data.sublist(start, end));
  }
}
