import 'dart:convert';
import 'dart:typed_data';
import 'byte_buffer_utils.dart';
import 'entities.dart';
import 'pdb_file.dart';
import 'mobi_book.dart';
import 'kf6_book.dart';
import 'kf8_book.dart';

/// MOBI 文件读取入口
class MobiReader {
  /// 从字节数据解析 MOBI 文件
  static MobiBook read(Uint8List data) {
    final pdb = PdbFile(data);
    final record0 = pdb.getRecordData(0);

    var headers = _readMobiEntryHeaders(record0);
    final mobi = headers.mobi;
    final exth = headers.exth;
    final resourceStart = mobi.resourceStart;

    var isKF8 = mobi.version >= 8;
    var kf8BoundaryOffset = 0;

    // 尝试从 KF6 中检测 KF8 boundary
    if (!isKF8) {
      final boundary = exth['boundary'];
      if (boundary != null && boundary is int && boundary != -1) {
        try {
          final buffer = pdb.getRecordData(boundary);
          headers = _readMobiEntryHeaders(buffer);
          kf8BoundaryOffset = boundary;
          isKF8 = true;
        } catch (_) {}
      }
    }

    if (isKF8) {
      return KF8Book(pdb, headers, kf8BoundaryOffset, resourceStart);
    } else {
      return KF6Book(pdb, headers, kf8BoundaryOffset, resourceStart);
    }
  }

  static MobiEntryHeaders _readMobiEntryHeaders(Uint8List record0) {
    final palmdoc = _readPalmDocHeader(record0);
    final mobi = _readMobiHeader(record0);
    final exth = (mobi.exthFlag & 0x40) != 0
        ? _readExth(Uint8List.fromList(record0.sublist(mobi.length + 16)), mobi.encoding)
        : <String, dynamic>{};
    final kf8 = mobi.version >= 8 ? _readKF8Header(record0) : null;
    return MobiEntryHeaders(palmdoc, mobi, exth, kf8);
  }

  static PalmDocHeader _readPalmDocHeader(Uint8List data) {
    return PalmDocHeader(
      readUint16(data, 0), // compression
      readUint16(data, 8), // numTextRecords
      readUint16(data, 10), // recordSize
      readUint16(data, 12), // encryption
    );
  }

  static MobiHeader _readMobiHeader(Uint8List data) {
    final identifier = readString(data, 16, 4);
    if (identifier != 'MOBI') throw FormatException('Missing MOBI header');

    final length = readUint32(data, 20);
    final type = readUint32(data, 24);
    final encoding = readUint32(data, 28);
    final uid = readUint32(data, 32);
    final version = readUint32(data, 36);
    final titleOffset = data.length > 88 ? readUint32(data, 84) : 0;
    final titleLength = data.length > 92 ? readUint32(data, 88) : 0;
    final localeRegion = data.length > 95 ? readUint8(data, 94) : 0;
    final localeLanguage = data.length > 96 ? readUint8(data, 95) : 0;
    final resourceStart = data.length > 112 ? readUint32(data, 108) : 0;
    final huffcdic = data.length > 116 ? readUint32(data, 112) : 0;
    final numHuffcdic = data.length > 120 ? readUint32(data, 116) : 0;
    final exthFlag = data.length > 132 ? readUint32(data, 128) : 0;
    final trailingFlags = data.length > 244 ? readUint32(data, 240) : 0;
    final indx = data.length > 248 ? readUint32(data, 244) : -1;

    final charset = encoding == 65001 ? utf8 : latin1;

    String title = '';
    if (titleOffset > 0 && titleLength > 0 && titleOffset + titleLength <= data.length) {
      title = readStringWithCharset(data, titleOffset, titleLength, charset);
    }

    final lang = _mobiLangMap[localeLanguage];
    final language = lang != null
        ? (localeRegion >> 2 < lang.length ? lang[localeRegion >> 2] ?? lang.first : lang.first)
        : '';

    return MobiHeader(
      identifier: identifier,
      length: length,
      type: type,
      encoding: encoding,
      uid: uid,
      version: version,
      titleOffset: titleOffset,
      titleLength: titleLength,
      localeRegion: localeRegion,
      localeLanguage: localeLanguage,
      resourceStart: resourceStart,
      huffcdic: huffcdic,
      numHuffcdic: numHuffcdic,
      exthFlag: exthFlag,
      trailingFlags: trailingFlags,
      indx: indx,
      title: title,
      language: language,
    );
  }

