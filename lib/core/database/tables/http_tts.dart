import 'package:drift/drift.dart';

/// HTTP TTS 表
class HttpTts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get url => text()();
  TextColumn get header => text().nullable()();
  TextColumn get loginCheckJs => text().nullable()();
  TextColumn get loginUrl => text().nullable()();
  TextColumn get loginUi => text().nullable()();
  TextColumn get comment => text().nullable()();
  TextColumn get group => text().nullable()();
  IntColumn get sortNumber =>
      integer().withDefault(const Constant(0))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
}
