import 'dart:math';
import 'dart:typed_data';
import 'byte_buffer_utils.dart';
import 'entities.dart';
import 'mobi_book.dart';

/// Kindle Format 8 Book（AZW3）
/// 用 skeleton + fragment 组装内容，kindle:pos:fid:off: 定位
class KF8Book extends MobiBook {
  late final List<Skeleton> skelTable;
  late final List<Fragment> fragTable;
  late final KF8Header kf8;
  late final List<KF8Section> sections;
  late final Map<int, List<TOC>> sectionIdMap;

  KF8Book(super.pdbFile, super.headers, super.kf8BoundaryOffset, super.resourceStart) {
    kf8 = headers.kf8!;
    _readFdstTable();
    _readSkelTable();
    _readFragTable();
    _processSections();
    _processNCX();
    _processSectionsMap();
  }

  // --- 公开 API ---

  Uint8List? getResourceByHref(String href) {
    final resource = _parseResourceURI(href);
    if (resource == null || resource.resourceType == 'flow') return null;
    return getResource(resource.id - 1);
  }

  KF8Section? getSectionByHref(String href) {
    final index = _getIndexByHref(href);
    if (index == -1) return null;
    return index < sections.length ? sections[index] : null;
  }

  /// 获取指定 href 范围的文本
  String getTextByHref(String href, String nextHref) {
    final pos = _parsePosURI(href);
    final nextPos = _parsePosURI(nextHref);
    if (pos == null) return '';

    final index = _getIndexByFID(pos.fid);
    if (index == -1) return '';

    final nextIndex = nextPos != null ? _getIndexByFID(nextPos.fid) : -1;
    final startFid = pos.fid;
    final endFid = (index == nextIndex && nextPos != null) ? nextPos.fid : 0x7FFFFFFF;
    final section = sections[index];
    final skel = section.skeleton;

    final droppedFrags = section.frags.where((f) => f.index < startFid).toList();
    var droppedFragsLength = droppedFrags.fold<int>(0, (sum, f) => sum + f.length);

    final frags = section.frags.where((f) => f.index >= startFid && f.index <= endFid).toList();
    final rawLength = skel.length + frags.fold<int>(0, (sum, f) => sum + f.length);
    final raw = _getRaw(skel.offset, section.length);

    final lastFragDroppedLength =
        (index == nextIndex && nextPos != null) ? frags.last.length - nextPos.off : 0;

    final resultLength = rawLength - pos.off - lastFragDroppedLength;
    if (resultLength <= 0) return '';

    final result = List<int>.filled(min(resultLength, raw.length), 0);
    int leftBytes = result.length;

    // 复制 skeleton 基础数据
    for (int i = 0; i < skel.length && i < result.length && i < raw.length; i++) {
      result[i] = raw[i];
    }
    leftBytes -= skel.length;

    for (int i = 0; i < frags.length; i++) {
      final frag = frags[i];
      final isFirstFrag = i == 0;
      final isLastFrag = i == frags.length - 1;

      final insertOffset = frag.insertOffset - skel.offset - droppedFragsLength;
      final offset = skel.length + frag.offset;

      final srcStart = insertOffset;
      final srcEnd = result.length - leftBytes;
      final dstStart = insertOffset + frag.length -
          (isFirstFrag ? pos.off : 0) -
          (isLastFrag ? lastFragDroppedLength : 0);

      // 移动现有数据
      if (dstStart < result.length && srcStart < srcEnd) {
        final moveLen = min(srcEnd - srcStart, result.length - (dstStart > 0 ? dstStart : 0));
        for (int j = moveLen - 1; j >= 0; j--) {
          if (dstStart + j < result.length && srcStart + j < result.length) {
            result[dstStart + j] = result[srcStart + j];
          }
        }
      }

      // 插入 fragment 数据
      final fragStart = offset + (isFirstFrag ? pos.off : 0);
      final fragEnd = offset + frag.length - (isLastFrag ? lastFragDroppedLength : 0);
      for (int j = fragStart; j < fragEnd && (insertOffset + j - fragStart) < result.length; j++) {
        if (j < raw.length) {
          result[insertOffset + j - fragStart] = raw[j];
        }
      }

      leftBytes -= frag.length -
          (isFirstFrag ? pos.off : 0) -
          (isLastFrag && index == nextIndex && nextPos != null ? nextPos.off : 0);
      if (isFirstFrag) {
        droppedFragsLength += pos.off;
      }
    }

    return charset.decode(Uint8List.fromList(result));
  }

  /// 获取完整 section 文本
  String getSectionText(KF8Section section) {
    final skel = section.skeleton;
    final frags = section.frags;
    final raw = _getRaw(skel.offset, section.length);

    final result = List<int>.from(raw);
    int leftBytes = raw.length;

    for (final frag in frags) {
      final insertOffset = frag.insertOffset - skel.offset;
      final offset = skel.length + frag.offset;

      // 移动现有数据腾出空间
      final srcEnd = result.length - leftBytes;
      if (insertOffset + frag.length <= result.length && insertOffset <= srcEnd) {
        for (int j = result.length - 1; j >= insertOffset + frag.length; j--) {
          if (j - frag.length >= 0) {
            result[j] = result[j - frag.length];
          }
        }
      }

      // 插入 fragment 数据
      for (int j = 0; j < frag.length; j++) {
        if (insertOffset + j < result.length && offset + j < raw.length) {
          result[insertOffset + j] = raw[offset + j];
        }
      }
      leftBytes -= frag.length;
    }

    return charset.decode(Uint8List.fromList(result));
  }

