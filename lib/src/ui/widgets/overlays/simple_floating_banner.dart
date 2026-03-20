import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';

const ValueKey<String> _barrierKey = ValueKey<String>(
  'simple_floating_banner_barrier',
);
const ValueKey<String> _surfaceKey = ValueKey<String>(
  'simple_floating_banner_surface',
);
const ValueKey<String> _closeButtonKey = ValueKey<String>(
  'simple_floating_banner_close_button',
);

Future<T?> showSimpleFloatingBanner<T>(
  BuildContext context, {
  Widget? media,
  Widget? child,
  bool showCloseButton = true,
  bool barrierDismissible = true,
  Color? barrierColor,
  Color? backgroundColor,
  BorderRadiusGeometry? borderRadius,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  double? maxWidth = SimpleFloatingBanner.defaultMaxWidth,
  double widthFactor = 0.9,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  VoidCallback? onClose,
}) {
  return showDialog<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    useSafeArea: false,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    routeSettings: routeSettings,
    builder: (BuildContext dialogContext) {
      return SimpleFloatingBanner(
        media: media,
        showCloseButton: showCloseButton,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        padding: padding,
        margin: margin,
        maxWidth: maxWidth,
        widthFactor: widthFactor,
        child: child,
        onClose: () {
          Navigator.of(dialogContext).pop();
          onClose?.call();
        },
      );
    },
  );
}

class SimpleFloatingBanner extends StatelessWidget {
  const SimpleFloatingBanner({
    super.key,
    this.media,
    this.child,
    this.onClose,
    this.showCloseButton = true,
    this.barrierDismissible = true,
    this.barrierColor,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.maxWidth = defaultMaxWidth,
    this.widthFactor = 0.9,
  }) : assert(
         media != null || child != null,
         'Provide at least one of media or child.',
       ),
       assert(widthFactor > 0 && widthFactor <= 1),
       assert(maxWidth == null || maxWidth > 0);

  static const double defaultMaxWidth = 420;

  final Widget? media;
  final Widget? child;
  final VoidCallback? onClose;
  final bool showCloseButton;
  final bool barrierDismissible;
  final Color? barrierColor;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? maxWidth;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final DialogThemeData dialogTheme = theme.dialogTheme;
    final BorderRadius resolvedBorderRadius = _resolvedBorderRadius(
      context,
      dialogTheme.shape,
    );
    final Color resolvedBackgroundColor =
        backgroundColor ?? dialogTheme.backgroundColor ?? tokens.cardBackground;
    final Color resolvedBorderColor =
        _dialogBorderColor(dialogTheme.shape) ?? tokens.cardBorderColor;
    final Color resolvedBarrierColor =
        barrierColor ??
        dialogTheme.barrierColor ??
        _fallbackBarrierColor(theme);

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: barrierDismissible ? onClose : null,
              child: ColoredBox(key: _barrierKey, color: resolvedBarrierColor),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: margin ?? JInsets.screenPadding,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: FractionallySizedBox(
                          widthFactor: widthFactor,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: maxWidth ?? double.infinity,
                            ),
                            child: _BannerSurface(
                              media: media,
                              showCloseButton: showCloseButton,
                              onClose: onClose,
                              padding: padding ?? JInsets.all16,
                              borderRadius: resolvedBorderRadius,
                              backgroundColor: resolvedBackgroundColor,
                              borderColor: resolvedBorderColor,
                              child: child,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius _resolvedBorderRadius(
    BuildContext context,
    ShapeBorder? themeShape,
  ) {
    final BorderRadiusGeometry? configuredRadius = borderRadius;
    if (configuredRadius != null) {
      return configuredRadius.resolve(Directionality.of(context));
    }

    if (themeShape is RoundedRectangleBorder) {
      return themeShape.borderRadius.resolve(Directionality.of(context));
    }

    if (themeShape is ContinuousRectangleBorder) {
      return themeShape.borderRadius.resolve(Directionality.of(context));
    }

    if (themeShape is StadiumBorder) {
      return BorderRadius.circular(JDimens.dp24);
    }

    return BorderRadius.circular(JDimens.dp24);
  }

  Color _fallbackBarrierColor(ThemeData theme) {
    final Color scrim = theme.colorScheme.scrim;
    if (scrim.alpha != 0) {
      return scrim.withAlpha(math.max(scrim.alpha, 166));
    }
    return Colors.black54;
  }

  Color? _dialogBorderColor(ShapeBorder? shape) {
    if (shape is OutlinedBorder && shape.side.style != BorderStyle.none) {
      return shape.side.color;
    }
    return null;
  }
}

class _BannerSurface extends StatelessWidget {
  const _BannerSurface({
    required this.media,
    required this.child,
    required this.showCloseButton,
    required this.onClose,
    required this.padding,
    required this.borderRadius,
    required this.backgroundColor,
    required this.borderColor,
  });

  final Widget? media;
  final Widget? child;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final ButtonStyle? iconButtonStyle = theme.iconButtonTheme.style;
    final Set<WidgetState> states = <WidgetState>{
      if (onClose == null) WidgetState.disabled,
    };
    final Color closeBackgroundColor =
        iconButtonStyle?.backgroundColor?.resolve(states) ??
        theme.colorScheme.surface.withAlpha(230);
    final Color closeForegroundColor =
        iconButtonStyle?.foregroundColor?.resolve(states) ??
        theme.colorScheme.onSurface;
    final BorderSide closeBorder =
        iconButtonStyle?.side?.resolve(states) ??
        BorderSide(color: tokens.cardBorderColor.withAlpha(204));

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Material(
          key: _surfaceKey,
          color: backgroundColor,
          surfaceTintColor: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(color: borderColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (media != null) media!,
              if (child != null) Padding(padding: padding, child: child!),
            ],
          ),
        ),
        if (showCloseButton)
          PositionedDirectional(
            top: -JDimens.dp12,
            end: -JDimens.dp12,
            child: IconButton(
              key: _closeButtonKey,
              tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
              onPressed: onClose,
              icon: const Icon(Icons.close),
              style: ButtonStyle(
                minimumSize: const WidgetStatePropertyAll<Size>(
                  Size.square(JDimens.dp40),
                ),
                padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                  EdgeInsets.all(JDimens.dp8),
                ),
                backgroundColor: WidgetStatePropertyAll<Color>(
                  closeBackgroundColor,
                ),
                foregroundColor: WidgetStatePropertyAll<Color>(
                  closeForegroundColor,
                ),
                side: WidgetStatePropertyAll<BorderSide>(closeBorder),
                shape: const WidgetStatePropertyAll<OutlinedBorder>(
                  CircleBorder(),
                ),
                elevation: const WidgetStatePropertyAll<double>(0),
              ),
            ),
          ),
      ],
    );
  }
}
