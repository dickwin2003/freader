import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

/// 书籍类型
class BookType {
  static const int text = 0;
  static const int audio = 1;
  static const int image = 2;
  static const int file = 3;
}

/// 书籍实体
@JsonSerializable(explicitToJson: true)
class Book {
  /// 书籍 URL（主键）
  @JsonKey(name: 'bookUrl')
  final String bookUrl;

  /// 目录页 URL
  @JsonKey(name: 'tocUrl')
  final String tocUrl;

  /// 来源书源 URL
  @JsonKey(name: 'origin')
  final String origin;

  /// 来源书源名称
  @JsonKey(name: 'originName')
  final String originName;

  /// 书名
  @JsonKey(name: 'name')
  final String name;

  /// 作者
  @JsonKey(name: 'author')
  final String author;

  /// 分类标签
  @JsonKey(name: 'kind')
  final String? kind;

  /// 用户自定义标签
  @JsonKey(name: 'customTag')
  final String? customTag;

  /// 封面 URL
  @JsonKey(name: 'coverUrl')
  final String? coverUrl;

  /// 自定义封面 URL
  @JsonKey(name: 'customCoverUrl')
  final String? customCoverUrl;

  /// 简介
  @JsonKey(name: 'intro')
  final String? intro;

  /// 自定义简介
  @JsonKey(name: 'customIntro')
  final String? customIntro;

  /// 字符编码
  @JsonKey(name: 'charset')
  final String? charset;

  /// 书籍类型：0=文本, 1=音频, 2=图片
  @JsonKey(name: 'type')
  final int type;

  /// 所属分组（逗号分隔的 group id）
  @JsonKey(name: 'group')
  final int group;

  /// 最新章节标题
  @JsonKey(name: 'latestChapterTitle')
  final String? latestChapterTitle;

  /// 最新章节时间
  @JsonKey(name: 'latestChapterTime')
  final int? latestChapterTime;

  /// 总章节数
  @JsonKey(name: 'totalChapterNum')
  final int totalChapterNum;

  /// 当前阅读章节索引
  @JsonKey(name: 'durChapterIndex')
  final int durChapterIndex;

  /// 当前阅读章节标题
  @JsonKey(name: 'durChapterTitle')
  final String? durChapterTitle;

  /// 当前阅读位置（字符偏移）
  @JsonKey(name: 'durChapterPos')
  final int durChapterPos;

  /// 当前阅读时间
  @JsonKey(name: 'durChapterTime')
  final int durChapterTime;

  /// 字数
  @JsonKey(name: 'wordCount')
  final String? wordCount;

  /// 是否可以更新
  @JsonKey(name: 'canUpdate')
  final bool canUpdate;

  /// 变量存储（JSON Map）
  @JsonKey(name: 'variable')
  final String? variable;

  /// 阅读配置（JSON）
  @JsonKey(name: 'readConfig')
  final String? readConfig;

  /// 同步时间
  @JsonKey(name: 'syncTime')
  final int? syncTime;

  /// 是否本地书籍
  @JsonKey(name: 'local')
  final bool local;

  /// 是否在书架中
  @JsonKey(name: 'inBookshelf')
  final bool inBookshelf;

  /// 用户评分（0-5，0 表示未评分）
  @JsonKey(name: 'score')
  final int score;

  const Book({
    required this.bookUrl,
    required this.tocUrl,
    required this.origin,
    required this.originName,
    required this.name,
    required this.author,
    this.kind,
    this.customTag,
    this.coverUrl,
    this.customCoverUrl,
    this.intro,
    this.customIntro,
    this.charset,
    this.type = BookType.text,
    this.group = 0,
    this.latestChapterTitle,
    this.latestChapterTime,
    this.totalChapterNum = 0,
    this.durChapterIndex = 0,
    this.durChapterTitle,
    this.durChapterPos = 0,
    this.durChapterTime = 0,
    this.wordCount,
    this.canUpdate = true,
    this.variable,
    this.readConfig,
    this.syncTime,
    this.local = false,
    this.inBookshelf = false,
    this.score = 0,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  /// 获取显示用的封面 URL（自定义优先）
  String? get displayCoverUrl => customCoverUrl ?? coverUrl;

  /// 获取显示用的简介（自定义优先）
  String? get displayIntro => customIntro ?? intro;
}
