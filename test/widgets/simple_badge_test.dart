import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleBadge', () {
    testWidgets('badge label renders', (WidgetTester tester) async {
      await pumpTestApp(
        tester,
        const Center(child: SimpleBadge.neutral(label: 'Draft')),
      );

      expect(find.text('Draft'), findsOneWidget);
    });

    testWidgets('a variant renders correctly', (WidgetTester tester) async {
      await pumpTestApp(
        tester,
        const Center(
          child: SimpleBadge.success(
            label: 'Active',
            icon: Icons.check_circle_outline,
          ),
        ),
      );

      expect(find.text('Active'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    });
  });

  group('SimpleBadge.filled', () {
    testWidgets('renders the label', (WidgetTester tester) async {
      await pumpTestApp(
        tester,
        const Center(
          child: SimpleBadge.filled(label: '46% OFF', color: Color(0xFFCC0000)),
        ),
      );

      expect(find.text('46% OFF'), findsOneWidget);
    });

    testWidgets('renders optional icon', (WidgetTester tester) async {
      await pumpTestApp(
        tester,
        const Center(
          child: SimpleBadge.filled(
            label: 'Sale',
            color: Color(0xFFCC0000),
            icon: Icons.local_offer_outlined,
          ),
        ),
      );

      expect(find.text('Sale'), findsOneWidget);
      expect(find.byIcon(Icons.local_offer_outlined), findsOneWidget);
    });

    testWidgets('uses explicit foregroundColor when provided', (
      WidgetTester tester,
    ) async {
      const Color explicitForeground = Color(0xFFFFFF00);

      await pumpTestApp(
        tester,
        const Center(
          child: SimpleBadge.filled(
            label: 'Test',
            color: Color(0xFFCC0000),
            foregroundColor: explicitForeground,
          ),
        ),
      );

      // The SimpleText.label widget applies color via Text style.
      final Text text = tester.widget<Text>(find.text('Test'));
      expect(text.style?.color, explicitForeground);
    });

    testWidgets('defaults to white foreground on dark background', (
      WidgetTester tester,
    ) async {
      // Dark red — estimateBrightnessForColor returns Brightness.dark.
      await pumpTestApp(
        tester,
        const Center(
          child: SimpleBadge.filled(
            label: 'OFF',
            color: Color(0xFFB00020), // dark red
          ),
        ),
      );

      final Text text = tester.widget<Text>(find.text('OFF'));
      expect(text.style?.color, Colors.white);
    });

    testWidgets('defaults to black foreground on light background', (
      WidgetTester tester,
    ) async {
      // Light yellow — estimateBrightnessForColor returns Brightness.light.
      await pumpTestApp(
        tester,
        const Center(
          child: SimpleBadge.filled(
            label: 'NEW',
            color: Color(0xFFFFF176), // light yellow
          ),
        ),
      );

      final Text text = tester.widget<Text>(find.text('NEW'));
      expect(text.style?.color, Colors.black);
    });

    testWidgets('has no visible border (transparent)', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        const Center(
          child: SimpleBadge.filled(label: 'NO', color: Color(0xFFCC0000)),
        ),
      );

      final DecoratedBox box = tester.widget<DecoratedBox>(
        find.byType(DecoratedBox).first,
      );
      final BoxDecoration decoration = box.decoration as BoxDecoration;
      expect(decoration.border, Border.all(color: Colors.transparent));
    });
  });
}
