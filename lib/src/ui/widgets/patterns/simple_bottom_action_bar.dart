import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../controls/buttons/simple_button.dart';
import '../typography/simple_text.dart';

class SimpleBottomActionBar extends StatelessWidget {
  const SimpleBottomActionBar({
    super.key,
    required this.actionLabel,
    required this.onAction,
    this.priceText,
    this.labelText,
    this.loading = false,
    this.backgroundColor,
    this.shadowColor,
    this.padding,
  });

  /// Primary CTA button label (required)
  final String actionLabel;

  /// Called when CTA is tapped. Pass null to disable the button.
  final VoidCallback? onAction;

  /// Optional price string shown on the left (e.g. 'RM 16.90')
  final String? priceText;

  /// Optional supporting label above price (e.g. 'Total', '2 items')
  final String? labelText;

  /// Shows loading state on the CTA button
  final bool loading;

  /// Override bar background color. Defaults to theme card surface.
  final Color? backgroundColor;

  /// Override shadow color. Defaults to Colors.black12.
  final Color? shadowColor;

  /// Override bar padding. Defaults to JInsets.horizontal16Vertical12.
  final EdgeInsetsGeometry? padding;

  bool get _hasLeftContent => priceText != null || labelText != null;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;

    final Color resolvedBackground =
        backgroundColor ??
        tokens
            .cardBackground; // last-resort white comes from cardBackground default
    final Color resolvedShadowColor =
        shadowColor ?? Colors.black12; // structurally harmless constant
    final EdgeInsetsGeometry resolvedPadding =
        padding ?? JInsets.horizontal16Vertical12;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: resolvedBackground,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: resolvedShadowColor,
            blurRadius: JDimens.dp8,
            offset: const Offset(0, -JDimens.dp1),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: resolvedPadding,
          child: Row(
            children: _hasLeftContent
                ? <Widget>[
                    _buildLeftSide(tokens),
                    JGaps.w32,
                    Expanded(child: _buildButton()),
                  ]
                : <Widget>[Expanded(child: _buildButton())],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftSide(AppThemeTokens tokens) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (labelText != null)
          SimpleText.label(
            text: labelText,
            color: tokens.mutedText,
            maxLines: 1,
          ),
        if (priceText != null)
          SimpleText.heading(
            text: priceText,
            color: tokens.primary,
            maxLines: 1,
          ),
      ],
    );
  }

  Widget _buildButton() {
    return SimpleButton.primary(
      label: actionLabel,
      onPressed: onAction,
      loading: loading,
    );
  }
}
