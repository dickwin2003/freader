import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:freader/main.dart';

void main() {
  testWidgets('App renders bookshelf page', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: FReaderApp()));

    // 验证书架标题存在
    expect(find.text('书架'), findsWidgets);

    // 验证底部导航项存在
    expect(find.text('笔记'), findsOneWidget);
    expect(find.text('AI'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);
  });
}
