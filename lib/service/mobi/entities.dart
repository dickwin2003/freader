/// MOBI 解析器所有数据类
library;

// ============ Headers ============

class PalmDocHeader {
  final int compression;
  final int numTextRecords;
  final int recordSize;
  final int encryption;
  const PalmDocHeader(this.compression, this.numTextRecords, this.recordSize, this.encryption);
}

class MobiHeader {
  final String identifier;
  final int length;
  final int type;
  final int encoding;
  final int uid;
  final int version;
  final int titleOffset;
  final int titleLength;
  final int localeRegion;
  final int localeLanguage;
  final int resourceStart;
  final int huffcdic;
  final int numHuffcdic;
  final int exthFlag;
  final int trailingFlags;
  final int indx;
  final String title;
  final String language;

  const MobiHeader({
    required this.identifier,
    required this.length,
    required this.type,
    required this.encoding,
    required this.uid,
    required this.version,
    required this.titleOffset,
    required this.titleLength,
    required this.localeRegion,
    required this.localeLanguage,
    required this.resourceStart,
    required this.huffcdic,
    required this.numHuffcdic,
    required this.exthFlag,
    required this.trailingFlags,
    required this.indx,
    required this.title,
    required this.language,
  });
}

class KF8Header {
  final int fdst;
  final int numFdst;
  final int frag;
  final int skel;
  final int guide;
  const KF8Header(this.fdst, this.numFdst, this.frag, this.skel, this.guide);
}

class MobiEntryHeaders {
  final PalmDocHeader palmdoc;
  final MobiHeader mobi;
  final Map<String, dynamic> exth;
  final KF8Header? kf8;
  const MobiEntryHeaders(this.palmdoc, this.mobi, this.exth, this.kf8);
}

class FdstHeader {
  final String magic;
  final int numEntries;
  const FdstHeader(this.magic, this.numEntries);
}

// ============ INDX System ============

class IndxHeader {
  final String magic;
  final int length;
  final int type;
  final int idxt;
  final int numRecords;
  final int encoding;
  final int language;
  final int total;
  final int ordt;
  final int ligt;
  final int numLigt;
  final int numCncx;

  const IndxHeader({
    required this.magic,
    required this.length,
    required this.type,
    required this.idxt,
    required this.numRecords,
    required this.encoding,
    required this.language,
    required this.total,
    required this.ordt,
    required this.ligt,
    required this.numLigt,
    required this.numCncx,
  });
}

class TagxHeader {
  final String magic;
  final int length;
  final int numControlBytes;
  const TagxHeader(this.magic, this.length, this.numControlBytes);
}

class TagxTag {
  final int tag;
  final int numValues;
  final int bitmask;
  final int controlByte;
  const TagxTag(this.tag, this.numValues, this.bitmask, this.controlByte);
}

class Ptagx {
  final int tag;
  final int tagValueCount;
  final int? valueCount;
  final int? valueBytes;
  const Ptagx(this.tag, this.tagValueCount, this.valueCount, this.valueBytes);
}

class IndexTag {
  final int tagId;
  final List<int> values;
  const IndexTag(this.tagId, this.values);
}

class IndexEntry {
  final String label;
  final List<IndexTag> tags;
  final Map<int, IndexTag> tagMap;
  const IndexEntry(this.label, this.tags, this.tagMap);
}

class IndexData {
  final List<IndexEntry> table;
  final Map<int, String> cncx;
  const IndexData(this.table, this.cncx);
}

// ============ NCX & TOC ============

class NCX {
  final int index;
  final int? offset;
  final int? size;
  final String label;
  final int? headingLevel;
  final List<int>? pos;
  final int? parent;
  final int? firstChild;
  final int? lastChild;
  List<NCX>? children;

  NCX({
    required this.index,
    this.offset,
    this.size,
    required this.label,
    this.headingLevel,
    this.pos,
    this.parent,
    this.firstChild,
    this.lastChild,
    this.children,
  });
}

class TOC {
  final String label;
  final String href;
  final List<TOC>? subitems;
  const TOC(this.label, this.href, {this.subitems});
}

// ============ KF6 ============

class KF6Section {
  final int index;
  final int start;
  final int end;
  final int length;
  final String href;
  KF6Section(this.index, this.start, this.end, this.length, this.href);
}

// ============ KF8 ============

class Skeleton {
  final int index;
  final String name;
  final int numFrag;
  final int offset;
  final int length;
  const Skeleton(this.index, this.name, this.numFrag, this.offset, this.length);
}

class Fragment {
  final int insertOffset;
  final String selector;
  final int index;
  final int offset;
  final int length;
  const Fragment(this.insertOffset, this.selector, this.index, this.offset, this.length);
}

class KF8Section {
  final int index;
  final Skeleton skeleton;
  final List<Fragment> frags;
  final int fragEnd;
  final int length;
  final int totalLength;
  final String href;
  const KF8Section(this.index, this.skeleton, this.frags, this.fragEnd, this.length, this.totalLength, this.href);

  bool get linear => frags.isNotEmpty;
}

class KF8Pos {
  final int fid;
  final int off;
  const KF8Pos(this.fid, this.off);
}

class KF8Resource {
  final String resourceType;
  final int id;
  final String type;
  const KF8Resource(this.resourceType, this.id, this.type);
}

// ============ Metadata ============

class MobiMetadata {
  final String identifier;
  final String title;
  final List<String> author;
  final String publisher;
  final String language;
  final String published;
  final String description;
  final List<String> subject;
  final String rights;

  const MobiMetadata({
    required this.identifier,
    required this.title,
    required this.author,
    required this.publisher,
    required this.language,
    required this.published,
    required this.description,
    required this.subject,
    required this.rights,
  });
}

// ============ Decompressor ============

class CdicEntry {
  List<int> data;
  bool decompressed;
  CdicEntry(this.data, this.decompressed);
}

// ============ EXTH ============

class ExthRecordType {
  final String name;
  final String type;
  final bool many;
  const ExthRecordType(this.name, [this.type = 'string', this.many = false]);
}
