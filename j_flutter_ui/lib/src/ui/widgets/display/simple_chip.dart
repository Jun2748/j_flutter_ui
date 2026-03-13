import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';
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
    final _ChipColors colors = _resolveColors(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: JDimens.dp12,
        vertical: JDimens.dp8,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(JDimens.dp24),
      ),
      child: SimpleText.label(text: label ?? '', color: colors.foreground),
    );
  }

  _ChipColors _resolveColors(BuildContext context) {
    switch (_variant) {
      case _SimpleChipVariant.neutral:
        return _ChipColors(
          background: JColors.getColor(context, lightKey: 'surface'),
          foreground: JColors.getColor(context, lightKey: 'textPrimary'),
        );
      case _SimpleChipVariant.primary:
        return _ChipColors(
          background: JColors.getColor(
            context,
            lightKey: 'primary',
          ).withAlpha(24),
          foreground: JColors.getColor(context, lightKey: 'primary'),
        );
      case _SimpleChipVariant.success:
        return _ChipColors(
          background: JColors.getColor(
            context,
            lightKey: 'success',
          ).withAlpha(24),
          foreground: JColors.getColor(context, lightKey: 'success'),
        );
      case _SimpleChipVariant.warning:
        return _ChipColors(
          background: JColors.getColor(
            context,
            lightKey: 'warning',
          ).withAlpha(24),
          foreground: JColors.getColor(context, lightKey: 'warning'),
        );
      case _SimpleChipVariant.error:
        return _ChipColors(
          background: JColors.getColor(
            context,
            lightKey: 'error',
          ).withAlpha(24),
          foreground: JColors.getColor(context, lightKey: 'error'),
        );
    }
  }
}

class _ChipColors {
  const _ChipColors({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}
