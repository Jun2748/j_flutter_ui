import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('SimpleBottomSheet', () {
    testWidgets('show displays title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return TextButton(
                  onPressed: () {
                    SimpleBottomSheet.show<void>(
                      context,
                      title: 'Choose an option',
                      child: const Text('Bottom sheet content'),
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

      expect(find.text('Choose an option'), findsOneWidget);
    });

    testWidgets('optional message renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return TextButton(
                  onPressed: () {
                    SimpleBottomSheet.show<void>(
                      context,
                      title: 'Sheet title',
                      message: 'Sheet message',
                      child: const Text('Bottom sheet content'),
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

      expect(find.text('Sheet message'), findsOneWidget);
    });

    testWidgets('provided child content renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return TextButton(
                  onPressed: () {
                    SimpleBottomSheet.show<void>(
                      context,
                      child: const Text('Provided content'),
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

      expect(find.text('Provided content'), findsOneWidget);
    });

    testWidgets('drag handle renders when enabled', (
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
                    SimpleBottomSheet.show<void>(
                      context,
                      child: const Text('Provided content'),
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

      expect(
        find.byKey(const ValueKey<String>('simple_bottom_sheet_handle')),
        findsOneWidget,
      );
    });

    testWidgets('bottom sheet closes safely when child pops route', (
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
                    SimpleBottomSheet.show<void>(
                      context,
                      child: Builder(
                        builder: (BuildContext sheetContext) {
                          return TextButton(
                            onPressed: () {
                              Navigator.of(sheetContext).pop();
                            },
                            child: const Text('Close Sheet'),
                          );
                        },
                      ),
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
      expect(find.text('Close Sheet'), findsOneWidget);

      await tester.tap(find.text('Close Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Close Sheet'), findsNothing);
    });
  });
}
