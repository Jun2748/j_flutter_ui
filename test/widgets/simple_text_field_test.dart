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
            body: SimpleTextField(labelText: 'Name', initialValue: 'Alice'),
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
        () => SimpleTextField(controller: controller, initialValue: 'Preset'),
        throwsA(isA<AssertionError>()),
      );
    });

    testWidgets(
      'prefixIcon and suffixIcon remain semantics-safe during submit',
      (WidgetTester tester) async {
        final SemanticsHandle semanticsHandle = tester.ensureSemantics();

        await tester.pumpWidget(
          MaterialApp(
            theme: JAppTheme.lightTheme,
            home: Scaffold(
              body: ListView(
                children: <Widget>[
                  SimpleFormBuilder(
                    fields: <SimpleFormFieldConfig<dynamic>>[
                      SimpleFormFieldConfig.text(
                        name: 'email',
                        label: 'Email',
                        required: true,
                      ),
                    ],
                    showSubmitButton: true,
                    onSubmit: (Map<String, dynamic> values) async {},
                  ),
                  const SimpleTextField(
                    labelText: 'Phone prefix',
                    hintText: '123456789',
                    prefixIcon: Padding(
                      padding: JInsets.horizontal12,
                      child: Center(child: SimpleText.body(text: '+60')),
                    ),
                  ),
                  SimpleTextField(
                    labelText: 'Password suffix',
                    obscureText: true,
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility_off_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).at(1), '123456789');
        await tester.enterText(find.byType(TextFormField).at(2), 'secret123');
        await tester.pumpAndSettle();

        await tester.tap(find.text('Submit'));
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        semanticsHandle.dispose();
      },
    );
  });
}
