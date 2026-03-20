import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../feedback/simple_badge.dart';
import '../display/simple_divider.dart';
import '../typography/simple_text.dart';

enum SimpleMenuTileDisclosure { none, chevron }

enum SimpleMenuTileDividers { none, top, bottom, both }

class SimpleMenuTile extends StatelessWidget {
  const SimpleMenuTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.badge,
    this.badgeLabel,
    this.trailingText,
    this.trailingLabel,
    this.disclosure = SimpleMenuTileDisclosure.chevron,
    this.dividers = SimpleMenuTileDividers.bottom,
    this.enabled = true,
    this.padding,
    this.minHeight = JHeights.menuTile,
    this.onTap,
  });

  const SimpleMenuTile.chevron({
    Key? key,
    required String title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    SimpleMenuTileDividers dividers = SimpleMenuTileDividers.bottom,
    bool enabled = true,
    EdgeInsets? padding,
    double minHeight = JHeights.menuTile,
    VoidCallback? onTap,
  }) : this(
         key: key,
         title: title,
         subtitle: subtitle,
         leading: leading,
         trailing: trailing,
         disclosure: SimpleMenuTileDisclosure.chevron,
         dividers: dividers,
         enabled: enabled,
         padding: padding,
         minHeight: minHeight,
         onTap: onTap,
       );

  const SimpleMenuTile.badge({
    Key? key,
    required String title,
    required String badgeLabel,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    SimpleMenuTileDisclosure disclosure = SimpleMenuTileDisclosure.chevron,
    SimpleMenuTileDividers dividers = SimpleMenuTileDividers.bottom,
    bool enabled = true,
    EdgeInsets? padding,
    double minHeight = JHeights.menuTile,
    VoidCallback? onTap,
  }) : this(
         key: key,
         title: title,
         subtitle: subtitle,
         leading: leading,
         trailing: trailing,
         badgeLabel: badgeLabel,
         disclosure: disclosure,
         dividers: dividers,
         enabled: enabled,
         padding: padding,
         minHeight: minHeight,
         onTap: onTap,
       );

  const SimpleMenuTile.trailingText({
    Key? key,
    required String title,
    required String trailingText,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    SimpleMenuTileDisclosure disclosure = SimpleMenuTileDisclosure.chevron,
    SimpleMenuTileDividers dividers = SimpleMenuTileDividers.bottom,
    bool enabled = true,
    EdgeInsets? padding,
    double minHeight = JHeights.menuTile,
    VoidCallback? onTap,
  }) : this(
         key: key,
         title: title,
         subtitle: subtitle,
         leading: leading,
         trailing: trailing,
         trailingText: trailingText,
         disclosure: disclosure,
         dividers: dividers,
         enabled: enabled,
         padding: padding,
         minHeight: minHeight,
         onTap: onTap,
       );

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? badge;
  final String? badgeLabel;
  final String? trailingText;
  final String? trailingLabel;
  final SimpleMenuTileDisclosure disclosure;
  final SimpleMenuTileDividers dividers;
  final bool enabled;
  final EdgeInsets? padding;
  final double minHeight;
  final VoidCallback? onTap;

  SimpleMenuTile copyWith({
    Key? key,
    String? title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    Widget? badge,
    String? badgeLabel,
    String? trailingText,
    String? trailingLabel,
    SimpleMenuTileDisclosure? disclosure,
    SimpleMenuTileDividers? dividers,
    bool? enabled,
    EdgeInsets? padding,
    double? minHeight,
    VoidCallback? onTap,
  }) {
    return SimpleMenuTile(
      key: key ?? this.key,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      leading: leading ?? this.leading,
      trailing: trailing ?? this.trailing,
      badge: badge ?? this.badge,
      badgeLabel: badgeLabel ?? this.badgeLabel,
      trailingText: trailingText ?? this.trailingText,
      trailingLabel: trailingLabel ?? this.trailingLabel,
      disclosure: disclosure ?? this.disclosure,
      dividers: dividers ?? this.dividers,
      enabled: enabled ?? this.enabled,
      padding: padding ?? this.padding,
      minHeight: minHeight ?? this.minHeight,
      onTap: onTap ?? this.onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets resolvedPadding =
        padding ?? JInsets.horizontal16Vertical14;
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final Color dividerColor = tokens.dividerColor;
    final Color mutedTextColor = tokens.mutedText;
    final bool showsTopDivider =
        dividers == SimpleMenuTileDividers.top ||
        dividers == SimpleMenuTileDividers.both;
    final bool showsBottomDivider =
        dividers == SimpleMenuTileDividers.bottom ||
        dividers == SimpleMenuTileDividers.both;

    final Widget tile = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: Container(
          constraints: BoxConstraints(minHeight: minHeight),
          padding: resolvedPadding,
          child: Opacity(
            opacity: enabled ? 1 : 0.56,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (leading != null) ...<Widget>[
                  IconTheme(
                    data: theme.iconTheme.copyWith(
                      color: theme.colorScheme.onSurface,
                      size: JIconSizes.md,
                    ),
                    child: leading!,
                  ),
                  JGaps.w16,
                ],
                Expanded(child: _buildContent(context, mutedTextColor)),
                if (_hasTrailingContent) ...<Widget>[
                  JGaps.w16,
                  _buildTrailing(mutedTextColor),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (showsTopDivider)
          _MenuTileDivider(
            horizontalInset: resolvedPadding.horizontal / 2,
            color: dividerColor,
          ),
        tile,
        if (showsBottomDivider)
          _MenuTileDivider(
            horizontalInset: resolvedPadding.horizontal / 2,
            color: dividerColor,
          ),
      ],
    );
  }

  bool get _hasSubtitle => subtitle != null && subtitle!.trim().isNotEmpty;

  bool get _hasTrailingText {
    final String? resolvedTrailingText = trailingText ?? trailingLabel;
    return resolvedTrailingText != null &&
        resolvedTrailingText.trim().isNotEmpty;
  }

  bool get _hasTrailingContent =>
      trailing != null ||
      _hasTrailingText ||
      disclosure == SimpleMenuTileDisclosure.chevron;

  Widget _buildContent(BuildContext context, Color mutedTextColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: SimpleText.body(
                text: title,
                weight: FontWeight.w600,
                maxLines: 2,
              ),
            ),
            if (_resolvedBadge != null) ...<Widget>[JGaps.w8, _resolvedBadge!],
          ],
        ),
        if (_hasSubtitle) ...<Widget>[
          JGaps.h8,
          SimpleText.caption(
            text: subtitle!,
            color: mutedTextColor,
            maxLines: 3,
          ),
        ],
      ],
    );
  }

  Widget? get _resolvedBadge {
    if (badge != null) {
      return badge;
    }

    if (badgeLabel != null && badgeLabel!.trim().isNotEmpty) {
      return SimpleBadge.warning(label: badgeLabel!.trim());
    }

    return null;
  }

  Widget _buildTrailing(Color mutedTextColor) {
    final List<Widget> children = <Widget>[];
    final String? resolvedTrailingText = trailingText ?? trailingLabel;

    if (_hasTrailingText) {
      children.add(
        Flexible(
          child: SimpleText.caption(
            text: resolvedTrailingText!,
            color: mutedTextColor,
            align: TextAlign.right,
            maxLines: 2,
          ),
        ),
      );
    }

    if (trailing != null) {
      if (children.isNotEmpty) {
        children.add(JGaps.w8);
      }
      children.add(trailing!);
    } else if (disclosure == SimpleMenuTileDisclosure.chevron) {
      if (children.isNotEmpty) {
        children.add(JGaps.w8);
      }
      children.add(
        Icon(Icons.chevron_right, size: JIconSizes.lg, color: mutedTextColor),
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: JDimens.dp24),
      child: Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}

class _MenuTileDivider extends StatelessWidget {
  const _MenuTileDivider({required this.horizontalInset, required this.color});

  final double horizontalInset;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SimpleDivider(
      color: color,
      height: JDimens.dp1,
      thickness: JDimens.dp1,
      indent: horizontalInset,
      endIndent: horizontalInset,
    );
  }
}
