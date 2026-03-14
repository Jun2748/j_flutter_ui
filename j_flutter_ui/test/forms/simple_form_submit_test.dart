import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleForm submit', () {
    testWidgets('submit callback is not called when form is invalid', (
      WidgetTester tester,
    ) async {
      int submitCount = 0;

      await pumpTestApp(
        tester,
        SimpleFormBuilder(
          fields: <SimpleFormFieldConfig<dynamic>>[
            SimpleFormFieldConfig.text(
              name: 'email',
              label: 'Email',
              validator: SimpleFormValidator.required(),
            ),
          ],
          showSubmitButton: true,
          onSubmit: (Map<String, dynamic> values) async {
            submitCount += 1;
          },
        ),
      );

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(submitCount, 0);
      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('submit callback is called when form is valid', (
      WidgetTester tester,
    ) async {
      int submitCount = 0;

      await pumpTestApp(
        tester,
        SimpleFormBuilder(
          fields: <SimpleFormFieldConfig<dynamic>>[
            SimpleFormFieldConfig.text(
              name: 'email',
              label: 'Email',
              validator: SimpleFormValidator.combine(<SimpleValidator>[
                SimpleFormValidator.required(),
                SimpleFormValidator.email(),
              ]),
            ),
          ],
          showSubmitButton: true,
          onSubmit: (Map<String, dynamic> values) async {
            submitCount += 1;
          },
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'valid@example.com');
      await tester.pump();
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(submitCount, 1);
    });

    testWidgets('submitting prevents duplicate submit taps', (
      WidgetTester tester,
    ) async {
      final Completer<void> completer = Completer<void>();
      int submitCount = 0;

      await pumpTestApp(
        tester,
        SimpleFormBuilder(
          fields: <SimpleFormFieldConfig<dynamic>>[
            SimpleFormFieldConfig.text(
              name: 'email',
              label: 'Email',
              validator: SimpleFormValidator.required(),
            ),
          ],
          showSubmitButton: true,
          onSubmit: (Map<String, dynamic> values) async {
            submitCount += 1;
            await completer.future;
          },
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'valid@example.com');
      await tester.pump();

      await tester.tap(find.text('Submit'));
      await tester.tap(find.text('Submit'));
      await tester.pump();

      expect(submitCount, 1);

      completer.complete();
      await tester.pumpAndSettle();
    });

    testWidgets(
      'invalid submit triggers first-error handling as practical in widget tests',
      (WidgetTester tester) async {
        final ScrollController scrollController = ScrollController();

        await pumpTestApp(
          tester,
          ListView(
            controller: scrollController,
            children: <Widget>[
              SimpleFormBuilder(
                fields: <SimpleFormFieldConfig<dynamic>>[
                  for (int index = 0; index < 8; index++)
                    SimpleFormFieldConfig.text(
                      name: 'field_$index',
                      label: 'Field ${index + 1}',
                      validator: SimpleFormValidator.required(),
                    ),
                ],
                showSubmitButton: true,
                onSubmit: (Map<String, dynamic> values) async {},
              ),
            ],
          ),
        );

        scrollController.jumpTo(scrollController.position.maxScrollExtent);
        await tester.pumpAndSettle();
        final double offsetBeforeSubmit = scrollController.offset;

        await tester.tap(find.text('Submit'));
        await tester.pumpAndSettle();

        expect(scrollController.offset, lessThan(offsetBeforeSubmit));
        expect(find.text('This field is required'), findsAtLeastNWidgets(1));
      },
    );
  });
}
