import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleText', () {
    testWidgets('priceLarge renders with JTextStyles.priceLarge and w800', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(tester, const SimpleText.priceLarge(text: 'RM 18.90'));

      final Text text = tester.widget<Text>(find.text('RM 18.90'));

      expect(text.style?.fontSize, JTextStyles.priceLarge.fontSize);
      expect(text.style?.height, JTextStyles.priceLarge.height);
      expect(text.style?.fontWeight, FontWeight.w800);
      expect(text.style?.fontFeatures, JTextStyles.priceLarge.fontFeatures);
    });

    testWidgets(
      'sectionLabel renders with JTextStyles.sectionLabel and w700',
      (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        const SimpleText.sectionLabel(text: 'FEATURED OFFER'),
      );

      final Text text = tester.widget<Text>(find.text('FEATURED OFFER'));

      expect(text.style?.fontSize, JTextStyles.sectionLabel.fontSize);
      expect(text.style?.height, JTextStyles.sectionLabel.height);
      expect(
        text.style?.letterSpacing,
        JTextStyles.sectionLabel.letterSpacing,
      );
      expect(text.style?.fontWeight, FontWeight.w700);
    });

    testWidgets('counter renders centered with counter style and w700', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(tester, const SimpleText.counter(text: '12'));

      final Text text = tester.widget<Text>(find.text('12'));

      expect(text.textAlign, TextAlign.center);
      expect(text.overflow, TextOverflow.clip);
      expect(text.style?.fontSize, JTextStyles.counter.fontSize);
      expect(text.style?.height, JTextStyles.counter.height);
      expect(text.style?.fontWeight, FontWeight.w700);
      expect(text.style?.fontFeatures, JTextStyles.counter.fontFeatures);
    });

    testWidgets('fontSize overrides style fontSize when provided', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        const SimpleText.body(text: 'Custom body', fontSize: JFontSizes.fs18),
      );

      final Text text = tester.widget<Text>(find.text('Custom body'));

      expect(text.style?.fontSize, JFontSizes.fs18);
    });

    testWidgets('fontSize is ignored when null and uses style default', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        const SimpleText.body(text: 'Default body', fontSize: null),
      );

      final Text text = tester.widget<Text>(find.text('Default body'));

      expect(
        text.style?.fontSize,
        JAppTheme.lightTheme.textTheme.bodyLarge?.fontSize ??
            JTextStyles.body1.fontSize,
      );
    });
  });
}
