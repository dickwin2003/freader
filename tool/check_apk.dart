import 'dart:io';
import 'package:archive/archive.dart';

void main() {
  final bytes = File('build/app/outputs/flutter-apk/app-debug.apk').readAsBytesSync();
  final archive = ZipDecoder().decodeBytes(bytes);
  final libs = archive.where((f) => f.name.contains('lib/')).map((f) => f.name).toList()
    ..sort();
  print('Native libs in apk (${libs.length}):');
  for (final n in libs) print('  $n');
}
