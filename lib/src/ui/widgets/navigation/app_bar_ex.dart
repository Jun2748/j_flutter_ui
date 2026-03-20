import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';

class AppBarEx extends StatelessWidget implements PreferredSizeWidget {
  const AppBarEx({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.trailing,
    this.centerTitle = false,
    this.backgroundColor,
    this.elevation = 0,
    this.height = JHeights.appBar,
    this.padding,
    this.bottomBorder,
    this.primary = true,
    this.automaticallyImplyLeading = true,
  });

  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? trailing;
  final bool centerTitle;
  final Color? backgroundColor;
  final double elevation;
  final double height;
  final EdgeInsetsGeometry? padding;
  final BorderSide? bottomBorder;
  final bool primary;
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final Widget? resolvedLeading = _buildLeading(context);
    final Widget? resolvedTrailing = _buildTrailing();
    final EdgeInsetsGeometry resolvedPadding =
        padding ??
        (resolvedLeading == null && resolvedTrailing == null
            ? JInsets.horizontal16
            : const EdgeInsets.symmetric(horizontal: JDimens.dp4));
    final Widget? resolvedTitle =
        titleWidget ??
        (title != null
            ? Text(title!, maxLines: 1, overflow: TextOverflow.ellipsis)
            : null);
    final Color? resolvedBackgroundColor =
        backgroundColor ?? theme.appBarTheme.backgroundColor;
    final Color fallbackForegroundColor = resolvedBackgroundColor == null
        ? tokens.onCardResolved(theme)
        : theme.colorScheme.onSurface;
    final Color? themeForegroundColor = theme.appBarTheme.foregroundColor;
    final TextStyle baseTitleStyle =
        theme.appBarTheme.titleTextStyle ??
        theme.textTheme.titleLarge ??
        const TextStyle();
    final TextStyle resolvedTitleStyle = baseTitleStyle.color != null
        ? baseTitleStyle
        : baseTitleStyle.copyWith(
            color: themeForegroundColor ?? fallbackForegroundColor,
          );
    final IconThemeData baseIconTheme =
        theme.appBarTheme.iconTheme ?? theme.iconTheme;
    final IconThemeData resolvedIconTheme = baseIconTheme.color != null
        ? baseIconTheme
        : baseIconTheme.copyWith(
            color: themeForegroundColor ?? fallbackForegroundColor,
          );
    final Widget toolbar = SizedBox(
      height: height,
      child: Padding(
        padding: resolvedPadding,
        child: NavigationToolbar(
          leading: resolvedLeading,
          middle: resolvedTitle,
          trailing: resolvedTrailing,
          centerMiddle: centerTitle,
          middleSpacing: JDimens.dp12,
        ),
      ),
    );

    return Material(
      color: resolvedBackgroundColor ?? tokens.cardBackground,
      elevation: elevation,
      surfaceTintColor: Colors.transparent,
      shadowColor: elevation == 0 ? Colors.transparent : null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom:
                bottomBorder ??
                BorderSide(color: tokens.dividerColor, width: JDimens.dp1),
          ),
        ),
        child: SafeArea(
          top: primary,
          bottom: false,
          child: IconTheme(
            data: resolvedIconTheme,
            child: DefaultTextStyle(
              style: resolvedTitleStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: toolbar,
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) {
      return leading;
    }

    if (!automaticallyImplyLeading) {
      return null;
    }

    final ModalRoute<dynamic>? route = ModalRoute.of(context);
    final bool canPop =
        Navigator.canPop(context) || (route?.impliesAppBarDismissal ?? false);

    if (!canPop) {
      return null;
    }

    return const BackButton();
  }

  Widget? _buildTrailing() {
    final bool hasActions = actions != null && actions!.isNotEmpty;

    if (trailing == null && !hasActions) {
      return null;
    }

    if (!hasActions) {
      return trailing;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (trailing case final Widget trailingWidget) trailingWidget,
        ...actions!,
      ],
    );
  }
}
