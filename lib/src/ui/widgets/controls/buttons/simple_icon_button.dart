import 'package:flutter/material.dart';

import '../../../resources/app_theme_tokens.dart';
import '../../../resources/dimens.dart';

enum _SimpleIconButtonVariant { filled, outline }

class SimpleIconButton extends StatelessWidget {
  const SimpleIconButton._({
    super.key,
    required this.icon,
    required this.onPressed,
    required _SimpleIconButtonVariant variant,
    this.tooltip,
    this.size,
    this.iconSize,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  }) : _variant = variant;

  const SimpleIconButton.filled({
    Key? key,
    required IconData icon,
    required VoidCallback? onPressed,
    String? tooltip,
    double? size,
    double? iconSize,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
  }) : this._(
         key: key,
         icon: icon,
         onPressed: onPressed,
         variant: _SimpleIconButtonVariant.filled,
         tooltip: tooltip,
         size: size,
         iconSize: iconSize,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         borderColor: borderColor,
       );

  const SimpleIconButton.outline({
    Key? key,
    required IconData icon,
    required VoidCallback? onPressed,
    String? tooltip,
    double? size,
    double? iconSize,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
  }) : this._(
         key: key,
         icon: icon,
         onPressed: onPressed,
         variant: _SimpleIconButtonVariant.outline,
         tooltip: tooltip,
         size: size,
         iconSize: iconSize,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         borderColor: borderColor,
       );

  static const Set<WidgetState> _enabledState = <WidgetState>{};
  static const Set<WidgetState> _disabledState = <WidgetState>{
    WidgetState.disabled,
  };

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double? size;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final _SimpleIconButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final ButtonStyle themeStyle =
        theme.iconButtonTheme.style ?? const ButtonStyle();
    final bool isDisabled = onPressed == null;
    final Set<WidgetState> states = isDisabled ? _disabledState : _enabledState;
    final double resolvedSize =
        size ??
        themeStyle.fixedSize?.resolve(states)?.shortestSide ??
        themeStyle.minimumSize?.resolve(states)?.shortestSide ??
        JDimens.dp40;
    final double resolvedIconSize =
        iconSize ??
        themeStyle.iconSize?.resolve(states) ??
        theme.iconTheme.size ??
        JIconSizes.md;
    final EdgeInsetsGeometry resolvedPadding =
        themeStyle.padding?.resolve(states) ?? EdgeInsets.zero;
    final ShapeBorder? themedShape = themeStyle.shape?.resolve(states);
    final OutlinedBorder resolvedShape = themedShape is OutlinedBorder
        ? themedShape
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(JDimens.dp12),
          );
    final Color resolvedForegroundColor = _foregroundColor(
      themeStyle,
      theme,
      tokens,
      states,
      isDisabled,
    );
    final Color resolvedBackgroundColor = _backgroundColor(
      themeStyle,
      theme,
      tokens,
      states,
      isDisabled,
    );
    final BorderSide resolvedBorderSide = _borderSide(
      themeStyle,
      theme,
      tokens,
      states,
      isDisabled,
    );
    final ButtonStyle style = themeStyle.copyWith(
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(resolvedPadding),
      shape: WidgetStatePropertyAll<OutlinedBorder>(resolvedShape),
      backgroundColor: WidgetStatePropertyAll<Color>(resolvedBackgroundColor),
      foregroundColor: WidgetStatePropertyAll<Color>(resolvedForegroundColor),
      side: WidgetStatePropertyAll<BorderSide>(resolvedBorderSide),
      elevation: const WidgetStatePropertyAll<double>(0),
      shadowColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
    );
    final BoxConstraints constraints = BoxConstraints.tightFor(
      width: resolvedSize,
      height: resolvedSize,
    );
    final Widget iconWidget = Icon(icon, size: resolvedIconSize);

    switch (_variant) {
      case _SimpleIconButtonVariant.filled:
        return IconButton.filled(
          onPressed: onPressed,
          tooltip: tooltip,
          constraints: constraints,
          iconSize: resolvedIconSize,
          style: style,
          icon: iconWidget,
        );
      case _SimpleIconButtonVariant.outline:
        return IconButton.outlined(
          onPressed: onPressed,
          tooltip: tooltip,
          constraints: constraints,
          iconSize: resolvedIconSize,
          style: style,
          icon: iconWidget,
        );
    }
  }

  Color _backgroundColor(
    ButtonStyle themeStyle,
    ThemeData theme,
    AppThemeTokens tokens,
    Set<WidgetState> states,
    bool isDisabled,
  ) {
    final Color? themedColor = themeStyle.backgroundColor?.resolve(states);
    if (backgroundColor != null) {
      return backgroundColor!;
    }
    if (themedColor != null) {
      return themedColor;
    }

    switch (_variant) {
      case _SimpleIconButtonVariant.filled:
        return isDisabled ? theme.disabledColor.withAlpha(31) : tokens.primary;
      case _SimpleIconButtonVariant.outline:
        return Colors.transparent;
    }
  }

  Color _foregroundColor(
    ButtonStyle themeStyle,
    ThemeData theme,
    AppThemeTokens tokens,
    Set<WidgetState> states,
    bool isDisabled,
  ) {
    final Color? themedColor = themeStyle.foregroundColor?.resolve(states);
    if (foregroundColor != null) {
      return foregroundColor!;
    }
    if (themedColor != null) {
      return themedColor;
    }
    if (isDisabled) {
      return theme.disabledColor;
    }

    switch (_variant) {
      case _SimpleIconButtonVariant.filled:
        return tokens.onPrimaryResolved(theme);
      case _SimpleIconButtonVariant.outline:
        return tokens.primary;
    }
  }

  BorderSide _borderSide(
    ButtonStyle themeStyle,
    ThemeData theme,
    AppThemeTokens tokens,
    Set<WidgetState> states,
    bool isDisabled,
  ) {
    final BorderSide? themedSide = themeStyle.side?.resolve(states);
    final double resolvedWidth = themedSide?.width ?? JDimens.dp1;
    if (borderColor != null) {
      return BorderSide(color: borderColor!, width: resolvedWidth);
    }
    if (themedSide != null) {
      return themedSide;
    }

    switch (_variant) {
      case _SimpleIconButtonVariant.filled:
        return BorderSide.none;
      case _SimpleIconButtonVariant.outline:
        return BorderSide(
          color: isDisabled
              ? theme.disabledColor.withAlpha(64)
              : tokens.primary,
          width: resolvedWidth,
        );
    }
  }
}
