import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleErrorView', () {
    testWidgets('default or custom title renders', (WidgetTester tester) async {
      await pumpTestApp(tester, const SimpleErrorView());

      expect(find.text('Something went wrong'), findsOneWidget);
    });

    testWidgets('message renders', (WidgetTester tester) async {
      await pumpTestApp(
        tester,
        const SimpleErrorView(message: 'Could not load bookings.'),
      );

      expect(find.text('Could not load bookings.'), findsOneWidget);
    });

    testWidgets('retry button renders when provided', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        SimpleErrorView(retryLabel: 'Try Again', onRetry: () {}),
      );

      expect(find.text('Try Again'), findsOneWidget);
    });

    testWidgets('retry callback can be triggered', (WidgetTester tester) async {
      bool retried = false;

      await pumpTestApp(
        tester,
        SimpleErrorView(
          retryLabel: 'Try Again',
          onRetry: () {
            retried = true;
          },
        ),
      );

      await tester.tap(find.text('Try Again'));
      await tester.pump();

      expect(retried, isTrue);
    });

    testWidgets('error view uses AppThemeTokens for supporting text', (
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
          home: const Scaffold(
            body: SimpleErrorView(message: 'Could not load bookings.'),
          ),
        ),
      );
      await tester.pump();

      final Text messageText = tester.widget<Text>(
        find.text('Could not load bookings.'),
      );

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
