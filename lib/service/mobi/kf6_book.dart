import 'dart:convert';
import 'dart:typed_data';
import 'entities.dart';
import 'mobi_book.dart';

/// Kindle Format 6 Book（旧版 MOBI）
/// 用 <mbp:pagebreak> 标签分节，filepos: 定位
class KF6Book extends MobiBook {
  late final List<KF6Section> sections;
  late final Map<int, List<TOC>> sectionIdMap;

  KF6Book(super.pdbFile, super.headers, super.kf8BoundaryOffset, super.resourceStart) {
    _processSections();
    _processNCX();
    _processSectionsMap();
  }

  /// 通过 recindex 获取资源
  Uint8List? getResourceByHref(String href) {
    final recindex = int.tryParse(href.replaceFirst(RegExp(r'.*recindex:'), ''));
    if (recindex == null) return null;
    return getResource(recindex - 1);
  }

  /// 获取 section 的文本内容
  String getSectionText(KF6Section section) {
    final bytes = getTextBytes(section.start, section.length);
    return charset.decode(bytes);
  }

  /// 通过 href 获取 section
  KF6Section? getSectionByHref(String href) {
    final index = _getIndexByHref(href);
    if (index == -1) return null;
    return index < sections.length ? sections[index] : null;
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

  int _getIndexByHref(String href) {
    final filepos = int.tryParse(href.replaceFirst(RegExp(r'.*filepos:'), ''));
    if (filepos == null) return -1;
    for (int i = 0; i < sections.length; i++) {
      if (sections[i].end > filepos) return i;
    }
    return -1;
  }

  void _processNCX() {
    final ncx = getNCX();
    if (ncx == null) return;

    TOC fmap(NCX item) {
      final filepos = item.offset ?? 0;
      final href = 'filepos:${filepos.toString().padLeft(10, '0')}';
      return TOC(item.label, href, subitems: item.children?.map(fmap).toList());
    }

    toc = ncx.map(fmap).toList();
  }

  void _processSections() {
    final result = <KF6Section>[];
    final allText = getTextBytes(0, 0x7FFFFFFF); // 读取全部文本
    // 将文本转为 ISO-8859-1 字符串来匹配 pagebreak 标签
    final text = latin1.decode(allText);
    final pattern = RegExp(r'<\s*(?:mbp:)?pagebreak[^>]*>', caseSensitive: false);

    int nextStart = 0;
    for (final match in pattern.allMatches(text)) {
      final start = nextStart;
      final end = match.start;
      nextStart = match.end;
      final length = end - start;
      final href = 'filepos:${start.toString().padLeft(10, '0')}';
      result.add(KF6Section(result.length, start, end, length, href));
    }

    // 最后一节
    if (nextStart > 0 && nextStart < text.length) {
      final start = nextStart;
      final length = text.length - start;
      final href = 'filepos:${start.toString().padLeft(10, '0')}';
      result.add(KF6Section(result.length, start, text.length, length, href));
    }

    // 如果没有找到 pagebreak，整本书作为一节
    if (result.isEmpty) {
      result.add(KF6Section(0, 0, text.length, text.length, 'filepos:0000000000'));
    }

    sections = result;
  }
}
