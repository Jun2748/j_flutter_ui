import 'package:flutter/material.dart';

import '../../../resources/app_theme_tokens.dart';
import '../../../resources/dimens.dart';
import '../../../resources/styles.dart';

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
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  }) : _variant = variant;

  const SimpleButton.primary({
    Key? key,
    required String? label,
    required VoidCallback? onPressed,
    bool loading = false,
    IconData? icon,
    double? width,
    EdgeInsets? padding,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: _SimpleButtonVariant.primary,
         loading: loading,
         icon: icon,
         width: width,
         padding: padding,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         borderColor: borderColor,
       );

  const SimpleButton.secondary({
    Key? key,
    required String? label,
    required VoidCallback? onPressed,
    bool loading = false,
    IconData? icon,
    double? width,
    EdgeInsets? padding,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: _SimpleButtonVariant.secondary,
         loading: loading,
         icon: icon,
         width: width,
         padding: padding,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         borderColor: borderColor,
       );

  const SimpleButton.outline({
    Key? key,
    required String? label,
    required VoidCallback? onPressed,
    bool loading = false,
    IconData? icon,
    double? width,
    EdgeInsets? padding,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: _SimpleButtonVariant.outline,
         loading: loading,
         icon: icon,
         width: width,
         padding: padding,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         borderColor: borderColor,
       );

  const SimpleButton.text({
    Key? key,
    required String? label,
    required VoidCallback? onPressed,
    bool loading = false,
    IconData? icon,
    double? width,
    EdgeInsets? padding,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: _SimpleButtonVariant.text,
         loading: loading,
         icon: icon,
         width: width,
         padding: padding,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         borderColor: borderColor,
       );

  static const Set<WidgetState> _enabledState = <WidgetState>{};
  static const Set<WidgetState> _disabledState = <WidgetState>{
    WidgetState.disabled,
  };

  final String? label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;
  final double? width;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final _SimpleButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = AppThemeTokens.resolve(theme);
    final ButtonStyle themeStyle = _themeStyle(theme);
    final bool isEnabled = onPressed != null;
    final bool isInteractive = isEnabled && !loading;
    final bool showDisabledState = !isEnabled;
    final EdgeInsetsGeometry resolvedPadding =
        padding ??
        themeStyle.padding?.resolve(_enabledState) ??
        JInsets.horizontal16Vertical12;
    final TextStyle resolvedTextStyle =
        themeStyle.textStyle?.resolve(_enabledState) ?? JTextStyles.button;
    final OutlinedBorder resolvedShape =
        themeStyle.shape?.resolve(_enabledState) ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JDimens.dp12),
        );
    final Size resolvedMinimumSize =
        themeStyle.minimumSize?.resolve(_enabledState) ??
        const Size(0, JHeights.button);
    final double resolvedElevation =
        themeStyle.elevation?.resolve(_enabledState) ?? 0;
    final Color foregroundColor = _foregroundColor(
      theme,
      tokens: tokens,
      showDisabledState: showDisabledState,
    );
    final Color backgroundColor = _backgroundColor(
      theme,
      tokens: tokens,
      showDisabledState: showDisabledState,
    );
    final BorderSide resolvedBorderSide = _borderSide(
      themeStyle,
      theme,
      tokens: tokens,
      showDisabledState: showDisabledState,
    );

    final ButtonStyle style = themeStyle.copyWith(
      minimumSize: WidgetStatePropertyAll<Size>(resolvedMinimumSize),
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(resolvedPadding),
      textStyle: WidgetStatePropertyAll<TextStyle>(resolvedTextStyle),
      shape: WidgetStatePropertyAll<OutlinedBorder>(resolvedShape),
      elevation: WidgetStatePropertyAll<double>(resolvedElevation),
      backgroundColor: WidgetStatePropertyAll<Color>(backgroundColor),
      foregroundColor: WidgetStatePropertyAll<Color>(foregroundColor),
      side: WidgetStatePropertyAll<BorderSide>(resolvedBorderSide),
      shadowColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
    );

    final Widget child = _buildChild(foregroundColor);

    final Widget button;
    switch (_variant) {
      case _SimpleButtonVariant.primary:
      case _SimpleButtonVariant.secondary:
        button = ElevatedButton(
          onPressed: isInteractive ? onPressed : null,
          style: style,
          child: child,
        );
      case _SimpleButtonVariant.outline:
        button = OutlinedButton(
          onPressed: isInteractive ? onPressed : null,
          style: style,
          child: child,
        );
      case _SimpleButtonVariant.text:
        button = TextButton(
          onPressed: isInteractive ? onPressed : null,
          style: style,
          child: child,
        );
    }

    return SizedBox(width: width, child: button);
  }

  ButtonStyle _themeStyle(ThemeData theme) {
    switch (_variant) {
      case _SimpleButtonVariant.primary:
      case _SimpleButtonVariant.secondary:
        return theme.elevatedButtonTheme.style ?? const ButtonStyle();
      case _SimpleButtonVariant.outline:
        return theme.outlinedButtonTheme.style ?? const ButtonStyle();
      case _SimpleButtonVariant.text:
        return theme.textButtonTheme.style ?? const ButtonStyle();
    }
  }

  Widget _buildChild(Color foregroundColor) {
    if (loading) {
      return SizedBox(
        height: JIconSizes.sm,
        width: JIconSizes.sm,
        child: CircularProgressIndicator(
          strokeWidth: JDimens.dp2,
          color: foregroundColor,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          Icon(icon, size: JIconSizes.md),
          JGaps.w8,
        ],
        Flexible(
          child: Text(
            label ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Color _backgroundColor(
    ThemeData theme, {
    required AppThemeTokens tokens,
    required bool showDisabledState,
  }) {
    final Color fallbackColor;

    switch (_variant) {
      case _SimpleButtonVariant.primary:
        fallbackColor = showDisabledState
            ? theme.disabledColor.withAlpha(31)
            : tokens.primary;
      case _SimpleButtonVariant.secondary:
        fallbackColor = showDisabledState
            ? theme.disabledColor.withAlpha(16)
            : Color.alphaBlend(
                tokens.secondary.withAlpha(18),
                tokens.cardBackground,
              );
      case _SimpleButtonVariant.outline:
      case _SimpleButtonVariant.text:
        fallbackColor = Colors.transparent;
    }

    return backgroundColor ?? fallbackColor;
  }

  Color _foregroundColor(
    ThemeData theme, {
    required AppThemeTokens tokens,
    required bool showDisabledState,
  }) {
    final Color fallbackColor;

    if (showDisabledState) {
      fallbackColor = theme.disabledColor;
    } else {
      switch (_variant) {
        case _SimpleButtonVariant.primary:
          fallbackColor = theme.colorScheme.onPrimary;
        case _SimpleButtonVariant.secondary:
          fallbackColor = tokens.secondary;
        case _SimpleButtonVariant.outline:
          fallbackColor = tokens.primary;
        case _SimpleButtonVariant.text:
          fallbackColor = tokens.primary;
      }
    }

    return foregroundColor ?? fallbackColor;
  }

  BorderSide _borderSide(
    ButtonStyle themeStyle,
    ThemeData theme, {
    required AppThemeTokens tokens,
    required bool showDisabledState,
  }) {
    final BorderSide? themedSide = themeStyle.side?.resolve(
      showDisabledState ? _disabledState : _enabledState,
    );
    final double resolvedWidth = themedSide?.width ?? JDimens.dp1;

    if (borderColor != null) {
      return BorderSide(color: borderColor!, width: resolvedWidth);
    }

    switch (_variant) {
      case _SimpleButtonVariant.secondary:
        return BorderSide(
          color: showDisabledState
              ? theme.disabledColor.withAlpha(64)
              : tokens.secondary.withAlpha(56),
          width: resolvedWidth,
        );
      case _SimpleButtonVariant.outline:
        return BorderSide(
          color: showDisabledState
              ? theme.disabledColor.withAlpha(64)
              : tokens.primary,
          width: resolvedWidth,
        );
      case _SimpleButtonVariant.primary:
      case _SimpleButtonVariant.text:
        return BorderSide.none;
    }
  }
}
