import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../controls/buttons/simple_icon_button.dart';
import '../typography/simple_text.dart';

/// Minus / count / plus stepper for adjusting item quantities.
///
/// Composes [SimpleIconButton.outline] for the buttons and
/// [SimpleText.counter] for the value display.
///
/// Place in product-detail or cart rows. Pass [onChanged] as `null`
/// to disable both buttons.
class SimpleQuantityStepper extends StatelessWidget {
  const SimpleQuantityStepper({
    super.key,
    required this.value,
    this.onChanged,
    this.minValue = 1,
    this.maxValue,
    this.buttonSize,
    this.iconSize,
    this.countWidth,
    this.gap,
    this.activeColor,
    this.disabledColor,
    this.disabledBorderColor,
    this.countColor,
  });

  /// Current count.
  final int value;

  /// Called with the new value when +/− is tapped.
  /// Pass `null` to disable both buttons.
  final ValueChanged<int>? onChanged;

  /// Floor value — minus button disables at this value. Defaults to `1`.
  final int minValue;

  /// Ceiling value — plus button disables at this value.
  /// `null` means no upper limit.
  final int? maxValue;

  /// Icon-button tap-target size. Defaults to `JDimens.dp40`.
  final double? buttonSize;

  /// Icon size inside each button. Defaults to `JIconSizes.md`.
  final double? iconSize;

  /// Width of the centered count label area. Defaults to `JDimens.dp40`.
  final double? countWidth;

  /// Horizontal gap between each button and the count. Defaults to `JDimens.dp16`.
  final double? gap;

  /// Foreground and border color for enabled buttons. Defaults to `tokens.primary`.
  final Color? activeColor;

  /// Foreground color when a button is disabled. Defaults to `tokens.mutedText`.
  final Color? disabledColor;

  /// Border color when a button is disabled. Defaults to `tokens.cardBorderColor`.
  final Color? disabledBorderColor;

  /// Color of the count text. Defaults to `tokens.primary`.
  final Color? countColor;

  @override
  Widget build(BuildContext context) {
    final AppThemeTokens tokens = Theme.of(context).appThemeTokens;

    final Color resolvedActive = activeColor ?? tokens.primary;
    final Color resolvedDisabled = disabledColor ?? tokens.mutedText;
    final Color resolvedDisabledBorder =
        disabledBorderColor ?? tokens.cardBorderColor;
    final Color resolvedCount = countColor ?? tokens.primary;
    final double resolvedGap = gap ?? JDimens.dp16;
    final double resolvedCountWidth = countWidth ?? JDimens.dp40;

    final int? max = maxValue;
    final bool canDecrease = onChanged != null && value > minValue;
    final bool canIncrease =
        onChanged != null && (max == null || value < max);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SimpleIconButton.outline(
          icon: Icons.remove,
          onPressed: canDecrease ? () => onChanged!(value - 1) : null,
          foregroundColor:
              canDecrease ? resolvedActive : resolvedDisabled,
          borderColor:
              canDecrease ? resolvedActive : resolvedDisabledBorder,
          size: buttonSize,
          iconSize: iconSize,
        ),
        SizedBox(width: resolvedGap),
        SizedBox(
          width: resolvedCountWidth,
          child: Center(
            child: SimpleText.counter(
              text: '$value',
              color: resolvedCount,
              maxLines: 1,
            ),
          ),
        ),
        SizedBox(width: resolvedGap),
        SimpleIconButton.outline(
          icon: Icons.add,
          onPressed: canIncrease ? () => onChanged!(value + 1) : null,
          foregroundColor:
              canIncrease ? resolvedActive : resolvedDisabled,
          borderColor:
              canIncrease ? resolvedActive : resolvedDisabledBorder,
          size: buttonSize,
          iconSize: iconSize,
        ),
      ],
    );
  }
}
