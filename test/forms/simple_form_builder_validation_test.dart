import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleFormBuilder validation', () {
    testWidgets('required validator shows error', (WidgetTester tester) async {
      final SimpleFormController controller = SimpleFormController();

      await pumpTestApp(
        tester,
        SimpleFormBuilder(
          controller: controller,
          fields: <SimpleFormFieldConfig<dynamic>>[
            SimpleFormFieldConfig.text(
              name: 'email',
              label: 'Email',
              validator: SimpleFormValidator.required(),
            ),
          ],
        ),
      );

      expect(controller.validate(), isFalse);
      await tester.pump();

      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('email validator rejects invalid email', (
      WidgetTester tester,
    ) async {
      final SimpleFormController controller = SimpleFormController();

      await pumpTestApp(
        tester,
        SimpleFormBuilder(
          controller: controller,
          fields: <SimpleFormFieldConfig<dynamic>>[
            SimpleFormFieldConfig.text(
              name: 'email',
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: SimpleFormValidator.combine(<SimpleValidator>[
                SimpleFormValidator.required(),
                SimpleFormValidator.email(),
              ]),
            ),
          ],
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'invalid-email');
      await tester.pump();

      expect(controller.validate(), isFalse);
      await tester.pump();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('cross-field validator rejects mismatched confirm password', (
      WidgetTester tester,
    ) async {
      final SimpleFormController controller = SimpleFormController();

      await pumpTestApp(
        tester,
        SimpleFormBuilder(
          controller: controller,
          fields: <SimpleFormFieldConfig<dynamic>>[
            SimpleFormFieldConfig.text(
              name: 'password',
              label: 'Password',
              validator: SimpleFormValidator.required(),
            ),
            SimpleFormFieldConfig.text(
              name: 'confirmPassword',
              label: 'Confirm Password',
              validator: SimpleFormValidator.required(),
              crossValidators: <SimpleCrossFieldValidator>[
                SimpleCrossFieldValidators.matchField(
                  'password',
                  message: 'Passwords do not match',
                ),
              ],
            ),
          ],
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'secret123');
      await tester.enterText(find.byType(TextFormField).at(1), 'secret999');
      await tester.pump();

      expect(controller.validate(), isFalse);
      await tester.pump();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('valid input passes validation', (WidgetTester tester) async {
      final SimpleFormController controller = SimpleFormController();

      await pumpTestApp(
        tester,
        SimpleFormBuilder(
          controller: controller,
          fields: <SimpleFormFieldConfig<dynamic>>[
            SimpleFormFieldConfig.text(
              name: 'email',
              label: 'Email',
              validator: SimpleFormValidator.combine(<SimpleValidator>[
                SimpleFormValidator.required(),
                SimpleFormValidator.email(),
              ]),
            ),
            SimpleFormFieldConfig.text(
              name: 'password',
              label: 'Password',
              validator: SimpleFormValidator.combine(<SimpleValidator>[
                SimpleFormValidator.required(),
                SimpleFormValidator.minLength(8),
              ]),
            ),
            SimpleFormFieldConfig.text(
              name: 'confirmPassword',
              label: 'Confirm Password',
              validator: SimpleFormValidator.required(),
              crossValidators: <SimpleCrossFieldValidator>[
                SimpleCrossFieldValidators.matchField(
                  'password',
                  message: 'Passwords do not match',
                ),
              ],
            ),
          ],
        ),
      );

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'valid@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(1), 'secret123');
      await tester.enterText(find.byType(TextFormField).at(2), 'secret123');
      await tester.pump();

      expect(controller.validate(), isTrue);
      await tester.pump();

      expect(find.text('Please enter a valid email address'), findsNothing);
      expect(find.text('Passwords do not match'), findsNothing);
    });

    testWidgets('built-in validation messages honor AppLocalizationBridge', (
      WidgetTester tester,
    ) async {
      final SimpleFormController controller = SimpleFormController();
      addTearDown(AppLocalizationBridge.clear);
      AppLocalizationBridge.configure((
        BuildContext context,
        String key, {
        Map<String, String>? args,
      }) {
        switch (key) {
          case L.formValidationRequiredField:
            return '${args?['field']} must be filled';
          case L.formValidationMinLength:
            return 'Need ${args?['length']} chars';
        }
        return null;
      });

      await pumpTestApp(
        tester,
        Builder(
          builder: (BuildContext context) {
            return SimpleFormBuilder(
              controller: controller,
              fields: <SimpleFormFieldConfig<dynamic>>[
                SimpleFormFieldConfig.text(
                  name: 'username',
                  label: 'Username',
                  required: true,
                  validator: SimpleFormValidator.minLength(5, context: context),
                ),
              ],
            );
          },
        ),
      );

      expect(controller.validate(), isFalse);
      await tester.pump();
      expect(find.text('Username must be filled'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'abc');
      await tester.pump();

      expect(controller.validate(), isFalse);
      await tester.pump();
      expect(find.text('Need 5 chars'), findsOneWidget);
    });
  });
}
