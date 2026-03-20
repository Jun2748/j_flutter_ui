import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class TextDemo extends StatelessWidget {
  const TextDemo({super.key});

  static const List<_PriceLine> _menuPrices = <_PriceLine>[
    _PriceLine(name: 'Americano', price: 'RM  4.50'),
    _PriceLine(name: 'Cold brew', price: 'RM 12.90'),
    _PriceLine(name: 'Signature blend', price: 'RM 11.00'),
    _PriceLine(name: 'Latte', price: 'RM  7.50'),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    String tr(String key) => Intl.text(key, context: context);
    final Color primary = theme.colorScheme.primary;
    final Color onSurface = theme.colorScheme.onSurface;
    final Color success =
        theme.extension<JStatusColors>()?.success ?? theme.colorScheme.tertiary;
    final Color error = theme.colorScheme.error;

    return AppScaffold(
      appBar: AppBarEx(title: tr(L.demoTextTitle)),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          Section(
            title: tr(L.demoTextScaleTitle),
            child: VStack(
              gap: JDimens.dp16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleText.title(text: tr(L.demoTextTitleSample)),
                SimpleText.heading(text: tr(L.demoTextHeadingSample)),
                SimpleText.body(text: tr(L.demoTextBodySample)),
                SimpleText.caption(text: tr(L.demoTextCaptionSample)),
                SimpleText.label(text: tr(L.demoTextLabelSample)),
              ],
            ),
          ),
          JGaps.h24,
          Section(
            title: tr(L.demoTextColorsTitle),
            child: VStack(
              gap: JDimens.dp12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleText.body(
                  text: tr(L.demoTextPrimaryLabel),
                  color: primary,
                ),
                SimpleText.body(
                  text: tr(L.demoTextSuccessLabel),
                  color: success,
                ),
                SimpleText.body(text: tr(L.demoTextErrorLabel), color: error),
              ],
            ),
          ),
          JGaps.h24,
          Section(
            title: tr(L.demoTextPriceTitle),
            child: VStack(
              gap: JDimens.dp16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _StyleRow(
                  label: 'JTextStyles.priceLarge',
                  price: 'RM 1,299.00',
                  style: JTextStyles.priceLarge,
                  color: onSurface,
                ),
                _StyleRow(
                  label: 'JTextStyles.price',
                  price: 'RM 24.90',
                  style: JTextStyles.price,
                  color: onSurface,
                ),
                const SimpleDivider(),
                SimpleText.caption(
                  text: tr(L.demoTextPriceAlignmentCaption),
                ),
                JGaps.h4,
                ..._menuPrices.map(
                  (_PriceLine line) => _PriceRow(
                    name: line.name,
                    price: line.price,
                    color: onSurface,
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

class _StyleRow extends StatelessWidget {
  const _StyleRow({
    required this.label,
    required this.price,
    required this.style,
    required this.color,
  });

  final String label;
  final String price;
  final TextStyle style;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Expanded(
          child: SimpleText.caption(text: label),
        ),
        Text(price, style: style.copyWith(color: color)),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.name,
    required this.price,
    required this.color,
  });

  final String name;
  final String price;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SimpleText.body(text: name),
        ),
        Text(price, style: JTextStyles.price.copyWith(color: color)),
      ],
    );
  }
}

class _PriceLine {
  const _PriceLine({required this.name, required this.price});

  final String name;
  final String price;
}
