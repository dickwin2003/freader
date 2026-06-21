import 'package:flutter_test/flutter_test.dart';
import 'package:freader/service/local_file_reader.dart';

/// buildMobiChaptersFromPreview 单元测试
/// 验证：过滤封面/元数据残片等空章节、用 TOC 真实标题、index 重排。
/// 复现「涌现.mobi 打开只显示书名2字」的真实场景。
void main() {
  group('buildMobiChaptersFromPreview', () {
    test('过滤封面/元数据残片，只保留正文，并用 TOC 真实标题', () {
      final chapters = LocalFileReader.buildMobiChaptersFromPreview(
        filePath: '/books/涌现.mobi',
        sectionTexts: [
          // 第0章：封面，只显示书名2字
          (href: 'kindle:pos:fid:0000:off:0000000000', text: '涌现'),
          // 插图/元数据残片章节（calibre 残片 alibre2"/> + 书名）
          (href: 'kindle:pos:fid:0010:off:0000000000',
              text: '\n    \n  \n  \nalibre2"/>\n  涌现'),
          // 序言：正文（来自真实日志，1963字）
          (href: 'kindle:pos:fid:0003:off:0000000000',
              text: '序言 写一本普通读者能看懂的书 光阴荏苒，距我为非专业读者写的第一本书。' * 20),
        ],
        tocTitleMap: {
          'kindle:pos:fid:0003:off:0000000000': '序言',
        },
        fallbackTitle: '涌现',
      );

      expect(chapters.length, 1); // 封面(2字) + 残片(25字) 被过滤
      expect(chapters[0].title, '序言');
      expect(chapters[0].url, 'kindle:pos:fid:0003:off:0000000000');
      expect(chapters[0].index, 0); // index 重排为 0
      expect(chapters[0].variable, 'mobi');
    });

    test('无 TOC 标题时用"第 N 节"占位', () {
      final chapters = LocalFileReader.buildMobiChaptersFromPreview(
        filePath: '/x.mobi',
        sectionTexts: [
          (href: 'a', text: '正文内容很多' * 10),
          (href: 'b', text: '第二章正文也很多' * 10),
        ],
        tocTitleMap: {},
        fallbackTitle: '书名',
      );

      expect(chapters.length, 2);
      expect(chapters[0].title, '第 1 节');
      expect(chapters[1].title, '第 2 节');
      expect(chapters[0].index, 0);
      expect(chapters[1].index, 1);
    });

    test('全部为空章节时返回空列表（由调用方兜底）', () {
      final chapters = LocalFileReader.buildMobiChaptersFromPreview(
        filePath: '/x.mobi',
        sectionTexts: [
          (href: 'a', text: '涌现'), // 2字
          (href: 'b', text: '   '), // 纯空白
          (href: 'c', text: '\n alibre2"/>\n'), // 残片
        ],
        tocTitleMap: {},
        fallbackTitle: '书名',
      );

      expect(chapters, isEmpty);
    });

    test('边界：内容刚好等于阈值(30字)被保留，29字被过滤', () {
      final chapters = LocalFileReader.buildMobiChaptersFromPreview(
        filePath: '/x.mobi',
        sectionTexts: [
          (href: 'keep', text: '一' * 30), // 30字 >= 阈值，保留
          (href: 'drop', text: '一' * 29), // 29字 < 阈值，过滤
        ],
        tocTitleMap: {},
        fallbackTitle: '书名',
        minContentLength: 30,
      );

      expect(chapters.length, 1);
      expect(chapters[0].url, 'keep');
    });

    test('TOC 标题为空白时回退到"第 N 节"', () {
      final chapters = LocalFileReader.buildMobiChaptersFromPreview(
        filePath: '/x.mobi',
        sectionTexts: [
          (href: 'a', text: '正文' * 20),
        ],
        tocTitleMap: {'a': '   '}, // 空白标题
        fallbackTitle: '书名',
      );

      expect(chapters.length, 1);
      expect(chapters[0].title, '第 1 节');
    });
  });
}
