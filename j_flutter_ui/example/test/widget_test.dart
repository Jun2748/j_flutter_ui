import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui_example/main.dart';

void main() {
  testWidgets('renders widget catalog', (WidgetTester tester) async {
    await tester.pumpWidget(const ExampleApp());
    await tester.pumpAndSettle();

    expect(find.text('Widget Catalog'), findsOneWidget);

    expect(find.widgetWithText(ListTile, 'Buttons'), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Cards'), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Text'), findsOneWidget);
  });
}
