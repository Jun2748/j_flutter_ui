import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../../resources/styles.dart';

// Icon inside each dot is scaled to 60% of the dot diameter.
const double _kIconToDotRatio = 0.6;

/// A single step in [SimpleStepIndicator].
@immutable
class SimpleStepItem {
  const SimpleStepItem({required this.label, this.icon});

  /// Label shown beneath the step dot.
  final String label;

  /// Optional icon rendered inside completed and active step dots.
  final IconData? icon;
}

/// Horizontal step-progress track for order lifecycle or multi-step flows.
///
/// Renders a row of dots connected by lines, with labels beneath each dot.
/// Steps before [currentStep] are "completed", [currentStep] is "active",
/// and steps after are "incomplete".
///
/// Place inside a constrained-width container. The track stretches to fill
/// available horizontal space.
class SimpleStepIndicator extends StatelessWidget {
  const SimpleStepIndicator({
    super.key,
    required this.steps,
    required this.currentStep,
    this.completedColor,
    this.activeColor,
    this.incompleteColor,
    this.activeLabelColor,
    this.inactiveLabelColor,
    this.dotSize,
    this.connectorThickness,
  });

  /// Ordered list of step definitions.
  final List<SimpleStepItem> steps;

  /// Zero-based index of the currently active step.
  final int currentStep;

  /// Color for completed dots and their trailing connectors.
  /// Defaults to `tokens.primary`.
  final Color? completedColor;

  /// Color for the active step dot. Defaults to `tokens.primary`.
  final Color? activeColor;

  /// Color for incomplete dots and connectors. Defaults to `tokens.cardBorderColor`.
  final Color? incompleteColor;

  /// Label color for the active step. Defaults to `tokens.primary`.
  final Color? activeLabelColor;

  /// Label color for inactive steps. Defaults to `tokens.mutedText`.
  final Color? inactiveLabelColor;

  /// Diameter of each step dot. Defaults to `JDimens.dp12`.
  final double? dotSize;

  /// Thickness of the connector lines. Defaults to `JDimens.dp2`.
  final double? connectorThickness;

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) {
      return const SizedBox.shrink();
    }

    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;

    final Color resolvedCompleted = completedColor ?? tokens.primary;
    final Color resolvedActive = activeColor ?? tokens.primary;
    final Color resolvedIncomplete = incompleteColor ?? tokens.cardBorderColor;
    final Color resolvedActiveLabel = activeLabelColor ?? tokens.primary;
    final Color resolvedInactiveLabel = inactiveLabelColor ?? tokens.mutedText;
    final double resolvedDot = dotSize ?? JDimens.dp12;
    final double resolvedConnector = connectorThickness ?? JDimens.dp2;

    final int safeStep = currentStep.clamp(0, steps.length - 1);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < steps.length; i++) ...<Widget>[
          Expanded(
            child: _StepCell(
              item: steps[i],
              index: i,
              currentStep: safeStep,
              stepCount: steps.length,
              completedColor: resolvedCompleted,
              activeColor: resolvedActive,
              incompleteColor: resolvedIncomplete,
              activeLabelColor: resolvedActiveLabel,
              inactiveLabelColor: resolvedInactiveLabel,
              dotSize: resolvedDot,
              connectorThickness: resolvedConnector,
              onPrimary: tokens.onPrimaryResolved(theme),
            ),
          ),
        ],
      ],
    );
  }
}

class _StepCell extends StatelessWidget {
  const _StepCell({
    required this.item,
    required this.index,
    required this.currentStep,
    required this.stepCount,
    required this.completedColor,
    required this.activeColor,
    required this.incompleteColor,
    required this.activeLabelColor,
    required this.inactiveLabelColor,
    required this.dotSize,
    required this.connectorThickness,
    required this.onPrimary,
  });

  final SimpleStepItem item;
  final int index;
  final int currentStep;
  final int stepCount;
  final Color completedColor;
  final Color activeColor;
  final Color incompleteColor;
  final Color activeLabelColor;
  final Color inactiveLabelColor;
  final double dotSize;
  final double connectorThickness;
  final Color onPrimary;

  bool get _isCompleted => index < currentStep;
  bool get _isActive => index == currentStep;
  bool get _isLast => index == stepCount - 1;

  Color get _dotColor =>
      _isCompleted ? completedColor : (_isActive ? activeColor : incompleteColor);

  Color get _labelColor => _isActive ? activeLabelColor : inactiveLabelColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildTrack(),
        SizedBox(height: JDimens.dp6),
        _buildLabel(),
      ],
    );
  }

  Widget _buildTrack() {
    // Half-connector before the dot (all steps except the first)
    // Dot
    // Half-connector after the dot (all steps except the last)
    final bool showLeadingLine = index > 0;
    final bool showTrailingLine = !_isLast;

    // Leading line colour: completed if this step is completed or active.
    final Color leadingColor =
        (_isCompleted || _isActive) ? completedColor : incompleteColor;
    // Trailing line colour: completed only if this step is already completed.
    final Color trailingColor = _isCompleted ? completedColor : incompleteColor;

    return SizedBox(
      height: dotSize,
      child: Row(
        children: <Widget>[
          // Leading half-connector
          if (showLeadingLine)
            Expanded(
              child: SizedBox(
                height: connectorThickness,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: leadingColor),
                ),
              ),
            )
          else
            const Expanded(child: SizedBox.shrink()),

          // Dot
          _buildDot(),

          // Trailing half-connector
          if (showTrailingLine)
            Expanded(
              child: SizedBox(
                height: connectorThickness,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: trailingColor),
                ),
              ),
            )
          else
            const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildDot() {
    final IconData? icon = item.icon;
    final bool showIcon = icon != null && (_isCompleted || _isActive);
    final double iconSize =
        (dotSize * _kIconToDotRatio).clamp(JDimens.dp8, JDimens.dp20);

    return Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: _dotColor,
        shape: BoxShape.circle,
        // Outline ring on active dot for visual emphasis
        border: _isActive
            ? Border.all(color: activeColor, width: JDimens.dp2)
            : null,
      ),
      child: showIcon
          ? Center(
              child: Icon(icon, size: iconSize, color: onPrimary),
            )
          : null,
    );
  }

  Widget _buildLabel() {
    return Text(
      item.label,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: JTextStyles.label.copyWith(color: _labelColor),
    );
  }
}
