import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class VoucherCardDemo extends StatelessWidget {
  const VoucherCardDemo({super.key});

  String get title => 'Voucher Card';

  @override
  Widget build(BuildContext context) {
    final AppThemeTokens tokens = Theme.of(context).appThemeTokens;

    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleText.sectionLabel(text: 'DEFAULT (dashed border)'),
          JGaps.h8,
          SimpleVoucherCard(
            borderColor: tokens.primary,
            child: Row(
              children: <Widget>[
                Container(
                  width: JDimens.dp48,
                  height: JDimens.dp48,
                  decoration: BoxDecoration(
                    color: tokens.primary.withAlpha(20),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.local_offer_outlined, color: tokens.primary),
                ),
                JGaps.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SimpleText.body(
                        text: 'BREW10',
                        weight: FontWeight.w700,
                        color: tokens.primary,
                        maxLines: 1,
                      ),
                      SimpleText.label(
                        text: '10% off your next order',
                        color: tokens.mutedText,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          JGaps.h16,
          SimpleText.sectionLabel(text: 'TAPPABLE'),
          JGaps.h8,
          SimpleVoucherCard(
            borderColor: tokens.primary,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Voucher tapped!')),
              );
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.redeem, color: tokens.primary, size: JIconSizes.md),
                JGaps.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SimpleText.body(
                        text: 'FREE DELIVERY',
                        weight: FontWeight.w700,
                        color: tokens.primary,
                        maxLines: 1,
                      ),
                      SimpleText.label(
                        text: 'Tap to apply',
                        color: tokens.mutedText,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: tokens.mutedText),
              ],
            ),
          ),
          JGaps.h16,
          SimpleText.sectionLabel(text: 'CUSTOM DASH'),
          JGaps.h8,
          SimpleVoucherCard(
            borderColor: tokens.primary,
            dashWidth: JDimens.dp4,
            dashGap: JDimens.dp4,
            borderWidth: JDimens.dp2,
            child: SimpleText.body(
              text: 'Dense dashes, thick border',
              color: tokens.primary,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
