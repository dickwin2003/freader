import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'package:freader/service/dev/app_logger.dart';

/// 端侧 OCR（Google ML Kit 文字识别）。免费、离线、比 gemma 小模型识图准得多。
class OcrService {
  const OcrService();

  /// 识别图片文件中的文字。返回拼接后的全文。
  Future<String> recognize(String filePath,
      {TextRecognitionScript script = TextRecognitionScript.chinese}) async {
    appLog('OCR 开始: $filePath (script=$script)', persistImmediately: true);
    final recognizer = TextRecognizer(script: script);
    try {
      final input = InputImage.fromFilePath(filePath);
      appLog('OCR InputImage 构建完成，调用 processImage...', persistImmediately: true);
      final result = await recognizer.processImage(input);
      appLog('OCR 成功: ${result.text.length} 字符', persistImmediately: true);
      return result.text.trim();
    } catch (e, st) {
      appLog('OCR 异常: $e\n$st', level: LogLevel.error, persistImmediately: true);
      rethrow;
    } finally {
      await recognizer.close();
    }
  }
}

final ocrServiceProvider = Provider<OcrService>((ref) => const OcrService());
