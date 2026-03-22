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
          SimpleText.sectionLabel(text: 'DEFAULT (HORIZONTAL)'),
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
          SimpleText.sectionLabel(text: 'IN A HORIZONTAL PRODUCT CARD'),
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
          JGaps.h16,
          SimpleText.sectionLabel(text: 'STACKED (VERTICAL PRODUCT CARD)'),
          JGaps.h8,
          SimpleGrid(
            columnCount: 2,
            columnGap: JDimens.dp12,
            rowGap: JDimens.dp12,
            children: <Widget>[
              SimpleCard(
                margin: EdgeInsets.zero,
                padding: JInsets.all12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: JDimens.dp100,
                      decoration: BoxDecoration(
                        color: tokens.cardBorderColor,
                        borderRadius: BorderRadius.circular(JDimens.dp8),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.local_cafe,
                          size: JIconSizes.xl,
                          color: tokens.primary,
                        ),
                      ),
                    ),
                    JGaps.h8,
                    const SimpleText.body(
                      text: 'Iced Latte',
                      weight: FontWeight.w700,
                      maxLines: 1,
                    ),
                    JGaps.h4,
                    const SimpleStrikethroughPrice.stacked(
                      originalPrice: 'RM 15.90',
                      currentPrice: 'RM 12.90',
                    ),
                  ],
                ),
              ),
              SimpleCard(
                margin: EdgeInsets.zero,
                padding: JInsets.all12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: JDimens.dp100,
                      decoration: BoxDecoration(
                        color: tokens.cardBorderColor,
                        borderRadius: BorderRadius.circular(JDimens.dp8),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.coffee,
                          size: JIconSizes.xl,
                          color: tokens.primary,
                        ),
                      ),
                    ),
                    JGaps.h8,
                    const SimpleText.body(
                      text: 'Cold Brew',
                      weight: FontWeight.w700,
                      maxLines: 1,
                    ),
                    JGaps.h4,
                    SimpleStrikethroughPrice.stacked(
                      originalPrice: 'RM 17.90',
                      currentPrice: 'RM 14.90',
                      currentPriceColor: Colors.green.shade700,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
