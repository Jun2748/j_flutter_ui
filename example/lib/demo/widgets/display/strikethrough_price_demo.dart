import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class StrikethroughPriceDemo extends StatelessWidget {
  const StrikethroughPriceDemo({super.key});

  String get title => 'Strikethrough Price';

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
            child: const SimpleStrikethroughPrice(
              originalPrice: 'RM 17.90',
              currentPrice: 'RM 14.90',
            ),
          ),
          JGaps.h16,
          SimpleText.sectionLabel(text: 'CUSTOM COLORS'),
          JGaps.h8,
          SimpleCard(
            child: SimpleStrikethroughPrice(
              originalPrice: 'RM 38.90',
              currentPrice: 'RM 27.90',
              originalPriceColor: tokens.mutedText,
              currentPriceColor: Colors.green.shade700,
              currentPriceWeight: FontWeight.w800,
            ),
          ),
          JGaps.h16,
          SimpleText.sectionLabel(text: 'IN A PRODUCT CARD'),
          JGaps.h8,
          SimpleCard(
            child: Row(
              children: <Widget>[
                Container(
                  width: JDimens.dp64,
                  height: JDimens.dp64,
                  decoration: BoxDecoration(
                    color: tokens.cardBorderColor,
                    borderRadius: BorderRadius.circular(JDimens.dp8),
                  ),
                  child: Icon(Icons.coffee, color: tokens.primary),
                ),
                JGaps.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SimpleText.body(
                        text: 'Cold Brew',
                        weight: FontWeight.w700,
                        maxLines: 1,
                      ),
                      const SimpleStrikethroughPrice(
                        originalPrice: 'RM 17.90',
                        currentPrice: 'RM 14.90',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
