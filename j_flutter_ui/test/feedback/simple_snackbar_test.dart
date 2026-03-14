import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('SimpleSnackbar', () {
    testWidgets('showSuccess displays snackbar message', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return TextButton(
                  onPressed: () {
                    SimpleSnackbar.showSuccess(
                      context,
                      message: 'Saved successfully',
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Saved successfully'), findsOneWidget);
    });

    testWidgets('showError displays snackbar message', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return TextButton(
                  onPressed: () {
                    SimpleSnackbar.showError(
                      context,
                      message: 'Something went wrong',
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Something went wrong'), findsOneWidget);
    });

    testWidgets(
      'snackbar action button renders and callback can be triggered',
      (WidgetTester tester) async {
        bool actionTriggered = false;

        await tester.pumpWidget(
          MaterialApp(
            theme: JAppTheme.lightTheme,
            home: Scaffold(
              body: Builder(
                builder: (BuildContext context) {
                  return TextButton(
                    onPressed: () {
                      SimpleSnackbar.showWarning(
                        context,
                        message: 'Please review this item',
                        actionLabel: 'Review',
                        onAction: () {
                          actionTriggered = true;
                        },
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        expect(find.text('Review'), findsOneWidget);

        await tester.tap(find.widgetWithText(TextButton, 'Review'));
        await tester.pump();

        expect(actionTriggered, isTrue);
      },
    );
  });
}
