import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:freader/core/database/app_database.dart' as db;
import 'package:freader/data/daos/book_source_dao.dart';
import 'package:freader/data/entities/book_source.dart' as dto;
import 'package:freader/data/entities/rules/search_rule.dart';
import 'package:freader/data/entities/rules/explore_rule.dart';
import 'package:freader/data/entities/rules/book_info_rule.dart';
import 'package:freader/data/entities/rules/toc_rule.dart';
import 'package:freader/data/entities/rules/content_rule.dart';
import 'package:freader/data/entities/rules/review_rule.dart';

/// 书源仓库 - 封装 DAO 操作 + JSON 序列化逻辑
class BookSourceRepository {
  final BookSourceDao _dao;

  BookSourceRepository(db.AppDatabase database) : _dao = BookSourceDao(database);

  /// 获取所有书源（DTO）
  Future<List<dto.BookSource>> getAll() async {
    final rows = await _dao.getAll();
    return rows.map(_toDto).toList();
  }

  /// 监听所有书源
  Stream<List<dto.BookSource>> watchAll() {
    return _dao.watchAll().map((rows) => rows.map(_toDto).toList());
  }

  /// 监听已启用书源
  Stream<List<dto.BookSource>> watchEnabled() {
    return _dao.watchEnabled().map((rows) => rows.map(_toDto).toList());
  }

  /// 监听启用发现的书源
  Stream<List<dto.BookSource>> watchEnabledExplore() {
    return _dao.watchEnabledExplore().map((rows) => rows.map(_toDto).toList());
  }

  /// 按名称搜索
  Stream<List<dto.BookSource>> searchByName(String query) {
    return _dao.searchByName(query).map((rows) => rows.map(_toDto).toList());
  }

  /// 按分组获取
  Stream<List<dto.BookSource>> watchByGroup(String group) {
    return _dao.watchByGroup(group).map((rows) => rows.map(_toDto).toList());
  }

  /// 获取所有分组
  Future<List<String>> getAllGroups() => _dao.getAllGroups();

  /// 根据 URL 获取
  Future<dto.BookSource?> getByUrl(String url) async {
    final row = await _dao.getByUrl(url);
    return row != null ? _toDto(row) : null;
  }

  /// 保存单个书源（从 DTO）
  Future<void> save(dto.BookSource source) {
    return _dao.insertOrReplace(_toCompanion(source));
  }

  /// 批量保存书源
  Future<void> saveAll(List<dto.BookSource> sources) {
    return _dao.insertAll(sources.map(_toCompanion).toList());
  }

  /// 启用/禁用
  Future<void> setEnabled(String url, bool enabled) =>
      _dao.setEnabled(url, enabled);

  /// 删除
  Future<void> deleteByUrl(String url) => _dao.deleteByUrl(url);

  /// 批量删除
  Future<void> deleteByUrls(List<String> urls) => _dao.deleteByUrls(urls);

  /// 获取数量
  Future<int> getCount() => _dao.getCount();

  // ===== JSON 导入/导出 =====

  /// 从 JSON 字符串导入书源
  /// [jsonStr] 可以是 JSON 数组或单个对象
  /// 返回导入的书源数量
  Future<int> importFromJson(String jsonStr) async {
    final dynamic decoded = jsonDecode(jsonStr);

    List<dynamic> list;
    if (decoded is List) {
      list = decoded;
    } else if (decoded is Map<String, dynamic>) {
      list = [decoded];
    } else {
      throw FormatException('无效的书源 JSON 格式');
    }

    final sources = <dto.BookSource>[];
    for (final item in list) {
      if (item is Map<String, dynamic>) {
        try {
          sources.add(dto.BookSource.fromJson(item));
        } catch (e) {
          // 跳过无效的书源条目
          continue;
        }
      }
    }

    if (sources.isNotEmpty) {
      await saveAll(sources);
    }
    return sources.length;
  }

  /// 导出所有书源为 JSON 字符串
  Future<String> exportToJson() async {
    final sources = await getAll();
    return jsonEncode(sources.map((s) => s.toJson()).toList());
  }

