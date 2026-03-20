import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class GapDemo extends StatelessWidget {
  const GapDemo({super.key});

  String get title => 'JGaps & JInsets';

  static const List<_InsetExample> _startExamples = <_InsetExample>[
    _InsetExample(label: 'onlyStart8', inset: JInsets.onlyStart8),
    _InsetExample(label: 'onlyStart12', inset: JInsets.onlyStart12),
    _InsetExample(label: 'onlyStart16', inset: JInsets.onlyStart16),
    _InsetExample(label: 'onlyStart20', inset: JInsets.onlyStart20),
    _InsetExample(label: 'onlyStart24', inset: JInsets.onlyStart24),
  ];

  static const List<_InsetExample> _endExamples = <_InsetExample>[
    _InsetExample(label: 'onlyEnd8', inset: JInsets.onlyEnd8),
    _InsetExample(label: 'onlyEnd12', inset: JInsets.onlyEnd12),
    _InsetExample(label: 'onlyEnd16', inset: JInsets.onlyEnd16),
    _InsetExample(label: 'onlyEnd20', inset: JInsets.onlyEnd20),
    _InsetExample(label: 'onlyEnd24', inset: JInsets.onlyEnd24),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primary = theme.colorScheme.primary;
    final Color surface = theme.colorScheme.surface;

    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: JInsets.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Section(
                  title: 'JGaps — vertical',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SimpleText.body(text: 'Above JGaps.h8'),
                      JGaps.h8,
                      const SimpleText.caption(text: 'After JGaps.h8'),
                      JGaps.h16,
                      const SimpleText.body(text: 'Above JGaps.h16'),
                      JGaps.h16,
                      const SimpleText.caption(text: 'After JGaps.h16'),
                      JGaps.h24,
                      const SimpleText.body(text: 'Above JGaps.h24'),
                      JGaps.h24,
                      const SimpleText.caption(text: 'After JGaps.h24'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          JGaps.h24,
          Padding(
            padding: JInsets.horizontal16,
            child: Section(
              title: 'JInsets — directional (RTL-safe)',
              child: const SimpleText.caption(
                text:
                    'onlyStart and onlyEnd use EdgeInsetsDirectional so leading/trailing padding flips correctly under RTL. Scroll the rows to see the inset applied to the first or last chip.',
                maxLines: 4,
              ),
            ),
          ),
          JGaps.h12,
          _InsetScrollRow(
            sectionLabel: 'onlyStart — leading edge only',
            examples: _startExamples,
            applyToFirst: true,
            chipColor: primary,
            onChipColor: surface,
          ),
          JGaps.h16,
          _InsetScrollRow(
            sectionLabel: 'onlyEnd — trailing edge only',
            examples: _endExamples,
            applyToFirst: false,
            chipColor: primary,
            onChipColor: surface,
          ),
          JGaps.h24,
        ],
      ),
    );
  }
}

class _InsetScrollRow extends StatelessWidget {
  const _InsetScrollRow({
    required this.sectionLabel,
    required this.examples,
    required this.applyToFirst,
    required this.chipColor,
    required this.onChipColor,
  });

  final String sectionLabel;
  final List<_InsetExample> examples;

  /// If true, the inset is applied to the first chip (onlyStart).
  /// If false, it is applied to the last chip (onlyEnd).
  final bool applyToFirst;
  final Color chipColor;
  final Color onChipColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: JInsets.horizontal16,
          child: SimpleText.caption(text: sectionLabel),
        ),
        JGaps.h8,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < examples.length; i++)
                Padding(
                  padding: _paddingFor(i),
                  child: _Chip(
                    label: examples[i].label,
                    color: chipColor,
                    onColor: onChipColor,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  EdgeInsetsGeometry _paddingFor(int index) {
    final bool isTarget =
        applyToFirst ? index == 0 : index == examples.length - 1;
    return isTarget
        ? examples[index].inset
        : const EdgeInsets.only(right: JDimens.dp8);
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.color,
    required this.onColor,
  });

  final String label;
  final Color color;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: JInsets.horizontal12Vertical8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(JDimens.dp20),
      ),
      child: Text(
        label,
        style: JTextStyles.label.copyWith(color: onColor),
      ),
    );
  }
}

class _InsetExample {
  const _InsetExample({required this.label, required this.inset});

  final String label;
  final EdgeInsetsDirectional inset;
}
