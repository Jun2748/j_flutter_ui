import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class SummaryRowDemo extends StatelessWidget {
  const SummaryRowDemo({super.key});

  String get title => 'Summary Row';

  @override
  Widget build(BuildContext context) {
    final AppThemeTokens tokens = Theme.of(context).appThemeTokens;

    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleText.sectionLabel(text: 'DEFAULT'),
          JGaps.h8,
          SimpleCard(
            child: Column(
              children: <Widget>[
                const SimpleSummaryRow(label: 'Subtotal', value: 'RM 28.80'),
                const SimpleDivider(),
                const SimpleSummaryRow(label: 'Delivery Fee', value: 'RM 3.00'),
                const SimpleDivider(),
                const SimpleSummaryRow(label: 'Tax (6%)', value: 'RM 1.73'),
                const SimpleDivider(),
                SimpleSummaryRow(
                  label: 'Total',
                  value: 'RM 33.53',
                  labelWeight: FontWeight.w700,
                  valueColor: tokens.primary,
                  valueWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          JGaps.h16,
          SimpleText.sectionLabel(text: 'CUSTOM COLORS'),
          JGaps.h8,
          SimpleCard(
            child: Column(
              children: <Widget>[
                SimpleSummaryRow(
                  label: 'Discount',
                  value: '-RM 2.00',
                  valueColor: Colors.green.shade700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
