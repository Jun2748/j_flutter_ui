import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('SimpleTextField', () {
    testWidgets('initialValue is applied when controller is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: const Scaffold(
            body: SimpleTextField(
              labelText: 'Name',
              initialValue: 'Alice',
            ),
          ),
        ),
      );

      final EditableText editable = tester.widget<EditableText>(
        find.byType(EditableText),
      );

      expect(editable.controller.text, 'Alice');
    });

    testWidgets('asserts when controller and initialValue are both provided', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller = TextEditingController();
      addTearDown(controller.dispose);

      expect(
        () => SimpleTextField(
          controller: controller,
          initialValue: 'Preset',
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}

