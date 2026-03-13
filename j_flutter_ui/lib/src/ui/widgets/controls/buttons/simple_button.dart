import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../../../resources/dimens.dart';
import '../../../resources/styles.dart';
import '../../layout/gap.dart';

enum _SimpleButtonVariant { primary, secondary, outline, text }

class SimpleButton extends StatelessWidget {
  const SimpleButton._({
    super.key,
    required this.label,
    required this.onPressed,
    required _SimpleButtonVariant variant,
    this.loading = false,
    this.icon,
    this.width,
    this.padding,
  }) : _variant = variant;

  const SimpleButton.primary({
    Key? key,
    required String? label,
    required VoidCallback? onPressed,
    bool loading = false,
    IconData? icon,
    double? width,
    EdgeInsets? padding,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: _SimpleButtonVariant.primary,
         loading: loading,
         icon: icon,
         width: width,
         padding: padding,
       );

  const SimpleButton.secondary({
    Key? key,
    required String? label,
    required VoidCallback? onPressed,
    bool loading = false,
    IconData? icon,
    double? width,
    EdgeInsets? padding,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: _SimpleButtonVariant.secondary,
         loading: loading,
         icon: icon,
         width: width,
         padding: padding,
       );

  const SimpleButton.outline({
    Key? key,
    required String? label,
    required VoidCallback? onPressed,
    bool loading = false,
    IconData? icon,
    double? width,
    EdgeInsets? padding,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: _SimpleButtonVariant.outline,
         loading: loading,
         icon: icon,
         width: width,
         padding: padding,
       );

  const SimpleButton.text({
    Key? key,
    required String? label,
    required VoidCallback? onPressed,
    bool loading = false,
    IconData? icon,
    double? width,
    EdgeInsets? padding,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: _SimpleButtonVariant.text,
         loading: loading,
         icon: icon,
         width: width,
         padding: padding,
       );

  final String? label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;
  final double? width;
  final EdgeInsets? padding;
  final _SimpleButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets resolvedPadding =
        padding ?? JInsets.horizontal16Vertical12;
    final VoidCallback? resolvedOnPressed = loading ? null : onPressed;

    final Color primary = JColors.getColor(context, lightKey: 'primary');
    final Color surface = JColors.getColor(context, lightKey: 'surface');
    final Color border = JColors.getColor(context, lightKey: 'border');
    final Color textPrimary = JColors.getColor(
      context,
      lightKey: 'textPrimary',
    );

    final ButtonStyle baseStyle = ButtonStyle(
      minimumSize: const WidgetStatePropertyAll<Size>(Size(0, JHeights.button)),
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(resolvedPadding),
      textStyle: const WidgetStatePropertyAll<TextStyle>(JTextStyles.button),
      shape: WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JDimens.dp12),
        ),
      ),
      elevation: const WidgetStatePropertyAll<double>(0),
    );

    final Widget child = _buildChild(
      color: _foregroundColor(primary: primary, textPrimary: textPrimary),
    );

    final Widget button;
    switch (_variant) {
      case _SimpleButtonVariant.primary:
      case _SimpleButtonVariant.secondary:
        button = ElevatedButton(
          onPressed: resolvedOnPressed,
          style: baseStyle.copyWith(
            backgroundColor: WidgetStatePropertyAll<Color>(
              _variant == _SimpleButtonVariant.primary ? primary : surface,
            ),
            foregroundColor: WidgetStatePropertyAll<Color>(
              _foregroundColor(primary: primary, textPrimary: textPrimary),
            ),
            shadowColor: const WidgetStatePropertyAll<Color>(Color(0x00000000)),
            side: WidgetStatePropertyAll<BorderSide>(
              BorderSide(
                color: _variant == _SimpleButtonVariant.secondary
                    ? border
                    : primary,
              ),
            ),
          ),
          child: child,
        );
      case _SimpleButtonVariant.outline:
        button = OutlinedButton(
          onPressed: resolvedOnPressed,
          style: baseStyle.copyWith(
            backgroundColor: const WidgetStatePropertyAll<Color>(
              Color(0x00000000),
            ),
            foregroundColor: WidgetStatePropertyAll<Color>(textPrimary),
            side: WidgetStatePropertyAll<BorderSide>(BorderSide(color: border)),
          ),
          child: child,
        );
      case _SimpleButtonVariant.text:
        button = TextButton(
          onPressed: resolvedOnPressed,
          style: baseStyle.copyWith(
            backgroundColor: const WidgetStatePropertyAll<Color>(
              Color(0x00000000),
            ),
            foregroundColor: WidgetStatePropertyAll<Color>(primary),
            overlayColor: WidgetStatePropertyAll<Color>(primary.withAlpha(18)),
          ),
          child: child,
        );
    }

    return SizedBox(width: width, child: button);
  }

  Widget _buildChild({required Color color}) {
    if (loading) {
      return SizedBox(
        height: JIconSizes.sm,
        width: JIconSizes.sm,
        child: CircularProgressIndicator(
          strokeWidth: JDimens.dp2,
          color: color,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (icon != null) ...<Widget>[Icon(icon, size: JIconSizes.md), Gap.w8],
        Text(label ?? ''),
      ],
    );
  }

  Color _foregroundColor({required Color primary, required Color textPrimary}) {
    switch (_variant) {
      case _SimpleButtonVariant.primary:
        return JColors.white;
      case _SimpleButtonVariant.secondary:
      case _SimpleButtonVariant.outline:
        return textPrimary;
      case _SimpleButtonVariant.text:
        return primary;
    }
  }
}
