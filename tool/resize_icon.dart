// ignore_for_file: avoid_print

import 'dart:io';
import 'package:image/image.dart' as img;

void main() async {
  final src = await File('assets/icon.png').readAsBytes();
  final icon = img.decodeImage(src)!;
  final sizes = {'mdpi': 48, 'hdpi': 72, 'xhdpi': 96, 'xxhdpi': 144, 'xxxhdpi': 192};
  for (final e in sizes.entries) {
    final resized = img.copyResize(icon, width: e.value);
    final out = 'android/app/src/main/res/mipmap-${e.key}/ic_launcher.png';
    await File(out).writeAsBytes(img.encodePng(resized));
    print('${e.key}: ${e.value}x${e.value} -> $out');
  }
}
