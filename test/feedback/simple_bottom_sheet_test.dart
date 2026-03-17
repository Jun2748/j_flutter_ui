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

    testWidgets('bottom sheet uses AppThemeTokens for surface styling', (
      WidgetTester tester,
    ) async {
      const AppThemeTokens tokens = AppThemeTokens(
        primary: Color(0xFF0F766E),
        secondary: Color(0xFF7C3AED),
        cardBackground: Color(0xFFFDFBF4),
        cardBorderColor: Color(0xFFD97706),
        inputBackground: Color(0xFFECFEFF),
        inputBorderColor: Color(0xFF0891B2),
        dividerColor: Color(0xFFF59E0B),
        mutedText: Color(0xFF92400E),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: _withTokens(JAppTheme.lightTheme, tokens),
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return TextButton(
                  onPressed: () {
                    SimpleBottomSheet.show<void>(
                      context,
                      title: 'Sheet title',
                      message: 'Sheet message',
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

      final BottomSheet bottomSheet = tester.widget<BottomSheet>(
        find.byType(BottomSheet),
      );
      final RoundedRectangleBorder shape =
          bottomSheet.shape! as RoundedRectangleBorder;
      final Container handle = tester.widget<Container>(
        find.byKey(const ValueKey<String>('simple_bottom_sheet_handle')),
      );
      final BoxDecoration handleDecoration =
          handle.decoration! as BoxDecoration;
      final Text messageText = tester.widget<Text>(find.text('Sheet message'));

      expect(bottomSheet.backgroundColor, const Color(0xFFFDFBF4));
      expect(shape.side.color, const Color(0xFFD97706));
      expect(handleDecoration.color, const Color(0xFFF59E0B));
      expect(messageText.style?.color, const Color(0xFF92400E));
    });
  });
}

ThemeData _withTokens(ThemeData base, AppThemeTokens tokens) {
  final List<ThemeExtension<dynamic>> extensions =
      base.extensions.values
          .where(
            (ThemeExtension<dynamic> extension) => extension is! AppThemeTokens,
          )
          .toList()
        ..add(tokens);

  return base.copyWith(extensions: extensions);
}
