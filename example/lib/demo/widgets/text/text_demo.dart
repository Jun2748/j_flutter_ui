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
                SimpleText.caption(text: tr(L.demoTextPriceAlignmentCaption)),
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
          JGaps.h24,
          Section(
            title: 'SimpleText semantic variants',
            child: VStack(
              gap: JDimens.dp16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SimpleText.sectionLabel(text: 'FEATURED OFFER'),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: SimpleText.body(text: 'Seasonal blend'),
                    ),
                    SimpleText.priceLarge(text: 'RM 18.90', color: onSurface),
                  ],
                ),
                const SimpleText.counter(text: '12'),
                const SimpleText.body(
                  text: 'Custom size override',
                  fontSize: JFontSizes.fs18,
                ),
              ],
            ),
          ),
          JGaps.h24,
          Section(
            title: 'F&B ordering flow typography',
            child: VStack(
              gap: JDimens.dp16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _VariantPreviewRow(
                  label: 'Section label',
                  child: const SimpleText.sectionLabel(text: 'CUSTOMIZE'),
                ),
                _VariantPreviewRow(
                  label: 'Heading',
                  child: SimpleText.heading(
                    text: 'Brown Sugar Boba Milk',
                    color: onSurface,
                  ),
                ),
                _VariantPreviewRow(
                  label: 'Hero price',
                  child: SimpleText.priceLarge(
                    text: 'RM 18.90',
                    color: onSurface,
                  ),
                ),
                _VariantPreviewRow(
                  label: 'Counter',
                  child: const SizedBox(
                    width: JDimens.dp40,
                    child: SimpleText.counter(text: '12'),
                  ),
                ),
                const SimpleCard(
                  child: _OrderingFlowPreview(),
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
        Expanded(child: SimpleText.caption(text: label)),
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
        Expanded(child: SimpleText.body(text: name)),
        Text(price, style: JTextStyles.price.copyWith(color: color)),
      ],
    );
  }
}

class _VariantPreviewRow extends StatelessWidget {
  const _VariantPreviewRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(child: SimpleText.caption(text: label)),
        JGaps.w16,
        Flexible(child: Align(alignment: Alignment.centerRight, child: child)),
      ],
    );
  }
}

class _OrderingFlowPreview extends StatelessWidget {
  const _OrderingFlowPreview();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return VStack(
      gap: JDimens.dp12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SimpleText.sectionLabel(text: 'TOP PICK'),
        SimpleText.heading(
          text: 'Iced Sea Salt Latte',
          color: theme.colorScheme.onSurface,
        ),
        const SimpleText.body(
          text:
              'Smooth milk tea with a lightly salted cream cap for a layered sip.',
          maxLines: 3,
        ),
        Row(
          children: <Widget>[
            SimpleText.priceLarge(text: 'RM 18.90', color: theme.colorScheme.onSurface),
            JGaps.w8,
            const SimpleText.caption(text: 'Hero price'),
          ],
        ),
        const SimpleDivider(),
        Row(
          children: <Widget>[
            const Expanded(child: SimpleText.label(text: 'Qty in stepper')),
            const SizedBox(
              width: JDimens.dp40,
              child: SimpleText.counter(text: '12'),
            ),
          ],
        ),
        const SimpleText.label(text: 'Less sugar • Warm • Pearl topping'),
      ],
    );
  }
}

class _PriceLine {
  const _PriceLine({required this.name, required this.price});

  final String name;
  final String price;
}
