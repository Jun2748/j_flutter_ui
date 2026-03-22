import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('JTextStyles — typography styles', () {
    test('heading1 has updated ordering-flow size and spacing', () {
      expect(JTextStyles.heading1.fontSize, JFontSizes.fs20);
      expect(JTextStyles.heading1.fontWeight, FontWeight.w700);
      expect(JTextStyles.heading1.height, JLineHeights.lh28 / JFontSizes.fs20);
      expect(JTextStyles.heading1.letterSpacing, -0.2);
    });

    test('priceLarge has tabular figures', () {
      expect(
        JTextStyles.priceLarge.fontFeatures,
        contains(const FontFeature('tnum')),
      );
    });

    test('priceLarge has correct size and weight', () {
      expect(JTextStyles.priceLarge.fontSize, JFontSizes.fs28);
      expect(JTextStyles.priceLarge.fontWeight, FontWeight.w800);
      expect(
        JTextStyles.priceLarge.height,
        JLineHeights.lh33_6 / JFontSizes.fs28,
      );
    });

    test('sectionLabel has uppercase-friendly spacing', () {
      expect(JTextStyles.sectionLabel.fontSize, JFontSizes.fs12);
      expect(JTextStyles.sectionLabel.fontWeight, FontWeight.w700);
      expect(
        JTextStyles.sectionLabel.height,
        JLineHeights.lh16_8 / JFontSizes.fs12,
      );
      expect(JTextStyles.sectionLabel.letterSpacing, JDimens.dp0_6);
    });

    test('counter uses compact tabular figures', () {
      expect(JTextStyles.counter.fontSize, JFontSizes.fs18);
      expect(JTextStyles.counter.fontWeight, FontWeight.w700);
      expect(JTextStyles.counter.height, JLineHeights.lh18 / JFontSizes.fs18);
      expect(JTextStyles.counter.letterSpacing, JDimens.dp0);
      expect(
        JTextStyles.counter.fontFeatures,
        contains(const FontFeature('tnum')),
      );
    });

    test('price has tabular figures', () {
      expect(
        JTextStyles.price.fontFeatures,
        contains(const FontFeature('tnum')),
      );
    });

    test('price has correct size and weight', () {
      expect(JTextStyles.price.fontSize, JFontSizes.fs16);
      expect(JTextStyles.price.fontWeight, FontWeight.w600);
    });

    test('price and priceLarge share the Inter font family', () {
      expect(JTextStyles.price.fontFamily, JTextStyles.fontFamily);
      expect(JTextStyles.priceLarge.fontFamily, JTextStyles.fontFamily);
    });
  });
}