  static KF8Header? _readKF8Header(Uint8List data) {
    if (data.length < 264) return null;
    return KF8Header(
      readUint32(data, 192), // fdst
      readUint32(data, 196), // numFdst
      data.length > 252 ? readUint32(data, 248) : 0, // frag
      data.length > 256 ? readUint32(data, 252) : 0, // skel
      data.length > 264 ? readUint32(data, 260) : 0, // guide
    );
  }

  static Map<String, dynamic> _readExth(Uint8List data, int encoding) {
    final magic = readString(data, 0, 4);
    if (magic != 'EXTH') return {};

    final count = readUint32(data, 8);
    int offset = 12;
    final map = <String, dynamic>{};

    for (int i = 0; i < count; i++) {
      if (offset + 8 > data.length) break;
      final type = readUint32(data, offset);
      final length = readUint32(data, offset + 4);
      if (length < 8 || offset + length > data.length) break;

      final exthType = _exthRecordTypeMap[type];
      if (exthType != null) {
        final dynamic value;
        if (exthType.type == 'uint') {
          value = readUint32(data, offset + 8);
        } else {
          value = readStringWithCharset(data, offset + 8, length - 8, encoding == 65001 ? utf8 : latin1);
        }

        if (exthType.many) {
          final list = map.putIfAbsent(exthType.name, () => <String>[]) as List;
          list.add(value);
        } else {
          map[exthType.name] = value;
        }
      }
      offset += length;
    }
    return map;
  }

  static final Map<int, ExthRecordType> _exthRecordTypeMap = {
    100: ExthRecordType('creator', 'string', true),
    101: ExthRecordType('publisher'),
    103: ExthRecordType('description'),
    104: ExthRecordType('isbn'),
    105: ExthRecordType('subject', 'string', true),
    106: ExthRecordType('date'),
    108: ExthRecordType('contributor', 'string', true),
    109: ExthRecordType('rights'),
    110: ExthRecordType('subjectCode', 'string', true),
    112: ExthRecordType('source', 'string', true),
    113: ExthRecordType('asin'),
    121: ExthRecordType('boundary', 'uint'),
    122: ExthRecordType('fixedLayout'),
    125: ExthRecordType('numResources', 'uint'),
    126: ExthRecordType('originalResolution'),
    127: ExthRecordType('zeroGutter'),
    128: ExthRecordType('zeroMargin'),
    129: ExthRecordType('coverURI'),
    132: ExthRecordType('regionMagnification'),
    201: ExthRecordType('coverOffset', 'uint'),
    202: ExthRecordType('thumbnailOffset', 'uint'),
    204: ExthRecordType('creatorSoftware', 'uint'),
    503: ExthRecordType('title'),
    524: ExthRecordType('language', 'string', true),
    527: ExthRecordType('pageProgressionDirection'),
  };

  static const _mobiLangMap = <int, List<String>>{
    1: ['ar', 'ar-SA', 'ar-IQ', 'ar-EG'],
    2: ['bg'],
    3: ['ca'],
    4: ['zh', 'zh-TW', 'zh-CN', 'zh-HK', 'zh-SG'],
    5: ['cs'],
    6: ['da'],
    7: ['de', 'de-DE', 'de-CH', 'de-AT'],
    8: ['el'],
    9: ['en', 'en-US', 'en-GB', 'en-AU', 'en-CA'],
    10: ['es', 'es-ES', 'es-MX'],
    11: ['fi'],
    12: ['fr', 'fr-FR', 'fr-BE', 'fr-CA', 'fr-CH'],
    13: ['he'],
    14: ['hu'],
    15: ['is'],
    16: ['it', 'it-IT', 'it-CH'],
    17: ['ja'],
    18: ['ko'],
    19: ['nl', 'nl-NL', 'nl-BE'],
    20: ['no', 'nb', 'nn'],
    21: ['pl'],
    22: ['pt', 'pt-BR', 'pt-PT'],
    25: ['ru'],
    29: ['sv', 'sv-SE', 'sv-FI'],
    30: ['th'],
    31: ['tr'],
    33: ['id'],
    34: ['uk'],
    39: ['lt'],
    41: ['fa'],
    42: ['vi'],
    57: ['hi'],
    62: ['ms'],
    67: ['uz'],
    69: ['bn'],
    79: ['sa'],
    82: ['cy', 'cy-GB'],
  };
}
