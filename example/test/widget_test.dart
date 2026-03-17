import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui_example/main.dart';

void main() {
  testWidgets('renders widget catalog', (WidgetTester tester) async {
    await tester.pumpWidget(const ExampleApp());
    await tester.pumpAndSettle();

    expect(find.text('Widget Catalog'), findsOneWidget);
    expect(find.text('Foundations'), findsWidgets);
    expect(find.text('Text'), findsWidgets);

    await tester.scrollUntilVisible(
      find.text('Buttons'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();

    expect(find.text('Buttons'), findsWidgets);

    await tester.scrollUntilVisible(
      find.text('Cards'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();

    expect(find.text('Cards'), findsWidgets);
  });
}
