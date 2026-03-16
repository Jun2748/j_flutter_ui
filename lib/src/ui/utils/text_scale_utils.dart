import 'package:flutter/material.dart';

abstract final class TextScaleUtils {
  const TextScaleUtils._();

  static double getClampedScale(
    BuildContext context, {
    double min = 1.0,
    double max = 1.2,
  }) {
    final double rawScale = MediaQuery.textScalerOf(context).scale(1.0);
    return rawScale.clamp(min, max);
  }
}
