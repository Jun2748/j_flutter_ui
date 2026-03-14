import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleForm backend errors', () {
    testWidgets('controller.setError displays backend error in the form', (
      WidgetTester tester,
    ) async {
      final SimpleFormController controller = SimpleFormController(
        initialValues: <String, dynamic>{'email': 'jun@example.com'},
      );

      await pumpTestApp(
        tester,
        SimpleFormBuilder(
          controller: controller,
          fields: <SimpleFormFieldConfig<dynamic>>[
            SimpleFormFieldConfig.text(name: 'email', label: 'Email'),
          ],
        ),
      );

      controller.setError('email', 'Email already exists');
      await tester.pump();

      expect(find.text('Email already exists'), findsOneWidget);
    });

    testWidgets('editing the field clears backend error', (
      WidgetTester tester,
    ) async {
      final SimpleFormController controller = SimpleFormController(
        initialValues: <String, dynamic>{'email': 'jun@example.com'},
      );

      await pumpTestApp(
        tester,
        SimpleFormBuilder(
          controller: controller,
          fields: <SimpleFormFieldConfig<dynamic>>[
            SimpleFormFieldConfig.text(name: 'email', label: 'Email'),
          ],
        ),
      );

      controller.setError('email', 'Email already exists');
      await tester.pump();
      expect(find.text('Email already exists'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'new@example.com');
      await tester.pump();

      expect(find.text('Email already exists'), findsNothing);
      expect(controller.getError('email'), isNull);
    });

    testWidgets('controller.setErrors works for multiple fields', (
      WidgetTester tester,
    ) async {
      final SimpleFormController controller = SimpleFormController(
        initialValues: <String, dynamic>{
          'email': 'jun@example.com',
          'username': 'jun',
        },
      );

      await pumpTestApp(
        tester,
        SimpleFormBuilder(
          controller: controller,
          fields: <SimpleFormFieldConfig<dynamic>>[
            SimpleFormFieldConfig.text(name: 'email', label: 'Email'),
            SimpleFormFieldConfig.text(name: 'username', label: 'Username'),
          ],
        ),
      );

      controller.setErrors(<String, String>{
        'email': 'Email already exists',
        'username': 'Username is already taken',
      });
      await tester.pump();

      expect(find.text('Email already exists'), findsOneWidget);
      expect(find.text('Username is already taken'), findsOneWidget);
    });
  });
}
