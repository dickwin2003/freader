// ignore_for_file: avoid_print

// 生成 FReader 应用图标 — 温暖书页风格
import 'dart:io';
import 'package:image/image.dart' as img;

int dist2(int x1, int y1, int x2, int y2) => (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);

void main() async {
  const size = 1024;
  final image = img.Image(size, size);

  // 背景渐变：暖棕到暖橙
  for (int y = 0; y < size; y++) {
    final t = y / size;
    final r = (93 + (230 - 93) * t).toInt();
    final g = (64 + (130 - 64) * t).toInt();
    final b = (55 + (30 - 55) * t).toInt();
    for (int x = 0; x < size; x++) {
      image.setPixelRgba(x, y, r, g, b, 255);
    }
  }

  final cx = size ~/ 2;
  final cy = size ~/ 2;
  final bookW = 500, bookH = 380, pageR = 20;

  // 左页
  _fillRRect(image, cx - bookW ~/ 2 - 5, cy - bookH ~/ 2, bookW ~/ 2, bookH, pageR, 250, 245, 235, 210);
  // 右页
  _fillRRect(image, cx + 5, cy - bookH ~/ 2, bookW ~/ 2, bookH, pageR, 255, 250, 240, 210);

  // 书脊
  for (int y = cy - bookH ~/ 2; y < cy + bookH ~/ 2; y++) {
    for (int dx = -5; dx <= 5; dx++) {
      _blend(image, cx + dx, y, 100, 70, 50, 180);
    }
  }

  // 左页文字线
  for (int i = 0; i < 9; i++) {
    final ly = cy - bookH ~/ 2 + 45 + i * 36;
    _drawHLine(image, cx - bookW ~/ 2 + 45, ly, 100 + (i % 3) * 35);
  }
  // 右页文字线
  for (int i = 0; i < 9; i++) {
    final ly = cy - bookH ~/ 2 + 45 + i * 36;
    _drawHLine(image, cx + 25, ly, 90 + (i % 3) * 45);
  }

  // 翻页折角
  for (int fy = 0; fy < 55; fy++) {
    for (int fx = 0; fx <= fy; fx++) {
      _blend(image, cx + bookW ~/ 2 - 10 + fx, cy - bookH ~/ 2 + fy,
          240, 210, 170, (200 * (1 - fy / 55)).toInt());
    }
  }

  // 底部 "F" 字母
  final fS = 100, fT = fS ~/ 5, fX = cx - fS ~/ 3, fY = cy + bookH ~/ 2 + 40;
  _rect(image, fX, fY, fT, fS);          // 竖线
  _rect(image, fX, fY, fS, fT);          // 上横线
  _rect(image, fX, fY + fS * 2 ~/ 5, fS * 7 ~/ 10, fT); // 中横线

  final png = img.encodePng(image);
  await File('assets/icon.png').writeAsBytes(png);
  print('Icon saved (${png.length} bytes)');
}

void _fillRRect(img.Image im, int x, int y, int w, int h, int r, int cr, int cg, int cb, int ca) {
  for (int dy = 0; dy < h; dy++) {
    for (int dx = 0; dx < w; dx++) {
      if (dx < r && dy < r && dist2(dx, dy, r, r) > r * r) continue;
      if (dx > w - r && dy < r && dist2(dx, dy, w - r, r) > r * r) continue;
      if (dx < r && dy > h - r && dist2(dx, dy, r, h - r) > r * r) continue;
      if (dx > w - r && dy > h - r && dist2(dx, dy, w - r, h - r) > r * r) continue;
      _blend(im, x + dx, y + dy, cr, cg, cb, ca);
    }
  }
}

void _rect(img.Image im, int x, int y, int w, int h) {
  for (int dy = 0; dy < h; dy++) {
    for (int dx = 0; dx < w; dx++) {
      _blend(im, x + dx, y + dy, 255, 255, 255, 210);
    }
  }
}

void _drawHLine(img.Image im, int x1, int y, int len) {
  for (int i = 0; i < len; i++) {
    for (int d = 0; d < 3; d++) {
      _blend(im, x1 + i, y + d, 255, 255, 255, 100);
    }
  }
}

void _blend(img.Image im, int x, int y, int r, int g, int b, int alpha) {
  if (x < 0 || x >= im.width || y < 0 || y >= im.height) return;
  final p = im.getPixel(x, y);
  final pr = (p >> 16) & 0xFF;
  final pg = (p >> 8) & 0xFF;
  final pb = p & 0xFF;
  final a = alpha / 255.0, ia = 1.0 - a;
  im.setPixelRgba(x, y,
    (pr * ia + r * a).round().clamp(0, 255),
    (pg * ia + g * a).round().clamp(0, 255),
    (pb * ia + b * a).round().clamp(0, 255), 255);
}
