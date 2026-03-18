import 'package:flutter/material.dart';

@immutable
class JTints {
  const JTints._();

  /// Returns a tinted surface color by alpha-blending [tint] over [base].
  static Color surface(Color base, Color tint, {required int alpha}) {
    return Color.alphaBlend(tint.withAlpha(alpha), base);
  }

  /// Returns a tinted border color by alpha-blending [tint] over [base].
  static Color border(Color base, Color tint, {required int alpha}) {
    return Color.alphaBlend(tint.withAlpha(alpha), base);
  }
}

