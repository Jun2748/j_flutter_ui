import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  testWidgets('SimpleButton.small renders with 32dp minimum height', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: JAppTheme.lightTheme,
        home: Scaffold(
          body: SimpleButton.small(label: 'Save', onPressed: () {}),
        ),
      ),
    );

    final ElevatedButton button = tester.widget<ElevatedButton>(
      find.byType(ElevatedButton),
    );
    final Size? minimumSize = button.style?.minimumSize?.resolve(
      <WidgetState>{},
    );

    expect(minimumSize?.height, JDimens.dp32);
  });
}
