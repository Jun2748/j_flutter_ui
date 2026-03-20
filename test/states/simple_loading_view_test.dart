import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleLoadingView', () {
    testWidgets('loading indicator renders', (WidgetTester tester) async {
      await pumpTestApp(tester, const SimpleLoadingView());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('optional message renders when provided', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        const SimpleLoadingView(message: 'Loading bookings...'),
      );

      expect(find.text('Loading bookings...'), findsOneWidget);
    });

    testWidgets('loading view uses AppThemeTokens colors', (
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
            body: SimpleLoadingView(message: 'Loading bookings...'),
          ),
        ),
      );
      await tester.pump();

      final CircularProgressIndicator indicator = tester
          .widget<CircularProgressIndicator>(
            find.byType(CircularProgressIndicator),
          );
      final Text message = tester.widget<Text>(
        find.text('Loading bookings...'),
      );

      expect(indicator.color, const Color(0xFF0F766E));
      expect(message.style?.color, const Color(0xFF92400E));
    });

    testWidgets('loading view respects ProgressIndicatorTheme color', (
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
          theme: _withTokens(
            JAppTheme.lightTheme.copyWith(
              progressIndicatorTheme: const ProgressIndicatorThemeData(
                color: Color(0xFF2563EB),
              ),
            ),
            tokens,
          ),
          home: const Scaffold(body: SimpleLoadingView()),
        ),
      );
      await tester.pump();

      final CircularProgressIndicator indicator = tester
          .widget<CircularProgressIndicator>(
            find.byType(CircularProgressIndicator),
          );

      expect(indicator.color, const Color(0xFF2563EB));
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
