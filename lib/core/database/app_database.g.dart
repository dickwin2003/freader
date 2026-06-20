// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BookSourcesTable extends BookSources
    with TableInfo<$BookSourcesTable, BookSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookSourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bookSourceUrlMeta = const VerificationMeta(
    'bookSourceUrl',
  );
  @override
  late final GeneratedColumn<String> bookSourceUrl = GeneratedColumn<String>(
    'book_source_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookSourceNameMeta = const VerificationMeta(
    'bookSourceName',
  );
  @override
  late final GeneratedColumn<String> bookSourceName = GeneratedColumn<String>(
    'book_source_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookSourceGroupMeta = const VerificationMeta(
    'bookSourceGroup',
  );
  @override
  late final GeneratedColumn<String> bookSourceGroup = GeneratedColumn<String>(
    'book_source_group',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bookSourceTypeMeta = const VerificationMeta(
    'bookSourceType',
  );
  @override
  late final GeneratedColumn<int> bookSourceType = GeneratedColumn<int>(
    'book_source_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _bookUrlPatternMeta = const VerificationMeta(
    'bookUrlPattern',
  );
  @override
  late final GeneratedColumn<String> bookUrlPattern = GeneratedColumn<String>(
    'book_url_pattern',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customOrderMeta = const VerificationMeta(
    'customOrder',
  );
  @override
  late final GeneratedColumn<int> customOrder = GeneratedColumn<int>(
    'custom_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _enabledExploreMeta = const VerificationMeta(
    'enabledExplore',
  );
  @override
  late final GeneratedColumn<bool> enabledExplore = GeneratedColumn<bool>(
    'enabled_explore',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled_explore" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _enabledCookieJarMeta = const VerificationMeta(
    'enabledCookieJar',
  );
  @override
  late final GeneratedColumn<bool> enabledCookieJar = GeneratedColumn<bool>(
    'enabled_cookie_jar',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled_cookie_jar" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _jsLibMeta = const VerificationMeta('jsLib');
  @override
  late final GeneratedColumn<String> jsLib = GeneratedColumn<String>(
    'js_lib',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _concurrentRateMeta = const VerificationMeta(
    'concurrentRate',
  );
  @override
  late final GeneratedColumn<String> concurrentRate = GeneratedColumn<String>(
    'concurrent_rate',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _headerMeta = const VerificationMeta('header');
  @override
  late final GeneratedColumn<String> header = GeneratedColumn<String>(
    'header',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loginUrlMeta = const VerificationMeta(
    'loginUrl',
  );
  @override
  late final GeneratedColumn<String> loginUrl = GeneratedColumn<String>(
    'login_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loginUiMeta = const VerificationMeta(
    'loginUi',
  );
  @override
  late final GeneratedColumn<String> loginUi = GeneratedColumn<String>(
    'login_ui',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loginCheckJsMeta = const VerificationMeta(
    'loginCheckJs',
  );
  @override
  late final GeneratedColumn<String> loginCheckJs = GeneratedColumn<String>(
    'login_check_js',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _searchUrlMeta = const VerificationMeta(
    'searchUrl',
  );
  @override
  late final GeneratedColumn<String> searchUrl = GeneratedColumn<String>(
    'search_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exploreUrlMeta = const VerificationMeta(
    'exploreUrl',
  );
  @override
  late final GeneratedColumn<String> exploreUrl = GeneratedColumn<String>(
    'explore_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exploreScreenMeta = const VerificationMeta(
    'exploreScreen',
  );
  @override
  late final GeneratedColumn<String> exploreScreen = GeneratedColumn<String>(
    'explore_screen',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleSearchMeta = const VerificationMeta(
    'ruleSearch',
  );
  @override
  late final GeneratedColumn<String> ruleSearch = GeneratedColumn<String>(
    'rule_search',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleExploreMeta = const VerificationMeta(
    'ruleExplore',
  );
  @override
  late final GeneratedColumn<String> ruleExplore = GeneratedColumn<String>(
    'rule_explore',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleBookInfoMeta = const VerificationMeta(
    'ruleBookInfo',
  );
  @override
  late final GeneratedColumn<String> ruleBookInfo = GeneratedColumn<String>(
    'rule_book_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleTocMeta = const VerificationMeta(
    'ruleToc',
  );
  @override
  late final GeneratedColumn<String> ruleToc = GeneratedColumn<String>(
    'rule_toc',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleContentMeta = const VerificationMeta(
    'ruleContent',
  );
  @override
  late final GeneratedColumn<String> ruleContent = GeneratedColumn<String>(
    'rule_content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleReviewMeta = const VerificationMeta(
    'ruleReview',
  );
  @override
  late final GeneratedColumn<String> ruleReview = GeneratedColumn<String>(
    'rule_review',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _respondTimeMeta = const VerificationMeta(
    'respondTime',
  );
  @override
  late final GeneratedColumn<int> respondTime = GeneratedColumn<int>(
    'respond_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(180000),
  );
  static const VerificationMeta _lastUpdateTimeMeta = const VerificationMeta(
    'lastUpdateTime',
  );
  @override
  late final GeneratedColumn<int> lastUpdateTime = GeneratedColumn<int>(
    'last_update_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _variableMeta = const VerificationMeta(
    'variable',
  );
  @override
  late final GeneratedColumn<String> variable = GeneratedColumn<String>(
    'variable',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    bookSourceUrl,
    bookSourceName,
    bookSourceGroup,
    bookSourceType,
    bookUrlPattern,
    customOrder,
    enabled,
    enabledExplore,
    enabledCookieJar,
    jsLib,
    concurrentRate,
    header,
    loginUrl,
    loginUi,
    loginCheckJs,
    searchUrl,
    exploreUrl,
    exploreScreen,
    ruleSearch,
    ruleExplore,
    ruleBookInfo,
    ruleToc,
    ruleContent,
    ruleReview,
    respondTime,
    lastUpdateTime,
    variable,
    weight,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'book_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookSource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('book_source_url')) {
      context.handle(
        _bookSourceUrlMeta,
        bookSourceUrl.isAcceptableOrUnknown(
          data['book_source_url']!,
          _bookSourceUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bookSourceUrlMeta);
    }
    if (data.containsKey('book_source_name')) {
      context.handle(
        _bookSourceNameMeta,
        bookSourceName.isAcceptableOrUnknown(
          data['book_source_name']!,
          _bookSourceNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bookSourceNameMeta);
    }
    if (data.containsKey('book_source_group')) {
      context.handle(
        _bookSourceGroupMeta,
        bookSourceGroup.isAcceptableOrUnknown(
          data['book_source_group']!,
          _bookSourceGroupMeta,
        ),
      );
    }
    if (data.containsKey('book_source_type')) {
      context.handle(
        _bookSourceTypeMeta,
        bookSourceType.isAcceptableOrUnknown(
          data['book_source_type']!,
          _bookSourceTypeMeta,
        ),
      );
    }
    if (data.containsKey('book_url_pattern')) {
      context.handle(
        _bookUrlPatternMeta,
        bookUrlPattern.isAcceptableOrUnknown(
          data['book_url_pattern']!,
          _bookUrlPatternMeta,
        ),
      );
    }
    if (data.containsKey('custom_order')) {
      context.handle(
        _customOrderMeta,
        customOrder.isAcceptableOrUnknown(
          data['custom_order']!,
          _customOrderMeta,
        ),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('enabled_explore')) {
      context.handle(
        _enabledExploreMeta,
        enabledExplore.isAcceptableOrUnknown(
          data['enabled_explore']!,
          _enabledExploreMeta,
        ),
      );
    }
    if (data.containsKey('enabled_cookie_jar')) {
      context.handle(
        _enabledCookieJarMeta,
        enabledCookieJar.isAcceptableOrUnknown(
          data['enabled_cookie_jar']!,
          _enabledCookieJarMeta,
        ),
      );
    }
    if (data.containsKey('js_lib')) {
      context.handle(
        _jsLibMeta,
        jsLib.isAcceptableOrUnknown(data['js_lib']!, _jsLibMeta),
      );
    }
    if (data.containsKey('concurrent_rate')) {
      context.handle(
        _concurrentRateMeta,
        concurrentRate.isAcceptableOrUnknown(
          data['concurrent_rate']!,
          _concurrentRateMeta,
        ),
      );
    }
    if (data.containsKey('header')) {
      context.handle(
        _headerMeta,
        header.isAcceptableOrUnknown(data['header']!, _headerMeta),
      );
    }
    if (data.containsKey('login_url')) {
      context.handle(
        _loginUrlMeta,
        loginUrl.isAcceptableOrUnknown(data['login_url']!, _loginUrlMeta),
      );
    }
    if (data.containsKey('login_ui')) {
      context.handle(
        _loginUiMeta,
        loginUi.isAcceptableOrUnknown(data['login_ui']!, _loginUiMeta),
      );
    }
    if (data.containsKey('login_check_js')) {
      context.handle(
        _loginCheckJsMeta,
        loginCheckJs.isAcceptableOrUnknown(
          data['login_check_js']!,
          _loginCheckJsMeta,
        ),
      );
    }
    if (data.containsKey('search_url')) {
      context.handle(
        _searchUrlMeta,
        searchUrl.isAcceptableOrUnknown(data['search_url']!, _searchUrlMeta),
      );
    }
    if (data.containsKey('explore_url')) {
      context.handle(
        _exploreUrlMeta,
        exploreUrl.isAcceptableOrUnknown(data['explore_url']!, _exploreUrlMeta),
      );
    }
    if (data.containsKey('explore_screen')) {
      context.handle(
        _exploreScreenMeta,
        exploreScreen.isAcceptableOrUnknown(
          data['explore_screen']!,
          _exploreScreenMeta,
        ),
      );
    }
    if (data.containsKey('rule_search')) {
      context.handle(
        _ruleSearchMeta,
        ruleSearch.isAcceptableOrUnknown(data['rule_search']!, _ruleSearchMeta),
      );
    }
    if (data.containsKey('rule_explore')) {
      context.handle(
        _ruleExploreMeta,
        ruleExplore.isAcceptableOrUnknown(
          data['rule_explore']!,
          _ruleExploreMeta,
        ),
      );
    }
    if (data.containsKey('rule_book_info')) {
      context.handle(
        _ruleBookInfoMeta,
        ruleBookInfo.isAcceptableOrUnknown(
          data['rule_book_info']!,
          _ruleBookInfoMeta,
        ),
      );
    }
    if (data.containsKey('rule_toc')) {
      context.handle(
        _ruleTocMeta,
        ruleToc.isAcceptableOrUnknown(data['rule_toc']!, _ruleTocMeta),
      );
    }
    if (data.containsKey('rule_content')) {
      context.handle(
        _ruleContentMeta,
        ruleContent.isAcceptableOrUnknown(
          data['rule_content']!,
          _ruleContentMeta,
        ),
      );
    }
    if (data.containsKey('rule_review')) {
      context.handle(
        _ruleReviewMeta,
        ruleReview.isAcceptableOrUnknown(data['rule_review']!, _ruleReviewMeta),
      );
    }
    if (data.containsKey('respond_time')) {
      context.handle(
        _respondTimeMeta,
        respondTime.isAcceptableOrUnknown(
          data['respond_time']!,
          _respondTimeMeta,
        ),
      );
    }
    if (data.containsKey('last_update_time')) {
      context.handle(
        _lastUpdateTimeMeta,
        lastUpdateTime.isAcceptableOrUnknown(
          data['last_update_time']!,
          _lastUpdateTimeMeta,
        ),
      );
    }
    if (data.containsKey('variable')) {
      context.handle(
        _variableMeta,
        variable.isAcceptableOrUnknown(data['variable']!, _variableMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bookSourceUrl};
  @override
  BookSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookSource(
      bookSourceUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_source_url'],
      )!,
      bookSourceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_source_name'],
      )!,
      bookSourceGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_source_group'],
      ),
      bookSourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}book_source_type'],
      )!,
      bookUrlPattern: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_url_pattern'],
      ),
      customOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}custom_order'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      enabledExplore: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled_explore'],
      )!,
      enabledCookieJar: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled_cookie_jar'],
      )!,
      jsLib: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}js_lib'],
      ),
      concurrentRate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}concurrent_rate'],
      ),
      header: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}header'],
      ),
      loginUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_url'],
      ),
      loginUi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_ui'],
      ),
      loginCheckJs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_check_js'],
      ),
      searchUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_url'],
      ),
      exploreUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explore_url'],
      ),
      exploreScreen: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explore_screen'],
      ),
      ruleSearch: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_search'],
      ),
      ruleExplore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_explore'],
      ),
      ruleBookInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_book_info'],
      ),
      ruleToc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_toc'],
      ),
      ruleContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_content'],
      ),
      ruleReview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_review'],
      ),
      respondTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}respond_time'],
      )!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_update_time'],
      ),
      variable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variable'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      )!,
    );
  }

  @override
  $BookSourcesTable createAlias(String alias) {
    return $BookSourcesTable(attachedDatabase, alias);
  }
}

class BookSource extends DataClass implements Insertable<BookSource> {
  /// 书源 URL（主键）
  final String bookSourceUrl;

  /// 书源名称
  final String bookSourceName;

  /// 书源分组
  final String? bookSourceGroup;

  /// 书源类型：0=文本, 1=音频, 2=图片, 3=文件
  final int bookSourceType;

  /// 书籍详情页 URL 匹配正则
  final String? bookUrlPattern;

  /// 自定义排序序号
  final int customOrder;

  /// 是否启用
  final bool enabled;

  /// 是否启用发现
  final bool enabledExplore;

  /// 是否启用 Cookie
  final bool enabledCookieJar;

  /// JS 库
  final String? jsLib;

  /// 并发速率限制
  final String? concurrentRate;

  /// 自定义头部
  final String? header;

  /// 登录 URL
  final String? loginUrl;

  /// 登录 UI
  final String? loginUi;

  /// 登录检查 JS
  final String? loginCheckJs;

  /// 搜索 URL
  final String? searchUrl;

  /// 发现 URL
  final String? exploreUrl;

  /// 发现页面配置
  final String? exploreScreen;

  /// 搜索规则（JSON）
  final String? ruleSearch;

  /// 发现规则（JSON）
  final String? ruleExplore;

  /// 书籍详情规则（JSON）
  final String? ruleBookInfo;

  /// 目录规则（JSON）
  final String? ruleToc;

  /// 正文规则（JSON）
  final String? ruleContent;

  /// 评论规则（JSON）
  final String? ruleReview;

  /// 响应时间
  final int respondTime;

  /// 最后更新时间
  final int? lastUpdateTime;

  /// 变量
  final String? variable;

  /// 权重
  final int weight;
  const BookSource({
    required this.bookSourceUrl,
    required this.bookSourceName,
    this.bookSourceGroup,
    required this.bookSourceType,
    this.bookUrlPattern,
    required this.customOrder,
    required this.enabled,
    required this.enabledExplore,
    required this.enabledCookieJar,
    this.jsLib,
    this.concurrentRate,
    this.header,
    this.loginUrl,
    this.loginUi,
    this.loginCheckJs,
    this.searchUrl,
    this.exploreUrl,
    this.exploreScreen,
    this.ruleSearch,
    this.ruleExplore,
    this.ruleBookInfo,
    this.ruleToc,
    this.ruleContent,
    this.ruleReview,
    required this.respondTime,
    this.lastUpdateTime,
    this.variable,
    required this.weight,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['book_source_url'] = Variable<String>(bookSourceUrl);
    map['book_source_name'] = Variable<String>(bookSourceName);
    if (!nullToAbsent || bookSourceGroup != null) {
      map['book_source_group'] = Variable<String>(bookSourceGroup);
    }
    map['book_source_type'] = Variable<int>(bookSourceType);
    if (!nullToAbsent || bookUrlPattern != null) {
      map['book_url_pattern'] = Variable<String>(bookUrlPattern);
    }
    map['custom_order'] = Variable<int>(customOrder);
    map['enabled'] = Variable<bool>(enabled);
    map['enabled_explore'] = Variable<bool>(enabledExplore);
    map['enabled_cookie_jar'] = Variable<bool>(enabledCookieJar);
    if (!nullToAbsent || jsLib != null) {
      map['js_lib'] = Variable<String>(jsLib);
    }
    if (!nullToAbsent || concurrentRate != null) {
      map['concurrent_rate'] = Variable<String>(concurrentRate);
    }
    if (!nullToAbsent || header != null) {
      map['header'] = Variable<String>(header);
    }
    if (!nullToAbsent || loginUrl != null) {
      map['login_url'] = Variable<String>(loginUrl);
    }
    if (!nullToAbsent || loginUi != null) {
      map['login_ui'] = Variable<String>(loginUi);
    }
    if (!nullToAbsent || loginCheckJs != null) {
      map['login_check_js'] = Variable<String>(loginCheckJs);
    }
    if (!nullToAbsent || searchUrl != null) {
      map['search_url'] = Variable<String>(searchUrl);
    }
    if (!nullToAbsent || exploreUrl != null) {
      map['explore_url'] = Variable<String>(exploreUrl);
    }
    if (!nullToAbsent || exploreScreen != null) {
      map['explore_screen'] = Variable<String>(exploreScreen);
    }
    if (!nullToAbsent || ruleSearch != null) {
      map['rule_search'] = Variable<String>(ruleSearch);
    }
    if (!nullToAbsent || ruleExplore != null) {
      map['rule_explore'] = Variable<String>(ruleExplore);
    }
    if (!nullToAbsent || ruleBookInfo != null) {
      map['rule_book_info'] = Variable<String>(ruleBookInfo);
    }
    if (!nullToAbsent || ruleToc != null) {
      map['rule_toc'] = Variable<String>(ruleToc);
    }
    if (!nullToAbsent || ruleContent != null) {
      map['rule_content'] = Variable<String>(ruleContent);
    }
    if (!nullToAbsent || ruleReview != null) {
      map['rule_review'] = Variable<String>(ruleReview);
    }
    map['respond_time'] = Variable<int>(respondTime);
    if (!nullToAbsent || lastUpdateTime != null) {
      map['last_update_time'] = Variable<int>(lastUpdateTime);
    }
    if (!nullToAbsent || variable != null) {
      map['variable'] = Variable<String>(variable);
    }
    map['weight'] = Variable<int>(weight);
    return map;
  }

  BookSourcesCompanion toCompanion(bool nullToAbsent) {
    return BookSourcesCompanion(
      bookSourceUrl: Value(bookSourceUrl),
      bookSourceName: Value(bookSourceName),
      bookSourceGroup: bookSourceGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(bookSourceGroup),
      bookSourceType: Value(bookSourceType),
      bookUrlPattern: bookUrlPattern == null && nullToAbsent
          ? const Value.absent()
          : Value(bookUrlPattern),
      customOrder: Value(customOrder),
      enabled: Value(enabled),
      enabledExplore: Value(enabledExplore),
      enabledCookieJar: Value(enabledCookieJar),
      jsLib: jsLib == null && nullToAbsent
          ? const Value.absent()
          : Value(jsLib),
      concurrentRate: concurrentRate == null && nullToAbsent
          ? const Value.absent()
          : Value(concurrentRate),
      header: header == null && nullToAbsent
          ? const Value.absent()
          : Value(header),
      loginUrl: loginUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(loginUrl),
      loginUi: loginUi == null && nullToAbsent
          ? const Value.absent()
          : Value(loginUi),
      loginCheckJs: loginCheckJs == null && nullToAbsent
          ? const Value.absent()
          : Value(loginCheckJs),
      searchUrl: searchUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(searchUrl),
      exploreUrl: exploreUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(exploreUrl),
      exploreScreen: exploreScreen == null && nullToAbsent
          ? const Value.absent()
          : Value(exploreScreen),
      ruleSearch: ruleSearch == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleSearch),
      ruleExplore: ruleExplore == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleExplore),
      ruleBookInfo: ruleBookInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleBookInfo),
      ruleToc: ruleToc == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleToc),
      ruleContent: ruleContent == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleContent),
      ruleReview: ruleReview == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleReview),
      respondTime: Value(respondTime),
      lastUpdateTime: lastUpdateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdateTime),
      variable: variable == null && nullToAbsent
          ? const Value.absent()
          : Value(variable),
      weight: Value(weight),
    );
  }

  factory BookSource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookSource(
      bookSourceUrl: serializer.fromJson<String>(json['bookSourceUrl']),
      bookSourceName: serializer.fromJson<String>(json['bookSourceName']),
      bookSourceGroup: serializer.fromJson<String?>(json['bookSourceGroup']),
      bookSourceType: serializer.fromJson<int>(json['bookSourceType']),
      bookUrlPattern: serializer.fromJson<String?>(json['bookUrlPattern']),
      customOrder: serializer.fromJson<int>(json['customOrder']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      enabledExplore: serializer.fromJson<bool>(json['enabledExplore']),
      enabledCookieJar: serializer.fromJson<bool>(json['enabledCookieJar']),
      jsLib: serializer.fromJson<String?>(json['jsLib']),
      concurrentRate: serializer.fromJson<String?>(json['concurrentRate']),
      header: serializer.fromJson<String?>(json['header']),
      loginUrl: serializer.fromJson<String?>(json['loginUrl']),
      loginUi: serializer.fromJson<String?>(json['loginUi']),
      loginCheckJs: serializer.fromJson<String?>(json['loginCheckJs']),
      searchUrl: serializer.fromJson<String?>(json['searchUrl']),
      exploreUrl: serializer.fromJson<String?>(json['exploreUrl']),
      exploreScreen: serializer.fromJson<String?>(json['exploreScreen']),
      ruleSearch: serializer.fromJson<String?>(json['ruleSearch']),
      ruleExplore: serializer.fromJson<String?>(json['ruleExplore']),
      ruleBookInfo: serializer.fromJson<String?>(json['ruleBookInfo']),
      ruleToc: serializer.fromJson<String?>(json['ruleToc']),
      ruleContent: serializer.fromJson<String?>(json['ruleContent']),
      ruleReview: serializer.fromJson<String?>(json['ruleReview']),
      respondTime: serializer.fromJson<int>(json['respondTime']),
      lastUpdateTime: serializer.fromJson<int?>(json['lastUpdateTime']),
      variable: serializer.fromJson<String?>(json['variable']),
      weight: serializer.fromJson<int>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bookSourceUrl': serializer.toJson<String>(bookSourceUrl),
      'bookSourceName': serializer.toJson<String>(bookSourceName),
      'bookSourceGroup': serializer.toJson<String?>(bookSourceGroup),
      'bookSourceType': serializer.toJson<int>(bookSourceType),
      'bookUrlPattern': serializer.toJson<String?>(bookUrlPattern),
      'customOrder': serializer.toJson<int>(customOrder),
      'enabled': serializer.toJson<bool>(enabled),
      'enabledExplore': serializer.toJson<bool>(enabledExplore),
      'enabledCookieJar': serializer.toJson<bool>(enabledCookieJar),
      'jsLib': serializer.toJson<String?>(jsLib),
      'concurrentRate': serializer.toJson<String?>(concurrentRate),
      'header': serializer.toJson<String?>(header),
      'loginUrl': serializer.toJson<String?>(loginUrl),
      'loginUi': serializer.toJson<String?>(loginUi),
      'loginCheckJs': serializer.toJson<String?>(loginCheckJs),
      'searchUrl': serializer.toJson<String?>(searchUrl),
      'exploreUrl': serializer.toJson<String?>(exploreUrl),
      'exploreScreen': serializer.toJson<String?>(exploreScreen),
      'ruleSearch': serializer.toJson<String?>(ruleSearch),
      'ruleExplore': serializer.toJson<String?>(ruleExplore),
      'ruleBookInfo': serializer.toJson<String?>(ruleBookInfo),
      'ruleToc': serializer.toJson<String?>(ruleToc),
      'ruleContent': serializer.toJson<String?>(ruleContent),
      'ruleReview': serializer.toJson<String?>(ruleReview),
      'respondTime': serializer.toJson<int>(respondTime),
      'lastUpdateTime': serializer.toJson<int?>(lastUpdateTime),
      'variable': serializer.toJson<String?>(variable),
      'weight': serializer.toJson<int>(weight),
    };
  }

  BookSource copyWith({
    String? bookSourceUrl,
    String? bookSourceName,
    Value<String?> bookSourceGroup = const Value.absent(),
    int? bookSourceType,
    Value<String?> bookUrlPattern = const Value.absent(),
    int? customOrder,
    bool? enabled,
    bool? enabledExplore,
    bool? enabledCookieJar,
    Value<String?> jsLib = const Value.absent(),
    Value<String?> concurrentRate = const Value.absent(),
    Value<String?> header = const Value.absent(),
    Value<String?> loginUrl = const Value.absent(),
    Value<String?> loginUi = const Value.absent(),
    Value<String?> loginCheckJs = const Value.absent(),
    Value<String?> searchUrl = const Value.absent(),
    Value<String?> exploreUrl = const Value.absent(),
    Value<String?> exploreScreen = const Value.absent(),
    Value<String?> ruleSearch = const Value.absent(),
    Value<String?> ruleExplore = const Value.absent(),
    Value<String?> ruleBookInfo = const Value.absent(),
    Value<String?> ruleToc = const Value.absent(),
    Value<String?> ruleContent = const Value.absent(),
    Value<String?> ruleReview = const Value.absent(),
    int? respondTime,
    Value<int?> lastUpdateTime = const Value.absent(),
    Value<String?> variable = const Value.absent(),
    int? weight,
  }) => BookSource(
    bookSourceUrl: bookSourceUrl ?? this.bookSourceUrl,
    bookSourceName: bookSourceName ?? this.bookSourceName,
    bookSourceGroup: bookSourceGroup.present
        ? bookSourceGroup.value
        : this.bookSourceGroup,
    bookSourceType: bookSourceType ?? this.bookSourceType,
    bookUrlPattern: bookUrlPattern.present
        ? bookUrlPattern.value
        : this.bookUrlPattern,
    customOrder: customOrder ?? this.customOrder,
    enabled: enabled ?? this.enabled,
    enabledExplore: enabledExplore ?? this.enabledExplore,
    enabledCookieJar: enabledCookieJar ?? this.enabledCookieJar,
    jsLib: jsLib.present ? jsLib.value : this.jsLib,
    concurrentRate: concurrentRate.present
        ? concurrentRate.value
        : this.concurrentRate,
    header: header.present ? header.value : this.header,
    loginUrl: loginUrl.present ? loginUrl.value : this.loginUrl,
    loginUi: loginUi.present ? loginUi.value : this.loginUi,
    loginCheckJs: loginCheckJs.present ? loginCheckJs.value : this.loginCheckJs,
    searchUrl: searchUrl.present ? searchUrl.value : this.searchUrl,
    exploreUrl: exploreUrl.present ? exploreUrl.value : this.exploreUrl,
    exploreScreen: exploreScreen.present
        ? exploreScreen.value
        : this.exploreScreen,
    ruleSearch: ruleSearch.present ? ruleSearch.value : this.ruleSearch,
    ruleExplore: ruleExplore.present ? ruleExplore.value : this.ruleExplore,
    ruleBookInfo: ruleBookInfo.present ? ruleBookInfo.value : this.ruleBookInfo,
    ruleToc: ruleToc.present ? ruleToc.value : this.ruleToc,
    ruleContent: ruleContent.present ? ruleContent.value : this.ruleContent,
    ruleReview: ruleReview.present ? ruleReview.value : this.ruleReview,
    respondTime: respondTime ?? this.respondTime,
    lastUpdateTime: lastUpdateTime.present
        ? lastUpdateTime.value
        : this.lastUpdateTime,
    variable: variable.present ? variable.value : this.variable,
    weight: weight ?? this.weight,
  );
  BookSource copyWithCompanion(BookSourcesCompanion data) {
    return BookSource(
      bookSourceUrl: data.bookSourceUrl.present
          ? data.bookSourceUrl.value
          : this.bookSourceUrl,
      bookSourceName: data.bookSourceName.present
          ? data.bookSourceName.value
          : this.bookSourceName,
      bookSourceGroup: data.bookSourceGroup.present
          ? data.bookSourceGroup.value
          : this.bookSourceGroup,
      bookSourceType: data.bookSourceType.present
          ? data.bookSourceType.value
          : this.bookSourceType,
      bookUrlPattern: data.bookUrlPattern.present
          ? data.bookUrlPattern.value
          : this.bookUrlPattern,
      customOrder: data.customOrder.present
          ? data.customOrder.value
          : this.customOrder,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      enabledExplore: data.enabledExplore.present
          ? data.enabledExplore.value
          : this.enabledExplore,
      enabledCookieJar: data.enabledCookieJar.present
          ? data.enabledCookieJar.value
          : this.enabledCookieJar,
      jsLib: data.jsLib.present ? data.jsLib.value : this.jsLib,
      concurrentRate: data.concurrentRate.present
          ? data.concurrentRate.value
          : this.concurrentRate,
      header: data.header.present ? data.header.value : this.header,
      loginUrl: data.loginUrl.present ? data.loginUrl.value : this.loginUrl,
      loginUi: data.loginUi.present ? data.loginUi.value : this.loginUi,
      loginCheckJs: data.loginCheckJs.present
          ? data.loginCheckJs.value
          : this.loginCheckJs,
      searchUrl: data.searchUrl.present ? data.searchUrl.value : this.searchUrl,
      exploreUrl: data.exploreUrl.present
          ? data.exploreUrl.value
          : this.exploreUrl,
      exploreScreen: data.exploreScreen.present
          ? data.exploreScreen.value
          : this.exploreScreen,
      ruleSearch: data.ruleSearch.present
          ? data.ruleSearch.value
          : this.ruleSearch,
      ruleExplore: data.ruleExplore.present
          ? data.ruleExplore.value
          : this.ruleExplore,
      ruleBookInfo: data.ruleBookInfo.present
          ? data.ruleBookInfo.value
          : this.ruleBookInfo,
      ruleToc: data.ruleToc.present ? data.ruleToc.value : this.ruleToc,
      ruleContent: data.ruleContent.present
          ? data.ruleContent.value
          : this.ruleContent,
      ruleReview: data.ruleReview.present
          ? data.ruleReview.value
          : this.ruleReview,
      respondTime: data.respondTime.present
          ? data.respondTime.value
          : this.respondTime,
      lastUpdateTime: data.lastUpdateTime.present
          ? data.lastUpdateTime.value
          : this.lastUpdateTime,
      variable: data.variable.present ? data.variable.value : this.variable,
      weight: data.weight.present ? data.weight.value : this.weight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookSource(')
          ..write('bookSourceUrl: $bookSourceUrl, ')
          ..write('bookSourceName: $bookSourceName, ')
          ..write('bookSourceGroup: $bookSourceGroup, ')
          ..write('bookSourceType: $bookSourceType, ')
          ..write('bookUrlPattern: $bookUrlPattern, ')
          ..write('customOrder: $customOrder, ')
          ..write('enabled: $enabled, ')
          ..write('enabledExplore: $enabledExplore, ')
          ..write('enabledCookieJar: $enabledCookieJar, ')
          ..write('jsLib: $jsLib, ')
          ..write('concurrentRate: $concurrentRate, ')
          ..write('header: $header, ')
          ..write('loginUrl: $loginUrl, ')
          ..write('loginUi: $loginUi, ')
          ..write('loginCheckJs: $loginCheckJs, ')
          ..write('searchUrl: $searchUrl, ')
          ..write('exploreUrl: $exploreUrl, ')
          ..write('exploreScreen: $exploreScreen, ')
          ..write('ruleSearch: $ruleSearch, ')
          ..write('ruleExplore: $ruleExplore, ')
          ..write('ruleBookInfo: $ruleBookInfo, ')
          ..write('ruleToc: $ruleToc, ')
          ..write('ruleContent: $ruleContent, ')
          ..write('ruleReview: $ruleReview, ')
          ..write('respondTime: $respondTime, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('variable: $variable, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    bookSourceUrl,
    bookSourceName,
    bookSourceGroup,
    bookSourceType,
    bookUrlPattern,
    customOrder,
    enabled,
    enabledExplore,
    enabledCookieJar,
    jsLib,
    concurrentRate,
    header,
    loginUrl,
    loginUi,
    loginCheckJs,
    searchUrl,
    exploreUrl,
    exploreScreen,
    ruleSearch,
    ruleExplore,
    ruleBookInfo,
    ruleToc,
    ruleContent,
    ruleReview,
    respondTime,
    lastUpdateTime,
    variable,
    weight,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookSource &&
          other.bookSourceUrl == this.bookSourceUrl &&
          other.bookSourceName == this.bookSourceName &&
          other.bookSourceGroup == this.bookSourceGroup &&
          other.bookSourceType == this.bookSourceType &&
          other.bookUrlPattern == this.bookUrlPattern &&
          other.customOrder == this.customOrder &&
          other.enabled == this.enabled &&
          other.enabledExplore == this.enabledExplore &&
          other.enabledCookieJar == this.enabledCookieJar &&
          other.jsLib == this.jsLib &&
          other.concurrentRate == this.concurrentRate &&
          other.header == this.header &&
          other.loginUrl == this.loginUrl &&
          other.loginUi == this.loginUi &&
          other.loginCheckJs == this.loginCheckJs &&
          other.searchUrl == this.searchUrl &&
          other.exploreUrl == this.exploreUrl &&
          other.exploreScreen == this.exploreScreen &&
          other.ruleSearch == this.ruleSearch &&
          other.ruleExplore == this.ruleExplore &&
          other.ruleBookInfo == this.ruleBookInfo &&
          other.ruleToc == this.ruleToc &&
          other.ruleContent == this.ruleContent &&
          other.ruleReview == this.ruleReview &&
          other.respondTime == this.respondTime &&
          other.lastUpdateTime == this.lastUpdateTime &&
          other.variable == this.variable &&
          other.weight == this.weight);
}

class BookSourcesCompanion extends UpdateCompanion<BookSource> {
  final Value<String> bookSourceUrl;
  final Value<String> bookSourceName;
  final Value<String?> bookSourceGroup;
  final Value<int> bookSourceType;
  final Value<String?> bookUrlPattern;
  final Value<int> customOrder;
  final Value<bool> enabled;
  final Value<bool> enabledExplore;
  final Value<bool> enabledCookieJar;
  final Value<String?> jsLib;
  final Value<String?> concurrentRate;
  final Value<String?> header;
  final Value<String?> loginUrl;
  final Value<String?> loginUi;
  final Value<String?> loginCheckJs;
  final Value<String?> searchUrl;
  final Value<String?> exploreUrl;
  final Value<String?> exploreScreen;
  final Value<String?> ruleSearch;
  final Value<String?> ruleExplore;
  final Value<String?> ruleBookInfo;
  final Value<String?> ruleToc;
  final Value<String?> ruleContent;
  final Value<String?> ruleReview;
  final Value<int> respondTime;
  final Value<int?> lastUpdateTime;
  final Value<String?> variable;
  final Value<int> weight;
  final Value<int> rowid;
  const BookSourcesCompanion({
    this.bookSourceUrl = const Value.absent(),
    this.bookSourceName = const Value.absent(),
    this.bookSourceGroup = const Value.absent(),
    this.bookSourceType = const Value.absent(),
    this.bookUrlPattern = const Value.absent(),
    this.customOrder = const Value.absent(),
    this.enabled = const Value.absent(),
    this.enabledExplore = const Value.absent(),
    this.enabledCookieJar = const Value.absent(),
    this.jsLib = const Value.absent(),
    this.concurrentRate = const Value.absent(),
    this.header = const Value.absent(),
    this.loginUrl = const Value.absent(),
    this.loginUi = const Value.absent(),
    this.loginCheckJs = const Value.absent(),
    this.searchUrl = const Value.absent(),
    this.exploreUrl = const Value.absent(),
    this.exploreScreen = const Value.absent(),
    this.ruleSearch = const Value.absent(),
    this.ruleExplore = const Value.absent(),
    this.ruleBookInfo = const Value.absent(),
    this.ruleToc = const Value.absent(),
    this.ruleContent = const Value.absent(),
    this.ruleReview = const Value.absent(),
    this.respondTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.variable = const Value.absent(),
    this.weight = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookSourcesCompanion.insert({
    required String bookSourceUrl,
    required String bookSourceName,
    this.bookSourceGroup = const Value.absent(),
    this.bookSourceType = const Value.absent(),
    this.bookUrlPattern = const Value.absent(),
    this.customOrder = const Value.absent(),
    this.enabled = const Value.absent(),
    this.enabledExplore = const Value.absent(),
    this.enabledCookieJar = const Value.absent(),
    this.jsLib = const Value.absent(),
    this.concurrentRate = const Value.absent(),
    this.header = const Value.absent(),
    this.loginUrl = const Value.absent(),
    this.loginUi = const Value.absent(),
    this.loginCheckJs = const Value.absent(),
    this.searchUrl = const Value.absent(),
    this.exploreUrl = const Value.absent(),
    this.exploreScreen = const Value.absent(),
    this.ruleSearch = const Value.absent(),
    this.ruleExplore = const Value.absent(),
    this.ruleBookInfo = const Value.absent(),
    this.ruleToc = const Value.absent(),
    this.ruleContent = const Value.absent(),
    this.ruleReview = const Value.absent(),
    this.respondTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.variable = const Value.absent(),
    this.weight = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : bookSourceUrl = Value(bookSourceUrl),
       bookSourceName = Value(bookSourceName);
  static Insertable<BookSource> custom({
    Expression<String>? bookSourceUrl,
    Expression<String>? bookSourceName,
    Expression<String>? bookSourceGroup,
    Expression<int>? bookSourceType,
    Expression<String>? bookUrlPattern,
    Expression<int>? customOrder,
    Expression<bool>? enabled,
    Expression<bool>? enabledExplore,
    Expression<bool>? enabledCookieJar,
    Expression<String>? jsLib,
    Expression<String>? concurrentRate,
    Expression<String>? header,
    Expression<String>? loginUrl,
    Expression<String>? loginUi,
    Expression<String>? loginCheckJs,
    Expression<String>? searchUrl,
    Expression<String>? exploreUrl,
    Expression<String>? exploreScreen,
    Expression<String>? ruleSearch,
    Expression<String>? ruleExplore,
    Expression<String>? ruleBookInfo,
    Expression<String>? ruleToc,
    Expression<String>? ruleContent,
    Expression<String>? ruleReview,
    Expression<int>? respondTime,
    Expression<int>? lastUpdateTime,
    Expression<String>? variable,
    Expression<int>? weight,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (bookSourceUrl != null) 'book_source_url': bookSourceUrl,
      if (bookSourceName != null) 'book_source_name': bookSourceName,
      if (bookSourceGroup != null) 'book_source_group': bookSourceGroup,
      if (bookSourceType != null) 'book_source_type': bookSourceType,
      if (bookUrlPattern != null) 'book_url_pattern': bookUrlPattern,
      if (customOrder != null) 'custom_order': customOrder,
      if (enabled != null) 'enabled': enabled,
      if (enabledExplore != null) 'enabled_explore': enabledExplore,
      if (enabledCookieJar != null) 'enabled_cookie_jar': enabledCookieJar,
      if (jsLib != null) 'js_lib': jsLib,
      if (concurrentRate != null) 'concurrent_rate': concurrentRate,
      if (header != null) 'header': header,
      if (loginUrl != null) 'login_url': loginUrl,
      if (loginUi != null) 'login_ui': loginUi,
      if (loginCheckJs != null) 'login_check_js': loginCheckJs,
      if (searchUrl != null) 'search_url': searchUrl,
      if (exploreUrl != null) 'explore_url': exploreUrl,
      if (exploreScreen != null) 'explore_screen': exploreScreen,
      if (ruleSearch != null) 'rule_search': ruleSearch,
      if (ruleExplore != null) 'rule_explore': ruleExplore,
      if (ruleBookInfo != null) 'rule_book_info': ruleBookInfo,
      if (ruleToc != null) 'rule_toc': ruleToc,
      if (ruleContent != null) 'rule_content': ruleContent,
      if (ruleReview != null) 'rule_review': ruleReview,
      if (respondTime != null) 'respond_time': respondTime,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
      if (variable != null) 'variable': variable,
      if (weight != null) 'weight': weight,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookSourcesCompanion copyWith({
    Value<String>? bookSourceUrl,
    Value<String>? bookSourceName,
    Value<String?>? bookSourceGroup,
    Value<int>? bookSourceType,
    Value<String?>? bookUrlPattern,
    Value<int>? customOrder,
    Value<bool>? enabled,
    Value<bool>? enabledExplore,
    Value<bool>? enabledCookieJar,
    Value<String?>? jsLib,
    Value<String?>? concurrentRate,
    Value<String?>? header,
    Value<String?>? loginUrl,
    Value<String?>? loginUi,
    Value<String?>? loginCheckJs,
    Value<String?>? searchUrl,
    Value<String?>? exploreUrl,
    Value<String?>? exploreScreen,
    Value<String?>? ruleSearch,
    Value<String?>? ruleExplore,
    Value<String?>? ruleBookInfo,
    Value<String?>? ruleToc,
    Value<String?>? ruleContent,
    Value<String?>? ruleReview,
    Value<int>? respondTime,
    Value<int?>? lastUpdateTime,
    Value<String?>? variable,
    Value<int>? weight,
    Value<int>? rowid,
  }) {
    return BookSourcesCompanion(
      bookSourceUrl: bookSourceUrl ?? this.bookSourceUrl,
      bookSourceName: bookSourceName ?? this.bookSourceName,
      bookSourceGroup: bookSourceGroup ?? this.bookSourceGroup,
      bookSourceType: bookSourceType ?? this.bookSourceType,
      bookUrlPattern: bookUrlPattern ?? this.bookUrlPattern,
      customOrder: customOrder ?? this.customOrder,
      enabled: enabled ?? this.enabled,
      enabledExplore: enabledExplore ?? this.enabledExplore,
      enabledCookieJar: enabledCookieJar ?? this.enabledCookieJar,
      jsLib: jsLib ?? this.jsLib,
      concurrentRate: concurrentRate ?? this.concurrentRate,
      header: header ?? this.header,
      loginUrl: loginUrl ?? this.loginUrl,
      loginUi: loginUi ?? this.loginUi,
      loginCheckJs: loginCheckJs ?? this.loginCheckJs,
      searchUrl: searchUrl ?? this.searchUrl,
      exploreUrl: exploreUrl ?? this.exploreUrl,
      exploreScreen: exploreScreen ?? this.exploreScreen,
      ruleSearch: ruleSearch ?? this.ruleSearch,
      ruleExplore: ruleExplore ?? this.ruleExplore,
      ruleBookInfo: ruleBookInfo ?? this.ruleBookInfo,
      ruleToc: ruleToc ?? this.ruleToc,
      ruleContent: ruleContent ?? this.ruleContent,
      ruleReview: ruleReview ?? this.ruleReview,
      respondTime: respondTime ?? this.respondTime,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      variable: variable ?? this.variable,
      weight: weight ?? this.weight,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bookSourceUrl.present) {
      map['book_source_url'] = Variable<String>(bookSourceUrl.value);
    }
    if (bookSourceName.present) {
      map['book_source_name'] = Variable<String>(bookSourceName.value);
    }
    if (bookSourceGroup.present) {
      map['book_source_group'] = Variable<String>(bookSourceGroup.value);
    }
    if (bookSourceType.present) {
      map['book_source_type'] = Variable<int>(bookSourceType.value);
    }
    if (bookUrlPattern.present) {
      map['book_url_pattern'] = Variable<String>(bookUrlPattern.value);
    }
    if (customOrder.present) {
      map['custom_order'] = Variable<int>(customOrder.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (enabledExplore.present) {
      map['enabled_explore'] = Variable<bool>(enabledExplore.value);
    }
    if (enabledCookieJar.present) {
      map['enabled_cookie_jar'] = Variable<bool>(enabledCookieJar.value);
    }
    if (jsLib.present) {
      map['js_lib'] = Variable<String>(jsLib.value);
    }
    if (concurrentRate.present) {
      map['concurrent_rate'] = Variable<String>(concurrentRate.value);
    }
    if (header.present) {
      map['header'] = Variable<String>(header.value);
    }
    if (loginUrl.present) {
      map['login_url'] = Variable<String>(loginUrl.value);
    }
    if (loginUi.present) {
      map['login_ui'] = Variable<String>(loginUi.value);
    }
    if (loginCheckJs.present) {
      map['login_check_js'] = Variable<String>(loginCheckJs.value);
    }
    if (searchUrl.present) {
      map['search_url'] = Variable<String>(searchUrl.value);
    }
    if (exploreUrl.present) {
      map['explore_url'] = Variable<String>(exploreUrl.value);
    }
    if (exploreScreen.present) {
      map['explore_screen'] = Variable<String>(exploreScreen.value);
    }
    if (ruleSearch.present) {
      map['rule_search'] = Variable<String>(ruleSearch.value);
    }
    if (ruleExplore.present) {
      map['rule_explore'] = Variable<String>(ruleExplore.value);
    }
    if (ruleBookInfo.present) {
      map['rule_book_info'] = Variable<String>(ruleBookInfo.value);
    }
    if (ruleToc.present) {
      map['rule_toc'] = Variable<String>(ruleToc.value);
    }
    if (ruleContent.present) {
      map['rule_content'] = Variable<String>(ruleContent.value);
    }
    if (ruleReview.present) {
      map['rule_review'] = Variable<String>(ruleReview.value);
    }
    if (respondTime.present) {
      map['respond_time'] = Variable<int>(respondTime.value);
    }
    if (lastUpdateTime.present) {
      map['last_update_time'] = Variable<int>(lastUpdateTime.value);
    }
    if (variable.present) {
      map['variable'] = Variable<String>(variable.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookSourcesCompanion(')
          ..write('bookSourceUrl: $bookSourceUrl, ')
          ..write('bookSourceName: $bookSourceName, ')
          ..write('bookSourceGroup: $bookSourceGroup, ')
          ..write('bookSourceType: $bookSourceType, ')
          ..write('bookUrlPattern: $bookUrlPattern, ')
          ..write('customOrder: $customOrder, ')
          ..write('enabled: $enabled, ')
          ..write('enabledExplore: $enabledExplore, ')
          ..write('enabledCookieJar: $enabledCookieJar, ')
          ..write('jsLib: $jsLib, ')
          ..write('concurrentRate: $concurrentRate, ')
          ..write('header: $header, ')
          ..write('loginUrl: $loginUrl, ')
          ..write('loginUi: $loginUi, ')
          ..write('loginCheckJs: $loginCheckJs, ')
          ..write('searchUrl: $searchUrl, ')
          ..write('exploreUrl: $exploreUrl, ')
          ..write('exploreScreen: $exploreScreen, ')
          ..write('ruleSearch: $ruleSearch, ')
          ..write('ruleExplore: $ruleExplore, ')
          ..write('ruleBookInfo: $ruleBookInfo, ')
          ..write('ruleToc: $ruleToc, ')
          ..write('ruleContent: $ruleContent, ')
          ..write('ruleReview: $ruleReview, ')
          ..write('respondTime: $respondTime, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('variable: $variable, ')
          ..write('weight: $weight, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BooksTable extends Books with TableInfo<$BooksTable, Book> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bookUrlMeta = const VerificationMeta(
    'bookUrl',
  );
  @override
  late final GeneratedColumn<String> bookUrl = GeneratedColumn<String>(
    'book_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tocUrlMeta = const VerificationMeta('tocUrl');
  @override
  late final GeneratedColumn<String> tocUrl = GeneratedColumn<String>(
    'toc_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
    'origin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originNameMeta = const VerificationMeta(
    'originName',
  );
  @override
  late final GeneratedColumn<String> originName = GeneratedColumn<String>(
    'origin_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customTagMeta = const VerificationMeta(
    'customTag',
  );
  @override
  late final GeneratedColumn<String> customTag = GeneratedColumn<String>(
    'custom_tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverUrlMeta = const VerificationMeta(
    'coverUrl',
  );
  @override
  late final GeneratedColumn<String> coverUrl = GeneratedColumn<String>(
    'cover_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customCoverUrlMeta = const VerificationMeta(
    'customCoverUrl',
  );
  @override
  late final GeneratedColumn<String> customCoverUrl = GeneratedColumn<String>(
    'custom_cover_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _introMeta = const VerificationMeta('intro');
  @override
  late final GeneratedColumn<String> intro = GeneratedColumn<String>(
    'intro',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customIntroMeta = const VerificationMeta(
    'customIntro',
  );
  @override
  late final GeneratedColumn<String> customIntro = GeneratedColumn<String>(
    'custom_intro',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _charsetMeta = const VerificationMeta(
    'charset',
  );
  @override
  late final GeneratedColumn<String> charset = GeneratedColumn<String>(
    'charset',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _groupMeta = const VerificationMeta('group');
  @override
  late final GeneratedColumn<int> group = GeneratedColumn<int>(
    'group',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _latestChapterTitleMeta =
      const VerificationMeta('latestChapterTitle');
  @override
  late final GeneratedColumn<String> latestChapterTitle =
      GeneratedColumn<String>(
        'latest_chapter_title',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _latestChapterTimeMeta = const VerificationMeta(
    'latestChapterTime',
  );
  @override
  late final GeneratedColumn<int> latestChapterTime = GeneratedColumn<int>(
    'latest_chapter_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalChapterNumMeta = const VerificationMeta(
    'totalChapterNum',
  );
  @override
  late final GeneratedColumn<int> totalChapterNum = GeneratedColumn<int>(
    'total_chapter_num',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _durChapterIndexMeta = const VerificationMeta(
    'durChapterIndex',
  );
  @override
  late final GeneratedColumn<int> durChapterIndex = GeneratedColumn<int>(
    'dur_chapter_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _durChapterTitleMeta = const VerificationMeta(
    'durChapterTitle',
  );
  @override
  late final GeneratedColumn<String> durChapterTitle = GeneratedColumn<String>(
    'dur_chapter_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durChapterPosMeta = const VerificationMeta(
    'durChapterPos',
  );
  @override
  late final GeneratedColumn<int> durChapterPos = GeneratedColumn<int>(
    'dur_chapter_pos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _durChapterTimeMeta = const VerificationMeta(
    'durChapterTime',
  );
  @override
  late final GeneratedColumn<int> durChapterTime = GeneratedColumn<int>(
    'dur_chapter_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _wordCountMeta = const VerificationMeta(
    'wordCount',
  );
  @override
  late final GeneratedColumn<String> wordCount = GeneratedColumn<String>(
    'word_count',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _canUpdateMeta = const VerificationMeta(
    'canUpdate',
  );
  @override
  late final GeneratedColumn<bool> canUpdate = GeneratedColumn<bool>(
    'can_update',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_update" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _variableMeta = const VerificationMeta(
    'variable',
  );
  @override
  late final GeneratedColumn<String> variable = GeneratedColumn<String>(
    'variable',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _readConfigMeta = const VerificationMeta(
    'readConfig',
  );
  @override
  late final GeneratedColumn<String> readConfig = GeneratedColumn<String>(
    'read_config',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncTimeMeta = const VerificationMeta(
    'syncTime',
  );
  @override
  late final GeneratedColumn<int> syncTime = GeneratedColumn<int>(
    'sync_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localMeta = const VerificationMeta('local');
  @override
  late final GeneratedColumn<bool> local = GeneratedColumn<bool>(
    'local',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("local" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _inBookshelfMeta = const VerificationMeta(
    'inBookshelf',
  );
  @override
  late final GeneratedColumn<bool> inBookshelf = GeneratedColumn<bool>(
    'in_bookshelf',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("in_bookshelf" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    bookUrl,
    tocUrl,
    origin,
    originName,
    name,
    author,
    kind,
    customTag,
    coverUrl,
    customCoverUrl,
    intro,
    customIntro,
    charset,
    type,
    group,
    latestChapterTitle,
    latestChapterTime,
    totalChapterNum,
    durChapterIndex,
    durChapterTitle,
    durChapterPos,
    durChapterTime,
    wordCount,
    canUpdate,
    variable,
    readConfig,
    syncTime,
    local,
    inBookshelf,
    score,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(
    Insertable<Book> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('book_url')) {
      context.handle(
        _bookUrlMeta,
        bookUrl.isAcceptableOrUnknown(data['book_url']!, _bookUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_bookUrlMeta);
    }
    if (data.containsKey('toc_url')) {
      context.handle(
        _tocUrlMeta,
        tocUrl.isAcceptableOrUnknown(data['toc_url']!, _tocUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_tocUrlMeta);
    }
    if (data.containsKey('origin')) {
      context.handle(
        _originMeta,
        origin.isAcceptableOrUnknown(data['origin']!, _originMeta),
      );
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('origin_name')) {
      context.handle(
        _originNameMeta,
        originName.isAcceptableOrUnknown(data['origin_name']!, _originNameMeta),
      );
    } else if (isInserting) {
      context.missing(_originNameMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    }
    if (data.containsKey('custom_tag')) {
      context.handle(
        _customTagMeta,
        customTag.isAcceptableOrUnknown(data['custom_tag']!, _customTagMeta),
      );
    }
    if (data.containsKey('cover_url')) {
      context.handle(
        _coverUrlMeta,
        coverUrl.isAcceptableOrUnknown(data['cover_url']!, _coverUrlMeta),
      );
    }
    if (data.containsKey('custom_cover_url')) {
      context.handle(
        _customCoverUrlMeta,
        customCoverUrl.isAcceptableOrUnknown(
          data['custom_cover_url']!,
          _customCoverUrlMeta,
        ),
      );
    }
    if (data.containsKey('intro')) {
      context.handle(
        _introMeta,
        intro.isAcceptableOrUnknown(data['intro']!, _introMeta),
      );
    }
    if (data.containsKey('custom_intro')) {
      context.handle(
        _customIntroMeta,
        customIntro.isAcceptableOrUnknown(
          data['custom_intro']!,
          _customIntroMeta,
        ),
      );
    }
    if (data.containsKey('charset')) {
      context.handle(
        _charsetMeta,
        charset.isAcceptableOrUnknown(data['charset']!, _charsetMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('group')) {
      context.handle(
        _groupMeta,
        group.isAcceptableOrUnknown(data['group']!, _groupMeta),
      );
    }
    if (data.containsKey('latest_chapter_title')) {
      context.handle(
        _latestChapterTitleMeta,
        latestChapterTitle.isAcceptableOrUnknown(
          data['latest_chapter_title']!,
          _latestChapterTitleMeta,
        ),
      );
    }
    if (data.containsKey('latest_chapter_time')) {
      context.handle(
        _latestChapterTimeMeta,
        latestChapterTime.isAcceptableOrUnknown(
          data['latest_chapter_time']!,
          _latestChapterTimeMeta,
        ),
      );
    }
    if (data.containsKey('total_chapter_num')) {
      context.handle(
        _totalChapterNumMeta,
        totalChapterNum.isAcceptableOrUnknown(
          data['total_chapter_num']!,
          _totalChapterNumMeta,
        ),
      );
    }
    if (data.containsKey('dur_chapter_index')) {
      context.handle(
        _durChapterIndexMeta,
        durChapterIndex.isAcceptableOrUnknown(
          data['dur_chapter_index']!,
          _durChapterIndexMeta,
        ),
      );
    }
    if (data.containsKey('dur_chapter_title')) {
      context.handle(
        _durChapterTitleMeta,
        durChapterTitle.isAcceptableOrUnknown(
          data['dur_chapter_title']!,
          _durChapterTitleMeta,
        ),
      );
    }
    if (data.containsKey('dur_chapter_pos')) {
      context.handle(
        _durChapterPosMeta,
        durChapterPos.isAcceptableOrUnknown(
          data['dur_chapter_pos']!,
          _durChapterPosMeta,
        ),
      );
    }
    if (data.containsKey('dur_chapter_time')) {
      context.handle(
        _durChapterTimeMeta,
        durChapterTime.isAcceptableOrUnknown(
          data['dur_chapter_time']!,
          _durChapterTimeMeta,
        ),
      );
    }
    if (data.containsKey('word_count')) {
      context.handle(
        _wordCountMeta,
        wordCount.isAcceptableOrUnknown(data['word_count']!, _wordCountMeta),
      );
    }
    if (data.containsKey('can_update')) {
      context.handle(
        _canUpdateMeta,
        canUpdate.isAcceptableOrUnknown(data['can_update']!, _canUpdateMeta),
      );
    }
    if (data.containsKey('variable')) {
      context.handle(
        _variableMeta,
        variable.isAcceptableOrUnknown(data['variable']!, _variableMeta),
      );
    }
    if (data.containsKey('read_config')) {
      context.handle(
        _readConfigMeta,
        readConfig.isAcceptableOrUnknown(data['read_config']!, _readConfigMeta),
      );
    }
    if (data.containsKey('sync_time')) {
      context.handle(
        _syncTimeMeta,
        syncTime.isAcceptableOrUnknown(data['sync_time']!, _syncTimeMeta),
      );
    }
    if (data.containsKey('local')) {
      context.handle(
        _localMeta,
        local.isAcceptableOrUnknown(data['local']!, _localMeta),
      );
    }
    if (data.containsKey('in_bookshelf')) {
      context.handle(
        _inBookshelfMeta,
        inBookshelf.isAcceptableOrUnknown(
          data['in_bookshelf']!,
          _inBookshelfMeta,
        ),
      );
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bookUrl};
  @override
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
      bookUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_url'],
      )!,
      tocUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}toc_url'],
      )!,
      origin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin'],
      )!,
      originName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_name'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      ),
      customTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_tag'],
      ),
      coverUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_url'],
      ),
      customCoverUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_cover_url'],
      ),
      intro: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intro'],
      ),
      customIntro: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_intro'],
      ),
      charset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}charset'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type'],
      )!,
      group: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group'],
      )!,
      latestChapterTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}latest_chapter_title'],
      ),
      latestChapterTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}latest_chapter_time'],
      ),
      totalChapterNum: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_chapter_num'],
      )!,
      durChapterIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dur_chapter_index'],
      )!,
      durChapterTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dur_chapter_title'],
      ),
      durChapterPos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dur_chapter_pos'],
      )!,
      durChapterTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dur_chapter_time'],
      )!,
      wordCount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_count'],
      ),
      canUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_update'],
      )!,
      variable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variable'],
      ),
      readConfig: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}read_config'],
      ),
      syncTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_time'],
      ),
      local: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}local'],
      )!,
      inBookshelf: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}in_bookshelf'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class Book extends DataClass implements Insertable<Book> {
  /// 书籍 URL（主键）
  final String bookUrl;

  /// 目录页 URL
  final String tocUrl;

  /// 来源书源 URL
  final String origin;

  /// 来源书源名称
  final String originName;

  /// 书名
  final String name;

  /// 作者
  final String author;

  /// 分类标签
  final String? kind;

  /// 用户自定义标签
  final String? customTag;

  /// 封面 URL
  final String? coverUrl;

  /// 自定义封面 URL
  final String? customCoverUrl;

  /// 简介
  final String? intro;

  /// 自定义简介
  final String? customIntro;

  /// 字符编码
  final String? charset;

  /// 书籍类型
  final int type;

  /// 所属分组
  final int group;

  /// 最新章节标题
  final String? latestChapterTitle;

  /// 最新章节时间
  final int? latestChapterTime;

  /// 总章节数
  final int totalChapterNum;

  /// 当前阅读章节索引
  final int durChapterIndex;

  /// 当前阅读章节标题
  final String? durChapterTitle;

  /// 当前阅读位置
  final int durChapterPos;

  /// 当前阅读时间
  final int durChapterTime;

  /// 字数
  final String? wordCount;

  /// 是否可以更新
  final bool canUpdate;

  /// 变量
  final String? variable;

  /// 阅读配置（JSON）
  final String? readConfig;

  /// 同步时间
  final int? syncTime;

  /// 是否本地书籍
  final bool local;

  /// 是否在书架中
  final bool inBookshelf;

  /// 用户评分（0-5，0 表示未评分）
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
    required this.type,
    required this.group,
    this.latestChapterTitle,
    this.latestChapterTime,
    required this.totalChapterNum,
    required this.durChapterIndex,
    this.durChapterTitle,
    required this.durChapterPos,
    required this.durChapterTime,
    this.wordCount,
    required this.canUpdate,
    this.variable,
    this.readConfig,
    this.syncTime,
    required this.local,
    required this.inBookshelf,
    required this.score,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['book_url'] = Variable<String>(bookUrl);
    map['toc_url'] = Variable<String>(tocUrl);
    map['origin'] = Variable<String>(origin);
    map['origin_name'] = Variable<String>(originName);
    map['name'] = Variable<String>(name);
    map['author'] = Variable<String>(author);
    if (!nullToAbsent || kind != null) {
      map['kind'] = Variable<String>(kind);
    }
    if (!nullToAbsent || customTag != null) {
      map['custom_tag'] = Variable<String>(customTag);
    }
    if (!nullToAbsent || coverUrl != null) {
      map['cover_url'] = Variable<String>(coverUrl);
    }
    if (!nullToAbsent || customCoverUrl != null) {
      map['custom_cover_url'] = Variable<String>(customCoverUrl);
    }
    if (!nullToAbsent || intro != null) {
      map['intro'] = Variable<String>(intro);
    }
    if (!nullToAbsent || customIntro != null) {
      map['custom_intro'] = Variable<String>(customIntro);
    }
    if (!nullToAbsent || charset != null) {
      map['charset'] = Variable<String>(charset);
    }
    map['type'] = Variable<int>(type);
    map['group'] = Variable<int>(group);
    if (!nullToAbsent || latestChapterTitle != null) {
      map['latest_chapter_title'] = Variable<String>(latestChapterTitle);
    }
    if (!nullToAbsent || latestChapterTime != null) {
      map['latest_chapter_time'] = Variable<int>(latestChapterTime);
    }
    map['total_chapter_num'] = Variable<int>(totalChapterNum);
    map['dur_chapter_index'] = Variable<int>(durChapterIndex);
    if (!nullToAbsent || durChapterTitle != null) {
      map['dur_chapter_title'] = Variable<String>(durChapterTitle);
    }
    map['dur_chapter_pos'] = Variable<int>(durChapterPos);
    map['dur_chapter_time'] = Variable<int>(durChapterTime);
    if (!nullToAbsent || wordCount != null) {
      map['word_count'] = Variable<String>(wordCount);
    }
    map['can_update'] = Variable<bool>(canUpdate);
    if (!nullToAbsent || variable != null) {
      map['variable'] = Variable<String>(variable);
    }
    if (!nullToAbsent || readConfig != null) {
      map['read_config'] = Variable<String>(readConfig);
    }
    if (!nullToAbsent || syncTime != null) {
      map['sync_time'] = Variable<int>(syncTime);
    }
    map['local'] = Variable<bool>(local);
    map['in_bookshelf'] = Variable<bool>(inBookshelf);
    map['score'] = Variable<int>(score);
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      bookUrl: Value(bookUrl),
      tocUrl: Value(tocUrl),
      origin: Value(origin),
      originName: Value(originName),
      name: Value(name),
      author: Value(author),
      kind: kind == null && nullToAbsent ? const Value.absent() : Value(kind),
      customTag: customTag == null && nullToAbsent
          ? const Value.absent()
          : Value(customTag),
      coverUrl: coverUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverUrl),
      customCoverUrl: customCoverUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(customCoverUrl),
      intro: intro == null && nullToAbsent
          ? const Value.absent()
          : Value(intro),
      customIntro: customIntro == null && nullToAbsent
          ? const Value.absent()
          : Value(customIntro),
      charset: charset == null && nullToAbsent
          ? const Value.absent()
          : Value(charset),
      type: Value(type),
      group: Value(group),
      latestChapterTitle: latestChapterTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(latestChapterTitle),
      latestChapterTime: latestChapterTime == null && nullToAbsent
          ? const Value.absent()
          : Value(latestChapterTime),
      totalChapterNum: Value(totalChapterNum),
      durChapterIndex: Value(durChapterIndex),
      durChapterTitle: durChapterTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(durChapterTitle),
      durChapterPos: Value(durChapterPos),
      durChapterTime: Value(durChapterTime),
      wordCount: wordCount == null && nullToAbsent
          ? const Value.absent()
          : Value(wordCount),
      canUpdate: Value(canUpdate),
      variable: variable == null && nullToAbsent
          ? const Value.absent()
          : Value(variable),
      readConfig: readConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(readConfig),
      syncTime: syncTime == null && nullToAbsent
          ? const Value.absent()
          : Value(syncTime),
      local: Value(local),
      inBookshelf: Value(inBookshelf),
      score: Value(score),
    );
  }

  factory Book.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
      bookUrl: serializer.fromJson<String>(json['bookUrl']),
      tocUrl: serializer.fromJson<String>(json['tocUrl']),
      origin: serializer.fromJson<String>(json['origin']),
      originName: serializer.fromJson<String>(json['originName']),
      name: serializer.fromJson<String>(json['name']),
      author: serializer.fromJson<String>(json['author']),
      kind: serializer.fromJson<String?>(json['kind']),
      customTag: serializer.fromJson<String?>(json['customTag']),
      coverUrl: serializer.fromJson<String?>(json['coverUrl']),
      customCoverUrl: serializer.fromJson<String?>(json['customCoverUrl']),
      intro: serializer.fromJson<String?>(json['intro']),
      customIntro: serializer.fromJson<String?>(json['customIntro']),
      charset: serializer.fromJson<String?>(json['charset']),
      type: serializer.fromJson<int>(json['type']),
      group: serializer.fromJson<int>(json['group']),
      latestChapterTitle: serializer.fromJson<String?>(
        json['latestChapterTitle'],
      ),
      latestChapterTime: serializer.fromJson<int?>(json['latestChapterTime']),
      totalChapterNum: serializer.fromJson<int>(json['totalChapterNum']),
      durChapterIndex: serializer.fromJson<int>(json['durChapterIndex']),
      durChapterTitle: serializer.fromJson<String?>(json['durChapterTitle']),
      durChapterPos: serializer.fromJson<int>(json['durChapterPos']),
      durChapterTime: serializer.fromJson<int>(json['durChapterTime']),
      wordCount: serializer.fromJson<String?>(json['wordCount']),
      canUpdate: serializer.fromJson<bool>(json['canUpdate']),
      variable: serializer.fromJson<String?>(json['variable']),
      readConfig: serializer.fromJson<String?>(json['readConfig']),
      syncTime: serializer.fromJson<int?>(json['syncTime']),
      local: serializer.fromJson<bool>(json['local']),
      inBookshelf: serializer.fromJson<bool>(json['inBookshelf']),
      score: serializer.fromJson<int>(json['score']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bookUrl': serializer.toJson<String>(bookUrl),
      'tocUrl': serializer.toJson<String>(tocUrl),
      'origin': serializer.toJson<String>(origin),
      'originName': serializer.toJson<String>(originName),
      'name': serializer.toJson<String>(name),
      'author': serializer.toJson<String>(author),
      'kind': serializer.toJson<String?>(kind),
      'customTag': serializer.toJson<String?>(customTag),
      'coverUrl': serializer.toJson<String?>(coverUrl),
      'customCoverUrl': serializer.toJson<String?>(customCoverUrl),
      'intro': serializer.toJson<String?>(intro),
      'customIntro': serializer.toJson<String?>(customIntro),
      'charset': serializer.toJson<String?>(charset),
      'type': serializer.toJson<int>(type),
      'group': serializer.toJson<int>(group),
      'latestChapterTitle': serializer.toJson<String?>(latestChapterTitle),
      'latestChapterTime': serializer.toJson<int?>(latestChapterTime),
      'totalChapterNum': serializer.toJson<int>(totalChapterNum),
      'durChapterIndex': serializer.toJson<int>(durChapterIndex),
      'durChapterTitle': serializer.toJson<String?>(durChapterTitle),
      'durChapterPos': serializer.toJson<int>(durChapterPos),
      'durChapterTime': serializer.toJson<int>(durChapterTime),
      'wordCount': serializer.toJson<String?>(wordCount),
      'canUpdate': serializer.toJson<bool>(canUpdate),
      'variable': serializer.toJson<String?>(variable),
      'readConfig': serializer.toJson<String?>(readConfig),
      'syncTime': serializer.toJson<int?>(syncTime),
      'local': serializer.toJson<bool>(local),
      'inBookshelf': serializer.toJson<bool>(inBookshelf),
      'score': serializer.toJson<int>(score),
    };
  }

  Book copyWith({
    String? bookUrl,
    String? tocUrl,
    String? origin,
    String? originName,
    String? name,
    String? author,
    Value<String?> kind = const Value.absent(),
    Value<String?> customTag = const Value.absent(),
    Value<String?> coverUrl = const Value.absent(),
    Value<String?> customCoverUrl = const Value.absent(),
    Value<String?> intro = const Value.absent(),
    Value<String?> customIntro = const Value.absent(),
    Value<String?> charset = const Value.absent(),
    int? type,
    int? group,
    Value<String?> latestChapterTitle = const Value.absent(),
    Value<int?> latestChapterTime = const Value.absent(),
    int? totalChapterNum,
    int? durChapterIndex,
    Value<String?> durChapterTitle = const Value.absent(),
    int? durChapterPos,
    int? durChapterTime,
    Value<String?> wordCount = const Value.absent(),
    bool? canUpdate,
    Value<String?> variable = const Value.absent(),
    Value<String?> readConfig = const Value.absent(),
    Value<int?> syncTime = const Value.absent(),
    bool? local,
    bool? inBookshelf,
    int? score,
  }) => Book(
    bookUrl: bookUrl ?? this.bookUrl,
    tocUrl: tocUrl ?? this.tocUrl,
    origin: origin ?? this.origin,
    originName: originName ?? this.originName,
    name: name ?? this.name,
    author: author ?? this.author,
    kind: kind.present ? kind.value : this.kind,
    customTag: customTag.present ? customTag.value : this.customTag,
    coverUrl: coverUrl.present ? coverUrl.value : this.coverUrl,
    customCoverUrl: customCoverUrl.present
        ? customCoverUrl.value
        : this.customCoverUrl,
    intro: intro.present ? intro.value : this.intro,
    customIntro: customIntro.present ? customIntro.value : this.customIntro,
    charset: charset.present ? charset.value : this.charset,
    type: type ?? this.type,
    group: group ?? this.group,
    latestChapterTitle: latestChapterTitle.present
        ? latestChapterTitle.value
        : this.latestChapterTitle,
    latestChapterTime: latestChapterTime.present
        ? latestChapterTime.value
        : this.latestChapterTime,
    totalChapterNum: totalChapterNum ?? this.totalChapterNum,
    durChapterIndex: durChapterIndex ?? this.durChapterIndex,
    durChapterTitle: durChapterTitle.present
        ? durChapterTitle.value
        : this.durChapterTitle,
    durChapterPos: durChapterPos ?? this.durChapterPos,
    durChapterTime: durChapterTime ?? this.durChapterTime,
    wordCount: wordCount.present ? wordCount.value : this.wordCount,
    canUpdate: canUpdate ?? this.canUpdate,
    variable: variable.present ? variable.value : this.variable,
    readConfig: readConfig.present ? readConfig.value : this.readConfig,
    syncTime: syncTime.present ? syncTime.value : this.syncTime,
    local: local ?? this.local,
    inBookshelf: inBookshelf ?? this.inBookshelf,
    score: score ?? this.score,
  );
  Book copyWithCompanion(BooksCompanion data) {
    return Book(
      bookUrl: data.bookUrl.present ? data.bookUrl.value : this.bookUrl,
      tocUrl: data.tocUrl.present ? data.tocUrl.value : this.tocUrl,
      origin: data.origin.present ? data.origin.value : this.origin,
      originName: data.originName.present
          ? data.originName.value
          : this.originName,
      name: data.name.present ? data.name.value : this.name,
      author: data.author.present ? data.author.value : this.author,
      kind: data.kind.present ? data.kind.value : this.kind,
      customTag: data.customTag.present ? data.customTag.value : this.customTag,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
      customCoverUrl: data.customCoverUrl.present
          ? data.customCoverUrl.value
          : this.customCoverUrl,
      intro: data.intro.present ? data.intro.value : this.intro,
      customIntro: data.customIntro.present
          ? data.customIntro.value
          : this.customIntro,
      charset: data.charset.present ? data.charset.value : this.charset,
      type: data.type.present ? data.type.value : this.type,
      group: data.group.present ? data.group.value : this.group,
      latestChapterTitle: data.latestChapterTitle.present
          ? data.latestChapterTitle.value
          : this.latestChapterTitle,
      latestChapterTime: data.latestChapterTime.present
          ? data.latestChapterTime.value
          : this.latestChapterTime,
      totalChapterNum: data.totalChapterNum.present
          ? data.totalChapterNum.value
          : this.totalChapterNum,
      durChapterIndex: data.durChapterIndex.present
          ? data.durChapterIndex.value
          : this.durChapterIndex,
      durChapterTitle: data.durChapterTitle.present
          ? data.durChapterTitle.value
          : this.durChapterTitle,
      durChapterPos: data.durChapterPos.present
          ? data.durChapterPos.value
          : this.durChapterPos,
      durChapterTime: data.durChapterTime.present
          ? data.durChapterTime.value
          : this.durChapterTime,
      wordCount: data.wordCount.present ? data.wordCount.value : this.wordCount,
      canUpdate: data.canUpdate.present ? data.canUpdate.value : this.canUpdate,
      variable: data.variable.present ? data.variable.value : this.variable,
      readConfig: data.readConfig.present
          ? data.readConfig.value
          : this.readConfig,
      syncTime: data.syncTime.present ? data.syncTime.value : this.syncTime,
      local: data.local.present ? data.local.value : this.local,
      inBookshelf: data.inBookshelf.present
          ? data.inBookshelf.value
          : this.inBookshelf,
      score: data.score.present ? data.score.value : this.score,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Book(')
          ..write('bookUrl: $bookUrl, ')
          ..write('tocUrl: $tocUrl, ')
          ..write('origin: $origin, ')
          ..write('originName: $originName, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('kind: $kind, ')
          ..write('customTag: $customTag, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('customCoverUrl: $customCoverUrl, ')
          ..write('intro: $intro, ')
          ..write('customIntro: $customIntro, ')
          ..write('charset: $charset, ')
          ..write('type: $type, ')
          ..write('group: $group, ')
          ..write('latestChapterTitle: $latestChapterTitle, ')
          ..write('latestChapterTime: $latestChapterTime, ')
          ..write('totalChapterNum: $totalChapterNum, ')
          ..write('durChapterIndex: $durChapterIndex, ')
          ..write('durChapterTitle: $durChapterTitle, ')
          ..write('durChapterPos: $durChapterPos, ')
          ..write('durChapterTime: $durChapterTime, ')
          ..write('wordCount: $wordCount, ')
          ..write('canUpdate: $canUpdate, ')
          ..write('variable: $variable, ')
          ..write('readConfig: $readConfig, ')
          ..write('syncTime: $syncTime, ')
          ..write('local: $local, ')
          ..write('inBookshelf: $inBookshelf, ')
          ..write('score: $score')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    bookUrl,
    tocUrl,
    origin,
    originName,
    name,
    author,
    kind,
    customTag,
    coverUrl,
    customCoverUrl,
    intro,
    customIntro,
    charset,
    type,
    group,
    latestChapterTitle,
    latestChapterTime,
    totalChapterNum,
    durChapterIndex,
    durChapterTitle,
    durChapterPos,
    durChapterTime,
    wordCount,
    canUpdate,
    variable,
    readConfig,
    syncTime,
    local,
    inBookshelf,
    score,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Book &&
          other.bookUrl == this.bookUrl &&
          other.tocUrl == this.tocUrl &&
          other.origin == this.origin &&
          other.originName == this.originName &&
          other.name == this.name &&
          other.author == this.author &&
          other.kind == this.kind &&
          other.customTag == this.customTag &&
          other.coverUrl == this.coverUrl &&
          other.customCoverUrl == this.customCoverUrl &&
          other.intro == this.intro &&
          other.customIntro == this.customIntro &&
          other.charset == this.charset &&
          other.type == this.type &&
          other.group == this.group &&
          other.latestChapterTitle == this.latestChapterTitle &&
          other.latestChapterTime == this.latestChapterTime &&
          other.totalChapterNum == this.totalChapterNum &&
          other.durChapterIndex == this.durChapterIndex &&
          other.durChapterTitle == this.durChapterTitle &&
          other.durChapterPos == this.durChapterPos &&
          other.durChapterTime == this.durChapterTime &&
          other.wordCount == this.wordCount &&
          other.canUpdate == this.canUpdate &&
          other.variable == this.variable &&
          other.readConfig == this.readConfig &&
          other.syncTime == this.syncTime &&
          other.local == this.local &&
          other.inBookshelf == this.inBookshelf &&
          other.score == this.score);
}

class BooksCompanion extends UpdateCompanion<Book> {
  final Value<String> bookUrl;
  final Value<String> tocUrl;
  final Value<String> origin;
  final Value<String> originName;
  final Value<String> name;
  final Value<String> author;
  final Value<String?> kind;
  final Value<String?> customTag;
  final Value<String?> coverUrl;
  final Value<String?> customCoverUrl;
  final Value<String?> intro;
  final Value<String?> customIntro;
  final Value<String?> charset;
  final Value<int> type;
  final Value<int> group;
  final Value<String?> latestChapterTitle;
  final Value<int?> latestChapterTime;
  final Value<int> totalChapterNum;
  final Value<int> durChapterIndex;
  final Value<String?> durChapterTitle;
  final Value<int> durChapterPos;
  final Value<int> durChapterTime;
  final Value<String?> wordCount;
  final Value<bool> canUpdate;
  final Value<String?> variable;
  final Value<String?> readConfig;
  final Value<int?> syncTime;
  final Value<bool> local;
  final Value<bool> inBookshelf;
  final Value<int> score;
  final Value<int> rowid;
  const BooksCompanion({
    this.bookUrl = const Value.absent(),
    this.tocUrl = const Value.absent(),
    this.origin = const Value.absent(),
    this.originName = const Value.absent(),
    this.name = const Value.absent(),
    this.author = const Value.absent(),
    this.kind = const Value.absent(),
    this.customTag = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.customCoverUrl = const Value.absent(),
    this.intro = const Value.absent(),
    this.customIntro = const Value.absent(),
    this.charset = const Value.absent(),
    this.type = const Value.absent(),
    this.group = const Value.absent(),
    this.latestChapterTitle = const Value.absent(),
    this.latestChapterTime = const Value.absent(),
    this.totalChapterNum = const Value.absent(),
    this.durChapterIndex = const Value.absent(),
    this.durChapterTitle = const Value.absent(),
    this.durChapterPos = const Value.absent(),
    this.durChapterTime = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.canUpdate = const Value.absent(),
    this.variable = const Value.absent(),
    this.readConfig = const Value.absent(),
    this.syncTime = const Value.absent(),
    this.local = const Value.absent(),
    this.inBookshelf = const Value.absent(),
    this.score = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BooksCompanion.insert({
    required String bookUrl,
    required String tocUrl,
    required String origin,
    required String originName,
    required String name,
    required String author,
    this.kind = const Value.absent(),
    this.customTag = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.customCoverUrl = const Value.absent(),
    this.intro = const Value.absent(),
    this.customIntro = const Value.absent(),
    this.charset = const Value.absent(),
    this.type = const Value.absent(),
    this.group = const Value.absent(),
    this.latestChapterTitle = const Value.absent(),
    this.latestChapterTime = const Value.absent(),
    this.totalChapterNum = const Value.absent(),
    this.durChapterIndex = const Value.absent(),
    this.durChapterTitle = const Value.absent(),
    this.durChapterPos = const Value.absent(),
    this.durChapterTime = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.canUpdate = const Value.absent(),
    this.variable = const Value.absent(),
    this.readConfig = const Value.absent(),
    this.syncTime = const Value.absent(),
    this.local = const Value.absent(),
    this.inBookshelf = const Value.absent(),
    this.score = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : bookUrl = Value(bookUrl),
       tocUrl = Value(tocUrl),
       origin = Value(origin),
       originName = Value(originName),
       name = Value(name),
       author = Value(author);
  static Insertable<Book> custom({
    Expression<String>? bookUrl,
    Expression<String>? tocUrl,
    Expression<String>? origin,
    Expression<String>? originName,
    Expression<String>? name,
    Expression<String>? author,
    Expression<String>? kind,
    Expression<String>? customTag,
    Expression<String>? coverUrl,
    Expression<String>? customCoverUrl,
    Expression<String>? intro,
    Expression<String>? customIntro,
    Expression<String>? charset,
    Expression<int>? type,
    Expression<int>? group,
    Expression<String>? latestChapterTitle,
    Expression<int>? latestChapterTime,
    Expression<int>? totalChapterNum,
    Expression<int>? durChapterIndex,
    Expression<String>? durChapterTitle,
    Expression<int>? durChapterPos,
    Expression<int>? durChapterTime,
    Expression<String>? wordCount,
    Expression<bool>? canUpdate,
    Expression<String>? variable,
    Expression<String>? readConfig,
    Expression<int>? syncTime,
    Expression<bool>? local,
    Expression<bool>? inBookshelf,
    Expression<int>? score,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (bookUrl != null) 'book_url': bookUrl,
      if (tocUrl != null) 'toc_url': tocUrl,
      if (origin != null) 'origin': origin,
      if (originName != null) 'origin_name': originName,
      if (name != null) 'name': name,
      if (author != null) 'author': author,
      if (kind != null) 'kind': kind,
      if (customTag != null) 'custom_tag': customTag,
      if (coverUrl != null) 'cover_url': coverUrl,
      if (customCoverUrl != null) 'custom_cover_url': customCoverUrl,
      if (intro != null) 'intro': intro,
      if (customIntro != null) 'custom_intro': customIntro,
      if (charset != null) 'charset': charset,
      if (type != null) 'type': type,
      if (group != null) 'group': group,
      if (latestChapterTitle != null)
        'latest_chapter_title': latestChapterTitle,
      if (latestChapterTime != null) 'latest_chapter_time': latestChapterTime,
      if (totalChapterNum != null) 'total_chapter_num': totalChapterNum,
      if (durChapterIndex != null) 'dur_chapter_index': durChapterIndex,
      if (durChapterTitle != null) 'dur_chapter_title': durChapterTitle,
      if (durChapterPos != null) 'dur_chapter_pos': durChapterPos,
      if (durChapterTime != null) 'dur_chapter_time': durChapterTime,
      if (wordCount != null) 'word_count': wordCount,
      if (canUpdate != null) 'can_update': canUpdate,
      if (variable != null) 'variable': variable,
      if (readConfig != null) 'read_config': readConfig,
      if (syncTime != null) 'sync_time': syncTime,
      if (local != null) 'local': local,
      if (inBookshelf != null) 'in_bookshelf': inBookshelf,
      if (score != null) 'score': score,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BooksCompanion copyWith({
    Value<String>? bookUrl,
    Value<String>? tocUrl,
    Value<String>? origin,
    Value<String>? originName,
    Value<String>? name,
    Value<String>? author,
    Value<String?>? kind,
    Value<String?>? customTag,
    Value<String?>? coverUrl,
    Value<String?>? customCoverUrl,
    Value<String?>? intro,
    Value<String?>? customIntro,
    Value<String?>? charset,
    Value<int>? type,
    Value<int>? group,
    Value<String?>? latestChapterTitle,
    Value<int?>? latestChapterTime,
    Value<int>? totalChapterNum,
    Value<int>? durChapterIndex,
    Value<String?>? durChapterTitle,
    Value<int>? durChapterPos,
    Value<int>? durChapterTime,
    Value<String?>? wordCount,
    Value<bool>? canUpdate,
    Value<String?>? variable,
    Value<String?>? readConfig,
    Value<int?>? syncTime,
    Value<bool>? local,
    Value<bool>? inBookshelf,
    Value<int>? score,
    Value<int>? rowid,
  }) {
    return BooksCompanion(
      bookUrl: bookUrl ?? this.bookUrl,
      tocUrl: tocUrl ?? this.tocUrl,
      origin: origin ?? this.origin,
      originName: originName ?? this.originName,
      name: name ?? this.name,
      author: author ?? this.author,
      kind: kind ?? this.kind,
      customTag: customTag ?? this.customTag,
      coverUrl: coverUrl ?? this.coverUrl,
      customCoverUrl: customCoverUrl ?? this.customCoverUrl,
      intro: intro ?? this.intro,
      customIntro: customIntro ?? this.customIntro,
      charset: charset ?? this.charset,
      type: type ?? this.type,
      group: group ?? this.group,
      latestChapterTitle: latestChapterTitle ?? this.latestChapterTitle,
      latestChapterTime: latestChapterTime ?? this.latestChapterTime,
      totalChapterNum: totalChapterNum ?? this.totalChapterNum,
      durChapterIndex: durChapterIndex ?? this.durChapterIndex,
      durChapterTitle: durChapterTitle ?? this.durChapterTitle,
      durChapterPos: durChapterPos ?? this.durChapterPos,
      durChapterTime: durChapterTime ?? this.durChapterTime,
      wordCount: wordCount ?? this.wordCount,
      canUpdate: canUpdate ?? this.canUpdate,
      variable: variable ?? this.variable,
      readConfig: readConfig ?? this.readConfig,
      syncTime: syncTime ?? this.syncTime,
      local: local ?? this.local,
      inBookshelf: inBookshelf ?? this.inBookshelf,
      score: score ?? this.score,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bookUrl.present) {
      map['book_url'] = Variable<String>(bookUrl.value);
    }
    if (tocUrl.present) {
      map['toc_url'] = Variable<String>(tocUrl.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (originName.present) {
      map['origin_name'] = Variable<String>(originName.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (customTag.present) {
      map['custom_tag'] = Variable<String>(customTag.value);
    }
    if (coverUrl.present) {
      map['cover_url'] = Variable<String>(coverUrl.value);
    }
    if (customCoverUrl.present) {
      map['custom_cover_url'] = Variable<String>(customCoverUrl.value);
    }
    if (intro.present) {
      map['intro'] = Variable<String>(intro.value);
    }
    if (customIntro.present) {
      map['custom_intro'] = Variable<String>(customIntro.value);
    }
    if (charset.present) {
      map['charset'] = Variable<String>(charset.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (group.present) {
      map['group'] = Variable<int>(group.value);
    }
    if (latestChapterTitle.present) {
      map['latest_chapter_title'] = Variable<String>(latestChapterTitle.value);
    }
    if (latestChapterTime.present) {
      map['latest_chapter_time'] = Variable<int>(latestChapterTime.value);
    }
    if (totalChapterNum.present) {
      map['total_chapter_num'] = Variable<int>(totalChapterNum.value);
    }
    if (durChapterIndex.present) {
      map['dur_chapter_index'] = Variable<int>(durChapterIndex.value);
    }
    if (durChapterTitle.present) {
      map['dur_chapter_title'] = Variable<String>(durChapterTitle.value);
    }
    if (durChapterPos.present) {
      map['dur_chapter_pos'] = Variable<int>(durChapterPos.value);
    }
    if (durChapterTime.present) {
      map['dur_chapter_time'] = Variable<int>(durChapterTime.value);
    }
    if (wordCount.present) {
      map['word_count'] = Variable<String>(wordCount.value);
    }
    if (canUpdate.present) {
      map['can_update'] = Variable<bool>(canUpdate.value);
    }
    if (variable.present) {
      map['variable'] = Variable<String>(variable.value);
    }
    if (readConfig.present) {
      map['read_config'] = Variable<String>(readConfig.value);
    }
    if (syncTime.present) {
      map['sync_time'] = Variable<int>(syncTime.value);
    }
    if (local.present) {
      map['local'] = Variable<bool>(local.value);
    }
    if (inBookshelf.present) {
      map['in_bookshelf'] = Variable<bool>(inBookshelf.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('bookUrl: $bookUrl, ')
          ..write('tocUrl: $tocUrl, ')
          ..write('origin: $origin, ')
          ..write('originName: $originName, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('kind: $kind, ')
          ..write('customTag: $customTag, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('customCoverUrl: $customCoverUrl, ')
          ..write('intro: $intro, ')
          ..write('customIntro: $customIntro, ')
          ..write('charset: $charset, ')
          ..write('type: $type, ')
          ..write('group: $group, ')
          ..write('latestChapterTitle: $latestChapterTitle, ')
          ..write('latestChapterTime: $latestChapterTime, ')
          ..write('totalChapterNum: $totalChapterNum, ')
          ..write('durChapterIndex: $durChapterIndex, ')
          ..write('durChapterTitle: $durChapterTitle, ')
          ..write('durChapterPos: $durChapterPos, ')
          ..write('durChapterTime: $durChapterTime, ')
          ..write('wordCount: $wordCount, ')
          ..write('canUpdate: $canUpdate, ')
          ..write('variable: $variable, ')
          ..write('readConfig: $readConfig, ')
          ..write('syncTime: $syncTime, ')
          ..write('local: $local, ')
          ..write('inBookshelf: $inBookshelf, ')
          ..write('score: $score, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookChaptersTable extends BookChapters
    with TableInfo<$BookChaptersTable, BookChapter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookChaptersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookUrlMeta = const VerificationMeta(
    'bookUrl',
  );
  @override
  late final GeneratedColumn<String> bookUrl = GeneratedColumn<String>(
    'book_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterIndexMeta = const VerificationMeta(
    'chapterIndex',
  );
  @override
  late final GeneratedColumn<int> chapterIndex = GeneratedColumn<int>(
    'chapter_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isVolumeMeta = const VerificationMeta(
    'isVolume',
  );
  @override
  late final GeneratedColumn<bool> isVolume = GeneratedColumn<bool>(
    'is_volume',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_volume" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _baseUrlMeta = const VerificationMeta(
    'baseUrl',
  );
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
    'base_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isVipMeta = const VerificationMeta('isVip');
  @override
  late final GeneratedColumn<bool> isVip = GeneratedColumn<bool>(
    'is_vip',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_vip" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isPayMeta = const VerificationMeta('isPay');
  @override
  late final GeneratedColumn<bool> isPay = GeneratedColumn<bool>(
    'is_pay',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pay" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _resourceUrlMeta = const VerificationMeta(
    'resourceUrl',
  );
  @override
  late final GeneratedColumn<String> resourceUrl = GeneratedColumn<String>(
    'resource_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
    'tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wordCountMeta = const VerificationMeta(
    'wordCount',
  );
  @override
  late final GeneratedColumn<String> wordCount = GeneratedColumn<String>(
    'word_count',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<int> start = GeneratedColumn<int>(
    'start',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<int> end = GeneratedColumn<int>(
    'end',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startFragmentIdMeta = const VerificationMeta(
    'startFragmentId',
  );
  @override
  late final GeneratedColumn<String> startFragmentId = GeneratedColumn<String>(
    'start_fragment_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endFragmentIdMeta = const VerificationMeta(
    'endFragmentId',
  );
  @override
  late final GeneratedColumn<String> endFragmentId = GeneratedColumn<String>(
    'end_fragment_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _variableMeta = const VerificationMeta(
    'variable',
  );
  @override
  late final GeneratedColumn<String> variable = GeneratedColumn<String>(
    'variable',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    url,
    bookUrl,
    title,
    chapterIndex,
    isVolume,
    baseUrl,
    isVip,
    isPay,
    resourceUrl,
    tag,
    wordCount,
    start,
    end,
    startFragmentId,
    endFragmentId,
    variable,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'book_chapters';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookChapter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('book_url')) {
      context.handle(
        _bookUrlMeta,
        bookUrl.isAcceptableOrUnknown(data['book_url']!, _bookUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_bookUrlMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('chapter_index')) {
      context.handle(
        _chapterIndexMeta,
        chapterIndex.isAcceptableOrUnknown(
          data['chapter_index']!,
          _chapterIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chapterIndexMeta);
    }
    if (data.containsKey('is_volume')) {
      context.handle(
        _isVolumeMeta,
        isVolume.isAcceptableOrUnknown(data['is_volume']!, _isVolumeMeta),
      );
    }
    if (data.containsKey('base_url')) {
      context.handle(
        _baseUrlMeta,
        baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta),
      );
    }
    if (data.containsKey('is_vip')) {
      context.handle(
        _isVipMeta,
        isVip.isAcceptableOrUnknown(data['is_vip']!, _isVipMeta),
      );
    }
    if (data.containsKey('is_pay')) {
      context.handle(
        _isPayMeta,
        isPay.isAcceptableOrUnknown(data['is_pay']!, _isPayMeta),
      );
    }
    if (data.containsKey('resource_url')) {
      context.handle(
        _resourceUrlMeta,
        resourceUrl.isAcceptableOrUnknown(
          data['resource_url']!,
          _resourceUrlMeta,
        ),
      );
    }
    if (data.containsKey('tag')) {
      context.handle(
        _tagMeta,
        tag.isAcceptableOrUnknown(data['tag']!, _tagMeta),
      );
    }
    if (data.containsKey('word_count')) {
      context.handle(
        _wordCountMeta,
        wordCount.isAcceptableOrUnknown(data['word_count']!, _wordCountMeta),
      );
    }
    if (data.containsKey('start')) {
      context.handle(
        _startMeta,
        start.isAcceptableOrUnknown(data['start']!, _startMeta),
      );
    }
    if (data.containsKey('end')) {
      context.handle(
        _endMeta,
        end.isAcceptableOrUnknown(data['end']!, _endMeta),
      );
    }
    if (data.containsKey('start_fragment_id')) {
      context.handle(
        _startFragmentIdMeta,
        startFragmentId.isAcceptableOrUnknown(
          data['start_fragment_id']!,
          _startFragmentIdMeta,
        ),
      );
    }
    if (data.containsKey('end_fragment_id')) {
      context.handle(
        _endFragmentIdMeta,
        endFragmentId.isAcceptableOrUnknown(
          data['end_fragment_id']!,
          _endFragmentIdMeta,
        ),
      );
    }
    if (data.containsKey('variable')) {
      context.handle(
        _variableMeta,
        variable.isAcceptableOrUnknown(data['variable']!, _variableMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {url, bookUrl};
  @override
  BookChapter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookChapter(
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      bookUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_url'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      chapterIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter_index'],
      )!,
      isVolume: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_volume'],
      )!,
      baseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_url'],
      ),
      isVip: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_vip'],
      )!,
      isPay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pay'],
      )!,
      resourceUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resource_url'],
      ),
      tag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag'],
      ),
      wordCount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_count'],
      ),
      start: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start'],
      ),
      end: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end'],
      ),
      startFragmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_fragment_id'],
      ),
      endFragmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_fragment_id'],
      ),
      variable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variable'],
      ),
    );
  }

  @override
  $BookChaptersTable createAlias(String alias) {
    return $BookChaptersTable(attachedDatabase, alias);
  }
}

class BookChapter extends DataClass implements Insertable<BookChapter> {
  /// 章节 URL
  final String url;

  /// 所属书籍 URL
  final String bookUrl;

  /// 章节标题
  final String title;

  /// 章节索引
  final int chapterIndex;

  /// 是否为卷标
  final bool isVolume;

  /// 基础 URL
  final String? baseUrl;

  /// 是否 VIP
  final bool isVip;

  /// 是否付费
  final bool isPay;

  /// 资源 URL
  final String? resourceUrl;

  /// 标签
  final String? tag;

  /// 字数
  final String? wordCount;

  /// 起始位置（EPUB）
  final int? start;

  /// 结束位置（EPUB）
  final int? end;

  /// 起始片段 ID（EPUB）
  final String? startFragmentId;

  /// 结束片段 ID（EPUB）
  final String? endFragmentId;

  /// 变量
  final String? variable;
  const BookChapter({
    required this.url,
    required this.bookUrl,
    required this.title,
    required this.chapterIndex,
    required this.isVolume,
    this.baseUrl,
    required this.isVip,
    required this.isPay,
    this.resourceUrl,
    this.tag,
    this.wordCount,
    this.start,
    this.end,
    this.startFragmentId,
    this.endFragmentId,
    this.variable,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['url'] = Variable<String>(url);
    map['book_url'] = Variable<String>(bookUrl);
    map['title'] = Variable<String>(title);
    map['chapter_index'] = Variable<int>(chapterIndex);
    map['is_volume'] = Variable<bool>(isVolume);
    if (!nullToAbsent || baseUrl != null) {
      map['base_url'] = Variable<String>(baseUrl);
    }
    map['is_vip'] = Variable<bool>(isVip);
    map['is_pay'] = Variable<bool>(isPay);
    if (!nullToAbsent || resourceUrl != null) {
      map['resource_url'] = Variable<String>(resourceUrl);
    }
    if (!nullToAbsent || tag != null) {
      map['tag'] = Variable<String>(tag);
    }
    if (!nullToAbsent || wordCount != null) {
      map['word_count'] = Variable<String>(wordCount);
    }
    if (!nullToAbsent || start != null) {
      map['start'] = Variable<int>(start);
    }
    if (!nullToAbsent || end != null) {
      map['end'] = Variable<int>(end);
    }
    if (!nullToAbsent || startFragmentId != null) {
      map['start_fragment_id'] = Variable<String>(startFragmentId);
    }
    if (!nullToAbsent || endFragmentId != null) {
      map['end_fragment_id'] = Variable<String>(endFragmentId);
    }
    if (!nullToAbsent || variable != null) {
      map['variable'] = Variable<String>(variable);
    }
    return map;
  }

  BookChaptersCompanion toCompanion(bool nullToAbsent) {
    return BookChaptersCompanion(
      url: Value(url),
      bookUrl: Value(bookUrl),
      title: Value(title),
      chapterIndex: Value(chapterIndex),
      isVolume: Value(isVolume),
      baseUrl: baseUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(baseUrl),
      isVip: Value(isVip),
      isPay: Value(isPay),
      resourceUrl: resourceUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(resourceUrl),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      wordCount: wordCount == null && nullToAbsent
          ? const Value.absent()
          : Value(wordCount),
      start: start == null && nullToAbsent
          ? const Value.absent()
          : Value(start),
      end: end == null && nullToAbsent ? const Value.absent() : Value(end),
      startFragmentId: startFragmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(startFragmentId),
      endFragmentId: endFragmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(endFragmentId),
      variable: variable == null && nullToAbsent
          ? const Value.absent()
          : Value(variable),
    );
  }

  factory BookChapter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookChapter(
      url: serializer.fromJson<String>(json['url']),
      bookUrl: serializer.fromJson<String>(json['bookUrl']),
      title: serializer.fromJson<String>(json['title']),
      chapterIndex: serializer.fromJson<int>(json['chapterIndex']),
      isVolume: serializer.fromJson<bool>(json['isVolume']),
      baseUrl: serializer.fromJson<String?>(json['baseUrl']),
      isVip: serializer.fromJson<bool>(json['isVip']),
      isPay: serializer.fromJson<bool>(json['isPay']),
      resourceUrl: serializer.fromJson<String?>(json['resourceUrl']),
      tag: serializer.fromJson<String?>(json['tag']),
      wordCount: serializer.fromJson<String?>(json['wordCount']),
      start: serializer.fromJson<int?>(json['start']),
      end: serializer.fromJson<int?>(json['end']),
      startFragmentId: serializer.fromJson<String?>(json['startFragmentId']),
      endFragmentId: serializer.fromJson<String?>(json['endFragmentId']),
      variable: serializer.fromJson<String?>(json['variable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'url': serializer.toJson<String>(url),
      'bookUrl': serializer.toJson<String>(bookUrl),
      'title': serializer.toJson<String>(title),
      'chapterIndex': serializer.toJson<int>(chapterIndex),
      'isVolume': serializer.toJson<bool>(isVolume),
      'baseUrl': serializer.toJson<String?>(baseUrl),
      'isVip': serializer.toJson<bool>(isVip),
      'isPay': serializer.toJson<bool>(isPay),
      'resourceUrl': serializer.toJson<String?>(resourceUrl),
      'tag': serializer.toJson<String?>(tag),
      'wordCount': serializer.toJson<String?>(wordCount),
      'start': serializer.toJson<int?>(start),
      'end': serializer.toJson<int?>(end),
      'startFragmentId': serializer.toJson<String?>(startFragmentId),
      'endFragmentId': serializer.toJson<String?>(endFragmentId),
      'variable': serializer.toJson<String?>(variable),
    };
  }

  BookChapter copyWith({
    String? url,
    String? bookUrl,
    String? title,
    int? chapterIndex,
    bool? isVolume,
    Value<String?> baseUrl = const Value.absent(),
    bool? isVip,
    bool? isPay,
    Value<String?> resourceUrl = const Value.absent(),
    Value<String?> tag = const Value.absent(),
    Value<String?> wordCount = const Value.absent(),
    Value<int?> start = const Value.absent(),
    Value<int?> end = const Value.absent(),
    Value<String?> startFragmentId = const Value.absent(),
    Value<String?> endFragmentId = const Value.absent(),
    Value<String?> variable = const Value.absent(),
  }) => BookChapter(
    url: url ?? this.url,
    bookUrl: bookUrl ?? this.bookUrl,
    title: title ?? this.title,
    chapterIndex: chapterIndex ?? this.chapterIndex,
    isVolume: isVolume ?? this.isVolume,
    baseUrl: baseUrl.present ? baseUrl.value : this.baseUrl,
    isVip: isVip ?? this.isVip,
    isPay: isPay ?? this.isPay,
    resourceUrl: resourceUrl.present ? resourceUrl.value : this.resourceUrl,
    tag: tag.present ? tag.value : this.tag,
    wordCount: wordCount.present ? wordCount.value : this.wordCount,
    start: start.present ? start.value : this.start,
    end: end.present ? end.value : this.end,
    startFragmentId: startFragmentId.present
        ? startFragmentId.value
        : this.startFragmentId,
    endFragmentId: endFragmentId.present
        ? endFragmentId.value
        : this.endFragmentId,
    variable: variable.present ? variable.value : this.variable,
  );
  BookChapter copyWithCompanion(BookChaptersCompanion data) {
    return BookChapter(
      url: data.url.present ? data.url.value : this.url,
      bookUrl: data.bookUrl.present ? data.bookUrl.value : this.bookUrl,
      title: data.title.present ? data.title.value : this.title,
      chapterIndex: data.chapterIndex.present
          ? data.chapterIndex.value
          : this.chapterIndex,
      isVolume: data.isVolume.present ? data.isVolume.value : this.isVolume,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
      isVip: data.isVip.present ? data.isVip.value : this.isVip,
      isPay: data.isPay.present ? data.isPay.value : this.isPay,
      resourceUrl: data.resourceUrl.present
          ? data.resourceUrl.value
          : this.resourceUrl,
      tag: data.tag.present ? data.tag.value : this.tag,
      wordCount: data.wordCount.present ? data.wordCount.value : this.wordCount,
      start: data.start.present ? data.start.value : this.start,
      end: data.end.present ? data.end.value : this.end,
      startFragmentId: data.startFragmentId.present
          ? data.startFragmentId.value
          : this.startFragmentId,
      endFragmentId: data.endFragmentId.present
          ? data.endFragmentId.value
          : this.endFragmentId,
      variable: data.variable.present ? data.variable.value : this.variable,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookChapter(')
          ..write('url: $url, ')
          ..write('bookUrl: $bookUrl, ')
          ..write('title: $title, ')
          ..write('chapterIndex: $chapterIndex, ')
          ..write('isVolume: $isVolume, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('isVip: $isVip, ')
          ..write('isPay: $isPay, ')
          ..write('resourceUrl: $resourceUrl, ')
          ..write('tag: $tag, ')
          ..write('wordCount: $wordCount, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('startFragmentId: $startFragmentId, ')
          ..write('endFragmentId: $endFragmentId, ')
          ..write('variable: $variable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    url,
    bookUrl,
    title,
    chapterIndex,
    isVolume,
    baseUrl,
    isVip,
    isPay,
    resourceUrl,
    tag,
    wordCount,
    start,
    end,
    startFragmentId,
    endFragmentId,
    variable,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookChapter &&
          other.url == this.url &&
          other.bookUrl == this.bookUrl &&
          other.title == this.title &&
          other.chapterIndex == this.chapterIndex &&
          other.isVolume == this.isVolume &&
          other.baseUrl == this.baseUrl &&
          other.isVip == this.isVip &&
          other.isPay == this.isPay &&
          other.resourceUrl == this.resourceUrl &&
          other.tag == this.tag &&
          other.wordCount == this.wordCount &&
          other.start == this.start &&
          other.end == this.end &&
          other.startFragmentId == this.startFragmentId &&
          other.endFragmentId == this.endFragmentId &&
          other.variable == this.variable);
}

class BookChaptersCompanion extends UpdateCompanion<BookChapter> {
  final Value<String> url;
  final Value<String> bookUrl;
  final Value<String> title;
  final Value<int> chapterIndex;
  final Value<bool> isVolume;
  final Value<String?> baseUrl;
  final Value<bool> isVip;
  final Value<bool> isPay;
  final Value<String?> resourceUrl;
  final Value<String?> tag;
  final Value<String?> wordCount;
  final Value<int?> start;
  final Value<int?> end;
  final Value<String?> startFragmentId;
  final Value<String?> endFragmentId;
  final Value<String?> variable;
  final Value<int> rowid;
  const BookChaptersCompanion({
    this.url = const Value.absent(),
    this.bookUrl = const Value.absent(),
    this.title = const Value.absent(),
    this.chapterIndex = const Value.absent(),
    this.isVolume = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.isVip = const Value.absent(),
    this.isPay = const Value.absent(),
    this.resourceUrl = const Value.absent(),
    this.tag = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.startFragmentId = const Value.absent(),
    this.endFragmentId = const Value.absent(),
    this.variable = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookChaptersCompanion.insert({
    required String url,
    required String bookUrl,
    required String title,
    required int chapterIndex,
    this.isVolume = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.isVip = const Value.absent(),
    this.isPay = const Value.absent(),
    this.resourceUrl = const Value.absent(),
    this.tag = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.startFragmentId = const Value.absent(),
    this.endFragmentId = const Value.absent(),
    this.variable = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : url = Value(url),
       bookUrl = Value(bookUrl),
       title = Value(title),
       chapterIndex = Value(chapterIndex);
  static Insertable<BookChapter> custom({
    Expression<String>? url,
    Expression<String>? bookUrl,
    Expression<String>? title,
    Expression<int>? chapterIndex,
    Expression<bool>? isVolume,
    Expression<String>? baseUrl,
    Expression<bool>? isVip,
    Expression<bool>? isPay,
    Expression<String>? resourceUrl,
    Expression<String>? tag,
    Expression<String>? wordCount,
    Expression<int>? start,
    Expression<int>? end,
    Expression<String>? startFragmentId,
    Expression<String>? endFragmentId,
    Expression<String>? variable,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (url != null) 'url': url,
      if (bookUrl != null) 'book_url': bookUrl,
      if (title != null) 'title': title,
      if (chapterIndex != null) 'chapter_index': chapterIndex,
      if (isVolume != null) 'is_volume': isVolume,
      if (baseUrl != null) 'base_url': baseUrl,
      if (isVip != null) 'is_vip': isVip,
      if (isPay != null) 'is_pay': isPay,
      if (resourceUrl != null) 'resource_url': resourceUrl,
      if (tag != null) 'tag': tag,
      if (wordCount != null) 'word_count': wordCount,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (startFragmentId != null) 'start_fragment_id': startFragmentId,
      if (endFragmentId != null) 'end_fragment_id': endFragmentId,
      if (variable != null) 'variable': variable,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookChaptersCompanion copyWith({
    Value<String>? url,
    Value<String>? bookUrl,
    Value<String>? title,
    Value<int>? chapterIndex,
    Value<bool>? isVolume,
    Value<String?>? baseUrl,
    Value<bool>? isVip,
    Value<bool>? isPay,
    Value<String?>? resourceUrl,
    Value<String?>? tag,
    Value<String?>? wordCount,
    Value<int?>? start,
    Value<int?>? end,
    Value<String?>? startFragmentId,
    Value<String?>? endFragmentId,
    Value<String?>? variable,
    Value<int>? rowid,
  }) {
    return BookChaptersCompanion(
      url: url ?? this.url,
      bookUrl: bookUrl ?? this.bookUrl,
      title: title ?? this.title,
      chapterIndex: chapterIndex ?? this.chapterIndex,
      isVolume: isVolume ?? this.isVolume,
      baseUrl: baseUrl ?? this.baseUrl,
      isVip: isVip ?? this.isVip,
      isPay: isPay ?? this.isPay,
      resourceUrl: resourceUrl ?? this.resourceUrl,
      tag: tag ?? this.tag,
      wordCount: wordCount ?? this.wordCount,
      start: start ?? this.start,
      end: end ?? this.end,
      startFragmentId: startFragmentId ?? this.startFragmentId,
      endFragmentId: endFragmentId ?? this.endFragmentId,
      variable: variable ?? this.variable,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (bookUrl.present) {
      map['book_url'] = Variable<String>(bookUrl.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (chapterIndex.present) {
      map['chapter_index'] = Variable<int>(chapterIndex.value);
    }
    if (isVolume.present) {
      map['is_volume'] = Variable<bool>(isVolume.value);
    }
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (isVip.present) {
      map['is_vip'] = Variable<bool>(isVip.value);
    }
    if (isPay.present) {
      map['is_pay'] = Variable<bool>(isPay.value);
    }
    if (resourceUrl.present) {
      map['resource_url'] = Variable<String>(resourceUrl.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (wordCount.present) {
      map['word_count'] = Variable<String>(wordCount.value);
    }
    if (start.present) {
      map['start'] = Variable<int>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<int>(end.value);
    }
    if (startFragmentId.present) {
      map['start_fragment_id'] = Variable<String>(startFragmentId.value);
    }
    if (endFragmentId.present) {
      map['end_fragment_id'] = Variable<String>(endFragmentId.value);
    }
    if (variable.present) {
      map['variable'] = Variable<String>(variable.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookChaptersCompanion(')
          ..write('url: $url, ')
          ..write('bookUrl: $bookUrl, ')
          ..write('title: $title, ')
          ..write('chapterIndex: $chapterIndex, ')
          ..write('isVolume: $isVolume, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('isVip: $isVip, ')
          ..write('isPay: $isPay, ')
          ..write('resourceUrl: $resourceUrl, ')
          ..write('tag: $tag, ')
          ..write('wordCount: $wordCount, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('startFragmentId: $startFragmentId, ')
          ..write('endFragmentId: $endFragmentId, ')
          ..write('variable: $variable, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookGroupsTable extends BookGroups
    with TableInfo<$BookGroupsTable, BookGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupNameMeta = const VerificationMeta(
    'groupName',
  );
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
    'group_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _showMeta = const VerificationMeta('show');
  @override
  late final GeneratedColumn<bool> show = GeneratedColumn<bool>(
    'show',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [groupId, groupName, order, show];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'book_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookGroup> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    if (data.containsKey('show')) {
      context.handle(
        _showMeta,
        show.isAcceptableOrUnknown(data['show']!, _showMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {groupId};
  @override
  BookGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookGroup(
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      )!,
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      show: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show'],
      )!,
    );
  }

  @override
  $BookGroupsTable createAlias(String alias) {
    return $BookGroupsTable(attachedDatabase, alias);
  }
}

class BookGroup extends DataClass implements Insertable<BookGroup> {
  final int groupId;
  final String groupName;
  final int order;
  final bool show;
  const BookGroup({
    required this.groupId,
    required this.groupName,
    required this.order,
    required this.show,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['group_id'] = Variable<int>(groupId);
    map['group_name'] = Variable<String>(groupName);
    map['order'] = Variable<int>(order);
    map['show'] = Variable<bool>(show);
    return map;
  }

  BookGroupsCompanion toCompanion(bool nullToAbsent) {
    return BookGroupsCompanion(
      groupId: Value(groupId),
      groupName: Value(groupName),
      order: Value(order),
      show: Value(show),
    );
  }

  factory BookGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookGroup(
      groupId: serializer.fromJson<int>(json['groupId']),
      groupName: serializer.fromJson<String>(json['groupName']),
      order: serializer.fromJson<int>(json['order']),
      show: serializer.fromJson<bool>(json['show']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'groupId': serializer.toJson<int>(groupId),
      'groupName': serializer.toJson<String>(groupName),
      'order': serializer.toJson<int>(order),
      'show': serializer.toJson<bool>(show),
    };
  }

  BookGroup copyWith({
    int? groupId,
    String? groupName,
    int? order,
    bool? show,
  }) => BookGroup(
    groupId: groupId ?? this.groupId,
    groupName: groupName ?? this.groupName,
    order: order ?? this.order,
    show: show ?? this.show,
  );
  BookGroup copyWithCompanion(BookGroupsCompanion data) {
    return BookGroup(
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      order: data.order.present ? data.order.value : this.order,
      show: data.show.present ? data.show.value : this.show,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookGroup(')
          ..write('groupId: $groupId, ')
          ..write('groupName: $groupName, ')
          ..write('order: $order, ')
          ..write('show: $show')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(groupId, groupName, order, show);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookGroup &&
          other.groupId == this.groupId &&
          other.groupName == this.groupName &&
          other.order == this.order &&
          other.show == this.show);
}

class BookGroupsCompanion extends UpdateCompanion<BookGroup> {
  final Value<int> groupId;
  final Value<String> groupName;
  final Value<int> order;
  final Value<bool> show;
  const BookGroupsCompanion({
    this.groupId = const Value.absent(),
    this.groupName = const Value.absent(),
    this.order = const Value.absent(),
    this.show = const Value.absent(),
  });
  BookGroupsCompanion.insert({
    this.groupId = const Value.absent(),
    required String groupName,
    this.order = const Value.absent(),
    this.show = const Value.absent(),
  }) : groupName = Value(groupName);
  static Insertable<BookGroup> custom({
    Expression<int>? groupId,
    Expression<String>? groupName,
    Expression<int>? order,
    Expression<bool>? show,
  }) {
    return RawValuesInsertable({
      if (groupId != null) 'group_id': groupId,
      if (groupName != null) 'group_name': groupName,
      if (order != null) 'order': order,
      if (show != null) 'show': show,
    });
  }

  BookGroupsCompanion copyWith({
    Value<int>? groupId,
    Value<String>? groupName,
    Value<int>? order,
    Value<bool>? show,
  }) {
    return BookGroupsCompanion(
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      order: order ?? this.order,
      show: show ?? this.show,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (show.present) {
      map['show'] = Variable<bool>(show.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookGroupsCompanion(')
          ..write('groupId: $groupId, ')
          ..write('groupName: $groupName, ')
          ..write('order: $order, ')
          ..write('show: $show')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<int> time = GeneratedColumn<int>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bookUrlMeta = const VerificationMeta(
    'bookUrl',
  );
  @override
  late final GeneratedColumn<String> bookUrl = GeneratedColumn<String>(
    'book_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookNameMeta = const VerificationMeta(
    'bookName',
  );
  @override
  late final GeneratedColumn<String> bookName = GeneratedColumn<String>(
    'book_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterIndexMeta = const VerificationMeta(
    'chapterIndex',
  );
  @override
  late final GeneratedColumn<int> chapterIndex = GeneratedColumn<int>(
    'chapter_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterPosMeta = const VerificationMeta(
    'chapterPos',
  );
  @override
  late final GeneratedColumn<int> chapterPos = GeneratedColumn<int>(
    'chapter_pos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookTextMeta = const VerificationMeta(
    'bookText',
  );
  @override
  late final GeneratedColumn<String> bookText = GeneratedColumn<String>(
    'book_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    time,
    bookUrl,
    bookName,
    chapterIndex,
    chapterPos,
    bookText,
    content,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    }
    if (data.containsKey('book_url')) {
      context.handle(
        _bookUrlMeta,
        bookUrl.isAcceptableOrUnknown(data['book_url']!, _bookUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_bookUrlMeta);
    }
    if (data.containsKey('book_name')) {
      context.handle(
        _bookNameMeta,
        bookName.isAcceptableOrUnknown(data['book_name']!, _bookNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bookNameMeta);
    }
    if (data.containsKey('chapter_index')) {
      context.handle(
        _chapterIndexMeta,
        chapterIndex.isAcceptableOrUnknown(
          data['chapter_index']!,
          _chapterIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chapterIndexMeta);
    }
    if (data.containsKey('chapter_pos')) {
      context.handle(
        _chapterPosMeta,
        chapterPos.isAcceptableOrUnknown(data['chapter_pos']!, _chapterPosMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterPosMeta);
    }
    if (data.containsKey('book_text')) {
      context.handle(
        _bookTextMeta,
        bookText.isAcceptableOrUnknown(data['book_text']!, _bookTextMeta),
      );
    } else if (isInserting) {
      context.missing(_bookTextMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {time};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time'],
      )!,
      bookUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_url'],
      )!,
      bookName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_name'],
      )!,
      chapterIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter_index'],
      )!,
      chapterPos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter_pos'],
      )!,
      bookText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_text'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int time;
  final String bookUrl;
  final String bookName;
  final int chapterIndex;
  final int chapterPos;
  final String bookText;
  final String? content;
  const Bookmark({
    required this.time,
    required this.bookUrl,
    required this.bookName,
    required this.chapterIndex,
    required this.chapterPos,
    required this.bookText,
    this.content,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['time'] = Variable<int>(time);
    map['book_url'] = Variable<String>(bookUrl);
    map['book_name'] = Variable<String>(bookName);
    map['chapter_index'] = Variable<int>(chapterIndex);
    map['chapter_pos'] = Variable<int>(chapterPos);
    map['book_text'] = Variable<String>(bookText);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      time: Value(time),
      bookUrl: Value(bookUrl),
      bookName: Value(bookName),
      chapterIndex: Value(chapterIndex),
      chapterPos: Value(chapterPos),
      bookText: Value(bookText),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
    );
  }

  factory Bookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      time: serializer.fromJson<int>(json['time']),
      bookUrl: serializer.fromJson<String>(json['bookUrl']),
      bookName: serializer.fromJson<String>(json['bookName']),
      chapterIndex: serializer.fromJson<int>(json['chapterIndex']),
      chapterPos: serializer.fromJson<int>(json['chapterPos']),
      bookText: serializer.fromJson<String>(json['bookText']),
      content: serializer.fromJson<String?>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'time': serializer.toJson<int>(time),
      'bookUrl': serializer.toJson<String>(bookUrl),
      'bookName': serializer.toJson<String>(bookName),
      'chapterIndex': serializer.toJson<int>(chapterIndex),
      'chapterPos': serializer.toJson<int>(chapterPos),
      'bookText': serializer.toJson<String>(bookText),
      'content': serializer.toJson<String?>(content),
    };
  }

  Bookmark copyWith({
    int? time,
    String? bookUrl,
    String? bookName,
    int? chapterIndex,
    int? chapterPos,
    String? bookText,
    Value<String?> content = const Value.absent(),
  }) => Bookmark(
    time: time ?? this.time,
    bookUrl: bookUrl ?? this.bookUrl,
    bookName: bookName ?? this.bookName,
    chapterIndex: chapterIndex ?? this.chapterIndex,
    chapterPos: chapterPos ?? this.chapterPos,
    bookText: bookText ?? this.bookText,
    content: content.present ? content.value : this.content,
  );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      time: data.time.present ? data.time.value : this.time,
      bookUrl: data.bookUrl.present ? data.bookUrl.value : this.bookUrl,
      bookName: data.bookName.present ? data.bookName.value : this.bookName,
      chapterIndex: data.chapterIndex.present
          ? data.chapterIndex.value
          : this.chapterIndex,
      chapterPos: data.chapterPos.present
          ? data.chapterPos.value
          : this.chapterPos,
      bookText: data.bookText.present ? data.bookText.value : this.bookText,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('time: $time, ')
          ..write('bookUrl: $bookUrl, ')
          ..write('bookName: $bookName, ')
          ..write('chapterIndex: $chapterIndex, ')
          ..write('chapterPos: $chapterPos, ')
          ..write('bookText: $bookText, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    time,
    bookUrl,
    bookName,
    chapterIndex,
    chapterPos,
    bookText,
    content,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.time == this.time &&
          other.bookUrl == this.bookUrl &&
          other.bookName == this.bookName &&
          other.chapterIndex == this.chapterIndex &&
          other.chapterPos == this.chapterPos &&
          other.bookText == this.bookText &&
          other.content == this.content);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> time;
  final Value<String> bookUrl;
  final Value<String> bookName;
  final Value<int> chapterIndex;
  final Value<int> chapterPos;
  final Value<String> bookText;
  final Value<String?> content;
  const BookmarksCompanion({
    this.time = const Value.absent(),
    this.bookUrl = const Value.absent(),
    this.bookName = const Value.absent(),
    this.chapterIndex = const Value.absent(),
    this.chapterPos = const Value.absent(),
    this.bookText = const Value.absent(),
    this.content = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.time = const Value.absent(),
    required String bookUrl,
    required String bookName,
    required int chapterIndex,
    required int chapterPos,
    required String bookText,
    this.content = const Value.absent(),
  }) : bookUrl = Value(bookUrl),
       bookName = Value(bookName),
       chapterIndex = Value(chapterIndex),
       chapterPos = Value(chapterPos),
       bookText = Value(bookText);
  static Insertable<Bookmark> custom({
    Expression<int>? time,
    Expression<String>? bookUrl,
    Expression<String>? bookName,
    Expression<int>? chapterIndex,
    Expression<int>? chapterPos,
    Expression<String>? bookText,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (time != null) 'time': time,
      if (bookUrl != null) 'book_url': bookUrl,
      if (bookName != null) 'book_name': bookName,
      if (chapterIndex != null) 'chapter_index': chapterIndex,
      if (chapterPos != null) 'chapter_pos': chapterPos,
      if (bookText != null) 'book_text': bookText,
      if (content != null) 'content': content,
    });
  }

  BookmarksCompanion copyWith({
    Value<int>? time,
    Value<String>? bookUrl,
    Value<String>? bookName,
    Value<int>? chapterIndex,
    Value<int>? chapterPos,
    Value<String>? bookText,
    Value<String?>? content,
  }) {
    return BookmarksCompanion(
      time: time ?? this.time,
      bookUrl: bookUrl ?? this.bookUrl,
      bookName: bookName ?? this.bookName,
      chapterIndex: chapterIndex ?? this.chapterIndex,
      chapterPos: chapterPos ?? this.chapterPos,
      bookText: bookText ?? this.bookText,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    if (bookUrl.present) {
      map['book_url'] = Variable<String>(bookUrl.value);
    }
    if (bookName.present) {
      map['book_name'] = Variable<String>(bookName.value);
    }
    if (chapterIndex.present) {
      map['chapter_index'] = Variable<int>(chapterIndex.value);
    }
    if (chapterPos.present) {
      map['chapter_pos'] = Variable<int>(chapterPos.value);
    }
    if (bookText.present) {
      map['book_text'] = Variable<String>(bookText.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('time: $time, ')
          ..write('bookUrl: $bookUrl, ')
          ..write('bookName: $bookName, ')
          ..write('chapterIndex: $chapterIndex, ')
          ..write('chapterPos: $chapterPos, ')
          ..write('bookText: $bookText, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $ReplaceRulesTable extends ReplaceRules
    with TableInfo<$ReplaceRulesTable, ReplaceRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReplaceRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _regexMeta = const VerificationMeta('regex');
  @override
  late final GeneratedColumn<String> regex = GeneratedColumn<String>(
    'regex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _replacementMeta = const VerificationMeta(
    'replacement',
  );
  @override
  late final GeneratedColumn<String> replacement = GeneratedColumn<String>(
    'replacement',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupMeta = const VerificationMeta('group');
  @override
  late final GeneratedColumn<String> group = GeneratedColumn<String>(
    'group',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isRegexMeta = const VerificationMeta(
    'isRegex',
  );
  @override
  late final GeneratedColumn<bool> isRegex = GeneratedColumn<bool>(
    'is_regex',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_regex" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _actMeta = const VerificationMeta('act');
  @override
  late final GeneratedColumn<bool> act = GeneratedColumn<bool>(
    'act',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("act" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _exampleMeta = const VerificationMeta(
    'example',
  );
  @override
  late final GeneratedColumn<String> example = GeneratedColumn<String>(
    'example',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    order,
    isEnabled,
    regex,
    replacement,
    scope,
    name,
    group,
    isRegex,
    act,
    example,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'replace_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReplaceRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('regex')) {
      context.handle(
        _regexMeta,
        regex.isAcceptableOrUnknown(data['regex']!, _regexMeta),
      );
    } else if (isInserting) {
      context.missing(_regexMeta);
    }
    if (data.containsKey('replacement')) {
      context.handle(
        _replacementMeta,
        replacement.isAcceptableOrUnknown(
          data['replacement']!,
          _replacementMeta,
        ),
      );
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('group')) {
      context.handle(
        _groupMeta,
        group.isAcceptableOrUnknown(data['group']!, _groupMeta),
      );
    }
    if (data.containsKey('is_regex')) {
      context.handle(
        _isRegexMeta,
        isRegex.isAcceptableOrUnknown(data['is_regex']!, _isRegexMeta),
      );
    }
    if (data.containsKey('act')) {
      context.handle(
        _actMeta,
        act.isAcceptableOrUnknown(data['act']!, _actMeta),
      );
    }
    if (data.containsKey('example')) {
      context.handle(
        _exampleMeta,
        example.isAcceptableOrUnknown(data['example']!, _exampleMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReplaceRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReplaceRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      regex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}regex'],
      )!,
      replacement: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}replacement'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      group: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group'],
      ),
      isRegex: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_regex'],
      )!,
      act: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}act'],
      )!,
      example: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}example'],
      ),
    );
  }

  @override
  $ReplaceRulesTable createAlias(String alias) {
    return $ReplaceRulesTable(attachedDatabase, alias);
  }
}

class ReplaceRule extends DataClass implements Insertable<ReplaceRule> {
  final int id;
  final int order;
  final bool isEnabled;
  final String regex;
  final String replacement;
  final String? scope;
  final String? name;
  final String? group;
  final bool isRegex;
  final bool act;
  final String? example;
  const ReplaceRule({
    required this.id,
    required this.order,
    required this.isEnabled,
    required this.regex,
    required this.replacement,
    this.scope,
    this.name,
    this.group,
    required this.isRegex,
    required this.act,
    this.example,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order'] = Variable<int>(order);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['regex'] = Variable<String>(regex);
    map['replacement'] = Variable<String>(replacement);
    if (!nullToAbsent || scope != null) {
      map['scope'] = Variable<String>(scope);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || group != null) {
      map['group'] = Variable<String>(group);
    }
    map['is_regex'] = Variable<bool>(isRegex);
    map['act'] = Variable<bool>(act);
    if (!nullToAbsent || example != null) {
      map['example'] = Variable<String>(example);
    }
    return map;
  }

  ReplaceRulesCompanion toCompanion(bool nullToAbsent) {
    return ReplaceRulesCompanion(
      id: Value(id),
      order: Value(order),
      isEnabled: Value(isEnabled),
      regex: Value(regex),
      replacement: Value(replacement),
      scope: scope == null && nullToAbsent
          ? const Value.absent()
          : Value(scope),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      group: group == null && nullToAbsent
          ? const Value.absent()
          : Value(group),
      isRegex: Value(isRegex),
      act: Value(act),
      example: example == null && nullToAbsent
          ? const Value.absent()
          : Value(example),
    );
  }

  factory ReplaceRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReplaceRule(
      id: serializer.fromJson<int>(json['id']),
      order: serializer.fromJson<int>(json['order']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      regex: serializer.fromJson<String>(json['regex']),
      replacement: serializer.fromJson<String>(json['replacement']),
      scope: serializer.fromJson<String?>(json['scope']),
      name: serializer.fromJson<String?>(json['name']),
      group: serializer.fromJson<String?>(json['group']),
      isRegex: serializer.fromJson<bool>(json['isRegex']),
      act: serializer.fromJson<bool>(json['act']),
      example: serializer.fromJson<String?>(json['example']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'order': serializer.toJson<int>(order),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'regex': serializer.toJson<String>(regex),
      'replacement': serializer.toJson<String>(replacement),
      'scope': serializer.toJson<String?>(scope),
      'name': serializer.toJson<String?>(name),
      'group': serializer.toJson<String?>(group),
      'isRegex': serializer.toJson<bool>(isRegex),
      'act': serializer.toJson<bool>(act),
      'example': serializer.toJson<String?>(example),
    };
  }

  ReplaceRule copyWith({
    int? id,
    int? order,
    bool? isEnabled,
    String? regex,
    String? replacement,
    Value<String?> scope = const Value.absent(),
    Value<String?> name = const Value.absent(),
    Value<String?> group = const Value.absent(),
    bool? isRegex,
    bool? act,
    Value<String?> example = const Value.absent(),
  }) => ReplaceRule(
    id: id ?? this.id,
    order: order ?? this.order,
    isEnabled: isEnabled ?? this.isEnabled,
    regex: regex ?? this.regex,
    replacement: replacement ?? this.replacement,
    scope: scope.present ? scope.value : this.scope,
    name: name.present ? name.value : this.name,
    group: group.present ? group.value : this.group,
    isRegex: isRegex ?? this.isRegex,
    act: act ?? this.act,
    example: example.present ? example.value : this.example,
  );
  ReplaceRule copyWithCompanion(ReplaceRulesCompanion data) {
    return ReplaceRule(
      id: data.id.present ? data.id.value : this.id,
      order: data.order.present ? data.order.value : this.order,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      regex: data.regex.present ? data.regex.value : this.regex,
      replacement: data.replacement.present
          ? data.replacement.value
          : this.replacement,
      scope: data.scope.present ? data.scope.value : this.scope,
      name: data.name.present ? data.name.value : this.name,
      group: data.group.present ? data.group.value : this.group,
      isRegex: data.isRegex.present ? data.isRegex.value : this.isRegex,
      act: data.act.present ? data.act.value : this.act,
      example: data.example.present ? data.example.value : this.example,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReplaceRule(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('regex: $regex, ')
          ..write('replacement: $replacement, ')
          ..write('scope: $scope, ')
          ..write('name: $name, ')
          ..write('group: $group, ')
          ..write('isRegex: $isRegex, ')
          ..write('act: $act, ')
          ..write('example: $example')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    order,
    isEnabled,
    regex,
    replacement,
    scope,
    name,
    group,
    isRegex,
    act,
    example,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReplaceRule &&
          other.id == this.id &&
          other.order == this.order &&
          other.isEnabled == this.isEnabled &&
          other.regex == this.regex &&
          other.replacement == this.replacement &&
          other.scope == this.scope &&
          other.name == this.name &&
          other.group == this.group &&
          other.isRegex == this.isRegex &&
          other.act == this.act &&
          other.example == this.example);
}

class ReplaceRulesCompanion extends UpdateCompanion<ReplaceRule> {
  final Value<int> id;
  final Value<int> order;
  final Value<bool> isEnabled;
  final Value<String> regex;
  final Value<String> replacement;
  final Value<String?> scope;
  final Value<String?> name;
  final Value<String?> group;
  final Value<bool> isRegex;
  final Value<bool> act;
  final Value<String?> example;
  const ReplaceRulesCompanion({
    this.id = const Value.absent(),
    this.order = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.regex = const Value.absent(),
    this.replacement = const Value.absent(),
    this.scope = const Value.absent(),
    this.name = const Value.absent(),
    this.group = const Value.absent(),
    this.isRegex = const Value.absent(),
    this.act = const Value.absent(),
    this.example = const Value.absent(),
  });
  ReplaceRulesCompanion.insert({
    this.id = const Value.absent(),
    this.order = const Value.absent(),
    this.isEnabled = const Value.absent(),
    required String regex,
    this.replacement = const Value.absent(),
    this.scope = const Value.absent(),
    this.name = const Value.absent(),
    this.group = const Value.absent(),
    this.isRegex = const Value.absent(),
    this.act = const Value.absent(),
    this.example = const Value.absent(),
  }) : regex = Value(regex);
  static Insertable<ReplaceRule> custom({
    Expression<int>? id,
    Expression<int>? order,
    Expression<bool>? isEnabled,
    Expression<String>? regex,
    Expression<String>? replacement,
    Expression<String>? scope,
    Expression<String>? name,
    Expression<String>? group,
    Expression<bool>? isRegex,
    Expression<bool>? act,
    Expression<String>? example,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (order != null) 'order': order,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (regex != null) 'regex': regex,
      if (replacement != null) 'replacement': replacement,
      if (scope != null) 'scope': scope,
      if (name != null) 'name': name,
      if (group != null) 'group': group,
      if (isRegex != null) 'is_regex': isRegex,
      if (act != null) 'act': act,
      if (example != null) 'example': example,
    });
  }

  ReplaceRulesCompanion copyWith({
    Value<int>? id,
    Value<int>? order,
    Value<bool>? isEnabled,
    Value<String>? regex,
    Value<String>? replacement,
    Value<String?>? scope,
    Value<String?>? name,
    Value<String?>? group,
    Value<bool>? isRegex,
    Value<bool>? act,
    Value<String?>? example,
  }) {
    return ReplaceRulesCompanion(
      id: id ?? this.id,
      order: order ?? this.order,
      isEnabled: isEnabled ?? this.isEnabled,
      regex: regex ?? this.regex,
      replacement: replacement ?? this.replacement,
      scope: scope ?? this.scope,
      name: name ?? this.name,
      group: group ?? this.group,
      isRegex: isRegex ?? this.isRegex,
      act: act ?? this.act,
      example: example ?? this.example,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (regex.present) {
      map['regex'] = Variable<String>(regex.value);
    }
    if (replacement.present) {
      map['replacement'] = Variable<String>(replacement.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (group.present) {
      map['group'] = Variable<String>(group.value);
    }
    if (isRegex.present) {
      map['is_regex'] = Variable<bool>(isRegex.value);
    }
    if (act.present) {
      map['act'] = Variable<bool>(act.value);
    }
    if (example.present) {
      map['example'] = Variable<String>(example.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReplaceRulesCompanion(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('regex: $regex, ')
          ..write('replacement: $replacement, ')
          ..write('scope: $scope, ')
          ..write('name: $name, ')
          ..write('group: $group, ')
          ..write('isRegex: $isRegex, ')
          ..write('act: $act, ')
          ..write('example: $example')
          ..write(')'))
        .toString();
  }
}

class $SearchBooksTable extends SearchBooks
    with TableInfo<$SearchBooksTable, SearchBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchBooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bookUrlMeta = const VerificationMeta(
    'bookUrl',
  );
  @override
  late final GeneratedColumn<String> bookUrl = GeneratedColumn<String>(
    'book_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
    'origin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originNameMeta = const VerificationMeta(
    'originName',
  );
  @override
  late final GeneratedColumn<String> originName = GeneratedColumn<String>(
    'origin_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverUrlMeta = const VerificationMeta(
    'coverUrl',
  );
  @override
  late final GeneratedColumn<String> coverUrl = GeneratedColumn<String>(
    'cover_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _introMeta = const VerificationMeta('intro');
  @override
  late final GeneratedColumn<String> intro = GeneratedColumn<String>(
    'intro',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wordCountMeta = const VerificationMeta(
    'wordCount',
  );
  @override
  late final GeneratedColumn<String> wordCount = GeneratedColumn<String>(
    'word_count',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latestChapterMeta = const VerificationMeta(
    'latestChapter',
  );
  @override
  late final GeneratedColumn<String> latestChapter = GeneratedColumn<String>(
    'latest_chapter',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updateTimeMeta = const VerificationMeta(
    'updateTime',
  );
  @override
  late final GeneratedColumn<String> updateTime = GeneratedColumn<String>(
    'update_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _searchTimeMeta = const VerificationMeta(
    'searchTime',
  );
  @override
  late final GeneratedColumn<int> searchTime = GeneratedColumn<int>(
    'search_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _variableMeta = const VerificationMeta(
    'variable',
  );
  @override
  late final GeneratedColumn<String> variable = GeneratedColumn<String>(
    'variable',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originOrderMeta = const VerificationMeta(
    'originOrder',
  );
  @override
  late final GeneratedColumn<int> originOrder = GeneratedColumn<int>(
    'origin_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    bookUrl,
    origin,
    originName,
    name,
    author,
    kind,
    coverUrl,
    intro,
    wordCount,
    latestChapter,
    updateTime,
    searchTime,
    variable,
    originOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_books';
  @override
  VerificationContext validateIntegrity(
    Insertable<SearchBook> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('book_url')) {
      context.handle(
        _bookUrlMeta,
        bookUrl.isAcceptableOrUnknown(data['book_url']!, _bookUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_bookUrlMeta);
    }
    if (data.containsKey('origin')) {
      context.handle(
        _originMeta,
        origin.isAcceptableOrUnknown(data['origin']!, _originMeta),
      );
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('origin_name')) {
      context.handle(
        _originNameMeta,
        originName.isAcceptableOrUnknown(data['origin_name']!, _originNameMeta),
      );
    } else if (isInserting) {
      context.missing(_originNameMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    }
    if (data.containsKey('cover_url')) {
      context.handle(
        _coverUrlMeta,
        coverUrl.isAcceptableOrUnknown(data['cover_url']!, _coverUrlMeta),
      );
    }
    if (data.containsKey('intro')) {
      context.handle(
        _introMeta,
        intro.isAcceptableOrUnknown(data['intro']!, _introMeta),
      );
    }
    if (data.containsKey('word_count')) {
      context.handle(
        _wordCountMeta,
        wordCount.isAcceptableOrUnknown(data['word_count']!, _wordCountMeta),
      );
    }
    if (data.containsKey('latest_chapter')) {
      context.handle(
        _latestChapterMeta,
        latestChapter.isAcceptableOrUnknown(
          data['latest_chapter']!,
          _latestChapterMeta,
        ),
      );
    }
    if (data.containsKey('update_time')) {
      context.handle(
        _updateTimeMeta,
        updateTime.isAcceptableOrUnknown(data['update_time']!, _updateTimeMeta),
      );
    }
    if (data.containsKey('search_time')) {
      context.handle(
        _searchTimeMeta,
        searchTime.isAcceptableOrUnknown(data['search_time']!, _searchTimeMeta),
      );
    }
    if (data.containsKey('variable')) {
      context.handle(
        _variableMeta,
        variable.isAcceptableOrUnknown(data['variable']!, _variableMeta),
      );
    }
    if (data.containsKey('origin_order')) {
      context.handle(
        _originOrderMeta,
        originOrder.isAcceptableOrUnknown(
          data['origin_order']!,
          _originOrderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bookUrl, origin};
  @override
  SearchBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchBook(
      bookUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_url'],
      )!,
      origin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin'],
      )!,
      originName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_name'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      ),
      coverUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_url'],
      ),
      intro: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intro'],
      ),
      wordCount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_count'],
      ),
      latestChapter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}latest_chapter'],
      ),
      updateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}update_time'],
      ),
      searchTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}search_time'],
      ),
      variable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variable'],
      ),
      originOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}origin_order'],
      )!,
    );
  }

  @override
  $SearchBooksTable createAlias(String alias) {
    return $SearchBooksTable(attachedDatabase, alias);
  }
}

class SearchBook extends DataClass implements Insertable<SearchBook> {
  final String bookUrl;
  final String origin;
  final String originName;
  final String name;
  final String author;
  final String? kind;
  final String? coverUrl;
  final String? intro;
  final String? wordCount;
  final String? latestChapter;
  final String? updateTime;
  final int? searchTime;
  final String? variable;
  final int originOrder;
  const SearchBook({
    required this.bookUrl,
    required this.origin,
    required this.originName,
    required this.name,
    required this.author,
    this.kind,
    this.coverUrl,
    this.intro,
    this.wordCount,
    this.latestChapter,
    this.updateTime,
    this.searchTime,
    this.variable,
    required this.originOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['book_url'] = Variable<String>(bookUrl);
    map['origin'] = Variable<String>(origin);
    map['origin_name'] = Variable<String>(originName);
    map['name'] = Variable<String>(name);
    map['author'] = Variable<String>(author);
    if (!nullToAbsent || kind != null) {
      map['kind'] = Variable<String>(kind);
    }
    if (!nullToAbsent || coverUrl != null) {
      map['cover_url'] = Variable<String>(coverUrl);
    }
    if (!nullToAbsent || intro != null) {
      map['intro'] = Variable<String>(intro);
    }
    if (!nullToAbsent || wordCount != null) {
      map['word_count'] = Variable<String>(wordCount);
    }
    if (!nullToAbsent || latestChapter != null) {
      map['latest_chapter'] = Variable<String>(latestChapter);
    }
    if (!nullToAbsent || updateTime != null) {
      map['update_time'] = Variable<String>(updateTime);
    }
    if (!nullToAbsent || searchTime != null) {
      map['search_time'] = Variable<int>(searchTime);
    }
    if (!nullToAbsent || variable != null) {
      map['variable'] = Variable<String>(variable);
    }
    map['origin_order'] = Variable<int>(originOrder);
    return map;
  }

  SearchBooksCompanion toCompanion(bool nullToAbsent) {
    return SearchBooksCompanion(
      bookUrl: Value(bookUrl),
      origin: Value(origin),
      originName: Value(originName),
      name: Value(name),
      author: Value(author),
      kind: kind == null && nullToAbsent ? const Value.absent() : Value(kind),
      coverUrl: coverUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverUrl),
      intro: intro == null && nullToAbsent
          ? const Value.absent()
          : Value(intro),
      wordCount: wordCount == null && nullToAbsent
          ? const Value.absent()
          : Value(wordCount),
      latestChapter: latestChapter == null && nullToAbsent
          ? const Value.absent()
          : Value(latestChapter),
      updateTime: updateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(updateTime),
      searchTime: searchTime == null && nullToAbsent
          ? const Value.absent()
          : Value(searchTime),
      variable: variable == null && nullToAbsent
          ? const Value.absent()
          : Value(variable),
      originOrder: Value(originOrder),
    );
  }

  factory SearchBook.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchBook(
      bookUrl: serializer.fromJson<String>(json['bookUrl']),
      origin: serializer.fromJson<String>(json['origin']),
      originName: serializer.fromJson<String>(json['originName']),
      name: serializer.fromJson<String>(json['name']),
      author: serializer.fromJson<String>(json['author']),
      kind: serializer.fromJson<String?>(json['kind']),
      coverUrl: serializer.fromJson<String?>(json['coverUrl']),
      intro: serializer.fromJson<String?>(json['intro']),
      wordCount: serializer.fromJson<String?>(json['wordCount']),
      latestChapter: serializer.fromJson<String?>(json['latestChapter']),
      updateTime: serializer.fromJson<String?>(json['updateTime']),
      searchTime: serializer.fromJson<int?>(json['searchTime']),
      variable: serializer.fromJson<String?>(json['variable']),
      originOrder: serializer.fromJson<int>(json['originOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bookUrl': serializer.toJson<String>(bookUrl),
      'origin': serializer.toJson<String>(origin),
      'originName': serializer.toJson<String>(originName),
      'name': serializer.toJson<String>(name),
      'author': serializer.toJson<String>(author),
      'kind': serializer.toJson<String?>(kind),
      'coverUrl': serializer.toJson<String?>(coverUrl),
      'intro': serializer.toJson<String?>(intro),
      'wordCount': serializer.toJson<String?>(wordCount),
      'latestChapter': serializer.toJson<String?>(latestChapter),
      'updateTime': serializer.toJson<String?>(updateTime),
      'searchTime': serializer.toJson<int?>(searchTime),
      'variable': serializer.toJson<String?>(variable),
      'originOrder': serializer.toJson<int>(originOrder),
    };
  }

  SearchBook copyWith({
    String? bookUrl,
    String? origin,
    String? originName,
    String? name,
    String? author,
    Value<String?> kind = const Value.absent(),
    Value<String?> coverUrl = const Value.absent(),
    Value<String?> intro = const Value.absent(),
    Value<String?> wordCount = const Value.absent(),
    Value<String?> latestChapter = const Value.absent(),
    Value<String?> updateTime = const Value.absent(),
    Value<int?> searchTime = const Value.absent(),
    Value<String?> variable = const Value.absent(),
    int? originOrder,
  }) => SearchBook(
    bookUrl: bookUrl ?? this.bookUrl,
    origin: origin ?? this.origin,
    originName: originName ?? this.originName,
    name: name ?? this.name,
    author: author ?? this.author,
    kind: kind.present ? kind.value : this.kind,
    coverUrl: coverUrl.present ? coverUrl.value : this.coverUrl,
    intro: intro.present ? intro.value : this.intro,
    wordCount: wordCount.present ? wordCount.value : this.wordCount,
    latestChapter: latestChapter.present
        ? latestChapter.value
        : this.latestChapter,
    updateTime: updateTime.present ? updateTime.value : this.updateTime,
    searchTime: searchTime.present ? searchTime.value : this.searchTime,
    variable: variable.present ? variable.value : this.variable,
    originOrder: originOrder ?? this.originOrder,
  );
  SearchBook copyWithCompanion(SearchBooksCompanion data) {
    return SearchBook(
      bookUrl: data.bookUrl.present ? data.bookUrl.value : this.bookUrl,
      origin: data.origin.present ? data.origin.value : this.origin,
      originName: data.originName.present
          ? data.originName.value
          : this.originName,
      name: data.name.present ? data.name.value : this.name,
      author: data.author.present ? data.author.value : this.author,
      kind: data.kind.present ? data.kind.value : this.kind,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
      intro: data.intro.present ? data.intro.value : this.intro,
      wordCount: data.wordCount.present ? data.wordCount.value : this.wordCount,
      latestChapter: data.latestChapter.present
          ? data.latestChapter.value
          : this.latestChapter,
      updateTime: data.updateTime.present
          ? data.updateTime.value
          : this.updateTime,
      searchTime: data.searchTime.present
          ? data.searchTime.value
          : this.searchTime,
      variable: data.variable.present ? data.variable.value : this.variable,
      originOrder: data.originOrder.present
          ? data.originOrder.value
          : this.originOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchBook(')
          ..write('bookUrl: $bookUrl, ')
          ..write('origin: $origin, ')
          ..write('originName: $originName, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('kind: $kind, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('intro: $intro, ')
          ..write('wordCount: $wordCount, ')
          ..write('latestChapter: $latestChapter, ')
          ..write('updateTime: $updateTime, ')
          ..write('searchTime: $searchTime, ')
          ..write('variable: $variable, ')
          ..write('originOrder: $originOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    bookUrl,
    origin,
    originName,
    name,
    author,
    kind,
    coverUrl,
    intro,
    wordCount,
    latestChapter,
    updateTime,
    searchTime,
    variable,
    originOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchBook &&
          other.bookUrl == this.bookUrl &&
          other.origin == this.origin &&
          other.originName == this.originName &&
          other.name == this.name &&
          other.author == this.author &&
          other.kind == this.kind &&
          other.coverUrl == this.coverUrl &&
          other.intro == this.intro &&
          other.wordCount == this.wordCount &&
          other.latestChapter == this.latestChapter &&
          other.updateTime == this.updateTime &&
          other.searchTime == this.searchTime &&
          other.variable == this.variable &&
          other.originOrder == this.originOrder);
}

class SearchBooksCompanion extends UpdateCompanion<SearchBook> {
  final Value<String> bookUrl;
  final Value<String> origin;
  final Value<String> originName;
  final Value<String> name;
  final Value<String> author;
  final Value<String?> kind;
  final Value<String?> coverUrl;
  final Value<String?> intro;
  final Value<String?> wordCount;
  final Value<String?> latestChapter;
  final Value<String?> updateTime;
  final Value<int?> searchTime;
  final Value<String?> variable;
  final Value<int> originOrder;
  final Value<int> rowid;
  const SearchBooksCompanion({
    this.bookUrl = const Value.absent(),
    this.origin = const Value.absent(),
    this.originName = const Value.absent(),
    this.name = const Value.absent(),
    this.author = const Value.absent(),
    this.kind = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.intro = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.latestChapter = const Value.absent(),
    this.updateTime = const Value.absent(),
    this.searchTime = const Value.absent(),
    this.variable = const Value.absent(),
    this.originOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SearchBooksCompanion.insert({
    required String bookUrl,
    required String origin,
    required String originName,
    required String name,
    required String author,
    this.kind = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.intro = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.latestChapter = const Value.absent(),
    this.updateTime = const Value.absent(),
    this.searchTime = const Value.absent(),
    this.variable = const Value.absent(),
    this.originOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : bookUrl = Value(bookUrl),
       origin = Value(origin),
       originName = Value(originName),
       name = Value(name),
       author = Value(author);
  static Insertable<SearchBook> custom({
    Expression<String>? bookUrl,
    Expression<String>? origin,
    Expression<String>? originName,
    Expression<String>? name,
    Expression<String>? author,
    Expression<String>? kind,
    Expression<String>? coverUrl,
    Expression<String>? intro,
    Expression<String>? wordCount,
    Expression<String>? latestChapter,
    Expression<String>? updateTime,
    Expression<int>? searchTime,
    Expression<String>? variable,
    Expression<int>? originOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (bookUrl != null) 'book_url': bookUrl,
      if (origin != null) 'origin': origin,
      if (originName != null) 'origin_name': originName,
      if (name != null) 'name': name,
      if (author != null) 'author': author,
      if (kind != null) 'kind': kind,
      if (coverUrl != null) 'cover_url': coverUrl,
      if (intro != null) 'intro': intro,
      if (wordCount != null) 'word_count': wordCount,
      if (latestChapter != null) 'latest_chapter': latestChapter,
      if (updateTime != null) 'update_time': updateTime,
      if (searchTime != null) 'search_time': searchTime,
      if (variable != null) 'variable': variable,
      if (originOrder != null) 'origin_order': originOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SearchBooksCompanion copyWith({
    Value<String>? bookUrl,
    Value<String>? origin,
    Value<String>? originName,
    Value<String>? name,
    Value<String>? author,
    Value<String?>? kind,
    Value<String?>? coverUrl,
    Value<String?>? intro,
    Value<String?>? wordCount,
    Value<String?>? latestChapter,
    Value<String?>? updateTime,
    Value<int?>? searchTime,
    Value<String?>? variable,
    Value<int>? originOrder,
    Value<int>? rowid,
  }) {
    return SearchBooksCompanion(
      bookUrl: bookUrl ?? this.bookUrl,
      origin: origin ?? this.origin,
      originName: originName ?? this.originName,
      name: name ?? this.name,
      author: author ?? this.author,
      kind: kind ?? this.kind,
      coverUrl: coverUrl ?? this.coverUrl,
      intro: intro ?? this.intro,
      wordCount: wordCount ?? this.wordCount,
      latestChapter: latestChapter ?? this.latestChapter,
      updateTime: updateTime ?? this.updateTime,
      searchTime: searchTime ?? this.searchTime,
      variable: variable ?? this.variable,
      originOrder: originOrder ?? this.originOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bookUrl.present) {
      map['book_url'] = Variable<String>(bookUrl.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (originName.present) {
      map['origin_name'] = Variable<String>(originName.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (coverUrl.present) {
      map['cover_url'] = Variable<String>(coverUrl.value);
    }
    if (intro.present) {
      map['intro'] = Variable<String>(intro.value);
    }
    if (wordCount.present) {
      map['word_count'] = Variable<String>(wordCount.value);
    }
    if (latestChapter.present) {
      map['latest_chapter'] = Variable<String>(latestChapter.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<String>(updateTime.value);
    }
    if (searchTime.present) {
      map['search_time'] = Variable<int>(searchTime.value);
    }
    if (variable.present) {
      map['variable'] = Variable<String>(variable.value);
    }
    if (originOrder.present) {
      map['origin_order'] = Variable<int>(originOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchBooksCompanion(')
          ..write('bookUrl: $bookUrl, ')
          ..write('origin: $origin, ')
          ..write('originName: $originName, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('kind: $kind, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('intro: $intro, ')
          ..write('wordCount: $wordCount, ')
          ..write('latestChapter: $latestChapter, ')
          ..write('updateTime: $updateTime, ')
          ..write('searchTime: $searchTime, ')
          ..write('variable: $variable, ')
          ..write('originOrder: $originOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RssSourcesTable extends RssSources
    with TableInfo<$RssSourcesTable, RssSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RssSourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sourceUrlMeta = const VerificationMeta(
    'sourceUrl',
  );
  @override
  late final GeneratedColumn<String> sourceUrl = GeneratedColumn<String>(
    'source_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceNameMeta = const VerificationMeta(
    'sourceName',
  );
  @override
  late final GeneratedColumn<String> sourceName = GeneratedColumn<String>(
    'source_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIconMeta = const VerificationMeta(
    'sourceIcon',
  );
  @override
  late final GeneratedColumn<String> sourceIcon = GeneratedColumn<String>(
    'source_icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceGroupMeta = const VerificationMeta(
    'sourceGroup',
  );
  @override
  late final GeneratedColumn<String> sourceGroup = GeneratedColumn<String>(
    'source_group',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customOrderMeta = const VerificationMeta(
    'customOrder',
  );
  @override
  late final GeneratedColumn<int> customOrder = GeneratedColumn<int>(
    'custom_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _enabledCookieJarMeta = const VerificationMeta(
    'enabledCookieJar',
  );
  @override
  late final GeneratedColumn<bool> enabledCookieJar = GeneratedColumn<bool>(
    'enabled_cookie_jar',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled_cookie_jar" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _concurrentRateMeta = const VerificationMeta(
    'concurrentRate',
  );
  @override
  late final GeneratedColumn<String> concurrentRate = GeneratedColumn<String>(
    'concurrent_rate',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _headerMeta = const VerificationMeta('header');
  @override
  late final GeneratedColumn<String> header = GeneratedColumn<String>(
    'header',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loginUrlMeta = const VerificationMeta(
    'loginUrl',
  );
  @override
  late final GeneratedColumn<String> loginUrl = GeneratedColumn<String>(
    'login_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loginUiMeta = const VerificationMeta(
    'loginUi',
  );
  @override
  late final GeneratedColumn<String> loginUi = GeneratedColumn<String>(
    'login_ui',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loginCheckJsMeta = const VerificationMeta(
    'loginCheckJs',
  );
  @override
  late final GeneratedColumn<String> loginCheckJs = GeneratedColumn<String>(
    'login_check_js',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleArticlesMeta = const VerificationMeta(
    'ruleArticles',
  );
  @override
  late final GeneratedColumn<String> ruleArticles = GeneratedColumn<String>(
    'rule_articles',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleNextPageMeta = const VerificationMeta(
    'ruleNextPage',
  );
  @override
  late final GeneratedColumn<String> ruleNextPage = GeneratedColumn<String>(
    'rule_next_page',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleTitleMeta = const VerificationMeta(
    'ruleTitle',
  );
  @override
  late final GeneratedColumn<String> ruleTitle = GeneratedColumn<String>(
    'rule_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rulePubDateMeta = const VerificationMeta(
    'rulePubDate',
  );
  @override
  late final GeneratedColumn<String> rulePubDate = GeneratedColumn<String>(
    'rule_pub_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleDescriptionMeta = const VerificationMeta(
    'ruleDescription',
  );
  @override
  late final GeneratedColumn<String> ruleDescription = GeneratedColumn<String>(
    'rule_description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleImageMeta = const VerificationMeta(
    'ruleImage',
  );
  @override
  late final GeneratedColumn<String> ruleImage = GeneratedColumn<String>(
    'rule_image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleContentMeta = const VerificationMeta(
    'ruleContent',
  );
  @override
  late final GeneratedColumn<String> ruleContent = GeneratedColumn<String>(
    'rule_content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleLinkMeta = const VerificationMeta(
    'ruleLink',
  );
  @override
  late final GeneratedColumn<String> ruleLink = GeneratedColumn<String>(
    'rule_link',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleCategoriesMeta = const VerificationMeta(
    'ruleCategories',
  );
  @override
  late final GeneratedColumn<String> ruleCategories = GeneratedColumn<String>(
    'rule_categories',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortUrlMeta = const VerificationMeta(
    'sortUrl',
  );
  @override
  late final GeneratedColumn<String> sortUrl = GeneratedColumn<String>(
    'sort_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _articleStyleMeta = const VerificationMeta(
    'articleStyle',
  );
  @override
  late final GeneratedColumn<int> articleStyle = GeneratedColumn<int>(
    'article_style',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _singleUrlMeta = const VerificationMeta(
    'singleUrl',
  );
  @override
  late final GeneratedColumn<bool> singleUrl = GeneratedColumn<bool>(
    'single_url',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("single_url" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _enableJsMeta = const VerificationMeta(
    'enableJs',
  );
  @override
  late final GeneratedColumn<bool> enableJs = GeneratedColumn<bool>(
    'enable_js',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_js" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _loadWithBaseUrlMeta = const VerificationMeta(
    'loadWithBaseUrl',
  );
  @override
  late final GeneratedColumn<bool> loadWithBaseUrl = GeneratedColumn<bool>(
    'load_with_base_url',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("load_with_base_url" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _jsLibMeta = const VerificationMeta('jsLib');
  @override
  late final GeneratedColumn<String> jsLib = GeneratedColumn<String>(
    'js_lib',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _variableMeta = const VerificationMeta(
    'variable',
  );
  @override
  late final GeneratedColumn<String> variable = GeneratedColumn<String>(
    'variable',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastUpdateTimeMeta = const VerificationMeta(
    'lastUpdateTime',
  );
  @override
  late final GeneratedColumn<int> lastUpdateTime = GeneratedColumn<int>(
    'last_update_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    sourceUrl,
    sourceName,
    sourceIcon,
    sourceGroup,
    customOrder,
    enabled,
    enabledCookieJar,
    concurrentRate,
    header,
    loginUrl,
    loginUi,
    loginCheckJs,
    ruleArticles,
    ruleNextPage,
    ruleTitle,
    rulePubDate,
    ruleDescription,
    ruleImage,
    ruleContent,
    ruleLink,
    ruleCategories,
    sortUrl,
    articleStyle,
    singleUrl,
    enableJs,
    loadWithBaseUrl,
    jsLib,
    variable,
    lastUpdateTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rss_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<RssSource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('source_url')) {
      context.handle(
        _sourceUrlMeta,
        sourceUrl.isAcceptableOrUnknown(data['source_url']!, _sourceUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceUrlMeta);
    }
    if (data.containsKey('source_name')) {
      context.handle(
        _sourceNameMeta,
        sourceName.isAcceptableOrUnknown(data['source_name']!, _sourceNameMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceNameMeta);
    }
    if (data.containsKey('source_icon')) {
      context.handle(
        _sourceIconMeta,
        sourceIcon.isAcceptableOrUnknown(data['source_icon']!, _sourceIconMeta),
      );
    }
    if (data.containsKey('source_group')) {
      context.handle(
        _sourceGroupMeta,
        sourceGroup.isAcceptableOrUnknown(
          data['source_group']!,
          _sourceGroupMeta,
        ),
      );
    }
    if (data.containsKey('custom_order')) {
      context.handle(
        _customOrderMeta,
        customOrder.isAcceptableOrUnknown(
          data['custom_order']!,
          _customOrderMeta,
        ),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('enabled_cookie_jar')) {
      context.handle(
        _enabledCookieJarMeta,
        enabledCookieJar.isAcceptableOrUnknown(
          data['enabled_cookie_jar']!,
          _enabledCookieJarMeta,
        ),
      );
    }
    if (data.containsKey('concurrent_rate')) {
      context.handle(
        _concurrentRateMeta,
        concurrentRate.isAcceptableOrUnknown(
          data['concurrent_rate']!,
          _concurrentRateMeta,
        ),
      );
    }
    if (data.containsKey('header')) {
      context.handle(
        _headerMeta,
        header.isAcceptableOrUnknown(data['header']!, _headerMeta),
      );
    }
    if (data.containsKey('login_url')) {
      context.handle(
        _loginUrlMeta,
        loginUrl.isAcceptableOrUnknown(data['login_url']!, _loginUrlMeta),
      );
    }
    if (data.containsKey('login_ui')) {
      context.handle(
        _loginUiMeta,
        loginUi.isAcceptableOrUnknown(data['login_ui']!, _loginUiMeta),
      );
    }
    if (data.containsKey('login_check_js')) {
      context.handle(
        _loginCheckJsMeta,
        loginCheckJs.isAcceptableOrUnknown(
          data['login_check_js']!,
          _loginCheckJsMeta,
        ),
      );
    }
    if (data.containsKey('rule_articles')) {
      context.handle(
        _ruleArticlesMeta,
        ruleArticles.isAcceptableOrUnknown(
          data['rule_articles']!,
          _ruleArticlesMeta,
        ),
      );
    }
    if (data.containsKey('rule_next_page')) {
      context.handle(
        _ruleNextPageMeta,
        ruleNextPage.isAcceptableOrUnknown(
          data['rule_next_page']!,
          _ruleNextPageMeta,
        ),
      );
    }
    if (data.containsKey('rule_title')) {
      context.handle(
        _ruleTitleMeta,
        ruleTitle.isAcceptableOrUnknown(data['rule_title']!, _ruleTitleMeta),
      );
    }
    if (data.containsKey('rule_pub_date')) {
      context.handle(
        _rulePubDateMeta,
        rulePubDate.isAcceptableOrUnknown(
          data['rule_pub_date']!,
          _rulePubDateMeta,
        ),
      );
    }
    if (data.containsKey('rule_description')) {
      context.handle(
        _ruleDescriptionMeta,
        ruleDescription.isAcceptableOrUnknown(
          data['rule_description']!,
          _ruleDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('rule_image')) {
      context.handle(
        _ruleImageMeta,
        ruleImage.isAcceptableOrUnknown(data['rule_image']!, _ruleImageMeta),
      );
    }
    if (data.containsKey('rule_content')) {
      context.handle(
        _ruleContentMeta,
        ruleContent.isAcceptableOrUnknown(
          data['rule_content']!,
          _ruleContentMeta,
        ),
      );
    }
    if (data.containsKey('rule_link')) {
      context.handle(
        _ruleLinkMeta,
        ruleLink.isAcceptableOrUnknown(data['rule_link']!, _ruleLinkMeta),
      );
    }
    if (data.containsKey('rule_categories')) {
      context.handle(
        _ruleCategoriesMeta,
        ruleCategories.isAcceptableOrUnknown(
          data['rule_categories']!,
          _ruleCategoriesMeta,
        ),
      );
    }
    if (data.containsKey('sort_url')) {
      context.handle(
        _sortUrlMeta,
        sortUrl.isAcceptableOrUnknown(data['sort_url']!, _sortUrlMeta),
      );
    }
    if (data.containsKey('article_style')) {
      context.handle(
        _articleStyleMeta,
        articleStyle.isAcceptableOrUnknown(
          data['article_style']!,
          _articleStyleMeta,
        ),
      );
    }
    if (data.containsKey('single_url')) {
      context.handle(
        _singleUrlMeta,
        singleUrl.isAcceptableOrUnknown(data['single_url']!, _singleUrlMeta),
      );
    }
    if (data.containsKey('enable_js')) {
      context.handle(
        _enableJsMeta,
        enableJs.isAcceptableOrUnknown(data['enable_js']!, _enableJsMeta),
      );
    }
    if (data.containsKey('load_with_base_url')) {
      context.handle(
        _loadWithBaseUrlMeta,
        loadWithBaseUrl.isAcceptableOrUnknown(
          data['load_with_base_url']!,
          _loadWithBaseUrlMeta,
        ),
      );
    }
    if (data.containsKey('js_lib')) {
      context.handle(
        _jsLibMeta,
        jsLib.isAcceptableOrUnknown(data['js_lib']!, _jsLibMeta),
      );
    }
    if (data.containsKey('variable')) {
      context.handle(
        _variableMeta,
        variable.isAcceptableOrUnknown(data['variable']!, _variableMeta),
      );
    }
    if (data.containsKey('last_update_time')) {
      context.handle(
        _lastUpdateTimeMeta,
        lastUpdateTime.isAcceptableOrUnknown(
          data['last_update_time']!,
          _lastUpdateTimeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sourceUrl};
  @override
  RssSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RssSource(
      sourceUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_url'],
      )!,
      sourceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_name'],
      )!,
      sourceIcon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_icon'],
      ),
      sourceGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_group'],
      ),
      customOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}custom_order'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      enabledCookieJar: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled_cookie_jar'],
      )!,
      concurrentRate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}concurrent_rate'],
      ),
      header: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}header'],
      ),
      loginUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_url'],
      ),
      loginUi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_ui'],
      ),
      loginCheckJs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_check_js'],
      ),
      ruleArticles: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_articles'],
      ),
      ruleNextPage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_next_page'],
      ),
      ruleTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_title'],
      ),
      rulePubDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_pub_date'],
      ),
      ruleDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_description'],
      ),
      ruleImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_image'],
      ),
      ruleContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_content'],
      ),
      ruleLink: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_link'],
      ),
      ruleCategories: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_categories'],
      ),
      sortUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sort_url'],
      ),
      articleStyle: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}article_style'],
      )!,
      singleUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}single_url'],
      )!,
      enableJs: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_js'],
      )!,
      loadWithBaseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}load_with_base_url'],
      )!,
      jsLib: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}js_lib'],
      ),
      variable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variable'],
      ),
      lastUpdateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_update_time'],
      ),
    );
  }

  @override
  $RssSourcesTable createAlias(String alias) {
    return $RssSourcesTable(attachedDatabase, alias);
  }
}

class RssSource extends DataClass implements Insertable<RssSource> {
  final String sourceUrl;
  final String sourceName;
  final String? sourceIcon;
  final String? sourceGroup;
  final int customOrder;
  final bool enabled;
  final bool enabledCookieJar;
  final String? concurrentRate;
  final String? header;
  final String? loginUrl;
  final String? loginUi;
  final String? loginCheckJs;
  final String? ruleArticles;
  final String? ruleNextPage;
  final String? ruleTitle;
  final String? rulePubDate;
  final String? ruleDescription;
  final String? ruleImage;
  final String? ruleContent;
  final String? ruleLink;
  final String? ruleCategories;
  final String? sortUrl;
  final int articleStyle;
  final bool singleUrl;
  final bool enableJs;
  final bool loadWithBaseUrl;
  final String? jsLib;
  final String? variable;
  final int? lastUpdateTime;
  const RssSource({
    required this.sourceUrl,
    required this.sourceName,
    this.sourceIcon,
    this.sourceGroup,
    required this.customOrder,
    required this.enabled,
    required this.enabledCookieJar,
    this.concurrentRate,
    this.header,
    this.loginUrl,
    this.loginUi,
    this.loginCheckJs,
    this.ruleArticles,
    this.ruleNextPage,
    this.ruleTitle,
    this.rulePubDate,
    this.ruleDescription,
    this.ruleImage,
    this.ruleContent,
    this.ruleLink,
    this.ruleCategories,
    this.sortUrl,
    required this.articleStyle,
    required this.singleUrl,
    required this.enableJs,
    required this.loadWithBaseUrl,
    this.jsLib,
    this.variable,
    this.lastUpdateTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['source_url'] = Variable<String>(sourceUrl);
    map['source_name'] = Variable<String>(sourceName);
    if (!nullToAbsent || sourceIcon != null) {
      map['source_icon'] = Variable<String>(sourceIcon);
    }
    if (!nullToAbsent || sourceGroup != null) {
      map['source_group'] = Variable<String>(sourceGroup);
    }
    map['custom_order'] = Variable<int>(customOrder);
    map['enabled'] = Variable<bool>(enabled);
    map['enabled_cookie_jar'] = Variable<bool>(enabledCookieJar);
    if (!nullToAbsent || concurrentRate != null) {
      map['concurrent_rate'] = Variable<String>(concurrentRate);
    }
    if (!nullToAbsent || header != null) {
      map['header'] = Variable<String>(header);
    }
    if (!nullToAbsent || loginUrl != null) {
      map['login_url'] = Variable<String>(loginUrl);
    }
    if (!nullToAbsent || loginUi != null) {
      map['login_ui'] = Variable<String>(loginUi);
    }
    if (!nullToAbsent || loginCheckJs != null) {
      map['login_check_js'] = Variable<String>(loginCheckJs);
    }
    if (!nullToAbsent || ruleArticles != null) {
      map['rule_articles'] = Variable<String>(ruleArticles);
    }
    if (!nullToAbsent || ruleNextPage != null) {
      map['rule_next_page'] = Variable<String>(ruleNextPage);
    }
    if (!nullToAbsent || ruleTitle != null) {
      map['rule_title'] = Variable<String>(ruleTitle);
    }
    if (!nullToAbsent || rulePubDate != null) {
      map['rule_pub_date'] = Variable<String>(rulePubDate);
    }
    if (!nullToAbsent || ruleDescription != null) {
      map['rule_description'] = Variable<String>(ruleDescription);
    }
    if (!nullToAbsent || ruleImage != null) {
      map['rule_image'] = Variable<String>(ruleImage);
    }
    if (!nullToAbsent || ruleContent != null) {
      map['rule_content'] = Variable<String>(ruleContent);
    }
    if (!nullToAbsent || ruleLink != null) {
      map['rule_link'] = Variable<String>(ruleLink);
    }
    if (!nullToAbsent || ruleCategories != null) {
      map['rule_categories'] = Variable<String>(ruleCategories);
    }
    if (!nullToAbsent || sortUrl != null) {
      map['sort_url'] = Variable<String>(sortUrl);
    }
    map['article_style'] = Variable<int>(articleStyle);
    map['single_url'] = Variable<bool>(singleUrl);
    map['enable_js'] = Variable<bool>(enableJs);
    map['load_with_base_url'] = Variable<bool>(loadWithBaseUrl);
    if (!nullToAbsent || jsLib != null) {
      map['js_lib'] = Variable<String>(jsLib);
    }
    if (!nullToAbsent || variable != null) {
      map['variable'] = Variable<String>(variable);
    }
    if (!nullToAbsent || lastUpdateTime != null) {
      map['last_update_time'] = Variable<int>(lastUpdateTime);
    }
    return map;
  }

  RssSourcesCompanion toCompanion(bool nullToAbsent) {
    return RssSourcesCompanion(
      sourceUrl: Value(sourceUrl),
      sourceName: Value(sourceName),
      sourceIcon: sourceIcon == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceIcon),
      sourceGroup: sourceGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceGroup),
      customOrder: Value(customOrder),
      enabled: Value(enabled),
      enabledCookieJar: Value(enabledCookieJar),
      concurrentRate: concurrentRate == null && nullToAbsent
          ? const Value.absent()
          : Value(concurrentRate),
      header: header == null && nullToAbsent
          ? const Value.absent()
          : Value(header),
      loginUrl: loginUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(loginUrl),
      loginUi: loginUi == null && nullToAbsent
          ? const Value.absent()
          : Value(loginUi),
      loginCheckJs: loginCheckJs == null && nullToAbsent
          ? const Value.absent()
          : Value(loginCheckJs),
      ruleArticles: ruleArticles == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleArticles),
      ruleNextPage: ruleNextPage == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleNextPage),
      ruleTitle: ruleTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleTitle),
      rulePubDate: rulePubDate == null && nullToAbsent
          ? const Value.absent()
          : Value(rulePubDate),
      ruleDescription: ruleDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleDescription),
      ruleImage: ruleImage == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleImage),
      ruleContent: ruleContent == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleContent),
      ruleLink: ruleLink == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleLink),
      ruleCategories: ruleCategories == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleCategories),
      sortUrl: sortUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(sortUrl),
      articleStyle: Value(articleStyle),
      singleUrl: Value(singleUrl),
      enableJs: Value(enableJs),
      loadWithBaseUrl: Value(loadWithBaseUrl),
      jsLib: jsLib == null && nullToAbsent
          ? const Value.absent()
          : Value(jsLib),
      variable: variable == null && nullToAbsent
          ? const Value.absent()
          : Value(variable),
      lastUpdateTime: lastUpdateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdateTime),
    );
  }

  factory RssSource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RssSource(
      sourceUrl: serializer.fromJson<String>(json['sourceUrl']),
      sourceName: serializer.fromJson<String>(json['sourceName']),
      sourceIcon: serializer.fromJson<String?>(json['sourceIcon']),
      sourceGroup: serializer.fromJson<String?>(json['sourceGroup']),
      customOrder: serializer.fromJson<int>(json['customOrder']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      enabledCookieJar: serializer.fromJson<bool>(json['enabledCookieJar']),
      concurrentRate: serializer.fromJson<String?>(json['concurrentRate']),
      header: serializer.fromJson<String?>(json['header']),
      loginUrl: serializer.fromJson<String?>(json['loginUrl']),
      loginUi: serializer.fromJson<String?>(json['loginUi']),
      loginCheckJs: serializer.fromJson<String?>(json['loginCheckJs']),
      ruleArticles: serializer.fromJson<String?>(json['ruleArticles']),
      ruleNextPage: serializer.fromJson<String?>(json['ruleNextPage']),
      ruleTitle: serializer.fromJson<String?>(json['ruleTitle']),
      rulePubDate: serializer.fromJson<String?>(json['rulePubDate']),
      ruleDescription: serializer.fromJson<String?>(json['ruleDescription']),
      ruleImage: serializer.fromJson<String?>(json['ruleImage']),
      ruleContent: serializer.fromJson<String?>(json['ruleContent']),
      ruleLink: serializer.fromJson<String?>(json['ruleLink']),
      ruleCategories: serializer.fromJson<String?>(json['ruleCategories']),
      sortUrl: serializer.fromJson<String?>(json['sortUrl']),
      articleStyle: serializer.fromJson<int>(json['articleStyle']),
      singleUrl: serializer.fromJson<bool>(json['singleUrl']),
      enableJs: serializer.fromJson<bool>(json['enableJs']),
      loadWithBaseUrl: serializer.fromJson<bool>(json['loadWithBaseUrl']),
      jsLib: serializer.fromJson<String?>(json['jsLib']),
      variable: serializer.fromJson<String?>(json['variable']),
      lastUpdateTime: serializer.fromJson<int?>(json['lastUpdateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sourceUrl': serializer.toJson<String>(sourceUrl),
      'sourceName': serializer.toJson<String>(sourceName),
      'sourceIcon': serializer.toJson<String?>(sourceIcon),
      'sourceGroup': serializer.toJson<String?>(sourceGroup),
      'customOrder': serializer.toJson<int>(customOrder),
      'enabled': serializer.toJson<bool>(enabled),
      'enabledCookieJar': serializer.toJson<bool>(enabledCookieJar),
      'concurrentRate': serializer.toJson<String?>(concurrentRate),
      'header': serializer.toJson<String?>(header),
      'loginUrl': serializer.toJson<String?>(loginUrl),
      'loginUi': serializer.toJson<String?>(loginUi),
      'loginCheckJs': serializer.toJson<String?>(loginCheckJs),
      'ruleArticles': serializer.toJson<String?>(ruleArticles),
      'ruleNextPage': serializer.toJson<String?>(ruleNextPage),
      'ruleTitle': serializer.toJson<String?>(ruleTitle),
      'rulePubDate': serializer.toJson<String?>(rulePubDate),
      'ruleDescription': serializer.toJson<String?>(ruleDescription),
      'ruleImage': serializer.toJson<String?>(ruleImage),
      'ruleContent': serializer.toJson<String?>(ruleContent),
      'ruleLink': serializer.toJson<String?>(ruleLink),
      'ruleCategories': serializer.toJson<String?>(ruleCategories),
      'sortUrl': serializer.toJson<String?>(sortUrl),
      'articleStyle': serializer.toJson<int>(articleStyle),
      'singleUrl': serializer.toJson<bool>(singleUrl),
      'enableJs': serializer.toJson<bool>(enableJs),
      'loadWithBaseUrl': serializer.toJson<bool>(loadWithBaseUrl),
      'jsLib': serializer.toJson<String?>(jsLib),
      'variable': serializer.toJson<String?>(variable),
      'lastUpdateTime': serializer.toJson<int?>(lastUpdateTime),
    };
  }

  RssSource copyWith({
    String? sourceUrl,
    String? sourceName,
    Value<String?> sourceIcon = const Value.absent(),
    Value<String?> sourceGroup = const Value.absent(),
    int? customOrder,
    bool? enabled,
    bool? enabledCookieJar,
    Value<String?> concurrentRate = const Value.absent(),
    Value<String?> header = const Value.absent(),
    Value<String?> loginUrl = const Value.absent(),
    Value<String?> loginUi = const Value.absent(),
    Value<String?> loginCheckJs = const Value.absent(),
    Value<String?> ruleArticles = const Value.absent(),
    Value<String?> ruleNextPage = const Value.absent(),
    Value<String?> ruleTitle = const Value.absent(),
    Value<String?> rulePubDate = const Value.absent(),
    Value<String?> ruleDescription = const Value.absent(),
    Value<String?> ruleImage = const Value.absent(),
    Value<String?> ruleContent = const Value.absent(),
    Value<String?> ruleLink = const Value.absent(),
    Value<String?> ruleCategories = const Value.absent(),
    Value<String?> sortUrl = const Value.absent(),
    int? articleStyle,
    bool? singleUrl,
    bool? enableJs,
    bool? loadWithBaseUrl,
    Value<String?> jsLib = const Value.absent(),
    Value<String?> variable = const Value.absent(),
    Value<int?> lastUpdateTime = const Value.absent(),
  }) => RssSource(
    sourceUrl: sourceUrl ?? this.sourceUrl,
    sourceName: sourceName ?? this.sourceName,
    sourceIcon: sourceIcon.present ? sourceIcon.value : this.sourceIcon,
    sourceGroup: sourceGroup.present ? sourceGroup.value : this.sourceGroup,
    customOrder: customOrder ?? this.customOrder,
    enabled: enabled ?? this.enabled,
    enabledCookieJar: enabledCookieJar ?? this.enabledCookieJar,
    concurrentRate: concurrentRate.present
        ? concurrentRate.value
        : this.concurrentRate,
    header: header.present ? header.value : this.header,
    loginUrl: loginUrl.present ? loginUrl.value : this.loginUrl,
    loginUi: loginUi.present ? loginUi.value : this.loginUi,
    loginCheckJs: loginCheckJs.present ? loginCheckJs.value : this.loginCheckJs,
    ruleArticles: ruleArticles.present ? ruleArticles.value : this.ruleArticles,
    ruleNextPage: ruleNextPage.present ? ruleNextPage.value : this.ruleNextPage,
    ruleTitle: ruleTitle.present ? ruleTitle.value : this.ruleTitle,
    rulePubDate: rulePubDate.present ? rulePubDate.value : this.rulePubDate,
    ruleDescription: ruleDescription.present
        ? ruleDescription.value
        : this.ruleDescription,
    ruleImage: ruleImage.present ? ruleImage.value : this.ruleImage,
    ruleContent: ruleContent.present ? ruleContent.value : this.ruleContent,
    ruleLink: ruleLink.present ? ruleLink.value : this.ruleLink,
    ruleCategories: ruleCategories.present
        ? ruleCategories.value
        : this.ruleCategories,
    sortUrl: sortUrl.present ? sortUrl.value : this.sortUrl,
    articleStyle: articleStyle ?? this.articleStyle,
    singleUrl: singleUrl ?? this.singleUrl,
    enableJs: enableJs ?? this.enableJs,
    loadWithBaseUrl: loadWithBaseUrl ?? this.loadWithBaseUrl,
    jsLib: jsLib.present ? jsLib.value : this.jsLib,
    variable: variable.present ? variable.value : this.variable,
    lastUpdateTime: lastUpdateTime.present
        ? lastUpdateTime.value
        : this.lastUpdateTime,
  );
  RssSource copyWithCompanion(RssSourcesCompanion data) {
    return RssSource(
      sourceUrl: data.sourceUrl.present ? data.sourceUrl.value : this.sourceUrl,
      sourceName: data.sourceName.present
          ? data.sourceName.value
          : this.sourceName,
      sourceIcon: data.sourceIcon.present
          ? data.sourceIcon.value
          : this.sourceIcon,
      sourceGroup: data.sourceGroup.present
          ? data.sourceGroup.value
          : this.sourceGroup,
      customOrder: data.customOrder.present
          ? data.customOrder.value
          : this.customOrder,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      enabledCookieJar: data.enabledCookieJar.present
          ? data.enabledCookieJar.value
          : this.enabledCookieJar,
      concurrentRate: data.concurrentRate.present
          ? data.concurrentRate.value
          : this.concurrentRate,
      header: data.header.present ? data.header.value : this.header,
      loginUrl: data.loginUrl.present ? data.loginUrl.value : this.loginUrl,
      loginUi: data.loginUi.present ? data.loginUi.value : this.loginUi,
      loginCheckJs: data.loginCheckJs.present
          ? data.loginCheckJs.value
          : this.loginCheckJs,
      ruleArticles: data.ruleArticles.present
          ? data.ruleArticles.value
          : this.ruleArticles,
      ruleNextPage: data.ruleNextPage.present
          ? data.ruleNextPage.value
          : this.ruleNextPage,
      ruleTitle: data.ruleTitle.present ? data.ruleTitle.value : this.ruleTitle,
      rulePubDate: data.rulePubDate.present
          ? data.rulePubDate.value
          : this.rulePubDate,
      ruleDescription: data.ruleDescription.present
          ? data.ruleDescription.value
          : this.ruleDescription,
      ruleImage: data.ruleImage.present ? data.ruleImage.value : this.ruleImage,
      ruleContent: data.ruleContent.present
          ? data.ruleContent.value
          : this.ruleContent,
      ruleLink: data.ruleLink.present ? data.ruleLink.value : this.ruleLink,
      ruleCategories: data.ruleCategories.present
          ? data.ruleCategories.value
          : this.ruleCategories,
      sortUrl: data.sortUrl.present ? data.sortUrl.value : this.sortUrl,
      articleStyle: data.articleStyle.present
          ? data.articleStyle.value
          : this.articleStyle,
      singleUrl: data.singleUrl.present ? data.singleUrl.value : this.singleUrl,
      enableJs: data.enableJs.present ? data.enableJs.value : this.enableJs,
      loadWithBaseUrl: data.loadWithBaseUrl.present
          ? data.loadWithBaseUrl.value
          : this.loadWithBaseUrl,
      jsLib: data.jsLib.present ? data.jsLib.value : this.jsLib,
      variable: data.variable.present ? data.variable.value : this.variable,
      lastUpdateTime: data.lastUpdateTime.present
          ? data.lastUpdateTime.value
          : this.lastUpdateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RssSource(')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('sourceName: $sourceName, ')
          ..write('sourceIcon: $sourceIcon, ')
          ..write('sourceGroup: $sourceGroup, ')
          ..write('customOrder: $customOrder, ')
          ..write('enabled: $enabled, ')
          ..write('enabledCookieJar: $enabledCookieJar, ')
          ..write('concurrentRate: $concurrentRate, ')
          ..write('header: $header, ')
          ..write('loginUrl: $loginUrl, ')
          ..write('loginUi: $loginUi, ')
          ..write('loginCheckJs: $loginCheckJs, ')
          ..write('ruleArticles: $ruleArticles, ')
          ..write('ruleNextPage: $ruleNextPage, ')
          ..write('ruleTitle: $ruleTitle, ')
          ..write('rulePubDate: $rulePubDate, ')
          ..write('ruleDescription: $ruleDescription, ')
          ..write('ruleImage: $ruleImage, ')
          ..write('ruleContent: $ruleContent, ')
          ..write('ruleLink: $ruleLink, ')
          ..write('ruleCategories: $ruleCategories, ')
          ..write('sortUrl: $sortUrl, ')
          ..write('articleStyle: $articleStyle, ')
          ..write('singleUrl: $singleUrl, ')
          ..write('enableJs: $enableJs, ')
          ..write('loadWithBaseUrl: $loadWithBaseUrl, ')
          ..write('jsLib: $jsLib, ')
          ..write('variable: $variable, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    sourceUrl,
    sourceName,
    sourceIcon,
    sourceGroup,
    customOrder,
    enabled,
    enabledCookieJar,
    concurrentRate,
    header,
    loginUrl,
    loginUi,
    loginCheckJs,
    ruleArticles,
    ruleNextPage,
    ruleTitle,
    rulePubDate,
    ruleDescription,
    ruleImage,
    ruleContent,
    ruleLink,
    ruleCategories,
    sortUrl,
    articleStyle,
    singleUrl,
    enableJs,
    loadWithBaseUrl,
    jsLib,
    variable,
    lastUpdateTime,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RssSource &&
          other.sourceUrl == this.sourceUrl &&
          other.sourceName == this.sourceName &&
          other.sourceIcon == this.sourceIcon &&
          other.sourceGroup == this.sourceGroup &&
          other.customOrder == this.customOrder &&
          other.enabled == this.enabled &&
          other.enabledCookieJar == this.enabledCookieJar &&
          other.concurrentRate == this.concurrentRate &&
          other.header == this.header &&
          other.loginUrl == this.loginUrl &&
          other.loginUi == this.loginUi &&
          other.loginCheckJs == this.loginCheckJs &&
          other.ruleArticles == this.ruleArticles &&
          other.ruleNextPage == this.ruleNextPage &&
          other.ruleTitle == this.ruleTitle &&
          other.rulePubDate == this.rulePubDate &&
          other.ruleDescription == this.ruleDescription &&
          other.ruleImage == this.ruleImage &&
          other.ruleContent == this.ruleContent &&
          other.ruleLink == this.ruleLink &&
          other.ruleCategories == this.ruleCategories &&
          other.sortUrl == this.sortUrl &&
          other.articleStyle == this.articleStyle &&
          other.singleUrl == this.singleUrl &&
          other.enableJs == this.enableJs &&
          other.loadWithBaseUrl == this.loadWithBaseUrl &&
          other.jsLib == this.jsLib &&
          other.variable == this.variable &&
          other.lastUpdateTime == this.lastUpdateTime);
}

class RssSourcesCompanion extends UpdateCompanion<RssSource> {
  final Value<String> sourceUrl;
  final Value<String> sourceName;
  final Value<String?> sourceIcon;
  final Value<String?> sourceGroup;
  final Value<int> customOrder;
  final Value<bool> enabled;
  final Value<bool> enabledCookieJar;
  final Value<String?> concurrentRate;
  final Value<String?> header;
  final Value<String?> loginUrl;
  final Value<String?> loginUi;
  final Value<String?> loginCheckJs;
  final Value<String?> ruleArticles;
  final Value<String?> ruleNextPage;
  final Value<String?> ruleTitle;
  final Value<String?> rulePubDate;
  final Value<String?> ruleDescription;
  final Value<String?> ruleImage;
  final Value<String?> ruleContent;
  final Value<String?> ruleLink;
  final Value<String?> ruleCategories;
  final Value<String?> sortUrl;
  final Value<int> articleStyle;
  final Value<bool> singleUrl;
  final Value<bool> enableJs;
  final Value<bool> loadWithBaseUrl;
  final Value<String?> jsLib;
  final Value<String?> variable;
  final Value<int?> lastUpdateTime;
  final Value<int> rowid;
  const RssSourcesCompanion({
    this.sourceUrl = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.sourceIcon = const Value.absent(),
    this.sourceGroup = const Value.absent(),
    this.customOrder = const Value.absent(),
    this.enabled = const Value.absent(),
    this.enabledCookieJar = const Value.absent(),
    this.concurrentRate = const Value.absent(),
    this.header = const Value.absent(),
    this.loginUrl = const Value.absent(),
    this.loginUi = const Value.absent(),
    this.loginCheckJs = const Value.absent(),
    this.ruleArticles = const Value.absent(),
    this.ruleNextPage = const Value.absent(),
    this.ruleTitle = const Value.absent(),
    this.rulePubDate = const Value.absent(),
    this.ruleDescription = const Value.absent(),
    this.ruleImage = const Value.absent(),
    this.ruleContent = const Value.absent(),
    this.ruleLink = const Value.absent(),
    this.ruleCategories = const Value.absent(),
    this.sortUrl = const Value.absent(),
    this.articleStyle = const Value.absent(),
    this.singleUrl = const Value.absent(),
    this.enableJs = const Value.absent(),
    this.loadWithBaseUrl = const Value.absent(),
    this.jsLib = const Value.absent(),
    this.variable = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RssSourcesCompanion.insert({
    required String sourceUrl,
    required String sourceName,
    this.sourceIcon = const Value.absent(),
    this.sourceGroup = const Value.absent(),
    this.customOrder = const Value.absent(),
    this.enabled = const Value.absent(),
    this.enabledCookieJar = const Value.absent(),
    this.concurrentRate = const Value.absent(),
    this.header = const Value.absent(),
    this.loginUrl = const Value.absent(),
    this.loginUi = const Value.absent(),
    this.loginCheckJs = const Value.absent(),
    this.ruleArticles = const Value.absent(),
    this.ruleNextPage = const Value.absent(),
    this.ruleTitle = const Value.absent(),
    this.rulePubDate = const Value.absent(),
    this.ruleDescription = const Value.absent(),
    this.ruleImage = const Value.absent(),
    this.ruleContent = const Value.absent(),
    this.ruleLink = const Value.absent(),
    this.ruleCategories = const Value.absent(),
    this.sortUrl = const Value.absent(),
    this.articleStyle = const Value.absent(),
    this.singleUrl = const Value.absent(),
    this.enableJs = const Value.absent(),
    this.loadWithBaseUrl = const Value.absent(),
    this.jsLib = const Value.absent(),
    this.variable = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : sourceUrl = Value(sourceUrl),
       sourceName = Value(sourceName);
  static Insertable<RssSource> custom({
    Expression<String>? sourceUrl,
    Expression<String>? sourceName,
    Expression<String>? sourceIcon,
    Expression<String>? sourceGroup,
    Expression<int>? customOrder,
    Expression<bool>? enabled,
    Expression<bool>? enabledCookieJar,
    Expression<String>? concurrentRate,
    Expression<String>? header,
    Expression<String>? loginUrl,
    Expression<String>? loginUi,
    Expression<String>? loginCheckJs,
    Expression<String>? ruleArticles,
    Expression<String>? ruleNextPage,
    Expression<String>? ruleTitle,
    Expression<String>? rulePubDate,
    Expression<String>? ruleDescription,
    Expression<String>? ruleImage,
    Expression<String>? ruleContent,
    Expression<String>? ruleLink,
    Expression<String>? ruleCategories,
    Expression<String>? sortUrl,
    Expression<int>? articleStyle,
    Expression<bool>? singleUrl,
    Expression<bool>? enableJs,
    Expression<bool>? loadWithBaseUrl,
    Expression<String>? jsLib,
    Expression<String>? variable,
    Expression<int>? lastUpdateTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sourceUrl != null) 'source_url': sourceUrl,
      if (sourceName != null) 'source_name': sourceName,
      if (sourceIcon != null) 'source_icon': sourceIcon,
      if (sourceGroup != null) 'source_group': sourceGroup,
      if (customOrder != null) 'custom_order': customOrder,
      if (enabled != null) 'enabled': enabled,
      if (enabledCookieJar != null) 'enabled_cookie_jar': enabledCookieJar,
      if (concurrentRate != null) 'concurrent_rate': concurrentRate,
      if (header != null) 'header': header,
      if (loginUrl != null) 'login_url': loginUrl,
      if (loginUi != null) 'login_ui': loginUi,
      if (loginCheckJs != null) 'login_check_js': loginCheckJs,
      if (ruleArticles != null) 'rule_articles': ruleArticles,
      if (ruleNextPage != null) 'rule_next_page': ruleNextPage,
      if (ruleTitle != null) 'rule_title': ruleTitle,
      if (rulePubDate != null) 'rule_pub_date': rulePubDate,
      if (ruleDescription != null) 'rule_description': ruleDescription,
      if (ruleImage != null) 'rule_image': ruleImage,
      if (ruleContent != null) 'rule_content': ruleContent,
      if (ruleLink != null) 'rule_link': ruleLink,
      if (ruleCategories != null) 'rule_categories': ruleCategories,
      if (sortUrl != null) 'sort_url': sortUrl,
      if (articleStyle != null) 'article_style': articleStyle,
      if (singleUrl != null) 'single_url': singleUrl,
      if (enableJs != null) 'enable_js': enableJs,
      if (loadWithBaseUrl != null) 'load_with_base_url': loadWithBaseUrl,
      if (jsLib != null) 'js_lib': jsLib,
      if (variable != null) 'variable': variable,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RssSourcesCompanion copyWith({
    Value<String>? sourceUrl,
    Value<String>? sourceName,
    Value<String?>? sourceIcon,
    Value<String?>? sourceGroup,
    Value<int>? customOrder,
    Value<bool>? enabled,
    Value<bool>? enabledCookieJar,
    Value<String?>? concurrentRate,
    Value<String?>? header,
    Value<String?>? loginUrl,
    Value<String?>? loginUi,
    Value<String?>? loginCheckJs,
    Value<String?>? ruleArticles,
    Value<String?>? ruleNextPage,
    Value<String?>? ruleTitle,
    Value<String?>? rulePubDate,
    Value<String?>? ruleDescription,
    Value<String?>? ruleImage,
    Value<String?>? ruleContent,
    Value<String?>? ruleLink,
    Value<String?>? ruleCategories,
    Value<String?>? sortUrl,
    Value<int>? articleStyle,
    Value<bool>? singleUrl,
    Value<bool>? enableJs,
    Value<bool>? loadWithBaseUrl,
    Value<String?>? jsLib,
    Value<String?>? variable,
    Value<int?>? lastUpdateTime,
    Value<int>? rowid,
  }) {
    return RssSourcesCompanion(
      sourceUrl: sourceUrl ?? this.sourceUrl,
      sourceName: sourceName ?? this.sourceName,
      sourceIcon: sourceIcon ?? this.sourceIcon,
      sourceGroup: sourceGroup ?? this.sourceGroup,
      customOrder: customOrder ?? this.customOrder,
      enabled: enabled ?? this.enabled,
      enabledCookieJar: enabledCookieJar ?? this.enabledCookieJar,
      concurrentRate: concurrentRate ?? this.concurrentRate,
      header: header ?? this.header,
      loginUrl: loginUrl ?? this.loginUrl,
      loginUi: loginUi ?? this.loginUi,
      loginCheckJs: loginCheckJs ?? this.loginCheckJs,
      ruleArticles: ruleArticles ?? this.ruleArticles,
      ruleNextPage: ruleNextPage ?? this.ruleNextPage,
      ruleTitle: ruleTitle ?? this.ruleTitle,
      rulePubDate: rulePubDate ?? this.rulePubDate,
      ruleDescription: ruleDescription ?? this.ruleDescription,
      ruleImage: ruleImage ?? this.ruleImage,
      ruleContent: ruleContent ?? this.ruleContent,
      ruleLink: ruleLink ?? this.ruleLink,
      ruleCategories: ruleCategories ?? this.ruleCategories,
      sortUrl: sortUrl ?? this.sortUrl,
      articleStyle: articleStyle ?? this.articleStyle,
      singleUrl: singleUrl ?? this.singleUrl,
      enableJs: enableJs ?? this.enableJs,
      loadWithBaseUrl: loadWithBaseUrl ?? this.loadWithBaseUrl,
      jsLib: jsLib ?? this.jsLib,
      variable: variable ?? this.variable,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sourceUrl.present) {
      map['source_url'] = Variable<String>(sourceUrl.value);
    }
    if (sourceName.present) {
      map['source_name'] = Variable<String>(sourceName.value);
    }
    if (sourceIcon.present) {
      map['source_icon'] = Variable<String>(sourceIcon.value);
    }
    if (sourceGroup.present) {
      map['source_group'] = Variable<String>(sourceGroup.value);
    }
    if (customOrder.present) {
      map['custom_order'] = Variable<int>(customOrder.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (enabledCookieJar.present) {
      map['enabled_cookie_jar'] = Variable<bool>(enabledCookieJar.value);
    }
    if (concurrentRate.present) {
      map['concurrent_rate'] = Variable<String>(concurrentRate.value);
    }
    if (header.present) {
      map['header'] = Variable<String>(header.value);
    }
    if (loginUrl.present) {
      map['login_url'] = Variable<String>(loginUrl.value);
    }
    if (loginUi.present) {
      map['login_ui'] = Variable<String>(loginUi.value);
    }
    if (loginCheckJs.present) {
      map['login_check_js'] = Variable<String>(loginCheckJs.value);
    }
    if (ruleArticles.present) {
      map['rule_articles'] = Variable<String>(ruleArticles.value);
    }
    if (ruleNextPage.present) {
      map['rule_next_page'] = Variable<String>(ruleNextPage.value);
    }
    if (ruleTitle.present) {
      map['rule_title'] = Variable<String>(ruleTitle.value);
    }
    if (rulePubDate.present) {
      map['rule_pub_date'] = Variable<String>(rulePubDate.value);
    }
    if (ruleDescription.present) {
      map['rule_description'] = Variable<String>(ruleDescription.value);
    }
    if (ruleImage.present) {
      map['rule_image'] = Variable<String>(ruleImage.value);
    }
    if (ruleContent.present) {
      map['rule_content'] = Variable<String>(ruleContent.value);
    }
    if (ruleLink.present) {
      map['rule_link'] = Variable<String>(ruleLink.value);
    }
    if (ruleCategories.present) {
      map['rule_categories'] = Variable<String>(ruleCategories.value);
    }
    if (sortUrl.present) {
      map['sort_url'] = Variable<String>(sortUrl.value);
    }
    if (articleStyle.present) {
      map['article_style'] = Variable<int>(articleStyle.value);
    }
    if (singleUrl.present) {
      map['single_url'] = Variable<bool>(singleUrl.value);
    }
    if (enableJs.present) {
      map['enable_js'] = Variable<bool>(enableJs.value);
    }
    if (loadWithBaseUrl.present) {
      map['load_with_base_url'] = Variable<bool>(loadWithBaseUrl.value);
    }
    if (jsLib.present) {
      map['js_lib'] = Variable<String>(jsLib.value);
    }
    if (variable.present) {
      map['variable'] = Variable<String>(variable.value);
    }
    if (lastUpdateTime.present) {
      map['last_update_time'] = Variable<int>(lastUpdateTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RssSourcesCompanion(')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('sourceName: $sourceName, ')
          ..write('sourceIcon: $sourceIcon, ')
          ..write('sourceGroup: $sourceGroup, ')
          ..write('customOrder: $customOrder, ')
          ..write('enabled: $enabled, ')
          ..write('enabledCookieJar: $enabledCookieJar, ')
          ..write('concurrentRate: $concurrentRate, ')
          ..write('header: $header, ')
          ..write('loginUrl: $loginUrl, ')
          ..write('loginUi: $loginUi, ')
          ..write('loginCheckJs: $loginCheckJs, ')
          ..write('ruleArticles: $ruleArticles, ')
          ..write('ruleNextPage: $ruleNextPage, ')
          ..write('ruleTitle: $ruleTitle, ')
          ..write('rulePubDate: $rulePubDate, ')
          ..write('ruleDescription: $ruleDescription, ')
          ..write('ruleImage: $ruleImage, ')
          ..write('ruleContent: $ruleContent, ')
          ..write('ruleLink: $ruleLink, ')
          ..write('ruleCategories: $ruleCategories, ')
          ..write('sortUrl: $sortUrl, ')
          ..write('articleStyle: $articleStyle, ')
          ..write('singleUrl: $singleUrl, ')
          ..write('enableJs: $enableJs, ')
          ..write('loadWithBaseUrl: $loadWithBaseUrl, ')
          ..write('jsLib: $jsLib, ')
          ..write('variable: $variable, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RssArticlesTable extends RssArticles
    with TableInfo<$RssArticlesTable, RssArticle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RssArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
    'origin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originNameMeta = const VerificationMeta(
    'originName',
  );
  @override
  late final GeneratedColumn<String> originName = GeneratedColumn<String>(
    'origin_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortMeta = const VerificationMeta('sort');
  @override
  late final GeneratedColumn<String> sort = GeneratedColumn<String>(
    'sort',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _pubDateMeta = const VerificationMeta(
    'pubDate',
  );
  @override
  late final GeneratedColumn<String> pubDate = GeneratedColumn<String>(
    'pub_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
    'link',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _variableMeta = const VerificationMeta(
    'variable',
  );
  @override
  late final GeneratedColumn<String> variable = GeneratedColumn<String>(
    'variable',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _readMeta = const VerificationMeta('read');
  @override
  late final GeneratedColumn<bool> read = GeneratedColumn<bool>(
    'read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    url,
    origin,
    originName,
    title,
    sort,
    order,
    pubDate,
    description,
    image,
    link,
    content,
    variable,
    read,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rss_articles';
  @override
  VerificationContext validateIntegrity(
    Insertable<RssArticle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('origin')) {
      context.handle(
        _originMeta,
        origin.isAcceptableOrUnknown(data['origin']!, _originMeta),
      );
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('origin_name')) {
      context.handle(
        _originNameMeta,
        originName.isAcceptableOrUnknown(data['origin_name']!, _originNameMeta),
      );
    } else if (isInserting) {
      context.missing(_originNameMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('sort')) {
      context.handle(
        _sortMeta,
        sort.isAcceptableOrUnknown(data['sort']!, _sortMeta),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    if (data.containsKey('pub_date')) {
      context.handle(
        _pubDateMeta,
        pubDate.isAcceptableOrUnknown(data['pub_date']!, _pubDateMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    }
    if (data.containsKey('link')) {
      context.handle(
        _linkMeta,
        link.isAcceptableOrUnknown(data['link']!, _linkMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('variable')) {
      context.handle(
        _variableMeta,
        variable.isAcceptableOrUnknown(data['variable']!, _variableMeta),
      );
    }
    if (data.containsKey('read')) {
      context.handle(
        _readMeta,
        read.isAcceptableOrUnknown(data['read']!, _readMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {url, origin};
  @override
  RssArticle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RssArticle(
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      origin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin'],
      )!,
      originName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_name'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      sort: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sort'],
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      pubDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pub_date'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      ),
      link: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}link'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      variable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variable'],
      ),
      read: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}read'],
      )!,
    );
  }

  @override
  $RssArticlesTable createAlias(String alias) {
    return $RssArticlesTable(attachedDatabase, alias);
  }
}

class RssArticle extends DataClass implements Insertable<RssArticle> {
  final String url;
  final String origin;
  final String originName;
  final String title;
  final String? sort;
  final int order;
  final String? pubDate;
  final String? description;
  final String? image;
  final String? link;
  final String? content;
  final String? variable;
  final bool read;
  const RssArticle({
    required this.url,
    required this.origin,
    required this.originName,
    required this.title,
    this.sort,
    required this.order,
    this.pubDate,
    this.description,
    this.image,
    this.link,
    this.content,
    this.variable,
    required this.read,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['url'] = Variable<String>(url);
    map['origin'] = Variable<String>(origin);
    map['origin_name'] = Variable<String>(originName);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || sort != null) {
      map['sort'] = Variable<String>(sort);
    }
    map['order'] = Variable<int>(order);
    if (!nullToAbsent || pubDate != null) {
      map['pub_date'] = Variable<String>(pubDate);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || variable != null) {
      map['variable'] = Variable<String>(variable);
    }
    map['read'] = Variable<bool>(read);
    return map;
  }

  RssArticlesCompanion toCompanion(bool nullToAbsent) {
    return RssArticlesCompanion(
      url: Value(url),
      origin: Value(origin),
      originName: Value(originName),
      title: Value(title),
      sort: sort == null && nullToAbsent ? const Value.absent() : Value(sort),
      order: Value(order),
      pubDate: pubDate == null && nullToAbsent
          ? const Value.absent()
          : Value(pubDate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      image: image == null && nullToAbsent
          ? const Value.absent()
          : Value(image),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      variable: variable == null && nullToAbsent
          ? const Value.absent()
          : Value(variable),
      read: Value(read),
    );
  }

  factory RssArticle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RssArticle(
      url: serializer.fromJson<String>(json['url']),
      origin: serializer.fromJson<String>(json['origin']),
      originName: serializer.fromJson<String>(json['originName']),
      title: serializer.fromJson<String>(json['title']),
      sort: serializer.fromJson<String?>(json['sort']),
      order: serializer.fromJson<int>(json['order']),
      pubDate: serializer.fromJson<String?>(json['pubDate']),
      description: serializer.fromJson<String?>(json['description']),
      image: serializer.fromJson<String?>(json['image']),
      link: serializer.fromJson<String?>(json['link']),
      content: serializer.fromJson<String?>(json['content']),
      variable: serializer.fromJson<String?>(json['variable']),
      read: serializer.fromJson<bool>(json['read']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'url': serializer.toJson<String>(url),
      'origin': serializer.toJson<String>(origin),
      'originName': serializer.toJson<String>(originName),
      'title': serializer.toJson<String>(title),
      'sort': serializer.toJson<String?>(sort),
      'order': serializer.toJson<int>(order),
      'pubDate': serializer.toJson<String?>(pubDate),
      'description': serializer.toJson<String?>(description),
      'image': serializer.toJson<String?>(image),
      'link': serializer.toJson<String?>(link),
      'content': serializer.toJson<String?>(content),
      'variable': serializer.toJson<String?>(variable),
      'read': serializer.toJson<bool>(read),
    };
  }

  RssArticle copyWith({
    String? url,
    String? origin,
    String? originName,
    String? title,
    Value<String?> sort = const Value.absent(),
    int? order,
    Value<String?> pubDate = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> image = const Value.absent(),
    Value<String?> link = const Value.absent(),
    Value<String?> content = const Value.absent(),
    Value<String?> variable = const Value.absent(),
    bool? read,
  }) => RssArticle(
    url: url ?? this.url,
    origin: origin ?? this.origin,
    originName: originName ?? this.originName,
    title: title ?? this.title,
    sort: sort.present ? sort.value : this.sort,
    order: order ?? this.order,
    pubDate: pubDate.present ? pubDate.value : this.pubDate,
    description: description.present ? description.value : this.description,
    image: image.present ? image.value : this.image,
    link: link.present ? link.value : this.link,
    content: content.present ? content.value : this.content,
    variable: variable.present ? variable.value : this.variable,
    read: read ?? this.read,
  );
  RssArticle copyWithCompanion(RssArticlesCompanion data) {
    return RssArticle(
      url: data.url.present ? data.url.value : this.url,
      origin: data.origin.present ? data.origin.value : this.origin,
      originName: data.originName.present
          ? data.originName.value
          : this.originName,
      title: data.title.present ? data.title.value : this.title,
      sort: data.sort.present ? data.sort.value : this.sort,
      order: data.order.present ? data.order.value : this.order,
      pubDate: data.pubDate.present ? data.pubDate.value : this.pubDate,
      description: data.description.present
          ? data.description.value
          : this.description,
      image: data.image.present ? data.image.value : this.image,
      link: data.link.present ? data.link.value : this.link,
      content: data.content.present ? data.content.value : this.content,
      variable: data.variable.present ? data.variable.value : this.variable,
      read: data.read.present ? data.read.value : this.read,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RssArticle(')
          ..write('url: $url, ')
          ..write('origin: $origin, ')
          ..write('originName: $originName, ')
          ..write('title: $title, ')
          ..write('sort: $sort, ')
          ..write('order: $order, ')
          ..write('pubDate: $pubDate, ')
          ..write('description: $description, ')
          ..write('image: $image, ')
          ..write('link: $link, ')
          ..write('content: $content, ')
          ..write('variable: $variable, ')
          ..write('read: $read')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    url,
    origin,
    originName,
    title,
    sort,
    order,
    pubDate,
    description,
    image,
    link,
    content,
    variable,
    read,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RssArticle &&
          other.url == this.url &&
          other.origin == this.origin &&
          other.originName == this.originName &&
          other.title == this.title &&
          other.sort == this.sort &&
          other.order == this.order &&
          other.pubDate == this.pubDate &&
          other.description == this.description &&
          other.image == this.image &&
          other.link == this.link &&
          other.content == this.content &&
          other.variable == this.variable &&
          other.read == this.read);
}

class RssArticlesCompanion extends UpdateCompanion<RssArticle> {
  final Value<String> url;
  final Value<String> origin;
  final Value<String> originName;
  final Value<String> title;
  final Value<String?> sort;
  final Value<int> order;
  final Value<String?> pubDate;
  final Value<String?> description;
  final Value<String?> image;
  final Value<String?> link;
  final Value<String?> content;
  final Value<String?> variable;
  final Value<bool> read;
  final Value<int> rowid;
  const RssArticlesCompanion({
    this.url = const Value.absent(),
    this.origin = const Value.absent(),
    this.originName = const Value.absent(),
    this.title = const Value.absent(),
    this.sort = const Value.absent(),
    this.order = const Value.absent(),
    this.pubDate = const Value.absent(),
    this.description = const Value.absent(),
    this.image = const Value.absent(),
    this.link = const Value.absent(),
    this.content = const Value.absent(),
    this.variable = const Value.absent(),
    this.read = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RssArticlesCompanion.insert({
    required String url,
    required String origin,
    required String originName,
    required String title,
    this.sort = const Value.absent(),
    this.order = const Value.absent(),
    this.pubDate = const Value.absent(),
    this.description = const Value.absent(),
    this.image = const Value.absent(),
    this.link = const Value.absent(),
    this.content = const Value.absent(),
    this.variable = const Value.absent(),
    this.read = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : url = Value(url),
       origin = Value(origin),
       originName = Value(originName),
       title = Value(title);
  static Insertable<RssArticle> custom({
    Expression<String>? url,
    Expression<String>? origin,
    Expression<String>? originName,
    Expression<String>? title,
    Expression<String>? sort,
    Expression<int>? order,
    Expression<String>? pubDate,
    Expression<String>? description,
    Expression<String>? image,
    Expression<String>? link,
    Expression<String>? content,
    Expression<String>? variable,
    Expression<bool>? read,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (url != null) 'url': url,
      if (origin != null) 'origin': origin,
      if (originName != null) 'origin_name': originName,
      if (title != null) 'title': title,
      if (sort != null) 'sort': sort,
      if (order != null) 'order': order,
      if (pubDate != null) 'pub_date': pubDate,
      if (description != null) 'description': description,
      if (image != null) 'image': image,
      if (link != null) 'link': link,
      if (content != null) 'content': content,
      if (variable != null) 'variable': variable,
      if (read != null) 'read': read,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RssArticlesCompanion copyWith({
    Value<String>? url,
    Value<String>? origin,
    Value<String>? originName,
    Value<String>? title,
    Value<String?>? sort,
    Value<int>? order,
    Value<String?>? pubDate,
    Value<String?>? description,
    Value<String?>? image,
    Value<String?>? link,
    Value<String?>? content,
    Value<String?>? variable,
    Value<bool>? read,
    Value<int>? rowid,
  }) {
    return RssArticlesCompanion(
      url: url ?? this.url,
      origin: origin ?? this.origin,
      originName: originName ?? this.originName,
      title: title ?? this.title,
      sort: sort ?? this.sort,
      order: order ?? this.order,
      pubDate: pubDate ?? this.pubDate,
      description: description ?? this.description,
      image: image ?? this.image,
      link: link ?? this.link,
      content: content ?? this.content,
      variable: variable ?? this.variable,
      read: read ?? this.read,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (originName.present) {
      map['origin_name'] = Variable<String>(originName.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (sort.present) {
      map['sort'] = Variable<String>(sort.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (pubDate.present) {
      map['pub_date'] = Variable<String>(pubDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (variable.present) {
      map['variable'] = Variable<String>(variable.value);
    }
    if (read.present) {
      map['read'] = Variable<bool>(read.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RssArticlesCompanion(')
          ..write('url: $url, ')
          ..write('origin: $origin, ')
          ..write('originName: $originName, ')
          ..write('title: $title, ')
          ..write('sort: $sort, ')
          ..write('order: $order, ')
          ..write('pubDate: $pubDate, ')
          ..write('description: $description, ')
          ..write('image: $image, ')
          ..write('link: $link, ')
          ..write('content: $content, ')
          ..write('variable: $variable, ')
          ..write('read: $read, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SearchKeywordsTable extends SearchKeywords
    with TableInfo<$SearchKeywordsTable, SearchKeyword> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchKeywordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usageMeta = const VerificationMeta('usage');
  @override
  late final GeneratedColumn<int> usage = GeneratedColumn<int>(
    'usage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastUseTimeMeta = const VerificationMeta(
    'lastUseTime',
  );
  @override
  late final GeneratedColumn<int> lastUseTime = GeneratedColumn<int>(
    'last_use_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [word, usage, lastUseTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_keywords';
  @override
  VerificationContext validateIntegrity(
    Insertable<SearchKeyword> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('usage')) {
      context.handle(
        _usageMeta,
        usage.isAcceptableOrUnknown(data['usage']!, _usageMeta),
      );
    }
    if (data.containsKey('last_use_time')) {
      context.handle(
        _lastUseTimeMeta,
        lastUseTime.isAcceptableOrUnknown(
          data['last_use_time']!,
          _lastUseTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUseTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {word};
  @override
  SearchKeyword map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchKeyword(
      word: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word'],
      )!,
      usage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usage'],
      )!,
      lastUseTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_use_time'],
      )!,
    );
  }

  @override
  $SearchKeywordsTable createAlias(String alias) {
    return $SearchKeywordsTable(attachedDatabase, alias);
  }
}

class SearchKeyword extends DataClass implements Insertable<SearchKeyword> {
  final String word;
  final int usage;
  final int lastUseTime;
  const SearchKeyword({
    required this.word,
    required this.usage,
    required this.lastUseTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word'] = Variable<String>(word);
    map['usage'] = Variable<int>(usage);
    map['last_use_time'] = Variable<int>(lastUseTime);
    return map;
  }

  SearchKeywordsCompanion toCompanion(bool nullToAbsent) {
    return SearchKeywordsCompanion(
      word: Value(word),
      usage: Value(usage),
      lastUseTime: Value(lastUseTime),
    );
  }

  factory SearchKeyword.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchKeyword(
      word: serializer.fromJson<String>(json['word']),
      usage: serializer.fromJson<int>(json['usage']),
      lastUseTime: serializer.fromJson<int>(json['lastUseTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'word': serializer.toJson<String>(word),
      'usage': serializer.toJson<int>(usage),
      'lastUseTime': serializer.toJson<int>(lastUseTime),
    };
  }

  SearchKeyword copyWith({String? word, int? usage, int? lastUseTime}) =>
      SearchKeyword(
        word: word ?? this.word,
        usage: usage ?? this.usage,
        lastUseTime: lastUseTime ?? this.lastUseTime,
      );
  SearchKeyword copyWithCompanion(SearchKeywordsCompanion data) {
    return SearchKeyword(
      word: data.word.present ? data.word.value : this.word,
      usage: data.usage.present ? data.usage.value : this.usage,
      lastUseTime: data.lastUseTime.present
          ? data.lastUseTime.value
          : this.lastUseTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchKeyword(')
          ..write('word: $word, ')
          ..write('usage: $usage, ')
          ..write('lastUseTime: $lastUseTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(word, usage, lastUseTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchKeyword &&
          other.word == this.word &&
          other.usage == this.usage &&
          other.lastUseTime == this.lastUseTime);
}

class SearchKeywordsCompanion extends UpdateCompanion<SearchKeyword> {
  final Value<String> word;
  final Value<int> usage;
  final Value<int> lastUseTime;
  final Value<int> rowid;
  const SearchKeywordsCompanion({
    this.word = const Value.absent(),
    this.usage = const Value.absent(),
    this.lastUseTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SearchKeywordsCompanion.insert({
    required String word,
    this.usage = const Value.absent(),
    required int lastUseTime,
    this.rowid = const Value.absent(),
  }) : word = Value(word),
       lastUseTime = Value(lastUseTime);
  static Insertable<SearchKeyword> custom({
    Expression<String>? word,
    Expression<int>? usage,
    Expression<int>? lastUseTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (word != null) 'word': word,
      if (usage != null) 'usage': usage,
      if (lastUseTime != null) 'last_use_time': lastUseTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SearchKeywordsCompanion copyWith({
    Value<String>? word,
    Value<int>? usage,
    Value<int>? lastUseTime,
    Value<int>? rowid,
  }) {
    return SearchKeywordsCompanion(
      word: word ?? this.word,
      usage: usage ?? this.usage,
      lastUseTime: lastUseTime ?? this.lastUseTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (usage.present) {
      map['usage'] = Variable<int>(usage.value);
    }
    if (lastUseTime.present) {
      map['last_use_time'] = Variable<int>(lastUseTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchKeywordsCompanion(')
          ..write('word: $word, ')
          ..write('usage: $usage, ')
          ..write('lastUseTime: $lastUseTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TxtTocRulesTable extends TxtTocRules
    with TableInfo<$TxtTocRulesTable, TxtTocRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TxtTocRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ruleMeta = const VerificationMeta('rule');
  @override
  late final GeneratedColumn<String> rule = GeneratedColumn<String>(
    'rule',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _serialNumberMeta = const VerificationMeta(
    'serialNumber',
  );
  @override
  late final GeneratedColumn<int> serialNumber = GeneratedColumn<int>(
    'serial_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _exampleMeta = const VerificationMeta(
    'example',
  );
  @override
  late final GeneratedColumn<String> example = GeneratedColumn<String>(
    'example',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    rule,
    enabled,
    serialNumber,
    example,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'txt_toc_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<TxtTocRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('rule')) {
      context.handle(
        _ruleMeta,
        rule.isAcceptableOrUnknown(data['rule']!, _ruleMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('serial_number')) {
      context.handle(
        _serialNumberMeta,
        serialNumber.isAcceptableOrUnknown(
          data['serial_number']!,
          _serialNumberMeta,
        ),
      );
    }
    if (data.containsKey('example')) {
      context.handle(
        _exampleMeta,
        example.isAcceptableOrUnknown(data['example']!, _exampleMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TxtTocRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TxtTocRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      rule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      serialNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}serial_number'],
      )!,
      example: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}example'],
      ),
    );
  }

  @override
  $TxtTocRulesTable createAlias(String alias) {
    return $TxtTocRulesTable(attachedDatabase, alias);
  }
}

class TxtTocRule extends DataClass implements Insertable<TxtTocRule> {
  final int id;
  final String name;
  final String rule;
  final bool enabled;
  final int serialNumber;
  final String? example;
  const TxtTocRule({
    required this.id,
    required this.name,
    required this.rule,
    required this.enabled,
    required this.serialNumber,
    this.example,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['rule'] = Variable<String>(rule);
    map['enabled'] = Variable<bool>(enabled);
    map['serial_number'] = Variable<int>(serialNumber);
    if (!nullToAbsent || example != null) {
      map['example'] = Variable<String>(example);
    }
    return map;
  }

  TxtTocRulesCompanion toCompanion(bool nullToAbsent) {
    return TxtTocRulesCompanion(
      id: Value(id),
      name: Value(name),
      rule: Value(rule),
      enabled: Value(enabled),
      serialNumber: Value(serialNumber),
      example: example == null && nullToAbsent
          ? const Value.absent()
          : Value(example),
    );
  }

  factory TxtTocRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TxtTocRule(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      rule: serializer.fromJson<String>(json['rule']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      serialNumber: serializer.fromJson<int>(json['serialNumber']),
      example: serializer.fromJson<String?>(json['example']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'rule': serializer.toJson<String>(rule),
      'enabled': serializer.toJson<bool>(enabled),
      'serialNumber': serializer.toJson<int>(serialNumber),
      'example': serializer.toJson<String?>(example),
    };
  }

  TxtTocRule copyWith({
    int? id,
    String? name,
    String? rule,
    bool? enabled,
    int? serialNumber,
    Value<String?> example = const Value.absent(),
  }) => TxtTocRule(
    id: id ?? this.id,
    name: name ?? this.name,
    rule: rule ?? this.rule,
    enabled: enabled ?? this.enabled,
    serialNumber: serialNumber ?? this.serialNumber,
    example: example.present ? example.value : this.example,
  );
  TxtTocRule copyWithCompanion(TxtTocRulesCompanion data) {
    return TxtTocRule(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      rule: data.rule.present ? data.rule.value : this.rule,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      serialNumber: data.serialNumber.present
          ? data.serialNumber.value
          : this.serialNumber,
      example: data.example.present ? data.example.value : this.example,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TxtTocRule(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rule: $rule, ')
          ..write('enabled: $enabled, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('example: $example')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, rule, enabled, serialNumber, example);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TxtTocRule &&
          other.id == this.id &&
          other.name == this.name &&
          other.rule == this.rule &&
          other.enabled == this.enabled &&
          other.serialNumber == this.serialNumber &&
          other.example == this.example);
}

class TxtTocRulesCompanion extends UpdateCompanion<TxtTocRule> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> rule;
  final Value<bool> enabled;
  final Value<int> serialNumber;
  final Value<String?> example;
  const TxtTocRulesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rule = const Value.absent(),
    this.enabled = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.example = const Value.absent(),
  });
  TxtTocRulesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String rule,
    this.enabled = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.example = const Value.absent(),
  }) : name = Value(name),
       rule = Value(rule);
  static Insertable<TxtTocRule> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? rule,
    Expression<bool>? enabled,
    Expression<int>? serialNumber,
    Expression<String>? example,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rule != null) 'rule': rule,
      if (enabled != null) 'enabled': enabled,
      if (serialNumber != null) 'serial_number': serialNumber,
      if (example != null) 'example': example,
    });
  }

  TxtTocRulesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? rule,
    Value<bool>? enabled,
    Value<int>? serialNumber,
    Value<String?>? example,
  }) {
    return TxtTocRulesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rule: rule ?? this.rule,
      enabled: enabled ?? this.enabled,
      serialNumber: serialNumber ?? this.serialNumber,
      example: example ?? this.example,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rule.present) {
      map['rule'] = Variable<String>(rule.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (serialNumber.present) {
      map['serial_number'] = Variable<int>(serialNumber.value);
    }
    if (example.present) {
      map['example'] = Variable<String>(example.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TxtTocRulesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rule: $rule, ')
          ..write('enabled: $enabled, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('example: $example')
          ..write(')'))
        .toString();
  }
}

class $HttpTtsTable extends HttpTts with TableInfo<$HttpTtsTable, HttpTt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HttpTtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _headerMeta = const VerificationMeta('header');
  @override
  late final GeneratedColumn<String> header = GeneratedColumn<String>(
    'header',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loginCheckJsMeta = const VerificationMeta(
    'loginCheckJs',
  );
  @override
  late final GeneratedColumn<String> loginCheckJs = GeneratedColumn<String>(
    'login_check_js',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loginUrlMeta = const VerificationMeta(
    'loginUrl',
  );
  @override
  late final GeneratedColumn<String> loginUrl = GeneratedColumn<String>(
    'login_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loginUiMeta = const VerificationMeta(
    'loginUi',
  );
  @override
  late final GeneratedColumn<String> loginUi = GeneratedColumn<String>(
    'login_ui',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupMeta = const VerificationMeta('group');
  @override
  late final GeneratedColumn<String> group = GeneratedColumn<String>(
    'group',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortNumberMeta = const VerificationMeta(
    'sortNumber',
  );
  @override
  late final GeneratedColumn<int> sortNumber = GeneratedColumn<int>(
    'sort_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    url,
    header,
    loginCheckJs,
    loginUrl,
    loginUi,
    comment,
    group,
    sortNumber,
    enabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'http_tts';
  @override
  VerificationContext validateIntegrity(
    Insertable<HttpTt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('header')) {
      context.handle(
        _headerMeta,
        header.isAcceptableOrUnknown(data['header']!, _headerMeta),
      );
    }
    if (data.containsKey('login_check_js')) {
      context.handle(
        _loginCheckJsMeta,
        loginCheckJs.isAcceptableOrUnknown(
          data['login_check_js']!,
          _loginCheckJsMeta,
        ),
      );
    }
    if (data.containsKey('login_url')) {
      context.handle(
        _loginUrlMeta,
        loginUrl.isAcceptableOrUnknown(data['login_url']!, _loginUrlMeta),
      );
    }
    if (data.containsKey('login_ui')) {
      context.handle(
        _loginUiMeta,
        loginUi.isAcceptableOrUnknown(data['login_ui']!, _loginUiMeta),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('group')) {
      context.handle(
        _groupMeta,
        group.isAcceptableOrUnknown(data['group']!, _groupMeta),
      );
    }
    if (data.containsKey('sort_number')) {
      context.handle(
        _sortNumberMeta,
        sortNumber.isAcceptableOrUnknown(data['sort_number']!, _sortNumberMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HttpTt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HttpTt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      header: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}header'],
      ),
      loginCheckJs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_check_js'],
      ),
      loginUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_url'],
      ),
      loginUi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_ui'],
      ),
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
      group: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group'],
      ),
      sortNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_number'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $HttpTtsTable createAlias(String alias) {
    return $HttpTtsTable(attachedDatabase, alias);
  }
}

class HttpTt extends DataClass implements Insertable<HttpTt> {
  final int id;
  final String name;
  final String url;
  final String? header;
  final String? loginCheckJs;
  final String? loginUrl;
  final String? loginUi;
  final String? comment;
  final String? group;
  final int sortNumber;
  final bool enabled;
  const HttpTt({
    required this.id,
    required this.name,
    required this.url,
    this.header,
    this.loginCheckJs,
    this.loginUrl,
    this.loginUi,
    this.comment,
    this.group,
    required this.sortNumber,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || header != null) {
      map['header'] = Variable<String>(header);
    }
    if (!nullToAbsent || loginCheckJs != null) {
      map['login_check_js'] = Variable<String>(loginCheckJs);
    }
    if (!nullToAbsent || loginUrl != null) {
      map['login_url'] = Variable<String>(loginUrl);
    }
    if (!nullToAbsent || loginUi != null) {
      map['login_ui'] = Variable<String>(loginUi);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    if (!nullToAbsent || group != null) {
      map['group'] = Variable<String>(group);
    }
    map['sort_number'] = Variable<int>(sortNumber);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  HttpTtsCompanion toCompanion(bool nullToAbsent) {
    return HttpTtsCompanion(
      id: Value(id),
      name: Value(name),
      url: Value(url),
      header: header == null && nullToAbsent
          ? const Value.absent()
          : Value(header),
      loginCheckJs: loginCheckJs == null && nullToAbsent
          ? const Value.absent()
          : Value(loginCheckJs),
      loginUrl: loginUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(loginUrl),
      loginUi: loginUi == null && nullToAbsent
          ? const Value.absent()
          : Value(loginUi),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      group: group == null && nullToAbsent
          ? const Value.absent()
          : Value(group),
      sortNumber: Value(sortNumber),
      enabled: Value(enabled),
    );
  }

  factory HttpTt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HttpTt(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      url: serializer.fromJson<String>(json['url']),
      header: serializer.fromJson<String?>(json['header']),
      loginCheckJs: serializer.fromJson<String?>(json['loginCheckJs']),
      loginUrl: serializer.fromJson<String?>(json['loginUrl']),
      loginUi: serializer.fromJson<String?>(json['loginUi']),
      comment: serializer.fromJson<String?>(json['comment']),
      group: serializer.fromJson<String?>(json['group']),
      sortNumber: serializer.fromJson<int>(json['sortNumber']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'url': serializer.toJson<String>(url),
      'header': serializer.toJson<String?>(header),
      'loginCheckJs': serializer.toJson<String?>(loginCheckJs),
      'loginUrl': serializer.toJson<String?>(loginUrl),
      'loginUi': serializer.toJson<String?>(loginUi),
      'comment': serializer.toJson<String?>(comment),
      'group': serializer.toJson<String?>(group),
      'sortNumber': serializer.toJson<int>(sortNumber),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  HttpTt copyWith({
    int? id,
    String? name,
    String? url,
    Value<String?> header = const Value.absent(),
    Value<String?> loginCheckJs = const Value.absent(),
    Value<String?> loginUrl = const Value.absent(),
    Value<String?> loginUi = const Value.absent(),
    Value<String?> comment = const Value.absent(),
    Value<String?> group = const Value.absent(),
    int? sortNumber,
    bool? enabled,
  }) => HttpTt(
    id: id ?? this.id,
    name: name ?? this.name,
    url: url ?? this.url,
    header: header.present ? header.value : this.header,
    loginCheckJs: loginCheckJs.present ? loginCheckJs.value : this.loginCheckJs,
    loginUrl: loginUrl.present ? loginUrl.value : this.loginUrl,
    loginUi: loginUi.present ? loginUi.value : this.loginUi,
    comment: comment.present ? comment.value : this.comment,
    group: group.present ? group.value : this.group,
    sortNumber: sortNumber ?? this.sortNumber,
    enabled: enabled ?? this.enabled,
  );
  HttpTt copyWithCompanion(HttpTtsCompanion data) {
    return HttpTt(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      url: data.url.present ? data.url.value : this.url,
      header: data.header.present ? data.header.value : this.header,
      loginCheckJs: data.loginCheckJs.present
          ? data.loginCheckJs.value
          : this.loginCheckJs,
      loginUrl: data.loginUrl.present ? data.loginUrl.value : this.loginUrl,
      loginUi: data.loginUi.present ? data.loginUi.value : this.loginUi,
      comment: data.comment.present ? data.comment.value : this.comment,
      group: data.group.present ? data.group.value : this.group,
      sortNumber: data.sortNumber.present
          ? data.sortNumber.value
          : this.sortNumber,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HttpTt(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('header: $header, ')
          ..write('loginCheckJs: $loginCheckJs, ')
          ..write('loginUrl: $loginUrl, ')
          ..write('loginUi: $loginUi, ')
          ..write('comment: $comment, ')
          ..write('group: $group, ')
          ..write('sortNumber: $sortNumber, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    url,
    header,
    loginCheckJs,
    loginUrl,
    loginUi,
    comment,
    group,
    sortNumber,
    enabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HttpTt &&
          other.id == this.id &&
          other.name == this.name &&
          other.url == this.url &&
          other.header == this.header &&
          other.loginCheckJs == this.loginCheckJs &&
          other.loginUrl == this.loginUrl &&
          other.loginUi == this.loginUi &&
          other.comment == this.comment &&
          other.group == this.group &&
          other.sortNumber == this.sortNumber &&
          other.enabled == this.enabled);
}

class HttpTtsCompanion extends UpdateCompanion<HttpTt> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> url;
  final Value<String?> header;
  final Value<String?> loginCheckJs;
  final Value<String?> loginUrl;
  final Value<String?> loginUi;
  final Value<String?> comment;
  final Value<String?> group;
  final Value<int> sortNumber;
  final Value<bool> enabled;
  const HttpTtsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.url = const Value.absent(),
    this.header = const Value.absent(),
    this.loginCheckJs = const Value.absent(),
    this.loginUrl = const Value.absent(),
    this.loginUi = const Value.absent(),
    this.comment = const Value.absent(),
    this.group = const Value.absent(),
    this.sortNumber = const Value.absent(),
    this.enabled = const Value.absent(),
  });
  HttpTtsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String url,
    this.header = const Value.absent(),
    this.loginCheckJs = const Value.absent(),
    this.loginUrl = const Value.absent(),
    this.loginUi = const Value.absent(),
    this.comment = const Value.absent(),
    this.group = const Value.absent(),
    this.sortNumber = const Value.absent(),
    this.enabled = const Value.absent(),
  }) : name = Value(name),
       url = Value(url);
  static Insertable<HttpTt> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? url,
    Expression<String>? header,
    Expression<String>? loginCheckJs,
    Expression<String>? loginUrl,
    Expression<String>? loginUi,
    Expression<String>? comment,
    Expression<String>? group,
    Expression<int>? sortNumber,
    Expression<bool>? enabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (url != null) 'url': url,
      if (header != null) 'header': header,
      if (loginCheckJs != null) 'login_check_js': loginCheckJs,
      if (loginUrl != null) 'login_url': loginUrl,
      if (loginUi != null) 'login_ui': loginUi,
      if (comment != null) 'comment': comment,
      if (group != null) 'group': group,
      if (sortNumber != null) 'sort_number': sortNumber,
      if (enabled != null) 'enabled': enabled,
    });
  }

  HttpTtsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? url,
    Value<String?>? header,
    Value<String?>? loginCheckJs,
    Value<String?>? loginUrl,
    Value<String?>? loginUi,
    Value<String?>? comment,
    Value<String?>? group,
    Value<int>? sortNumber,
    Value<bool>? enabled,
  }) {
    return HttpTtsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      header: header ?? this.header,
      loginCheckJs: loginCheckJs ?? this.loginCheckJs,
      loginUrl: loginUrl ?? this.loginUrl,
      loginUi: loginUi ?? this.loginUi,
      comment: comment ?? this.comment,
      group: group ?? this.group,
      sortNumber: sortNumber ?? this.sortNumber,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (header.present) {
      map['header'] = Variable<String>(header.value);
    }
    if (loginCheckJs.present) {
      map['login_check_js'] = Variable<String>(loginCheckJs.value);
    }
    if (loginUrl.present) {
      map['login_url'] = Variable<String>(loginUrl.value);
    }
    if (loginUi.present) {
      map['login_ui'] = Variable<String>(loginUi.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (group.present) {
      map['group'] = Variable<String>(group.value);
    }
    if (sortNumber.present) {
      map['sort_number'] = Variable<int>(sortNumber.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HttpTtsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('header: $header, ')
          ..write('loginCheckJs: $loginCheckJs, ')
          ..write('loginUrl: $loginUrl, ')
          ..write('loginUi: $loginUi, ')
          ..write('comment: $comment, ')
          ..write('group: $group, ')
          ..write('sortNumber: $sortNumber, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }
}

class $DictRulesTable extends DictRules
    with TableInfo<$DictRulesTable, DictRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DictRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlRuleMeta = const VerificationMeta(
    'urlRule',
  );
  @override
  late final GeneratedColumn<String> urlRule = GeneratedColumn<String>(
    'url_rule',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sortNumberMeta = const VerificationMeta(
    'sortNumber',
  );
  @override
  late final GeneratedColumn<int> sortNumber = GeneratedColumn<int>(
    'sort_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _showRuleMeta = const VerificationMeta(
    'showRule',
  );
  @override
  late final GeneratedColumn<String> showRule = GeneratedColumn<String>(
    'show_rule',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enabledExploreMeta = const VerificationMeta(
    'enabledExplore',
  );
  @override
  late final GeneratedColumn<bool> enabledExplore = GeneratedColumn<bool>(
    'enabled_explore',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled_explore" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    name,
    urlRule,
    enabled,
    sortNumber,
    showRule,
    enabledExplore,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dict_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<DictRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('url_rule')) {
      context.handle(
        _urlRuleMeta,
        urlRule.isAcceptableOrUnknown(data['url_rule']!, _urlRuleMeta),
      );
    } else if (isInserting) {
      context.missing(_urlRuleMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('sort_number')) {
      context.handle(
        _sortNumberMeta,
        sortNumber.isAcceptableOrUnknown(data['sort_number']!, _sortNumberMeta),
      );
    }
    if (data.containsKey('show_rule')) {
      context.handle(
        _showRuleMeta,
        showRule.isAcceptableOrUnknown(data['show_rule']!, _showRuleMeta),
      );
    }
    if (data.containsKey('enabled_explore')) {
      context.handle(
        _enabledExploreMeta,
        enabledExplore.isAcceptableOrUnknown(
          data['enabled_explore']!,
          _enabledExploreMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  DictRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DictRule(
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      urlRule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url_rule'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      sortNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_number'],
      )!,
      showRule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}show_rule'],
      ),
      enabledExplore: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled_explore'],
      )!,
    );
  }

  @override
  $DictRulesTable createAlias(String alias) {
    return $DictRulesTable(attachedDatabase, alias);
  }
}

class DictRule extends DataClass implements Insertable<DictRule> {
  final String name;
  final String urlRule;
  final bool enabled;
  final int sortNumber;
  final String? showRule;
  final bool enabledExplore;
  const DictRule({
    required this.name,
    required this.urlRule,
    required this.enabled,
    required this.sortNumber,
    this.showRule,
    required this.enabledExplore,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['url_rule'] = Variable<String>(urlRule);
    map['enabled'] = Variable<bool>(enabled);
    map['sort_number'] = Variable<int>(sortNumber);
    if (!nullToAbsent || showRule != null) {
      map['show_rule'] = Variable<String>(showRule);
    }
    map['enabled_explore'] = Variable<bool>(enabledExplore);
    return map;
  }

  DictRulesCompanion toCompanion(bool nullToAbsent) {
    return DictRulesCompanion(
      name: Value(name),
      urlRule: Value(urlRule),
      enabled: Value(enabled),
      sortNumber: Value(sortNumber),
      showRule: showRule == null && nullToAbsent
          ? const Value.absent()
          : Value(showRule),
      enabledExplore: Value(enabledExplore),
    );
  }

  factory DictRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DictRule(
      name: serializer.fromJson<String>(json['name']),
      urlRule: serializer.fromJson<String>(json['urlRule']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      sortNumber: serializer.fromJson<int>(json['sortNumber']),
      showRule: serializer.fromJson<String?>(json['showRule']),
      enabledExplore: serializer.fromJson<bool>(json['enabledExplore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'urlRule': serializer.toJson<String>(urlRule),
      'enabled': serializer.toJson<bool>(enabled),
      'sortNumber': serializer.toJson<int>(sortNumber),
      'showRule': serializer.toJson<String?>(showRule),
      'enabledExplore': serializer.toJson<bool>(enabledExplore),
    };
  }

  DictRule copyWith({
    String? name,
    String? urlRule,
    bool? enabled,
    int? sortNumber,
    Value<String?> showRule = const Value.absent(),
    bool? enabledExplore,
  }) => DictRule(
    name: name ?? this.name,
    urlRule: urlRule ?? this.urlRule,
    enabled: enabled ?? this.enabled,
    sortNumber: sortNumber ?? this.sortNumber,
    showRule: showRule.present ? showRule.value : this.showRule,
    enabledExplore: enabledExplore ?? this.enabledExplore,
  );
  DictRule copyWithCompanion(DictRulesCompanion data) {
    return DictRule(
      name: data.name.present ? data.name.value : this.name,
      urlRule: data.urlRule.present ? data.urlRule.value : this.urlRule,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      sortNumber: data.sortNumber.present
          ? data.sortNumber.value
          : this.sortNumber,
      showRule: data.showRule.present ? data.showRule.value : this.showRule,
      enabledExplore: data.enabledExplore.present
          ? data.enabledExplore.value
          : this.enabledExplore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DictRule(')
          ..write('name: $name, ')
          ..write('urlRule: $urlRule, ')
          ..write('enabled: $enabled, ')
          ..write('sortNumber: $sortNumber, ')
          ..write('showRule: $showRule, ')
          ..write('enabledExplore: $enabledExplore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(name, urlRule, enabled, sortNumber, showRule, enabledExplore);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DictRule &&
          other.name == this.name &&
          other.urlRule == this.urlRule &&
          other.enabled == this.enabled &&
          other.sortNumber == this.sortNumber &&
          other.showRule == this.showRule &&
          other.enabledExplore == this.enabledExplore);
}

class DictRulesCompanion extends UpdateCompanion<DictRule> {
  final Value<String> name;
  final Value<String> urlRule;
  final Value<bool> enabled;
  final Value<int> sortNumber;
  final Value<String?> showRule;
  final Value<bool> enabledExplore;
  final Value<int> rowid;
  const DictRulesCompanion({
    this.name = const Value.absent(),
    this.urlRule = const Value.absent(),
    this.enabled = const Value.absent(),
    this.sortNumber = const Value.absent(),
    this.showRule = const Value.absent(),
    this.enabledExplore = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DictRulesCompanion.insert({
    required String name,
    required String urlRule,
    this.enabled = const Value.absent(),
    this.sortNumber = const Value.absent(),
    this.showRule = const Value.absent(),
    this.enabledExplore = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       urlRule = Value(urlRule);
  static Insertable<DictRule> custom({
    Expression<String>? name,
    Expression<String>? urlRule,
    Expression<bool>? enabled,
    Expression<int>? sortNumber,
    Expression<String>? showRule,
    Expression<bool>? enabledExplore,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (urlRule != null) 'url_rule': urlRule,
      if (enabled != null) 'enabled': enabled,
      if (sortNumber != null) 'sort_number': sortNumber,
      if (showRule != null) 'show_rule': showRule,
      if (enabledExplore != null) 'enabled_explore': enabledExplore,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DictRulesCompanion copyWith({
    Value<String>? name,
    Value<String>? urlRule,
    Value<bool>? enabled,
    Value<int>? sortNumber,
    Value<String?>? showRule,
    Value<bool>? enabledExplore,
    Value<int>? rowid,
  }) {
    return DictRulesCompanion(
      name: name ?? this.name,
      urlRule: urlRule ?? this.urlRule,
      enabled: enabled ?? this.enabled,
      sortNumber: sortNumber ?? this.sortNumber,
      showRule: showRule ?? this.showRule,
      enabledExplore: enabledExplore ?? this.enabledExplore,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (urlRule.present) {
      map['url_rule'] = Variable<String>(urlRule.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (sortNumber.present) {
      map['sort_number'] = Variable<int>(sortNumber.value);
    }
    if (showRule.present) {
      map['show_rule'] = Variable<String>(showRule.value);
    }
    if (enabledExplore.present) {
      map['enabled_explore'] = Variable<bool>(enabledExplore.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictRulesCompanion(')
          ..write('name: $name, ')
          ..write('urlRule: $urlRule, ')
          ..write('enabled: $enabled, ')
          ..write('sortNumber: $sortNumber, ')
          ..write('showRule: $showRule, ')
          ..write('enabledExplore: $enabledExplore, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bookUrlMeta = const VerificationMeta(
    'bookUrl',
  );
  @override
  late final GeneratedColumn<String> bookUrl = GeneratedColumn<String>(
    'book_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bookNameMeta = const VerificationMeta(
    'bookName',
  );
  @override
  late final GeneratedColumn<String> bookName = GeneratedColumn<String>(
    'book_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chapterIndexMeta = const VerificationMeta(
    'chapterIndex',
  );
  @override
  late final GeneratedColumn<int> chapterIndex = GeneratedColumn<int>(
    'chapter_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createTimeMeta = const VerificationMeta(
    'createTime',
  );
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
    'create_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updateTimeMeta = const VerificationMeta(
    'updateTime',
  );
  @override
  late final GeneratedColumn<int> updateTime = GeneratedColumn<int>(
    'update_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    content,
    bookUrl,
    bookName,
    chapterIndex,
    createTime,
    updateTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Note> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('book_url')) {
      context.handle(
        _bookUrlMeta,
        bookUrl.isAcceptableOrUnknown(data['book_url']!, _bookUrlMeta),
      );
    }
    if (data.containsKey('book_name')) {
      context.handle(
        _bookNameMeta,
        bookName.isAcceptableOrUnknown(data['book_name']!, _bookNameMeta),
      );
    }
    if (data.containsKey('chapter_index')) {
      context.handle(
        _chapterIndexMeta,
        chapterIndex.isAcceptableOrUnknown(
          data['chapter_index']!,
          _chapterIndexMeta,
        ),
      );
    }
    if (data.containsKey('create_time')) {
      context.handle(
        _createTimeMeta,
        createTime.isAcceptableOrUnknown(data['create_time']!, _createTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('update_time')) {
      context.handle(
        _updateTimeMeta,
        updateTime.isAcceptableOrUnknown(data['update_time']!, _updateTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_updateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      bookUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_url'],
      ),
      bookName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_name'],
      ),
      chapterIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter_index'],
      ),
      createTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}create_time'],
      )!,
      updateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}update_time'],
      )!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  /// 主键（自增）
  final int id;

  /// 标题
  final String title;

  /// 正文
  final String content;

  /// 关联书籍 URL（可空，表示未关联书）
  final String? bookUrl;

  /// 关联书籍名称（冗余，便于列表展示）
  final String? bookName;

  /// 关联章节索引（可空）
  final int? chapterIndex;

  /// 创建时间（毫秒）
  final int createTime;

  /// 更新时间（毫秒）
  final int updateTime;
  const Note({
    required this.id,
    required this.title,
    required this.content,
    this.bookUrl,
    this.bookName,
    this.chapterIndex,
    required this.createTime,
    required this.updateTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || bookUrl != null) {
      map['book_url'] = Variable<String>(bookUrl);
    }
    if (!nullToAbsent || bookName != null) {
      map['book_name'] = Variable<String>(bookName);
    }
    if (!nullToAbsent || chapterIndex != null) {
      map['chapter_index'] = Variable<int>(chapterIndex);
    }
    map['create_time'] = Variable<int>(createTime);
    map['update_time'] = Variable<int>(updateTime);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      bookUrl: bookUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(bookUrl),
      bookName: bookName == null && nullToAbsent
          ? const Value.absent()
          : Value(bookName),
      chapterIndex: chapterIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(chapterIndex),
      createTime: Value(createTime),
      updateTime: Value(updateTime),
    );
  }

  factory Note.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      bookUrl: serializer.fromJson<String?>(json['bookUrl']),
      bookName: serializer.fromJson<String?>(json['bookName']),
      chapterIndex: serializer.fromJson<int?>(json['chapterIndex']),
      createTime: serializer.fromJson<int>(json['createTime']),
      updateTime: serializer.fromJson<int>(json['updateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'bookUrl': serializer.toJson<String?>(bookUrl),
      'bookName': serializer.toJson<String?>(bookName),
      'chapterIndex': serializer.toJson<int?>(chapterIndex),
      'createTime': serializer.toJson<int>(createTime),
      'updateTime': serializer.toJson<int>(updateTime),
    };
  }

  Note copyWith({
    int? id,
    String? title,
    String? content,
    Value<String?> bookUrl = const Value.absent(),
    Value<String?> bookName = const Value.absent(),
    Value<int?> chapterIndex = const Value.absent(),
    int? createTime,
    int? updateTime,
  }) => Note(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    bookUrl: bookUrl.present ? bookUrl.value : this.bookUrl,
    bookName: bookName.present ? bookName.value : this.bookName,
    chapterIndex: chapterIndex.present ? chapterIndex.value : this.chapterIndex,
    createTime: createTime ?? this.createTime,
    updateTime: updateTime ?? this.updateTime,
  );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      bookUrl: data.bookUrl.present ? data.bookUrl.value : this.bookUrl,
      bookName: data.bookName.present ? data.bookName.value : this.bookName,
      chapterIndex: data.chapterIndex.present
          ? data.chapterIndex.value
          : this.chapterIndex,
      createTime: data.createTime.present
          ? data.createTime.value
          : this.createTime,
      updateTime: data.updateTime.present
          ? data.updateTime.value
          : this.updateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('bookUrl: $bookUrl, ')
          ..write('bookName: $bookName, ')
          ..write('chapterIndex: $chapterIndex, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    content,
    bookUrl,
    bookName,
    chapterIndex,
    createTime,
    updateTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.bookUrl == this.bookUrl &&
          other.bookName == this.bookName &&
          other.chapterIndex == this.chapterIndex &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<String?> bookUrl;
  final Value<String?> bookName;
  final Value<int?> chapterIndex;
  final Value<int> createTime;
  final Value<int> updateTime;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.bookUrl = const Value.absent(),
    this.bookName = const Value.absent(),
    this.chapterIndex = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.bookUrl = const Value.absent(),
    this.bookName = const Value.absent(),
    this.chapterIndex = const Value.absent(),
    required int createTime,
    required int updateTime,
  }) : createTime = Value(createTime),
       updateTime = Value(updateTime);
  static Insertable<Note> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? bookUrl,
    Expression<String>? bookName,
    Expression<int>? chapterIndex,
    Expression<int>? createTime,
    Expression<int>? updateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (bookUrl != null) 'book_url': bookUrl,
      if (bookName != null) 'book_name': bookName,
      if (chapterIndex != null) 'chapter_index': chapterIndex,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
    });
  }

  NotesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? content,
    Value<String?>? bookUrl,
    Value<String?>? bookName,
    Value<int?>? chapterIndex,
    Value<int>? createTime,
    Value<int>? updateTime,
  }) {
    return NotesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      bookUrl: bookUrl ?? this.bookUrl,
      bookName: bookName ?? this.bookName,
      chapterIndex: chapterIndex ?? this.chapterIndex,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (bookUrl.present) {
      map['book_url'] = Variable<String>(bookUrl.value);
    }
    if (bookName.present) {
      map['book_name'] = Variable<String>(bookName.value);
    }
    if (chapterIndex.present) {
      map['chapter_index'] = Variable<int>(chapterIndex.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<int>(updateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('bookUrl: $bookUrl, ')
          ..write('bookName: $bookName, ')
          ..write('chapterIndex: $chapterIndex, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BookSourcesTable bookSources = $BookSourcesTable(this);
  late final $BooksTable books = $BooksTable(this);
  late final $BookChaptersTable bookChapters = $BookChaptersTable(this);
  late final $BookGroupsTable bookGroups = $BookGroupsTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $ReplaceRulesTable replaceRules = $ReplaceRulesTable(this);
  late final $SearchBooksTable searchBooks = $SearchBooksTable(this);
  late final $RssSourcesTable rssSources = $RssSourcesTable(this);
  late final $RssArticlesTable rssArticles = $RssArticlesTable(this);
  late final $SearchKeywordsTable searchKeywords = $SearchKeywordsTable(this);
  late final $TxtTocRulesTable txtTocRules = $TxtTocRulesTable(this);
  late final $HttpTtsTable httpTts = $HttpTtsTable(this);
  late final $DictRulesTable dictRules = $DictRulesTable(this);
  late final $NotesTable notes = $NotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    bookSources,
    books,
    bookChapters,
    bookGroups,
    bookmarks,
    replaceRules,
    searchBooks,
    rssSources,
    rssArticles,
    searchKeywords,
    txtTocRules,
    httpTts,
    dictRules,
    notes,
  ];
}

typedef $$BookSourcesTableCreateCompanionBuilder =
    BookSourcesCompanion Function({
      required String bookSourceUrl,
      required String bookSourceName,
      Value<String?> bookSourceGroup,
      Value<int> bookSourceType,
      Value<String?> bookUrlPattern,
      Value<int> customOrder,
      Value<bool> enabled,
      Value<bool> enabledExplore,
      Value<bool> enabledCookieJar,
      Value<String?> jsLib,
      Value<String?> concurrentRate,
      Value<String?> header,
      Value<String?> loginUrl,
      Value<String?> loginUi,
      Value<String?> loginCheckJs,
      Value<String?> searchUrl,
      Value<String?> exploreUrl,
      Value<String?> exploreScreen,
      Value<String?> ruleSearch,
      Value<String?> ruleExplore,
      Value<String?> ruleBookInfo,
      Value<String?> ruleToc,
      Value<String?> ruleContent,
      Value<String?> ruleReview,
      Value<int> respondTime,
      Value<int?> lastUpdateTime,
      Value<String?> variable,
      Value<int> weight,
      Value<int> rowid,
    });
typedef $$BookSourcesTableUpdateCompanionBuilder =
    BookSourcesCompanion Function({
      Value<String> bookSourceUrl,
      Value<String> bookSourceName,
      Value<String?> bookSourceGroup,
      Value<int> bookSourceType,
      Value<String?> bookUrlPattern,
      Value<int> customOrder,
      Value<bool> enabled,
      Value<bool> enabledExplore,
      Value<bool> enabledCookieJar,
      Value<String?> jsLib,
      Value<String?> concurrentRate,
      Value<String?> header,
      Value<String?> loginUrl,
      Value<String?> loginUi,
      Value<String?> loginCheckJs,
      Value<String?> searchUrl,
      Value<String?> exploreUrl,
      Value<String?> exploreScreen,
      Value<String?> ruleSearch,
      Value<String?> ruleExplore,
      Value<String?> ruleBookInfo,
      Value<String?> ruleToc,
      Value<String?> ruleContent,
      Value<String?> ruleReview,
      Value<int> respondTime,
      Value<int?> lastUpdateTime,
      Value<String?> variable,
      Value<int> weight,
      Value<int> rowid,
    });

class $$BookSourcesTableFilterComposer
    extends Composer<_$AppDatabase, $BookSourcesTable> {
  $$BookSourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get bookSourceUrl => $composableBuilder(
    column: $table.bookSourceUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookSourceName => $composableBuilder(
    column: $table.bookSourceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookSourceGroup => $composableBuilder(
    column: $table.bookSourceGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bookSourceType => $composableBuilder(
    column: $table.bookSourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookUrlPattern => $composableBuilder(
    column: $table.bookUrlPattern,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customOrder => $composableBuilder(
    column: $table.customOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabledExplore => $composableBuilder(
    column: $table.enabledExplore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabledCookieJar => $composableBuilder(
    column: $table.enabledCookieJar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jsLib => $composableBuilder(
    column: $table.jsLib,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get concurrentRate => $composableBuilder(
    column: $table.concurrentRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get header => $composableBuilder(
    column: $table.header,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginUrl => $composableBuilder(
    column: $table.loginUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginUi => $composableBuilder(
    column: $table.loginUi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginCheckJs => $composableBuilder(
    column: $table.loginCheckJs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchUrl => $composableBuilder(
    column: $table.searchUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exploreUrl => $composableBuilder(
    column: $table.exploreUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exploreScreen => $composableBuilder(
    column: $table.exploreScreen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleSearch => $composableBuilder(
    column: $table.ruleSearch,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleExplore => $composableBuilder(
    column: $table.ruleExplore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleBookInfo => $composableBuilder(
    column: $table.ruleBookInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleToc => $composableBuilder(
    column: $table.ruleToc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleContent => $composableBuilder(
    column: $table.ruleContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleReview => $composableBuilder(
    column: $table.ruleReview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get respondTime => $composableBuilder(
    column: $table.respondTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variable => $composableBuilder(
    column: $table.variable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookSourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $BookSourcesTable> {
  $$BookSourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get bookSourceUrl => $composableBuilder(
    column: $table.bookSourceUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookSourceName => $composableBuilder(
    column: $table.bookSourceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookSourceGroup => $composableBuilder(
    column: $table.bookSourceGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bookSourceType => $composableBuilder(
    column: $table.bookSourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookUrlPattern => $composableBuilder(
    column: $table.bookUrlPattern,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customOrder => $composableBuilder(
    column: $table.customOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabledExplore => $composableBuilder(
    column: $table.enabledExplore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabledCookieJar => $composableBuilder(
    column: $table.enabledCookieJar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jsLib => $composableBuilder(
    column: $table.jsLib,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get concurrentRate => $composableBuilder(
    column: $table.concurrentRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get header => $composableBuilder(
    column: $table.header,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginUrl => $composableBuilder(
    column: $table.loginUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginUi => $composableBuilder(
    column: $table.loginUi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginCheckJs => $composableBuilder(
    column: $table.loginCheckJs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchUrl => $composableBuilder(
    column: $table.searchUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exploreUrl => $composableBuilder(
    column: $table.exploreUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exploreScreen => $composableBuilder(
    column: $table.exploreScreen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleSearch => $composableBuilder(
    column: $table.ruleSearch,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleExplore => $composableBuilder(
    column: $table.ruleExplore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleBookInfo => $composableBuilder(
    column: $table.ruleBookInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleToc => $composableBuilder(
    column: $table.ruleToc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleContent => $composableBuilder(
    column: $table.ruleContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleReview => $composableBuilder(
    column: $table.ruleReview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get respondTime => $composableBuilder(
    column: $table.respondTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variable => $composableBuilder(
    column: $table.variable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookSourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookSourcesTable> {
  $$BookSourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get bookSourceUrl => $composableBuilder(
    column: $table.bookSourceUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bookSourceName => $composableBuilder(
    column: $table.bookSourceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bookSourceGroup => $composableBuilder(
    column: $table.bookSourceGroup,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bookSourceType => $composableBuilder(
    column: $table.bookSourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bookUrlPattern => $composableBuilder(
    column: $table.bookUrlPattern,
    builder: (column) => column,
  );

  GeneratedColumn<int> get customOrder => $composableBuilder(
    column: $table.customOrder,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<bool> get enabledExplore => $composableBuilder(
    column: $table.enabledExplore,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enabledCookieJar => $composableBuilder(
    column: $table.enabledCookieJar,
    builder: (column) => column,
  );

  GeneratedColumn<String> get jsLib =>
      $composableBuilder(column: $table.jsLib, builder: (column) => column);

  GeneratedColumn<String> get concurrentRate => $composableBuilder(
    column: $table.concurrentRate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get header =>
      $composableBuilder(column: $table.header, builder: (column) => column);

  GeneratedColumn<String> get loginUrl =>
      $composableBuilder(column: $table.loginUrl, builder: (column) => column);

  GeneratedColumn<String> get loginUi =>
      $composableBuilder(column: $table.loginUi, builder: (column) => column);

  GeneratedColumn<String> get loginCheckJs => $composableBuilder(
    column: $table.loginCheckJs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get searchUrl =>
      $composableBuilder(column: $table.searchUrl, builder: (column) => column);

  GeneratedColumn<String> get exploreUrl => $composableBuilder(
    column: $table.exploreUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exploreScreen => $composableBuilder(
    column: $table.exploreScreen,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleSearch => $composableBuilder(
    column: $table.ruleSearch,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleExplore => $composableBuilder(
    column: $table.ruleExplore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleBookInfo => $composableBuilder(
    column: $table.ruleBookInfo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleToc =>
      $composableBuilder(column: $table.ruleToc, builder: (column) => column);

  GeneratedColumn<String> get ruleContent => $composableBuilder(
    column: $table.ruleContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleReview => $composableBuilder(
    column: $table.ruleReview,
    builder: (column) => column,
  );

  GeneratedColumn<int> get respondTime => $composableBuilder(
    column: $table.respondTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variable =>
      $composableBuilder(column: $table.variable, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);
}

class $$BookSourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookSourcesTable,
          BookSource,
          $$BookSourcesTableFilterComposer,
          $$BookSourcesTableOrderingComposer,
          $$BookSourcesTableAnnotationComposer,
          $$BookSourcesTableCreateCompanionBuilder,
          $$BookSourcesTableUpdateCompanionBuilder,
          (
            BookSource,
            BaseReferences<_$AppDatabase, $BookSourcesTable, BookSource>,
          ),
          BookSource,
          PrefetchHooks Function()
        > {
  $$BookSourcesTableTableManager(_$AppDatabase db, $BookSourcesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookSourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookSourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookSourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> bookSourceUrl = const Value.absent(),
                Value<String> bookSourceName = const Value.absent(),
                Value<String?> bookSourceGroup = const Value.absent(),
                Value<int> bookSourceType = const Value.absent(),
                Value<String?> bookUrlPattern = const Value.absent(),
                Value<int> customOrder = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<bool> enabledExplore = const Value.absent(),
                Value<bool> enabledCookieJar = const Value.absent(),
                Value<String?> jsLib = const Value.absent(),
                Value<String?> concurrentRate = const Value.absent(),
                Value<String?> header = const Value.absent(),
                Value<String?> loginUrl = const Value.absent(),
                Value<String?> loginUi = const Value.absent(),
                Value<String?> loginCheckJs = const Value.absent(),
                Value<String?> searchUrl = const Value.absent(),
                Value<String?> exploreUrl = const Value.absent(),
                Value<String?> exploreScreen = const Value.absent(),
                Value<String?> ruleSearch = const Value.absent(),
                Value<String?> ruleExplore = const Value.absent(),
                Value<String?> ruleBookInfo = const Value.absent(),
                Value<String?> ruleToc = const Value.absent(),
                Value<String?> ruleContent = const Value.absent(),
                Value<String?> ruleReview = const Value.absent(),
                Value<int> respondTime = const Value.absent(),
                Value<int?> lastUpdateTime = const Value.absent(),
                Value<String?> variable = const Value.absent(),
                Value<int> weight = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookSourcesCompanion(
                bookSourceUrl: bookSourceUrl,
                bookSourceName: bookSourceName,
                bookSourceGroup: bookSourceGroup,
                bookSourceType: bookSourceType,
                bookUrlPattern: bookUrlPattern,
                customOrder: customOrder,
                enabled: enabled,
                enabledExplore: enabledExplore,
                enabledCookieJar: enabledCookieJar,
                jsLib: jsLib,
                concurrentRate: concurrentRate,
                header: header,
                loginUrl: loginUrl,
                loginUi: loginUi,
                loginCheckJs: loginCheckJs,
                searchUrl: searchUrl,
                exploreUrl: exploreUrl,
                exploreScreen: exploreScreen,
                ruleSearch: ruleSearch,
                ruleExplore: ruleExplore,
                ruleBookInfo: ruleBookInfo,
                ruleToc: ruleToc,
                ruleContent: ruleContent,
                ruleReview: ruleReview,
                respondTime: respondTime,
                lastUpdateTime: lastUpdateTime,
                variable: variable,
                weight: weight,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String bookSourceUrl,
                required String bookSourceName,
                Value<String?> bookSourceGroup = const Value.absent(),
                Value<int> bookSourceType = const Value.absent(),
                Value<String?> bookUrlPattern = const Value.absent(),
                Value<int> customOrder = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<bool> enabledExplore = const Value.absent(),
                Value<bool> enabledCookieJar = const Value.absent(),
                Value<String?> jsLib = const Value.absent(),
                Value<String?> concurrentRate = const Value.absent(),
                Value<String?> header = const Value.absent(),
                Value<String?> loginUrl = const Value.absent(),
                Value<String?> loginUi = const Value.absent(),
                Value<String?> loginCheckJs = const Value.absent(),
                Value<String?> searchUrl = const Value.absent(),
                Value<String?> exploreUrl = const Value.absent(),
                Value<String?> exploreScreen = const Value.absent(),
                Value<String?> ruleSearch = const Value.absent(),
                Value<String?> ruleExplore = const Value.absent(),
                Value<String?> ruleBookInfo = const Value.absent(),
                Value<String?> ruleToc = const Value.absent(),
                Value<String?> ruleContent = const Value.absent(),
                Value<String?> ruleReview = const Value.absent(),
                Value<int> respondTime = const Value.absent(),
                Value<int?> lastUpdateTime = const Value.absent(),
                Value<String?> variable = const Value.absent(),
                Value<int> weight = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookSourcesCompanion.insert(
                bookSourceUrl: bookSourceUrl,
                bookSourceName: bookSourceName,
                bookSourceGroup: bookSourceGroup,
                bookSourceType: bookSourceType,
                bookUrlPattern: bookUrlPattern,
                customOrder: customOrder,
                enabled: enabled,
                enabledExplore: enabledExplore,
                enabledCookieJar: enabledCookieJar,
                jsLib: jsLib,
                concurrentRate: concurrentRate,
                header: header,
                loginUrl: loginUrl,
                loginUi: loginUi,
                loginCheckJs: loginCheckJs,
                searchUrl: searchUrl,
                exploreUrl: exploreUrl,
                exploreScreen: exploreScreen,
                ruleSearch: ruleSearch,
                ruleExplore: ruleExplore,
                ruleBookInfo: ruleBookInfo,
                ruleToc: ruleToc,
                ruleContent: ruleContent,
                ruleReview: ruleReview,
                respondTime: respondTime,
                lastUpdateTime: lastUpdateTime,
                variable: variable,
                weight: weight,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookSourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookSourcesTable,
      BookSource,
      $$BookSourcesTableFilterComposer,
      $$BookSourcesTableOrderingComposer,
      $$BookSourcesTableAnnotationComposer,
      $$BookSourcesTableCreateCompanionBuilder,
      $$BookSourcesTableUpdateCompanionBuilder,
      (
        BookSource,
        BaseReferences<_$AppDatabase, $BookSourcesTable, BookSource>,
      ),
      BookSource,
      PrefetchHooks Function()
    >;
typedef $$BooksTableCreateCompanionBuilder =
    BooksCompanion Function({
      required String bookUrl,
      required String tocUrl,
      required String origin,
      required String originName,
      required String name,
      required String author,
      Value<String?> kind,
      Value<String?> customTag,
      Value<String?> coverUrl,
      Value<String?> customCoverUrl,
      Value<String?> intro,
      Value<String?> customIntro,
      Value<String?> charset,
      Value<int> type,
      Value<int> group,
      Value<String?> latestChapterTitle,
      Value<int?> latestChapterTime,
      Value<int> totalChapterNum,
      Value<int> durChapterIndex,
      Value<String?> durChapterTitle,
      Value<int> durChapterPos,
      Value<int> durChapterTime,
      Value<String?> wordCount,
      Value<bool> canUpdate,
      Value<String?> variable,
      Value<String?> readConfig,
      Value<int?> syncTime,
      Value<bool> local,
      Value<bool> inBookshelf,
      Value<int> score,
      Value<int> rowid,
    });
typedef $$BooksTableUpdateCompanionBuilder =
    BooksCompanion Function({
      Value<String> bookUrl,
      Value<String> tocUrl,
      Value<String> origin,
      Value<String> originName,
      Value<String> name,
      Value<String> author,
      Value<String?> kind,
      Value<String?> customTag,
      Value<String?> coverUrl,
      Value<String?> customCoverUrl,
      Value<String?> intro,
      Value<String?> customIntro,
      Value<String?> charset,
      Value<int> type,
      Value<int> group,
      Value<String?> latestChapterTitle,
      Value<int?> latestChapterTime,
      Value<int> totalChapterNum,
      Value<int> durChapterIndex,
      Value<String?> durChapterTitle,
      Value<int> durChapterPos,
      Value<int> durChapterTime,
      Value<String?> wordCount,
      Value<bool> canUpdate,
      Value<String?> variable,
      Value<String?> readConfig,
      Value<int?> syncTime,
      Value<bool> local,
      Value<bool> inBookshelf,
      Value<int> score,
      Value<int> rowid,
    });

class $$BooksTableFilterComposer extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get bookUrl => $composableBuilder(
    column: $table.bookUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tocUrl => $composableBuilder(
    column: $table.tocUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originName => $composableBuilder(
    column: $table.originName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customTag => $composableBuilder(
    column: $table.customTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customCoverUrl => $composableBuilder(
    column: $table.customCoverUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intro => $composableBuilder(
    column: $table.intro,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customIntro => $composableBuilder(
    column: $table.customIntro,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get charset => $composableBuilder(
    column: $table.charset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get group => $composableBuilder(
    column: $table.group,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get latestChapterTitle => $composableBuilder(
    column: $table.latestChapterTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get latestChapterTime => $composableBuilder(
    column: $table.latestChapterTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalChapterNum => $composableBuilder(
    column: $table.totalChapterNum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durChapterIndex => $composableBuilder(
    column: $table.durChapterIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get durChapterTitle => $composableBuilder(
    column: $table.durChapterTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durChapterPos => $composableBuilder(
    column: $table.durChapterPos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durChapterTime => $composableBuilder(
    column: $table.durChapterTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canUpdate => $composableBuilder(
    column: $table.canUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variable => $composableBuilder(
    column: $table.variable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readConfig => $composableBuilder(
    column: $table.readConfig,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncTime => $composableBuilder(
    column: $table.syncTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get local => $composableBuilder(
    column: $table.local,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get inBookshelf => $composableBuilder(
    column: $table.inBookshelf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get bookUrl => $composableBuilder(
    column: $table.bookUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tocUrl => $composableBuilder(
    column: $table.tocUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originName => $composableBuilder(
    column: $table.originName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customTag => $composableBuilder(
    column: $table.customTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customCoverUrl => $composableBuilder(
    column: $table.customCoverUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intro => $composableBuilder(
    column: $table.intro,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customIntro => $composableBuilder(
    column: $table.customIntro,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get charset => $composableBuilder(
    column: $table.charset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get group => $composableBuilder(
    column: $table.group,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get latestChapterTitle => $composableBuilder(
    column: $table.latestChapterTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get latestChapterTime => $composableBuilder(
    column: $table.latestChapterTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalChapterNum => $composableBuilder(
    column: $table.totalChapterNum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durChapterIndex => $composableBuilder(
    column: $table.durChapterIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get durChapterTitle => $composableBuilder(
    column: $table.durChapterTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durChapterPos => $composableBuilder(
    column: $table.durChapterPos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durChapterTime => $composableBuilder(
    column: $table.durChapterTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canUpdate => $composableBuilder(
    column: $table.canUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variable => $composableBuilder(
    column: $table.variable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readConfig => $composableBuilder(
    column: $table.readConfig,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncTime => $composableBuilder(
    column: $table.syncTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get local => $composableBuilder(
    column: $table.local,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get inBookshelf => $composableBuilder(
    column: $table.inBookshelf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get bookUrl =>
      $composableBuilder(column: $table.bookUrl, builder: (column) => column);

  GeneratedColumn<String> get tocUrl =>
      $composableBuilder(column: $table.tocUrl, builder: (column) => column);

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<String> get originName => $composableBuilder(
    column: $table.originName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get customTag =>
      $composableBuilder(column: $table.customTag, builder: (column) => column);

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);

  GeneratedColumn<String> get customCoverUrl => $composableBuilder(
    column: $table.customCoverUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get intro =>
      $composableBuilder(column: $table.intro, builder: (column) => column);

  GeneratedColumn<String> get customIntro => $composableBuilder(
    column: $table.customIntro,
    builder: (column) => column,
  );

  GeneratedColumn<String> get charset =>
      $composableBuilder(column: $table.charset, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get group =>
      $composableBuilder(column: $table.group, builder: (column) => column);

  GeneratedColumn<String> get latestChapterTitle => $composableBuilder(
    column: $table.latestChapterTitle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get latestChapterTime => $composableBuilder(
    column: $table.latestChapterTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalChapterNum => $composableBuilder(
    column: $table.totalChapterNum,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durChapterIndex => $composableBuilder(
    column: $table.durChapterIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get durChapterTitle => $composableBuilder(
    column: $table.durChapterTitle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durChapterPos => $composableBuilder(
    column: $table.durChapterPos,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durChapterTime => $composableBuilder(
    column: $table.durChapterTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wordCount =>
      $composableBuilder(column: $table.wordCount, builder: (column) => column);

  GeneratedColumn<bool> get canUpdate =>
      $composableBuilder(column: $table.canUpdate, builder: (column) => column);

  GeneratedColumn<String> get variable =>
      $composableBuilder(column: $table.variable, builder: (column) => column);

  GeneratedColumn<String> get readConfig => $composableBuilder(
    column: $table.readConfig,
    builder: (column) => column,
  );

  GeneratedColumn<int> get syncTime =>
      $composableBuilder(column: $table.syncTime, builder: (column) => column);

  GeneratedColumn<bool> get local =>
      $composableBuilder(column: $table.local, builder: (column) => column);

  GeneratedColumn<bool> get inBookshelf => $composableBuilder(
    column: $table.inBookshelf,
    builder: (column) => column,
  );

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);
}

class $$BooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BooksTable,
          Book,
          $$BooksTableFilterComposer,
          $$BooksTableOrderingComposer,
          $$BooksTableAnnotationComposer,
          $$BooksTableCreateCompanionBuilder,
          $$BooksTableUpdateCompanionBuilder,
          (Book, BaseReferences<_$AppDatabase, $BooksTable, Book>),
          Book,
          PrefetchHooks Function()
        > {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> bookUrl = const Value.absent(),
                Value<String> tocUrl = const Value.absent(),
                Value<String> origin = const Value.absent(),
                Value<String> originName = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String?> kind = const Value.absent(),
                Value<String?> customTag = const Value.absent(),
                Value<String?> coverUrl = const Value.absent(),
                Value<String?> customCoverUrl = const Value.absent(),
                Value<String?> intro = const Value.absent(),
                Value<String?> customIntro = const Value.absent(),
                Value<String?> charset = const Value.absent(),
                Value<int> type = const Value.absent(),
                Value<int> group = const Value.absent(),
                Value<String?> latestChapterTitle = const Value.absent(),
                Value<int?> latestChapterTime = const Value.absent(),
                Value<int> totalChapterNum = const Value.absent(),
                Value<int> durChapterIndex = const Value.absent(),
                Value<String?> durChapterTitle = const Value.absent(),
                Value<int> durChapterPos = const Value.absent(),
                Value<int> durChapterTime = const Value.absent(),
                Value<String?> wordCount = const Value.absent(),
                Value<bool> canUpdate = const Value.absent(),
                Value<String?> variable = const Value.absent(),
                Value<String?> readConfig = const Value.absent(),
                Value<int?> syncTime = const Value.absent(),
                Value<bool> local = const Value.absent(),
                Value<bool> inBookshelf = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion(
                bookUrl: bookUrl,
                tocUrl: tocUrl,
                origin: origin,
                originName: originName,
                name: name,
                author: author,
                kind: kind,
                customTag: customTag,
                coverUrl: coverUrl,
                customCoverUrl: customCoverUrl,
                intro: intro,
                customIntro: customIntro,
                charset: charset,
                type: type,
                group: group,
                latestChapterTitle: latestChapterTitle,
                latestChapterTime: latestChapterTime,
                totalChapterNum: totalChapterNum,
                durChapterIndex: durChapterIndex,
                durChapterTitle: durChapterTitle,
                durChapterPos: durChapterPos,
                durChapterTime: durChapterTime,
                wordCount: wordCount,
                canUpdate: canUpdate,
                variable: variable,
                readConfig: readConfig,
                syncTime: syncTime,
                local: local,
                inBookshelf: inBookshelf,
                score: score,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String bookUrl,
                required String tocUrl,
                required String origin,
                required String originName,
                required String name,
                required String author,
                Value<String?> kind = const Value.absent(),
                Value<String?> customTag = const Value.absent(),
                Value<String?> coverUrl = const Value.absent(),
                Value<String?> customCoverUrl = const Value.absent(),
                Value<String?> intro = const Value.absent(),
                Value<String?> customIntro = const Value.absent(),
                Value<String?> charset = const Value.absent(),
                Value<int> type = const Value.absent(),
                Value<int> group = const Value.absent(),
                Value<String?> latestChapterTitle = const Value.absent(),
                Value<int?> latestChapterTime = const Value.absent(),
                Value<int> totalChapterNum = const Value.absent(),
                Value<int> durChapterIndex = const Value.absent(),
                Value<String?> durChapterTitle = const Value.absent(),
                Value<int> durChapterPos = const Value.absent(),
                Value<int> durChapterTime = const Value.absent(),
                Value<String?> wordCount = const Value.absent(),
                Value<bool> canUpdate = const Value.absent(),
                Value<String?> variable = const Value.absent(),
                Value<String?> readConfig = const Value.absent(),
                Value<int?> syncTime = const Value.absent(),
                Value<bool> local = const Value.absent(),
                Value<bool> inBookshelf = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion.insert(
                bookUrl: bookUrl,
                tocUrl: tocUrl,
                origin: origin,
                originName: originName,
                name: name,
                author: author,
                kind: kind,
                customTag: customTag,
                coverUrl: coverUrl,
                customCoverUrl: customCoverUrl,
                intro: intro,
                customIntro: customIntro,
                charset: charset,
                type: type,
                group: group,
                latestChapterTitle: latestChapterTitle,
                latestChapterTime: latestChapterTime,
                totalChapterNum: totalChapterNum,
                durChapterIndex: durChapterIndex,
                durChapterTitle: durChapterTitle,
                durChapterPos: durChapterPos,
                durChapterTime: durChapterTime,
                wordCount: wordCount,
                canUpdate: canUpdate,
                variable: variable,
                readConfig: readConfig,
                syncTime: syncTime,
                local: local,
                inBookshelf: inBookshelf,
                score: score,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BooksTable,
      Book,
      $$BooksTableFilterComposer,
      $$BooksTableOrderingComposer,
      $$BooksTableAnnotationComposer,
      $$BooksTableCreateCompanionBuilder,
      $$BooksTableUpdateCompanionBuilder,
      (Book, BaseReferences<_$AppDatabase, $BooksTable, Book>),
      Book,
      PrefetchHooks Function()
    >;
typedef $$BookChaptersTableCreateCompanionBuilder =
    BookChaptersCompanion Function({
      required String url,
      required String bookUrl,
      required String title,
      required int chapterIndex,
      Value<bool> isVolume,
      Value<String?> baseUrl,
      Value<bool> isVip,
      Value<bool> isPay,
      Value<String?> resourceUrl,
      Value<String?> tag,
      Value<String?> wordCount,
      Value<int?> start,
      Value<int?> end,
      Value<String?> startFragmentId,
      Value<String?> endFragmentId,
      Value<String?> variable,
      Value<int> rowid,
    });
typedef $$BookChaptersTableUpdateCompanionBuilder =
    BookChaptersCompanion Function({
      Value<String> url,
      Value<String> bookUrl,
      Value<String> title,
      Value<int> chapterIndex,
      Value<bool> isVolume,
      Value<String?> baseUrl,
      Value<bool> isVip,
      Value<bool> isPay,
      Value<String?> resourceUrl,
      Value<String?> tag,
      Value<String?> wordCount,
      Value<int?> start,
      Value<int?> end,
      Value<String?> startFragmentId,
      Value<String?> endFragmentId,
      Value<String?> variable,
      Value<int> rowid,
    });

class $$BookChaptersTableFilterComposer
    extends Composer<_$AppDatabase, $BookChaptersTable> {
  $$BookChaptersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookUrl => $composableBuilder(
    column: $table.bookUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapterIndex => $composableBuilder(
    column: $table.chapterIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVolume => $composableBuilder(
    column: $table.isVolume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVip => $composableBuilder(
    column: $table.isVip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPay => $composableBuilder(
    column: $table.isPay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resourceUrl => $composableBuilder(
    column: $table.resourceUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startFragmentId => $composableBuilder(
    column: $table.startFragmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endFragmentId => $composableBuilder(
    column: $table.endFragmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variable => $composableBuilder(
    column: $table.variable,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookChaptersTableOrderingComposer
    extends Composer<_$AppDatabase, $BookChaptersTable> {
  $$BookChaptersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookUrl => $composableBuilder(
    column: $table.bookUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapterIndex => $composableBuilder(
    column: $table.chapterIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVolume => $composableBuilder(
    column: $table.isVolume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVip => $composableBuilder(
    column: $table.isVip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPay => $composableBuilder(
    column: $table.isPay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resourceUrl => $composableBuilder(
    column: $table.resourceUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startFragmentId => $composableBuilder(
    column: $table.startFragmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endFragmentId => $composableBuilder(
    column: $table.endFragmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variable => $composableBuilder(
    column: $table.variable,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookChaptersTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookChaptersTable> {
  $$BookChaptersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get bookUrl =>
      $composableBuilder(column: $table.bookUrl, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get chapterIndex => $composableBuilder(
    column: $table.chapterIndex,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isVolume =>
      $composableBuilder(column: $table.isVolume, builder: (column) => column);

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);

  GeneratedColumn<bool> get isVip =>
      $composableBuilder(column: $table.isVip, builder: (column) => column);

  GeneratedColumn<bool> get isPay =>
      $composableBuilder(column: $table.isPay, builder: (column) => column);

  GeneratedColumn<String> get resourceUrl => $composableBuilder(
    column: $table.resourceUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<String> get wordCount =>
      $composableBuilder(column: $table.wordCount, builder: (column) => column);

  GeneratedColumn<int> get start =>
      $composableBuilder(column: $table.start, builder: (column) => column);

  GeneratedColumn<int> get end =>
      $composableBuilder(column: $table.end, builder: (column) => column);

  GeneratedColumn<String> get startFragmentId => $composableBuilder(
    column: $table.startFragmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get endFragmentId => $composableBuilder(
    column: $table.endFragmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variable =>
      $composableBuilder(column: $table.variable, builder: (column) => column);
}

class $$BookChaptersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookChaptersTable,
          BookChapter,
          $$BookChaptersTableFilterComposer,
          $$BookChaptersTableOrderingComposer,
          $$BookChaptersTableAnnotationComposer,
          $$BookChaptersTableCreateCompanionBuilder,
          $$BookChaptersTableUpdateCompanionBuilder,
          (
            BookChapter,
            BaseReferences<_$AppDatabase, $BookChaptersTable, BookChapter>,
          ),
          BookChapter,
          PrefetchHooks Function()
        > {
  $$BookChaptersTableTableManager(_$AppDatabase db, $BookChaptersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookChaptersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookChaptersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookChaptersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> url = const Value.absent(),
                Value<String> bookUrl = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> chapterIndex = const Value.absent(),
                Value<bool> isVolume = const Value.absent(),
                Value<String?> baseUrl = const Value.absent(),
                Value<bool> isVip = const Value.absent(),
                Value<bool> isPay = const Value.absent(),
                Value<String?> resourceUrl = const Value.absent(),
                Value<String?> tag = const Value.absent(),
                Value<String?> wordCount = const Value.absent(),
                Value<int?> start = const Value.absent(),
                Value<int?> end = const Value.absent(),
                Value<String?> startFragmentId = const Value.absent(),
                Value<String?> endFragmentId = const Value.absent(),
                Value<String?> variable = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookChaptersCompanion(
                url: url,
                bookUrl: bookUrl,
                title: title,
                chapterIndex: chapterIndex,
                isVolume: isVolume,
                baseUrl: baseUrl,
                isVip: isVip,
                isPay: isPay,
                resourceUrl: resourceUrl,
                tag: tag,
                wordCount: wordCount,
                start: start,
                end: end,
                startFragmentId: startFragmentId,
                endFragmentId: endFragmentId,
                variable: variable,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String url,
                required String bookUrl,
                required String title,
                required int chapterIndex,
                Value<bool> isVolume = const Value.absent(),
                Value<String?> baseUrl = const Value.absent(),
                Value<bool> isVip = const Value.absent(),
                Value<bool> isPay = const Value.absent(),
                Value<String?> resourceUrl = const Value.absent(),
                Value<String?> tag = const Value.absent(),
                Value<String?> wordCount = const Value.absent(),
                Value<int?> start = const Value.absent(),
                Value<int?> end = const Value.absent(),
                Value<String?> startFragmentId = const Value.absent(),
                Value<String?> endFragmentId = const Value.absent(),
                Value<String?> variable = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookChaptersCompanion.insert(
                url: url,
                bookUrl: bookUrl,
                title: title,
                chapterIndex: chapterIndex,
                isVolume: isVolume,
                baseUrl: baseUrl,
                isVip: isVip,
                isPay: isPay,
                resourceUrl: resourceUrl,
                tag: tag,
                wordCount: wordCount,
                start: start,
                end: end,
                startFragmentId: startFragmentId,
                endFragmentId: endFragmentId,
                variable: variable,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookChaptersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookChaptersTable,
      BookChapter,
      $$BookChaptersTableFilterComposer,
      $$BookChaptersTableOrderingComposer,
      $$BookChaptersTableAnnotationComposer,
      $$BookChaptersTableCreateCompanionBuilder,
      $$BookChaptersTableUpdateCompanionBuilder,
      (
        BookChapter,
        BaseReferences<_$AppDatabase, $BookChaptersTable, BookChapter>,
      ),
      BookChapter,
      PrefetchHooks Function()
    >;
typedef $$BookGroupsTableCreateCompanionBuilder =
    BookGroupsCompanion Function({
      Value<int> groupId,
      required String groupName,
      Value<int> order,
      Value<bool> show,
    });
typedef $$BookGroupsTableUpdateCompanionBuilder =
    BookGroupsCompanion Function({
      Value<int> groupId,
      Value<String> groupName,
      Value<int> order,
      Value<bool> show,
    });

class $$BookGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $BookGroupsTable> {
  $$BookGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get show => $composableBuilder(
    column: $table.show,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $BookGroupsTable> {
  $$BookGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get show => $composableBuilder(
    column: $table.show,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookGroupsTable> {
  $$BookGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<bool> get show =>
      $composableBuilder(column: $table.show, builder: (column) => column);
}

class $$BookGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookGroupsTable,
          BookGroup,
          $$BookGroupsTableFilterComposer,
          $$BookGroupsTableOrderingComposer,
          $$BookGroupsTableAnnotationComposer,
          $$BookGroupsTableCreateCompanionBuilder,
          $$BookGroupsTableUpdateCompanionBuilder,
          (
            BookGroup,
            BaseReferences<_$AppDatabase, $BookGroupsTable, BookGroup>,
          ),
          BookGroup,
          PrefetchHooks Function()
        > {
  $$BookGroupsTableTableManager(_$AppDatabase db, $BookGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> groupId = const Value.absent(),
                Value<String> groupName = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<bool> show = const Value.absent(),
              }) => BookGroupsCompanion(
                groupId: groupId,
                groupName: groupName,
                order: order,
                show: show,
              ),
          createCompanionCallback:
              ({
                Value<int> groupId = const Value.absent(),
                required String groupName,
                Value<int> order = const Value.absent(),
                Value<bool> show = const Value.absent(),
              }) => BookGroupsCompanion.insert(
                groupId: groupId,
                groupName: groupName,
                order: order,
                show: show,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookGroupsTable,
      BookGroup,
      $$BookGroupsTableFilterComposer,
      $$BookGroupsTableOrderingComposer,
      $$BookGroupsTableAnnotationComposer,
      $$BookGroupsTableCreateCompanionBuilder,
      $$BookGroupsTableUpdateCompanionBuilder,
      (BookGroup, BaseReferences<_$AppDatabase, $BookGroupsTable, BookGroup>),
      BookGroup,
      PrefetchHooks Function()
    >;
typedef $$BookmarksTableCreateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> time,
      required String bookUrl,
      required String bookName,
      required int chapterIndex,
      required int chapterPos,
      required String bookText,
      Value<String?> content,
    });
typedef $$BookmarksTableUpdateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> time,
      Value<String> bookUrl,
      Value<String> bookName,
      Value<int> chapterIndex,
      Value<int> chapterPos,
      Value<String> bookText,
      Value<String?> content,
    });

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookUrl => $composableBuilder(
    column: $table.bookUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookName => $composableBuilder(
    column: $table.bookName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapterIndex => $composableBuilder(
    column: $table.chapterIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapterPos => $composableBuilder(
    column: $table.chapterPos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookText => $composableBuilder(
    column: $table.bookText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookUrl => $composableBuilder(
    column: $table.bookUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookName => $composableBuilder(
    column: $table.bookName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapterIndex => $composableBuilder(
    column: $table.chapterIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapterPos => $composableBuilder(
    column: $table.chapterPos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookText => $composableBuilder(
    column: $table.bookText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get bookUrl =>
      $composableBuilder(column: $table.bookUrl, builder: (column) => column);

  GeneratedColumn<String> get bookName =>
      $composableBuilder(column: $table.bookName, builder: (column) => column);

  GeneratedColumn<int> get chapterIndex => $composableBuilder(
    column: $table.chapterIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get chapterPos => $composableBuilder(
    column: $table.chapterPos,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bookText =>
      $composableBuilder(column: $table.bookText, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTable,
          Bookmark,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
          Bookmark,
          PrefetchHooks Function()
        > {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> time = const Value.absent(),
                Value<String> bookUrl = const Value.absent(),
                Value<String> bookName = const Value.absent(),
                Value<int> chapterIndex = const Value.absent(),
                Value<int> chapterPos = const Value.absent(),
                Value<String> bookText = const Value.absent(),
                Value<String?> content = const Value.absent(),
              }) => BookmarksCompanion(
                time: time,
                bookUrl: bookUrl,
                bookName: bookName,
                chapterIndex: chapterIndex,
                chapterPos: chapterPos,
                bookText: bookText,
                content: content,
              ),
          createCompanionCallback:
              ({
                Value<int> time = const Value.absent(),
                required String bookUrl,
                required String bookName,
                required int chapterIndex,
                required int chapterPos,
                required String bookText,
                Value<String?> content = const Value.absent(),
              }) => BookmarksCompanion.insert(
                time: time,
                bookUrl: bookUrl,
                bookName: bookName,
                chapterIndex: chapterIndex,
                chapterPos: chapterPos,
                bookText: bookText,
                content: content,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTable,
      Bookmark,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
      Bookmark,
      PrefetchHooks Function()
    >;
typedef $$ReplaceRulesTableCreateCompanionBuilder =
    ReplaceRulesCompanion Function({
      Value<int> id,
      Value<int> order,
      Value<bool> isEnabled,
      required String regex,
      Value<String> replacement,
      Value<String?> scope,
      Value<String?> name,
      Value<String?> group,
      Value<bool> isRegex,
      Value<bool> act,
      Value<String?> example,
    });
typedef $$ReplaceRulesTableUpdateCompanionBuilder =
    ReplaceRulesCompanion Function({
      Value<int> id,
      Value<int> order,
      Value<bool> isEnabled,
      Value<String> regex,
      Value<String> replacement,
      Value<String?> scope,
      Value<String?> name,
      Value<String?> group,
      Value<bool> isRegex,
      Value<bool> act,
      Value<String?> example,
    });

class $$ReplaceRulesTableFilterComposer
    extends Composer<_$AppDatabase, $ReplaceRulesTable> {
  $$ReplaceRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get regex => $composableBuilder(
    column: $table.regex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replacement => $composableBuilder(
    column: $table.replacement,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get group => $composableBuilder(
    column: $table.group,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRegex => $composableBuilder(
    column: $table.isRegex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get act => $composableBuilder(
    column: $table.act,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get example => $composableBuilder(
    column: $table.example,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReplaceRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReplaceRulesTable> {
  $$ReplaceRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regex => $composableBuilder(
    column: $table.regex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replacement => $composableBuilder(
    column: $table.replacement,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get group => $composableBuilder(
    column: $table.group,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRegex => $composableBuilder(
    column: $table.isRegex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get act => $composableBuilder(
    column: $table.act,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get example => $composableBuilder(
    column: $table.example,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReplaceRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReplaceRulesTable> {
  $$ReplaceRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get regex =>
      $composableBuilder(column: $table.regex, builder: (column) => column);

  GeneratedColumn<String> get replacement => $composableBuilder(
    column: $table.replacement,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get group =>
      $composableBuilder(column: $table.group, builder: (column) => column);

  GeneratedColumn<bool> get isRegex =>
      $composableBuilder(column: $table.isRegex, builder: (column) => column);

  GeneratedColumn<bool> get act =>
      $composableBuilder(column: $table.act, builder: (column) => column);

  GeneratedColumn<String> get example =>
      $composableBuilder(column: $table.example, builder: (column) => column);
}

class $$ReplaceRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReplaceRulesTable,
          ReplaceRule,
          $$ReplaceRulesTableFilterComposer,
          $$ReplaceRulesTableOrderingComposer,
          $$ReplaceRulesTableAnnotationComposer,
          $$ReplaceRulesTableCreateCompanionBuilder,
          $$ReplaceRulesTableUpdateCompanionBuilder,
          (
            ReplaceRule,
            BaseReferences<_$AppDatabase, $ReplaceRulesTable, ReplaceRule>,
          ),
          ReplaceRule,
          PrefetchHooks Function()
        > {
  $$ReplaceRulesTableTableManager(_$AppDatabase db, $ReplaceRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReplaceRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReplaceRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReplaceRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String> regex = const Value.absent(),
                Value<String> replacement = const Value.absent(),
                Value<String?> scope = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> group = const Value.absent(),
                Value<bool> isRegex = const Value.absent(),
                Value<bool> act = const Value.absent(),
                Value<String?> example = const Value.absent(),
              }) => ReplaceRulesCompanion(
                id: id,
                order: order,
                isEnabled: isEnabled,
                regex: regex,
                replacement: replacement,
                scope: scope,
                name: name,
                group: group,
                isRegex: isRegex,
                act: act,
                example: example,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                required String regex,
                Value<String> replacement = const Value.absent(),
                Value<String?> scope = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> group = const Value.absent(),
                Value<bool> isRegex = const Value.absent(),
                Value<bool> act = const Value.absent(),
                Value<String?> example = const Value.absent(),
              }) => ReplaceRulesCompanion.insert(
                id: id,
                order: order,
                isEnabled: isEnabled,
                regex: regex,
                replacement: replacement,
                scope: scope,
                name: name,
                group: group,
                isRegex: isRegex,
                act: act,
                example: example,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReplaceRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReplaceRulesTable,
      ReplaceRule,
      $$ReplaceRulesTableFilterComposer,
      $$ReplaceRulesTableOrderingComposer,
      $$ReplaceRulesTableAnnotationComposer,
      $$ReplaceRulesTableCreateCompanionBuilder,
      $$ReplaceRulesTableUpdateCompanionBuilder,
      (
        ReplaceRule,
        BaseReferences<_$AppDatabase, $ReplaceRulesTable, ReplaceRule>,
      ),
      ReplaceRule,
      PrefetchHooks Function()
    >;
typedef $$SearchBooksTableCreateCompanionBuilder =
    SearchBooksCompanion Function({
      required String bookUrl,
      required String origin,
      required String originName,
      required String name,
      required String author,
      Value<String?> kind,
      Value<String?> coverUrl,
      Value<String?> intro,
      Value<String?> wordCount,
      Value<String?> latestChapter,
      Value<String?> updateTime,
      Value<int?> searchTime,
      Value<String?> variable,
      Value<int> originOrder,
      Value<int> rowid,
    });
typedef $$SearchBooksTableUpdateCompanionBuilder =
    SearchBooksCompanion Function({
      Value<String> bookUrl,
      Value<String> origin,
      Value<String> originName,
      Value<String> name,
      Value<String> author,
      Value<String?> kind,
      Value<String?> coverUrl,
      Value<String?> intro,
      Value<String?> wordCount,
      Value<String?> latestChapter,
      Value<String?> updateTime,
      Value<int?> searchTime,
      Value<String?> variable,
      Value<int> originOrder,
      Value<int> rowid,
    });

class $$SearchBooksTableFilterComposer
    extends Composer<_$AppDatabase, $SearchBooksTable> {
  $$SearchBooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get bookUrl => $composableBuilder(
    column: $table.bookUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originName => $composableBuilder(
    column: $table.originName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intro => $composableBuilder(
    column: $table.intro,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get latestChapter => $composableBuilder(
    column: $table.latestChapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get searchTime => $composableBuilder(
    column: $table.searchTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variable => $composableBuilder(
    column: $table.variable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get originOrder => $composableBuilder(
    column: $table.originOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SearchBooksTableOrderingComposer
    extends Composer<_$AppDatabase, $SearchBooksTable> {
  $$SearchBooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get bookUrl => $composableBuilder(
    column: $table.bookUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originName => $composableBuilder(
    column: $table.originName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intro => $composableBuilder(
    column: $table.intro,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get latestChapter => $composableBuilder(
    column: $table.latestChapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get searchTime => $composableBuilder(
    column: $table.searchTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variable => $composableBuilder(
    column: $table.variable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get originOrder => $composableBuilder(
    column: $table.originOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SearchBooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $SearchBooksTable> {
  $$SearchBooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get bookUrl =>
      $composableBuilder(column: $table.bookUrl, builder: (column) => column);

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<String> get originName => $composableBuilder(
    column: $table.originName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);

  GeneratedColumn<String> get intro =>
      $composableBuilder(column: $table.intro, builder: (column) => column);

  GeneratedColumn<String> get wordCount =>
      $composableBuilder(column: $table.wordCount, builder: (column) => column);

  GeneratedColumn<String> get latestChapter => $composableBuilder(
    column: $table.latestChapter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get searchTime => $composableBuilder(
    column: $table.searchTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variable =>
      $composableBuilder(column: $table.variable, builder: (column) => column);

  GeneratedColumn<int> get originOrder => $composableBuilder(
    column: $table.originOrder,
    builder: (column) => column,
  );
}

class $$SearchBooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SearchBooksTable,
          SearchBook,
          $$SearchBooksTableFilterComposer,
          $$SearchBooksTableOrderingComposer,
          $$SearchBooksTableAnnotationComposer,
          $$SearchBooksTableCreateCompanionBuilder,
          $$SearchBooksTableUpdateCompanionBuilder,
          (
            SearchBook,
            BaseReferences<_$AppDatabase, $SearchBooksTable, SearchBook>,
          ),
          SearchBook,
          PrefetchHooks Function()
        > {
  $$SearchBooksTableTableManager(_$AppDatabase db, $SearchBooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchBooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchBooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SearchBooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> bookUrl = const Value.absent(),
                Value<String> origin = const Value.absent(),
                Value<String> originName = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String?> kind = const Value.absent(),
                Value<String?> coverUrl = const Value.absent(),
                Value<String?> intro = const Value.absent(),
                Value<String?> wordCount = const Value.absent(),
                Value<String?> latestChapter = const Value.absent(),
                Value<String?> updateTime = const Value.absent(),
                Value<int?> searchTime = const Value.absent(),
                Value<String?> variable = const Value.absent(),
                Value<int> originOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SearchBooksCompanion(
                bookUrl: bookUrl,
                origin: origin,
                originName: originName,
                name: name,
                author: author,
                kind: kind,
                coverUrl: coverUrl,
                intro: intro,
                wordCount: wordCount,
                latestChapter: latestChapter,
                updateTime: updateTime,
                searchTime: searchTime,
                variable: variable,
                originOrder: originOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String bookUrl,
                required String origin,
                required String originName,
                required String name,
                required String author,
                Value<String?> kind = const Value.absent(),
                Value<String?> coverUrl = const Value.absent(),
                Value<String?> intro = const Value.absent(),
                Value<String?> wordCount = const Value.absent(),
                Value<String?> latestChapter = const Value.absent(),
                Value<String?> updateTime = const Value.absent(),
                Value<int?> searchTime = const Value.absent(),
                Value<String?> variable = const Value.absent(),
                Value<int> originOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SearchBooksCompanion.insert(
                bookUrl: bookUrl,
                origin: origin,
                originName: originName,
                name: name,
                author: author,
                kind: kind,
                coverUrl: coverUrl,
                intro: intro,
                wordCount: wordCount,
                latestChapter: latestChapter,
                updateTime: updateTime,
                searchTime: searchTime,
                variable: variable,
                originOrder: originOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SearchBooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SearchBooksTable,
      SearchBook,
      $$SearchBooksTableFilterComposer,
      $$SearchBooksTableOrderingComposer,
      $$SearchBooksTableAnnotationComposer,
      $$SearchBooksTableCreateCompanionBuilder,
      $$SearchBooksTableUpdateCompanionBuilder,
      (
        SearchBook,
        BaseReferences<_$AppDatabase, $SearchBooksTable, SearchBook>,
      ),
      SearchBook,
      PrefetchHooks Function()
    >;
typedef $$RssSourcesTableCreateCompanionBuilder =
    RssSourcesCompanion Function({
      required String sourceUrl,
      required String sourceName,
      Value<String?> sourceIcon,
      Value<String?> sourceGroup,
      Value<int> customOrder,
      Value<bool> enabled,
      Value<bool> enabledCookieJar,
      Value<String?> concurrentRate,
      Value<String?> header,
      Value<String?> loginUrl,
      Value<String?> loginUi,
      Value<String?> loginCheckJs,
      Value<String?> ruleArticles,
      Value<String?> ruleNextPage,
      Value<String?> ruleTitle,
      Value<String?> rulePubDate,
      Value<String?> ruleDescription,
      Value<String?> ruleImage,
      Value<String?> ruleContent,
      Value<String?> ruleLink,
      Value<String?> ruleCategories,
      Value<String?> sortUrl,
      Value<int> articleStyle,
      Value<bool> singleUrl,
      Value<bool> enableJs,
      Value<bool> loadWithBaseUrl,
      Value<String?> jsLib,
      Value<String?> variable,
      Value<int?> lastUpdateTime,
      Value<int> rowid,
    });
typedef $$RssSourcesTableUpdateCompanionBuilder =
    RssSourcesCompanion Function({
      Value<String> sourceUrl,
      Value<String> sourceName,
      Value<String?> sourceIcon,
      Value<String?> sourceGroup,
      Value<int> customOrder,
      Value<bool> enabled,
      Value<bool> enabledCookieJar,
      Value<String?> concurrentRate,
      Value<String?> header,
      Value<String?> loginUrl,
      Value<String?> loginUi,
      Value<String?> loginCheckJs,
      Value<String?> ruleArticles,
      Value<String?> ruleNextPage,
      Value<String?> ruleTitle,
      Value<String?> rulePubDate,
      Value<String?> ruleDescription,
      Value<String?> ruleImage,
      Value<String?> ruleContent,
      Value<String?> ruleLink,
      Value<String?> ruleCategories,
      Value<String?> sortUrl,
      Value<int> articleStyle,
      Value<bool> singleUrl,
      Value<bool> enableJs,
      Value<bool> loadWithBaseUrl,
      Value<String?> jsLib,
      Value<String?> variable,
      Value<int?> lastUpdateTime,
      Value<int> rowid,
    });

class $$RssSourcesTableFilterComposer
    extends Composer<_$AppDatabase, $RssSourcesTable> {
  $$RssSourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceIcon => $composableBuilder(
    column: $table.sourceIcon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceGroup => $composableBuilder(
    column: $table.sourceGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customOrder => $composableBuilder(
    column: $table.customOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabledCookieJar => $composableBuilder(
    column: $table.enabledCookieJar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get concurrentRate => $composableBuilder(
    column: $table.concurrentRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get header => $composableBuilder(
    column: $table.header,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginUrl => $composableBuilder(
    column: $table.loginUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginUi => $composableBuilder(
    column: $table.loginUi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginCheckJs => $composableBuilder(
    column: $table.loginCheckJs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleArticles => $composableBuilder(
    column: $table.ruleArticles,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleNextPage => $composableBuilder(
    column: $table.ruleNextPage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleTitle => $composableBuilder(
    column: $table.ruleTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rulePubDate => $composableBuilder(
    column: $table.rulePubDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleDescription => $composableBuilder(
    column: $table.ruleDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleImage => $composableBuilder(
    column: $table.ruleImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleContent => $composableBuilder(
    column: $table.ruleContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleLink => $composableBuilder(
    column: $table.ruleLink,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleCategories => $composableBuilder(
    column: $table.ruleCategories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sortUrl => $composableBuilder(
    column: $table.sortUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get articleStyle => $composableBuilder(
    column: $table.articleStyle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get singleUrl => $composableBuilder(
    column: $table.singleUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableJs => $composableBuilder(
    column: $table.enableJs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get loadWithBaseUrl => $composableBuilder(
    column: $table.loadWithBaseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jsLib => $composableBuilder(
    column: $table.jsLib,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variable => $composableBuilder(
    column: $table.variable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RssSourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $RssSourcesTable> {
  $$RssSourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceIcon => $composableBuilder(
    column: $table.sourceIcon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceGroup => $composableBuilder(
    column: $table.sourceGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customOrder => $composableBuilder(
    column: $table.customOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabledCookieJar => $composableBuilder(
    column: $table.enabledCookieJar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get concurrentRate => $composableBuilder(
    column: $table.concurrentRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get header => $composableBuilder(
    column: $table.header,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginUrl => $composableBuilder(
    column: $table.loginUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginUi => $composableBuilder(
    column: $table.loginUi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginCheckJs => $composableBuilder(
    column: $table.loginCheckJs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleArticles => $composableBuilder(
    column: $table.ruleArticles,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleNextPage => $composableBuilder(
    column: $table.ruleNextPage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleTitle => $composableBuilder(
    column: $table.ruleTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rulePubDate => $composableBuilder(
    column: $table.rulePubDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleDescription => $composableBuilder(
    column: $table.ruleDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleImage => $composableBuilder(
    column: $table.ruleImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleContent => $composableBuilder(
    column: $table.ruleContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleLink => $composableBuilder(
    column: $table.ruleLink,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleCategories => $composableBuilder(
    column: $table.ruleCategories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sortUrl => $composableBuilder(
    column: $table.sortUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get articleStyle => $composableBuilder(
    column: $table.articleStyle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get singleUrl => $composableBuilder(
    column: $table.singleUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableJs => $composableBuilder(
    column: $table.enableJs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get loadWithBaseUrl => $composableBuilder(
    column: $table.loadWithBaseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jsLib => $composableBuilder(
    column: $table.jsLib,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variable => $composableBuilder(
    column: $table.variable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RssSourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RssSourcesTable> {
  $$RssSourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get sourceUrl =>
      $composableBuilder(column: $table.sourceUrl, builder: (column) => column);

  GeneratedColumn<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceIcon => $composableBuilder(
    column: $table.sourceIcon,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceGroup => $composableBuilder(
    column: $table.sourceGroup,
    builder: (column) => column,
  );

  GeneratedColumn<int> get customOrder => $composableBuilder(
    column: $table.customOrder,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<bool> get enabledCookieJar => $composableBuilder(
    column: $table.enabledCookieJar,
    builder: (column) => column,
  );

  GeneratedColumn<String> get concurrentRate => $composableBuilder(
    column: $table.concurrentRate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get header =>
      $composableBuilder(column: $table.header, builder: (column) => column);

  GeneratedColumn<String> get loginUrl =>
      $composableBuilder(column: $table.loginUrl, builder: (column) => column);

  GeneratedColumn<String> get loginUi =>
      $composableBuilder(column: $table.loginUi, builder: (column) => column);

  GeneratedColumn<String> get loginCheckJs => $composableBuilder(
    column: $table.loginCheckJs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleArticles => $composableBuilder(
    column: $table.ruleArticles,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleNextPage => $composableBuilder(
    column: $table.ruleNextPage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleTitle =>
      $composableBuilder(column: $table.ruleTitle, builder: (column) => column);

  GeneratedColumn<String> get rulePubDate => $composableBuilder(
    column: $table.rulePubDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleDescription => $composableBuilder(
    column: $table.ruleDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleImage =>
      $composableBuilder(column: $table.ruleImage, builder: (column) => column);

  GeneratedColumn<String> get ruleContent => $composableBuilder(
    column: $table.ruleContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleLink =>
      $composableBuilder(column: $table.ruleLink, builder: (column) => column);

  GeneratedColumn<String> get ruleCategories => $composableBuilder(
    column: $table.ruleCategories,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sortUrl =>
      $composableBuilder(column: $table.sortUrl, builder: (column) => column);

  GeneratedColumn<int> get articleStyle => $composableBuilder(
    column: $table.articleStyle,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get singleUrl =>
      $composableBuilder(column: $table.singleUrl, builder: (column) => column);

  GeneratedColumn<bool> get enableJs =>
      $composableBuilder(column: $table.enableJs, builder: (column) => column);

  GeneratedColumn<bool> get loadWithBaseUrl => $composableBuilder(
    column: $table.loadWithBaseUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get jsLib =>
      $composableBuilder(column: $table.jsLib, builder: (column) => column);

  GeneratedColumn<String> get variable =>
      $composableBuilder(column: $table.variable, builder: (column) => column);

  GeneratedColumn<int> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => column,
  );
}

class $$RssSourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RssSourcesTable,
          RssSource,
          $$RssSourcesTableFilterComposer,
          $$RssSourcesTableOrderingComposer,
          $$RssSourcesTableAnnotationComposer,
          $$RssSourcesTableCreateCompanionBuilder,
          $$RssSourcesTableUpdateCompanionBuilder,
          (
            RssSource,
            BaseReferences<_$AppDatabase, $RssSourcesTable, RssSource>,
          ),
          RssSource,
          PrefetchHooks Function()
        > {
  $$RssSourcesTableTableManager(_$AppDatabase db, $RssSourcesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RssSourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RssSourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RssSourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sourceUrl = const Value.absent(),
                Value<String> sourceName = const Value.absent(),
                Value<String?> sourceIcon = const Value.absent(),
                Value<String?> sourceGroup = const Value.absent(),
                Value<int> customOrder = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<bool> enabledCookieJar = const Value.absent(),
                Value<String?> concurrentRate = const Value.absent(),
                Value<String?> header = const Value.absent(),
                Value<String?> loginUrl = const Value.absent(),
                Value<String?> loginUi = const Value.absent(),
                Value<String?> loginCheckJs = const Value.absent(),
                Value<String?> ruleArticles = const Value.absent(),
                Value<String?> ruleNextPage = const Value.absent(),
                Value<String?> ruleTitle = const Value.absent(),
                Value<String?> rulePubDate = const Value.absent(),
                Value<String?> ruleDescription = const Value.absent(),
                Value<String?> ruleImage = const Value.absent(),
                Value<String?> ruleContent = const Value.absent(),
                Value<String?> ruleLink = const Value.absent(),
                Value<String?> ruleCategories = const Value.absent(),
                Value<String?> sortUrl = const Value.absent(),
                Value<int> articleStyle = const Value.absent(),
                Value<bool> singleUrl = const Value.absent(),
                Value<bool> enableJs = const Value.absent(),
                Value<bool> loadWithBaseUrl = const Value.absent(),
                Value<String?> jsLib = const Value.absent(),
                Value<String?> variable = const Value.absent(),
                Value<int?> lastUpdateTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RssSourcesCompanion(
                sourceUrl: sourceUrl,
                sourceName: sourceName,
                sourceIcon: sourceIcon,
                sourceGroup: sourceGroup,
                customOrder: customOrder,
                enabled: enabled,
                enabledCookieJar: enabledCookieJar,
                concurrentRate: concurrentRate,
                header: header,
                loginUrl: loginUrl,
                loginUi: loginUi,
                loginCheckJs: loginCheckJs,
                ruleArticles: ruleArticles,
                ruleNextPage: ruleNextPage,
                ruleTitle: ruleTitle,
                rulePubDate: rulePubDate,
                ruleDescription: ruleDescription,
                ruleImage: ruleImage,
                ruleContent: ruleContent,
                ruleLink: ruleLink,
                ruleCategories: ruleCategories,
                sortUrl: sortUrl,
                articleStyle: articleStyle,
                singleUrl: singleUrl,
                enableJs: enableJs,
                loadWithBaseUrl: loadWithBaseUrl,
                jsLib: jsLib,
                variable: variable,
                lastUpdateTime: lastUpdateTime,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sourceUrl,
                required String sourceName,
                Value<String?> sourceIcon = const Value.absent(),
                Value<String?> sourceGroup = const Value.absent(),
                Value<int> customOrder = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<bool> enabledCookieJar = const Value.absent(),
                Value<String?> concurrentRate = const Value.absent(),
                Value<String?> header = const Value.absent(),
                Value<String?> loginUrl = const Value.absent(),
                Value<String?> loginUi = const Value.absent(),
                Value<String?> loginCheckJs = const Value.absent(),
                Value<String?> ruleArticles = const Value.absent(),
                Value<String?> ruleNextPage = const Value.absent(),
                Value<String?> ruleTitle = const Value.absent(),
                Value<String?> rulePubDate = const Value.absent(),
                Value<String?> ruleDescription = const Value.absent(),
                Value<String?> ruleImage = const Value.absent(),
                Value<String?> ruleContent = const Value.absent(),
                Value<String?> ruleLink = const Value.absent(),
                Value<String?> ruleCategories = const Value.absent(),
                Value<String?> sortUrl = const Value.absent(),
                Value<int> articleStyle = const Value.absent(),
                Value<bool> singleUrl = const Value.absent(),
                Value<bool> enableJs = const Value.absent(),
                Value<bool> loadWithBaseUrl = const Value.absent(),
                Value<String?> jsLib = const Value.absent(),
                Value<String?> variable = const Value.absent(),
                Value<int?> lastUpdateTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RssSourcesCompanion.insert(
                sourceUrl: sourceUrl,
                sourceName: sourceName,
                sourceIcon: sourceIcon,
                sourceGroup: sourceGroup,
                customOrder: customOrder,
                enabled: enabled,
                enabledCookieJar: enabledCookieJar,
                concurrentRate: concurrentRate,
                header: header,
                loginUrl: loginUrl,
                loginUi: loginUi,
                loginCheckJs: loginCheckJs,
                ruleArticles: ruleArticles,
                ruleNextPage: ruleNextPage,
                ruleTitle: ruleTitle,
                rulePubDate: rulePubDate,
                ruleDescription: ruleDescription,
                ruleImage: ruleImage,
                ruleContent: ruleContent,
                ruleLink: ruleLink,
                ruleCategories: ruleCategories,
                sortUrl: sortUrl,
                articleStyle: articleStyle,
                singleUrl: singleUrl,
                enableJs: enableJs,
                loadWithBaseUrl: loadWithBaseUrl,
                jsLib: jsLib,
                variable: variable,
                lastUpdateTime: lastUpdateTime,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RssSourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RssSourcesTable,
      RssSource,
      $$RssSourcesTableFilterComposer,
      $$RssSourcesTableOrderingComposer,
      $$RssSourcesTableAnnotationComposer,
      $$RssSourcesTableCreateCompanionBuilder,
      $$RssSourcesTableUpdateCompanionBuilder,
      (RssSource, BaseReferences<_$AppDatabase, $RssSourcesTable, RssSource>),
      RssSource,
      PrefetchHooks Function()
    >;
typedef $$RssArticlesTableCreateCompanionBuilder =
    RssArticlesCompanion Function({
      required String url,
      required String origin,
      required String originName,
      required String title,
      Value<String?> sort,
      Value<int> order,
      Value<String?> pubDate,
      Value<String?> description,
      Value<String?> image,
      Value<String?> link,
      Value<String?> content,
      Value<String?> variable,
      Value<bool> read,
      Value<int> rowid,
    });
typedef $$RssArticlesTableUpdateCompanionBuilder =
    RssArticlesCompanion Function({
      Value<String> url,
      Value<String> origin,
      Value<String> originName,
      Value<String> title,
      Value<String?> sort,
      Value<int> order,
      Value<String?> pubDate,
      Value<String?> description,
      Value<String?> image,
      Value<String?> link,
      Value<String?> content,
      Value<String?> variable,
      Value<bool> read,
      Value<int> rowid,
    });

class $$RssArticlesTableFilterComposer
    extends Composer<_$AppDatabase, $RssArticlesTable> {
  $$RssArticlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originName => $composableBuilder(
    column: $table.originName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sort => $composableBuilder(
    column: $table.sort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pubDate => $composableBuilder(
    column: $table.pubDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variable => $composableBuilder(
    column: $table.variable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get read => $composableBuilder(
    column: $table.read,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RssArticlesTableOrderingComposer
    extends Composer<_$AppDatabase, $RssArticlesTable> {
  $$RssArticlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originName => $composableBuilder(
    column: $table.originName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sort => $composableBuilder(
    column: $table.sort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pubDate => $composableBuilder(
    column: $table.pubDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variable => $composableBuilder(
    column: $table.variable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get read => $composableBuilder(
    column: $table.read,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RssArticlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RssArticlesTable> {
  $$RssArticlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<String> get originName => $composableBuilder(
    column: $table.originName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get sort =>
      $composableBuilder(column: $table.sort, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get pubDate =>
      $composableBuilder(column: $table.pubDate, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get variable =>
      $composableBuilder(column: $table.variable, builder: (column) => column);

  GeneratedColumn<bool> get read =>
      $composableBuilder(column: $table.read, builder: (column) => column);
}

class $$RssArticlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RssArticlesTable,
          RssArticle,
          $$RssArticlesTableFilterComposer,
          $$RssArticlesTableOrderingComposer,
          $$RssArticlesTableAnnotationComposer,
          $$RssArticlesTableCreateCompanionBuilder,
          $$RssArticlesTableUpdateCompanionBuilder,
          (
            RssArticle,
            BaseReferences<_$AppDatabase, $RssArticlesTable, RssArticle>,
          ),
          RssArticle,
          PrefetchHooks Function()
        > {
  $$RssArticlesTableTableManager(_$AppDatabase db, $RssArticlesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RssArticlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RssArticlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RssArticlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> url = const Value.absent(),
                Value<String> origin = const Value.absent(),
                Value<String> originName = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> sort = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<String?> pubDate = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<String?> link = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String?> variable = const Value.absent(),
                Value<bool> read = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RssArticlesCompanion(
                url: url,
                origin: origin,
                originName: originName,
                title: title,
                sort: sort,
                order: order,
                pubDate: pubDate,
                description: description,
                image: image,
                link: link,
                content: content,
                variable: variable,
                read: read,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String url,
                required String origin,
                required String originName,
                required String title,
                Value<String?> sort = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<String?> pubDate = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<String?> link = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String?> variable = const Value.absent(),
                Value<bool> read = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RssArticlesCompanion.insert(
                url: url,
                origin: origin,
                originName: originName,
                title: title,
                sort: sort,
                order: order,
                pubDate: pubDate,
                description: description,
                image: image,
                link: link,
                content: content,
                variable: variable,
                read: read,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RssArticlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RssArticlesTable,
      RssArticle,
      $$RssArticlesTableFilterComposer,
      $$RssArticlesTableOrderingComposer,
      $$RssArticlesTableAnnotationComposer,
      $$RssArticlesTableCreateCompanionBuilder,
      $$RssArticlesTableUpdateCompanionBuilder,
      (
        RssArticle,
        BaseReferences<_$AppDatabase, $RssArticlesTable, RssArticle>,
      ),
      RssArticle,
      PrefetchHooks Function()
    >;
typedef $$SearchKeywordsTableCreateCompanionBuilder =
    SearchKeywordsCompanion Function({
      required String word,
      Value<int> usage,
      required int lastUseTime,
      Value<int> rowid,
    });
typedef $$SearchKeywordsTableUpdateCompanionBuilder =
    SearchKeywordsCompanion Function({
      Value<String> word,
      Value<int> usage,
      Value<int> lastUseTime,
      Value<int> rowid,
    });

class $$SearchKeywordsTableFilterComposer
    extends Composer<_$AppDatabase, $SearchKeywordsTable> {
  $$SearchKeywordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usage => $composableBuilder(
    column: $table.usage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastUseTime => $composableBuilder(
    column: $table.lastUseTime,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SearchKeywordsTableOrderingComposer
    extends Composer<_$AppDatabase, $SearchKeywordsTable> {
  $$SearchKeywordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usage => $composableBuilder(
    column: $table.usage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastUseTime => $composableBuilder(
    column: $table.lastUseTime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SearchKeywordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SearchKeywordsTable> {
  $$SearchKeywordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<int> get usage =>
      $composableBuilder(column: $table.usage, builder: (column) => column);

  GeneratedColumn<int> get lastUseTime => $composableBuilder(
    column: $table.lastUseTime,
    builder: (column) => column,
  );
}

class $$SearchKeywordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SearchKeywordsTable,
          SearchKeyword,
          $$SearchKeywordsTableFilterComposer,
          $$SearchKeywordsTableOrderingComposer,
          $$SearchKeywordsTableAnnotationComposer,
          $$SearchKeywordsTableCreateCompanionBuilder,
          $$SearchKeywordsTableUpdateCompanionBuilder,
          (
            SearchKeyword,
            BaseReferences<_$AppDatabase, $SearchKeywordsTable, SearchKeyword>,
          ),
          SearchKeyword,
          PrefetchHooks Function()
        > {
  $$SearchKeywordsTableTableManager(
    _$AppDatabase db,
    $SearchKeywordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchKeywordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchKeywordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SearchKeywordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> word = const Value.absent(),
                Value<int> usage = const Value.absent(),
                Value<int> lastUseTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SearchKeywordsCompanion(
                word: word,
                usage: usage,
                lastUseTime: lastUseTime,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String word,
                Value<int> usage = const Value.absent(),
                required int lastUseTime,
                Value<int> rowid = const Value.absent(),
              }) => SearchKeywordsCompanion.insert(
                word: word,
                usage: usage,
                lastUseTime: lastUseTime,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SearchKeywordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SearchKeywordsTable,
      SearchKeyword,
      $$SearchKeywordsTableFilterComposer,
      $$SearchKeywordsTableOrderingComposer,
      $$SearchKeywordsTableAnnotationComposer,
      $$SearchKeywordsTableCreateCompanionBuilder,
      $$SearchKeywordsTableUpdateCompanionBuilder,
      (
        SearchKeyword,
        BaseReferences<_$AppDatabase, $SearchKeywordsTable, SearchKeyword>,
      ),
      SearchKeyword,
      PrefetchHooks Function()
    >;
typedef $$TxtTocRulesTableCreateCompanionBuilder =
    TxtTocRulesCompanion Function({
      Value<int> id,
      required String name,
      required String rule,
      Value<bool> enabled,
      Value<int> serialNumber,
      Value<String?> example,
    });
typedef $$TxtTocRulesTableUpdateCompanionBuilder =
    TxtTocRulesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> rule,
      Value<bool> enabled,
      Value<int> serialNumber,
      Value<String?> example,
    });

class $$TxtTocRulesTableFilterComposer
    extends Composer<_$AppDatabase, $TxtTocRulesTable> {
  $$TxtTocRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rule => $composableBuilder(
    column: $table.rule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get example => $composableBuilder(
    column: $table.example,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TxtTocRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $TxtTocRulesTable> {
  $$TxtTocRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rule => $composableBuilder(
    column: $table.rule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get example => $composableBuilder(
    column: $table.example,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TxtTocRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TxtTocRulesTable> {
  $$TxtTocRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get rule =>
      $composableBuilder(column: $table.rule, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get example =>
      $composableBuilder(column: $table.example, builder: (column) => column);
}

class $$TxtTocRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TxtTocRulesTable,
          TxtTocRule,
          $$TxtTocRulesTableFilterComposer,
          $$TxtTocRulesTableOrderingComposer,
          $$TxtTocRulesTableAnnotationComposer,
          $$TxtTocRulesTableCreateCompanionBuilder,
          $$TxtTocRulesTableUpdateCompanionBuilder,
          (
            TxtTocRule,
            BaseReferences<_$AppDatabase, $TxtTocRulesTable, TxtTocRule>,
          ),
          TxtTocRule,
          PrefetchHooks Function()
        > {
  $$TxtTocRulesTableTableManager(_$AppDatabase db, $TxtTocRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TxtTocRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TxtTocRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TxtTocRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> rule = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> serialNumber = const Value.absent(),
                Value<String?> example = const Value.absent(),
              }) => TxtTocRulesCompanion(
                id: id,
                name: name,
                rule: rule,
                enabled: enabled,
                serialNumber: serialNumber,
                example: example,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String rule,
                Value<bool> enabled = const Value.absent(),
                Value<int> serialNumber = const Value.absent(),
                Value<String?> example = const Value.absent(),
              }) => TxtTocRulesCompanion.insert(
                id: id,
                name: name,
                rule: rule,
                enabled: enabled,
                serialNumber: serialNumber,
                example: example,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TxtTocRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TxtTocRulesTable,
      TxtTocRule,
      $$TxtTocRulesTableFilterComposer,
      $$TxtTocRulesTableOrderingComposer,
      $$TxtTocRulesTableAnnotationComposer,
      $$TxtTocRulesTableCreateCompanionBuilder,
      $$TxtTocRulesTableUpdateCompanionBuilder,
      (
        TxtTocRule,
        BaseReferences<_$AppDatabase, $TxtTocRulesTable, TxtTocRule>,
      ),
      TxtTocRule,
      PrefetchHooks Function()
    >;
typedef $$HttpTtsTableCreateCompanionBuilder =
    HttpTtsCompanion Function({
      Value<int> id,
      required String name,
      required String url,
      Value<String?> header,
      Value<String?> loginCheckJs,
      Value<String?> loginUrl,
      Value<String?> loginUi,
      Value<String?> comment,
      Value<String?> group,
      Value<int> sortNumber,
      Value<bool> enabled,
    });
typedef $$HttpTtsTableUpdateCompanionBuilder =
    HttpTtsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> url,
      Value<String?> header,
      Value<String?> loginCheckJs,
      Value<String?> loginUrl,
      Value<String?> loginUi,
      Value<String?> comment,
      Value<String?> group,
      Value<int> sortNumber,
      Value<bool> enabled,
    });

class $$HttpTtsTableFilterComposer
    extends Composer<_$AppDatabase, $HttpTtsTable> {
  $$HttpTtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get header => $composableBuilder(
    column: $table.header,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginCheckJs => $composableBuilder(
    column: $table.loginCheckJs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginUrl => $composableBuilder(
    column: $table.loginUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginUi => $composableBuilder(
    column: $table.loginUi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get group => $composableBuilder(
    column: $table.group,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortNumber => $composableBuilder(
    column: $table.sortNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HttpTtsTableOrderingComposer
    extends Composer<_$AppDatabase, $HttpTtsTable> {
  $$HttpTtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get header => $composableBuilder(
    column: $table.header,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginCheckJs => $composableBuilder(
    column: $table.loginCheckJs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginUrl => $composableBuilder(
    column: $table.loginUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginUi => $composableBuilder(
    column: $table.loginUi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get group => $composableBuilder(
    column: $table.group,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortNumber => $composableBuilder(
    column: $table.sortNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HttpTtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HttpTtsTable> {
  $$HttpTtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get header =>
      $composableBuilder(column: $table.header, builder: (column) => column);

  GeneratedColumn<String> get loginCheckJs => $composableBuilder(
    column: $table.loginCheckJs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get loginUrl =>
      $composableBuilder(column: $table.loginUrl, builder: (column) => column);

  GeneratedColumn<String> get loginUi =>
      $composableBuilder(column: $table.loginUi, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<String> get group =>
      $composableBuilder(column: $table.group, builder: (column) => column);

  GeneratedColumn<int> get sortNumber => $composableBuilder(
    column: $table.sortNumber,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);
}

class $$HttpTtsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HttpTtsTable,
          HttpTt,
          $$HttpTtsTableFilterComposer,
          $$HttpTtsTableOrderingComposer,
          $$HttpTtsTableAnnotationComposer,
          $$HttpTtsTableCreateCompanionBuilder,
          $$HttpTtsTableUpdateCompanionBuilder,
          (HttpTt, BaseReferences<_$AppDatabase, $HttpTtsTable, HttpTt>),
          HttpTt,
          PrefetchHooks Function()
        > {
  $$HttpTtsTableTableManager(_$AppDatabase db, $HttpTtsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HttpTtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HttpTtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HttpTtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String?> header = const Value.absent(),
                Value<String?> loginCheckJs = const Value.absent(),
                Value<String?> loginUrl = const Value.absent(),
                Value<String?> loginUi = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<String?> group = const Value.absent(),
                Value<int> sortNumber = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
              }) => HttpTtsCompanion(
                id: id,
                name: name,
                url: url,
                header: header,
                loginCheckJs: loginCheckJs,
                loginUrl: loginUrl,
                loginUi: loginUi,
                comment: comment,
                group: group,
                sortNumber: sortNumber,
                enabled: enabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String url,
                Value<String?> header = const Value.absent(),
                Value<String?> loginCheckJs = const Value.absent(),
                Value<String?> loginUrl = const Value.absent(),
                Value<String?> loginUi = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<String?> group = const Value.absent(),
                Value<int> sortNumber = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
              }) => HttpTtsCompanion.insert(
                id: id,
                name: name,
                url: url,
                header: header,
                loginCheckJs: loginCheckJs,
                loginUrl: loginUrl,
                loginUi: loginUi,
                comment: comment,
                group: group,
                sortNumber: sortNumber,
                enabled: enabled,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HttpTtsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HttpTtsTable,
      HttpTt,
      $$HttpTtsTableFilterComposer,
      $$HttpTtsTableOrderingComposer,
      $$HttpTtsTableAnnotationComposer,
      $$HttpTtsTableCreateCompanionBuilder,
      $$HttpTtsTableUpdateCompanionBuilder,
      (HttpTt, BaseReferences<_$AppDatabase, $HttpTtsTable, HttpTt>),
      HttpTt,
      PrefetchHooks Function()
    >;
typedef $$DictRulesTableCreateCompanionBuilder =
    DictRulesCompanion Function({
      required String name,
      required String urlRule,
      Value<bool> enabled,
      Value<int> sortNumber,
      Value<String?> showRule,
      Value<bool> enabledExplore,
      Value<int> rowid,
    });
typedef $$DictRulesTableUpdateCompanionBuilder =
    DictRulesCompanion Function({
      Value<String> name,
      Value<String> urlRule,
      Value<bool> enabled,
      Value<int> sortNumber,
      Value<String?> showRule,
      Value<bool> enabledExplore,
      Value<int> rowid,
    });

class $$DictRulesTableFilterComposer
    extends Composer<_$AppDatabase, $DictRulesTable> {
  $$DictRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get urlRule => $composableBuilder(
    column: $table.urlRule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortNumber => $composableBuilder(
    column: $table.sortNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get showRule => $composableBuilder(
    column: $table.showRule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabledExplore => $composableBuilder(
    column: $table.enabledExplore,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DictRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $DictRulesTable> {
  $$DictRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get urlRule => $composableBuilder(
    column: $table.urlRule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortNumber => $composableBuilder(
    column: $table.sortNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get showRule => $composableBuilder(
    column: $table.showRule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabledExplore => $composableBuilder(
    column: $table.enabledExplore,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DictRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DictRulesTable> {
  $$DictRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get urlRule =>
      $composableBuilder(column: $table.urlRule, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get sortNumber => $composableBuilder(
    column: $table.sortNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get showRule =>
      $composableBuilder(column: $table.showRule, builder: (column) => column);

  GeneratedColumn<bool> get enabledExplore => $composableBuilder(
    column: $table.enabledExplore,
    builder: (column) => column,
  );
}

class $$DictRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DictRulesTable,
          DictRule,
          $$DictRulesTableFilterComposer,
          $$DictRulesTableOrderingComposer,
          $$DictRulesTableAnnotationComposer,
          $$DictRulesTableCreateCompanionBuilder,
          $$DictRulesTableUpdateCompanionBuilder,
          (DictRule, BaseReferences<_$AppDatabase, $DictRulesTable, DictRule>),
          DictRule,
          PrefetchHooks Function()
        > {
  $$DictRulesTableTableManager(_$AppDatabase db, $DictRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DictRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DictRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DictRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> name = const Value.absent(),
                Value<String> urlRule = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> sortNumber = const Value.absent(),
                Value<String?> showRule = const Value.absent(),
                Value<bool> enabledExplore = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DictRulesCompanion(
                name: name,
                urlRule: urlRule,
                enabled: enabled,
                sortNumber: sortNumber,
                showRule: showRule,
                enabledExplore: enabledExplore,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String name,
                required String urlRule,
                Value<bool> enabled = const Value.absent(),
                Value<int> sortNumber = const Value.absent(),
                Value<String?> showRule = const Value.absent(),
                Value<bool> enabledExplore = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DictRulesCompanion.insert(
                name: name,
                urlRule: urlRule,
                enabled: enabled,
                sortNumber: sortNumber,
                showRule: showRule,
                enabledExplore: enabledExplore,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DictRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DictRulesTable,
      DictRule,
      $$DictRulesTableFilterComposer,
      $$DictRulesTableOrderingComposer,
      $$DictRulesTableAnnotationComposer,
      $$DictRulesTableCreateCompanionBuilder,
      $$DictRulesTableUpdateCompanionBuilder,
      (DictRule, BaseReferences<_$AppDatabase, $DictRulesTable, DictRule>),
      DictRule,
      PrefetchHooks Function()
    >;
typedef $$NotesTableCreateCompanionBuilder =
    NotesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> content,
      Value<String?> bookUrl,
      Value<String?> bookName,
      Value<int?> chapterIndex,
      required int createTime,
      required int updateTime,
    });
typedef $$NotesTableUpdateCompanionBuilder =
    NotesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> content,
      Value<String?> bookUrl,
      Value<String?> bookName,
      Value<int?> chapterIndex,
      Value<int> createTime,
      Value<int> updateTime,
    });

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookUrl => $composableBuilder(
    column: $table.bookUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookName => $composableBuilder(
    column: $table.bookName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapterIndex => $composableBuilder(
    column: $table.chapterIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookUrl => $composableBuilder(
    column: $table.bookUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookName => $composableBuilder(
    column: $table.bookName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapterIndex => $composableBuilder(
    column: $table.chapterIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get bookUrl =>
      $composableBuilder(column: $table.bookUrl, builder: (column) => column);

  GeneratedColumn<String> get bookName =>
      $composableBuilder(column: $table.bookName, builder: (column) => column);

  GeneratedColumn<int> get chapterIndex => $composableBuilder(
    column: $table.chapterIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => column,
  );
}

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTable,
          Note,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (Note, BaseReferences<_$AppDatabase, $NotesTable, Note>),
          Note,
          PrefetchHooks Function()
        > {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> bookUrl = const Value.absent(),
                Value<String?> bookName = const Value.absent(),
                Value<int?> chapterIndex = const Value.absent(),
                Value<int> createTime = const Value.absent(),
                Value<int> updateTime = const Value.absent(),
              }) => NotesCompanion(
                id: id,
                title: title,
                content: content,
                bookUrl: bookUrl,
                bookName: bookName,
                chapterIndex: chapterIndex,
                createTime: createTime,
                updateTime: updateTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> bookUrl = const Value.absent(),
                Value<String?> bookName = const Value.absent(),
                Value<int?> chapterIndex = const Value.absent(),
                required int createTime,
                required int updateTime,
              }) => NotesCompanion.insert(
                id: id,
                title: title,
                content: content,
                bookUrl: bookUrl,
                bookName: bookName,
                chapterIndex: chapterIndex,
                createTime: createTime,
                updateTime: updateTime,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTable,
      Note,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (Note, BaseReferences<_$AppDatabase, $NotesTable, Note>),
      Note,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BookSourcesTableTableManager get bookSources =>
      $$BookSourcesTableTableManager(_db, _db.bookSources);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
  $$BookChaptersTableTableManager get bookChapters =>
      $$BookChaptersTableTableManager(_db, _db.bookChapters);
  $$BookGroupsTableTableManager get bookGroups =>
      $$BookGroupsTableTableManager(_db, _db.bookGroups);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$ReplaceRulesTableTableManager get replaceRules =>
      $$ReplaceRulesTableTableManager(_db, _db.replaceRules);
  $$SearchBooksTableTableManager get searchBooks =>
      $$SearchBooksTableTableManager(_db, _db.searchBooks);
  $$RssSourcesTableTableManager get rssSources =>
      $$RssSourcesTableTableManager(_db, _db.rssSources);
  $$RssArticlesTableTableManager get rssArticles =>
      $$RssArticlesTableTableManager(_db, _db.rssArticles);
  $$SearchKeywordsTableTableManager get searchKeywords =>
      $$SearchKeywordsTableTableManager(_db, _db.searchKeywords);
  $$TxtTocRulesTableTableManager get txtTocRules =>
      $$TxtTocRulesTableTableManager(_db, _db.txtTocRules);
  $$HttpTtsTableTableManager get httpTts =>
      $$HttpTtsTableTableManager(_db, _db.httpTts);
  $$DictRulesTableTableManager get dictRules =>
      $$DictRulesTableTableManager(_db, _db.dictRules);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
}
