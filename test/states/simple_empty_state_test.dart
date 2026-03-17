import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleEmptyState', () {
    testWidgets('title renders', (WidgetTester tester) async {
      await pumpTestApp(tester, const SimpleEmptyState(title: 'No items'));

      expect(find.text('No items'), findsOneWidget);
    });

    testWidgets('message renders', (WidgetTester tester) async {
      await pumpTestApp(
        tester,
        const SimpleEmptyState(
          title: 'No items',
          message: 'Try refreshing later.',
        ),
      );

      expect(find.text('Try refreshing later.'), findsOneWidget);
    });

    testWidgets('action button renders when provided', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        SimpleEmptyState(
          title: 'No items',
          actionLabel: 'Refresh',
          onActionPressed: () {},
        ),
      );

      expect(find.text('Refresh'), findsOneWidget);
    });

    testWidgets('action callback can be triggered', (
      WidgetTester tester,
    ) async {
      bool pressed = false;

      await pumpTestApp(
        tester,
        SimpleEmptyState(
          title: 'No items',
          actionLabel: 'Refresh',
          onActionPressed: () {
            pressed = true;
          },
        ),
      );

      await tester.tap(find.text('Refresh'));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('empty state uses AppThemeTokens colors', (
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
            body: SimpleEmptyState(
              title: 'No items',
              message: 'Try refreshing later.',
            ),
          ),
        ),
      );
      await tester.pump();

      final Container iconContainer = tester.widget<Container>(
        find.byType(Container).first,
      );
      final BoxDecoration decoration =
          iconContainer.decoration! as BoxDecoration;
      final Icon icon = tester.widget<Icon>(find.byType(Icon));
      final Text messageText = tester.widget<Text>(
        find.text('Try refreshing later.'),
      );

      expect(icon.color, const Color(0xFF0F766E));
      expect(decoration.color, isNotNull);
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
