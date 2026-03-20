import 'package:flutter/material.dart';

import 'dimens.dart';

abstract final class JTextStyles {
  const JTextStyles._();

  static const String fontFamily = 'Inter';

  static const TextStyle title1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: JFontSizes.fs32,
    fontWeight: FontWeight.w700,
    height: JLineHeights.lh40 / JFontSizes.fs32,
    letterSpacing: -0.4,
  );

  static const TextStyle title2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: JFontSizes.fs20,
    fontWeight: FontWeight.w600,
    height: JLineHeights.lh28 / JFontSizes.fs20,
    letterSpacing: -0.2,
  );

  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: JFontSizes.fs24,
    fontWeight: FontWeight.w700,
    height: JLineHeights.lh32 / JFontSizes.fs24,
    letterSpacing: -0.3,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: JFontSizes.fs16,
    fontWeight: FontWeight.w400,
    height: JLineHeights.lh24 / JFontSizes.fs16,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: JFontSizes.fs14,
    fontWeight: FontWeight.w400,
    height: JLineHeights.lh20 / JFontSizes.fs14,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize: JFontSizes.fs12,
    fontWeight: FontWeight.w500,
    height: JLineHeights.lh16 / JFontSizes.fs12,
    letterSpacing: 0.2,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: JFontSizes.fs16,
    fontWeight: FontWeight.w600,
    height: JLineHeights.lh24 / JFontSizes.fs16,
    letterSpacing: 0.1,
  );

  /// Prominent price display — hero prices on product/order cards.
  /// Tabular figures keep digit widths uniform so prices align vertically.
  static const TextStyle priceLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: JFontSizes.fs20,
    fontWeight: FontWeight.w700,
    height: JLineHeights.lh28 / JFontSizes.fs20,
    letterSpacing: -0.2,
    fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
  );

  /// Inline price display — list items, summaries, cart rows.
  /// Tabular figures keep digit widths uniform so prices align vertically.
  static const TextStyle price = TextStyle(
    fontFamily: fontFamily,
    fontSize: JFontSizes.fs16,
    fontWeight: FontWeight.w600,
    height: JLineHeights.lh24 / JFontSizes.fs16,
    fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
  );
}
