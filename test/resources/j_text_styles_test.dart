import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('JTextStyles — price styles', () {
    test('priceLarge has tabular figures', () {
      expect(
        JTextStyles.priceLarge.fontFeatures,
        contains(const FontFeature('tnum')),
      );
    });

    test('priceLarge has correct size and weight', () {
      expect(JTextStyles.priceLarge.fontSize, JFontSizes.fs20);
      expect(JTextStyles.priceLarge.fontWeight, FontWeight.w700);
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
