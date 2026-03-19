import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('SimpleSearchField', () {
    testWidgets('switches to a new external controller cleanly', (
      WidgetTester tester,
    ) async {
      final TextEditingController firstController = TextEditingController(
        text: 'Alpha',
      );
      final TextEditingController secondController = TextEditingController(
        text: 'Beta',
      );
      addTearDown(firstController.dispose);
      addTearDown(secondController.dispose);

      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            body: _SearchFieldHarness(
              firstController: firstController,
              secondController: secondController,
            ),
          ),
        ),
      );
      await tester.pump();

      EditableText editable = tester.widget<EditableText>(
        find.byType(EditableText),
      );
      expect(editable.controller, same(firstController));
      expect(editable.controller.text, 'Alpha');
      expect(find.byIcon(Icons.close), findsOneWidget);

      await tester.tap(find.text('Swap'));
      await tester.pump();

      editable = tester.widget<EditableText>(find.byType(EditableText));
      expect(editable.controller, same(secondController));
      expect(editable.controller.text, 'Beta');

      firstController.text = 'Stale';
      await tester.pump();

      editable = tester.widget<EditableText>(find.byType(EditableText));
      expect(editable.controller, same(secondController));
      expect(editable.controller.text, 'Beta');

      secondController.clear();
      await tester.pump();

      expect(find.byIcon(Icons.close), findsNothing);
    });
  });
}

class _SearchFieldHarness extends StatefulWidget {
  const _SearchFieldHarness({
    required this.firstController,
    required this.secondController,
  });

  final TextEditingController firstController;
  final TextEditingController secondController;

  @override
  State<_SearchFieldHarness> createState() => _SearchFieldHarnessState();
}

class _SearchFieldHarnessState extends State<_SearchFieldHarness> {
  bool _useFirstController = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SimpleSearchField(
          controller: _useFirstController
              ? widget.firstController
              : widget.secondController,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _useFirstController = false;
            });
          },
          child: const Text('Swap'),
        ),
      ],
    );
  }
}