  // --- 内部方法 ---

  Uint8List _getRaw(int offset, int len) {
    return getTextBytes(offset, len);
  }

  KF8Pos? _parsePosURI(String href) {
    final match = RegExp(r'kindle:pos:fid:(\w+):off:(\w+)').firstMatch(href);
    if (match == null) return null;
    return KF8Pos(
      int.parse(match.group(1)!, radix: 32),
      int.parse(match.group(2)!, radix: 32),
    );
  }

  KF8Resource? _parseResourceURI(String href) {
    final match = RegExp(r'kindle:(flow|embed):(\w+)(?:\?mime=([\w/+.-]+))?').firstMatch(href);
    if (match == null) return null;
    return KF8Resource(
      match.group(1)!,
      int.parse(match.group(2)!, radix: 32),
      match.group(3) ?? '',
    );
  }

  int _getIndexByHref(String href) {
    final pos = _parsePosURI(href);
    if (pos == null) return -1;
    return _getIndexByFID(pos.fid);
  }

  int _getIndexByFID(int fid) {
    for (int i = 0; i < sections.length; i++) {
      if (sections[i].frags.any((frag) => frag.index == fid)) return i;
    }
    return -1;
  }

  String _makePosURI(int fid, int off) {
    final encodedFid = fid.toRadixString(32).toUpperCase().padLeft(4, '0');
    final encodedOff = off.toRadixString(32).toUpperCase().padLeft(10, '0');
    return 'kindle:pos:fid:$encodedFid:off:$encodedOff';
  }

  void _processNCX() {
    final ncx = getNCX();
    if (ncx == null) return;

    TOC fmap(NCX item) {
      final pos = item.pos;
      String href = '';
      if (pos != null && pos.length >= 2) {
        href = _makePosURI(pos[0], pos[1]);
      }
      return TOC(item.label, href, subitems: item.children?.map(fmap).toList());
    }

    toc = ncx.map(fmap).toList();
  }

  void _processSections() {
    final result = <KF8Section>[];
    int fragEnd = 0;

    for (int i = 0; i < skelTable.length; i++) {
      final skel = skelTable[i];
      final fragStart = fragEnd;
      fragEnd = fragStart + skel.numFrag;
      final frags = fragTable.sublist(fragStart, min(fragEnd, fragTable.length));
      final length = skel.length + frags.fold<int>(0, (sum, f) => sum + f.length);
      final totalLength = (result.isNotEmpty ? result.last.totalLength : 0) + length;
      final href = frags.isNotEmpty ? _makePosURI(frags.first.index, 0) : '';

      result.add(KF8Section(i, skel, frags, fragEnd, length, totalLength, href));
    }

    sections = result;
  }

  void _processSectionsMap() {
    sectionIdMap = {};
    if (toc == null) return;

    void fmap(TOC item) {
      final index = _getIndexByHref(item.href);
      if (index == -1) return;
      sectionIdMap.putIfAbsent(index, () => []).add(item);
      item.subitems?.forEach(fmap);
    }

    toc!.forEach(fmap);
  }

  void _readFragTable() {
    final fragData = getIndexData(kf8.frag);
    fragTable = fragData.table.map((entry) {
      final tagMap = entry.tagMap;
      return Fragment(
        int.tryParse(entry.label) ?? 0,
        fragData.cncx[tagMap[2]?.values[0] ?? -1] ?? '',
        tagMap[4]?.values[0] ?? 0,
        tagMap[6]?.values[0] ?? 0,
        (tagMap[6] != null && tagMap[6]!.values.length > 1) ? tagMap[6]!.values[1] : 0,
      );
    }).toList();
  }

  void _readSkelTable() {
    final skelData = getIndexData(kf8.skel);
    skelTable = skelData.table.asMap().entries.map((e) {
      final tagMap = e.value.tagMap;
      return Skeleton(
        e.key,
        e.value.label,
        tagMap[1]?.values[0] ?? 0,
        tagMap[6]?.values[0] ?? 0,
        (tagMap[6] != null && tagMap[6]!.values.length > 1) ? tagMap[6]!.values[1] : 0,
      );
    }).toList();
  }

  void _readFdstTable() {
    try {
      final fdstBuffer = getRecord(kf8.fdst);
      final magic = readString(fdstBuffer, 0, 4);
      if (magic != 'FDST') return;
      // FDST 表用于多流场景，大多数 MOBI 文件只有一个流
      // 暂时不存储，因为文本读取已通过 getTextBytes 统一处理
    } catch (_) {}
  }
}
