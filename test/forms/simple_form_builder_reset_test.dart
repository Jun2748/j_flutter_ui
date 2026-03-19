import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleFormBuilder reset', () {
    testWidgets(
      'reset clears values to null, clears errors, and blanks text inputs',
      (WidgetTester tester) async {
        final GlobalKey<SimpleFormBuilderState> formKey =
            GlobalKey<SimpleFormBuilderState>();
        final SimpleFormController controller = SimpleFormController(
          initialValues: <String, dynamic>{
            'name': 'Jun',
            'query': 'Coffee',
            'terms': true,
            'role': 'admin',
          },
        );
        Map<String, dynamic>? lastChangedValues;

        await pumpTestApp(
          tester,
          SimpleFormBuilder(
            key: formKey,
            controller: controller,
            onChanged: (Map<String, dynamic> values) {
              lastChangedValues = values;
            },
            fields: <SimpleFormFieldConfig<dynamic>>[
              SimpleFormFieldConfig.text(
                name: 'name',
                label: 'Name',
                required: true,
              ),
              SimpleFormFieldConfig.search(name: 'query', label: 'Query'),
              SimpleFormFieldConfig.checkbox(name: 'terms', label: 'Terms'),
              SimpleFormFieldConfig<String>.dropdown(
                name: 'role',
                label: 'Role',
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: 'admin',
                    child: Text('Admin'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'member',
                    child: Text('Member'),
                  ),
                ],
              ),
            ],
          ),
        );

        await tester.enterText(find.byType(TextFormField).first, '');
        await tester.pump();

        controller.setError('role', 'Role backend error');
        await tester.pump();

        expect(controller.validate(), isFalse);
        await tester.pump();
        expect(find.text('Name is required'), findsOneWidget);
        expect(find.text('Role backend error'), findsOneWidget);

        formKey.currentState?.reset();
        await tester.pump();

        expect(controller.values, <String, dynamic>{
          'name': null,
          'query': null,
          'terms': null,
          'role': null,
        });
        expect(lastChangedValues, <String, dynamic>{
          'name': null,
          'query': null,
          'terms': null,
          'role': null,
        });
        expect(find.text('Name is required'), findsNothing);
        expect(find.text('Role backend error'), findsNothing);

        final List<EditableText> editables = tester
            .widgetList<EditableText>(find.byType(EditableText))
            .toList();
        expect(editables, hasLength(2));
        expect(editables[0].controller.text, isEmpty);
        expect(editables[1].controller.text, isEmpty);
      },
    );
  });
}