  /// 导出指定书源为 JSON 字符串
  String exportSourcesToJson(List<dto.BookSource> sources) {
    return jsonEncode(sources.map((s) => s.toJson()).toList());
  }

  // ===== 类型转换 =====

  /// 数据库行 -> DTO
  dto.BookSource _toDto(db.BookSource row) {
    return dto.BookSource(
      bookSourceUrl: row.bookSourceUrl,
      bookSourceName: row.bookSourceName,
      bookSourceGroup: row.bookSourceGroup,
      bookSourceType: row.bookSourceType,
      bookUrlPattern: row.bookUrlPattern,
      customOrder: row.customOrder,
      enabled: row.enabled,
      enabledExplore: row.enabledExplore,
      enabledCookieJar: row.enabledCookieJar,
      jsLib: row.jsLib,
      concurrentRate: row.concurrentRate,
      header: row.header,
      loginUrl: row.loginUrl,
      loginUi: row.loginUi,
      loginCheckJs: row.loginCheckJs,
      searchUrl: row.searchUrl,
      exploreUrl: row.exploreUrl,
      exploreScreen: row.exploreScreen,
      ruleSearch: _parseRule(row.ruleSearch, SearchRule.fromJson),
      ruleExplore: _parseRule(row.ruleExplore, ExploreRule.fromJson),
      ruleBookInfo: _parseRule(row.ruleBookInfo, BookInfoRule.fromJson),
      ruleToc: _parseRule(row.ruleToc, TocRule.fromJson),
      ruleContent: _parseRule(row.ruleContent, ContentRule.fromJson),
      ruleReview: _parseRule(row.ruleReview, ReviewRule.fromJson),
      respondTime: row.respondTime,
      lastUpdateTime: row.lastUpdateTime,
      variable: row.variable,
      weight: row.weight,
    );
  }

  T? _parseRule<T>(String? json, T Function(Map<String, dynamic>) fromJson) {
    if (json == null || json.isEmpty) return null;
    try {
      return fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  /// DTO -> 数据库 Companion
  db.BookSourcesCompanion _toCompanion(dto.BookSource source) {
    return db.BookSourcesCompanion(
      bookSourceUrl: Value(source.bookSourceUrl),
      bookSourceName: Value(source.bookSourceName),
      bookSourceGroup: Value(source.bookSourceGroup),
      bookSourceType: Value(source.bookSourceType),
      bookUrlPattern: Value(source.bookUrlPattern),
      customOrder: Value(source.customOrder),
      enabled: Value(source.enabled),
      enabledExplore: Value(source.enabledExplore),
      enabledCookieJar: Value(source.enabledCookieJar),
      jsLib: Value(source.jsLib),
      concurrentRate: Value(source.concurrentRate),
      header: Value(source.header),
      loginUrl: Value(source.loginUrl),
      loginUi: Value(source.loginUi),
      loginCheckJs: Value(source.loginCheckJs),
      searchUrl: Value(source.searchUrl),
      exploreUrl: Value(source.exploreUrl),
      exploreScreen: Value(source.exploreScreen),
      ruleSearch: Value(source.ruleSearch != null
          ? jsonEncode(source.ruleSearch!.toJson())
          : null),
      ruleExplore: Value(source.ruleExplore != null
          ? jsonEncode(source.ruleExplore!.toJson())
          : null),
      ruleBookInfo: Value(source.ruleBookInfo != null
          ? jsonEncode(source.ruleBookInfo!.toJson())
          : null),
      ruleToc: Value(
          source.ruleToc != null ? jsonEncode(source.ruleToc!.toJson()) : null),
      ruleContent: Value(source.ruleContent != null
          ? jsonEncode(source.ruleContent!.toJson())
          : null),
      ruleReview: Value(source.ruleReview != null
          ? jsonEncode(source.ruleReview!.toJson())
          : null),
      respondTime: Value(source.respondTime),
      lastUpdateTime: Value(source.lastUpdateTime),
      variable: Value(source.variable),
      weight: Value(source.weight),
    );
  }
}
