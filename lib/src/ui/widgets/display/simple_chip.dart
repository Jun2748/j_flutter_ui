import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../../resources/tinted_surface.dart';
import '../typography/simple_text.dart';

enum _SimpleChipVariant { neutral, primary, success, warning, error }

class SimpleChip extends StatelessWidget {
  const SimpleChip._({
    super.key,
    required this.label,
    required _SimpleChipVariant variant,
  }) : _variant = variant;

  const SimpleChip.neutral({Key? key, required String? label})
    : this._(key: key, label: label, variant: _SimpleChipVariant.neutral);

  const SimpleChip.primary({Key? key, required String? label})
    : this._(key: key, label: label, variant: _SimpleChipVariant.primary);

  const SimpleChip.success({Key? key, required String? label})
    : this._(key: key, label: label, variant: _SimpleChipVariant.success);

  const SimpleChip.warning({Key? key, required String? label})
    : this._(key: key, label: label, variant: _SimpleChipVariant.warning);

  const SimpleChip.error({Key? key, required String? label})
    : this._(key: key, label: label, variant: _SimpleChipVariant.error);

  final String? label;
  final _SimpleChipVariant _variant;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final _ChipColors colors = _resolveColors(theme);

    return Container(
      padding: JInsets.horizontal12Vertical8,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(JDimens.dp24),
      ),
      child: SimpleText.label(text: label ?? '', color: colors.foreground),
    );
  }

  _ChipColors _resolveColors(ThemeData theme) {
    final AppThemeTokens tokens = theme.appThemeTokens;
    final JStatusColors statusColors =
        theme.extension<JStatusColors>() ??
        JStatusColors.fallback(brightness: theme.brightness);

    switch (_variant) {
      case _SimpleChipVariant.neutral:
        return _ChipColors(
          background: tokens.cardBackground,
          foreground: theme.colorScheme.onSurface,
        );
      case _SimpleChipVariant.primary:
        return _ChipColors(
          background: JTints.surface(
            tokens.cardBackground,
            tokens.primary,
            alpha: 24,
          ),
          foreground: tokens.primary,
        );
      case _SimpleChipVariant.success:
        final Color success = statusColors.success;
        return _ChipColors(
          background: JTints.surface(tokens.cardBackground, success, alpha: 24),
          foreground: success,
        );
      case _SimpleChipVariant.warning:
        final Color warning = statusColors.warning;
        return _ChipColors(
          background: JTints.surface(tokens.cardBackground, warning, alpha: 24),
          foreground: warning,
        );
      case _SimpleChipVariant.error:
        return _ChipColors(
          background: JTints.surface(
            tokens.cardBackground,
            theme.colorScheme.error,
            alpha: 24,
          ),
          foreground: theme.colorScheme.error,
        );
    }
  }
}

class _ChipColors {
  const _ChipColors({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}
