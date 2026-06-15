import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_food_picker/main.dart';

void main() {
  testWidgets('App launches with home page', (WidgetTester tester) async {
    await tester.pumpWidget(const FoodPickerApp());

    // 验证首页标题存在
    expect(find.text('今天吃啥'), findsWidgets);

    // 验证两个导航按钮存在
    expect(find.text('使用说明'), findsOneWidget);
    expect(find.text('隐私合规'), findsOneWidget);
  });
}
