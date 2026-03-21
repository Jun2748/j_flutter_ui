import 'package:flutter/material.dart';

import '../../../resources/app_theme_tokens.dart';
import '../../../resources/dimens.dart';
import '../../../resources/styles.dart';
import '../../../resources/tinted_surface.dart';

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
    TextStyle? defaultTextStyle,
    Size? defaultMinimumSize,
  })  : _variant = variant,
        _defaultTextStyle = defaultTextStyle,
        _defaultMinimumSize = defaultMinimumSize;

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

  const SimpleButton.small({
    Key? key,
    required String? label,
    required VoidCallback? onPressed,
    bool loading = false,
    IconData? icon,
    double? width,
    EdgeInsets? padding = JInsets.horizontal12Vertical8,
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
          defaultTextStyle: JTextStyles.label,
          defaultMinimumSize: const Size(0, JDimens.dp32),
        );

  const SimpleButton.smallOutline({
    Key? key,
    required String? label,
    required VoidCallback? onPressed,
    bool loading = false,
    IconData? icon,
    double? width,
    EdgeInsets? padding = JInsets.horizontal12Vertical8,
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
          defaultTextStyle: JTextStyles.label,
          defaultMinimumSize: const Size(0, JDimens.dp32),
        );

  const SimpleButton.smallText({
    Key? key,
    required String? label,
    required VoidCallback? onPressed,
    bool loading = false,
    IconData? icon,
    double? width,
    EdgeInsets? padding = JInsets.horizontal12Vertical8,
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
          defaultTextStyle: JTextStyles.label,
          defaultMinimumSize: const Size(0, JDimens.dp32),
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
  final TextStyle? _defaultTextStyle;
  final Size? _defaultMinimumSize;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final ButtonStyle themeStyle = _themeStyle(theme);
    final bool isEnabled = onPressed != null;
    final bool isInteractive = isEnabled && !loading;
    final bool showDisabledState = !isEnabled;
    final EdgeInsetsGeometry resolvedPadding =
        padding ??
        themeStyle.padding?.resolve(_enabledState) ??
        JInsets.horizontal16Vertical12;
    final TextStyle resolvedTextStyle =
        _defaultTextStyle ??
        themeStyle.textStyle?.resolve(_enabledState) ??
        JTextStyles.button;
    final OutlinedBorder resolvedShape =
        themeStyle.shape?.resolve(_enabledState) ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JDimens.dp12),
        );
    final Size resolvedMinimumSize =
        _defaultMinimumSize ??
        themeStyle.minimumSize?.resolve(_enabledState) ??
        const Size(0, JHeights.button);
    final double resolvedElevation =
        themeStyle.elevation?.resolve(_enabledState) ?? 0;
    final Color resolvedForegroundColor = _foregroundColor(
      theme,
      tokens: tokens,
      themeStyle: themeStyle,
      showDisabledState: showDisabledState,
    );
    final Color resolvedBackgroundColor = _backgroundColor(
      theme,
      tokens: tokens,
      themeStyle: themeStyle,
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
      backgroundColor: WidgetStatePropertyAll<Color>(resolvedBackgroundColor),
      foregroundColor: WidgetStatePropertyAll<Color>(resolvedForegroundColor),
      side: WidgetStatePropertyAll<BorderSide>(resolvedBorderSide),
      shadowColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
    );

    final Widget child = _buildChild(resolvedForegroundColor);

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
    required ButtonStyle themeStyle,
    required bool showDisabledState,
  }) {
    // Step 1: explicit widget parameter
    final Color? explicit = backgroundColor;
    if (explicit != null) return explicit;

    // Step 2: Material component theme
    final Color? themedColor = themeStyle.backgroundColor?.resolve(
      showDisabledState ? _disabledState : _enabledState,
    );
    if (themedColor != null) return themedColor;

    // Step 3: AppThemeTokens / fallback
    switch (_variant) {
      case _SimpleButtonVariant.primary:
        return showDisabledState
            ? theme.disabledColor.withAlpha(31)
            : tokens.primary;
      case _SimpleButtonVariant.secondary:
        return showDisabledState
            ? theme.disabledColor.withAlpha(16)
            : JTints.surface(tokens.cardBackground, tokens.secondary, alpha: 18);
      case _SimpleButtonVariant.outline:
      case _SimpleButtonVariant.text:
        return Colors.transparent;
    }
  }

  Color _foregroundColor(
    ThemeData theme, {
    required AppThemeTokens tokens,
    required ButtonStyle themeStyle,
    required bool showDisabledState,
  }) {
    // Step 1: explicit widget parameter
    final Color? explicit = foregroundColor;
    if (explicit != null) return explicit;

    // Step 2: Material component theme
    final Color? themedColor = themeStyle.foregroundColor?.resolve(
      showDisabledState ? _disabledState : _enabledState,
    );
    if (themedColor != null) return themedColor;

    // Step 3: AppThemeTokens / fallback
    if (showDisabledState) return theme.disabledColor;

    switch (_variant) {
      case _SimpleButtonVariant.primary:
        return tokens.onPrimaryResolved(theme);
      case _SimpleButtonVariant.secondary:
        return tokens.secondary;
      case _SimpleButtonVariant.outline:
        return tokens.primary;
      case _SimpleButtonVariant.text:
        return tokens.primary;
    }
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

    // Step 1: explicit widget parameter
    final Color? explicitBorderColor = borderColor;
    if (explicitBorderColor != null) {
      return BorderSide(color: explicitBorderColor, width: resolvedWidth);
    }

    // Step 2: Material component theme
    if (themedSide != null) return themedSide;

    // Step 3: AppThemeTokens / fallback
    switch (_variant) {
      case _SimpleButtonVariant.secondary:
        return BorderSide(
          color: showDisabledState
              ? theme.disabledColor.withAlpha(64)
              : JTints.border(tokens.cardBackground, tokens.secondary, alpha: 56),
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
