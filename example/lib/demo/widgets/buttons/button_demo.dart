import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    String tr(String key) => Intl.text(key, context: context);

    return AppScaffold(
      appBar: AppBarEx(title: tr(L.demoButtonTitle)),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          Section(
            title: tr(L.demoButtonVariantsTitle),
            child: VStack(
              gap: JDimens.dp16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SimpleButton.primary(
                  label: tr(L.demoButtonPrimaryLabel),
                  icon: Icons.check_circle_outline,
                  onPressed: () {},
                ),
                SimpleButton.secondary(
                  label: tr(L.demoButtonSecondaryLabel),
                  onPressed: () {},
                ),
                SimpleButton.outline(
                  label: tr(L.demoButtonOutlineLabel),
                  onPressed: () {},
                ),
                SimpleButton.text(
                  label: tr(L.demoButtonTextLabel),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          JGaps.h24,
          Section(
            title: tr(L.demoButtonStatesTitle),
            child: VStack(
              gap: JDimens.dp12,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                HStack(
                  gap: JDimens.dp12,
                  children: <Widget>[
                    Expanded(
                      child: SimpleButton.primary(
                        label: tr(L.demoButtonLoadingPrimary),
                        loading: true,
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: SimpleButton.outline(
                        label: tr(L.demoButtonLoadingOutline),
                        loading: true,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SimpleButton.secondary(
                  label: tr(L.demoButtonDisabledLabel),
                  onPressed: null,
                ),
              ],
            ),
          ),
          JGaps.h24,
          Section(
            title: 'Compact icon actions',
            child: Wrap(
              spacing: JDimens.dp12,
              runSpacing: JDimens.dp12,
              children: <Widget>[
                SimpleIconButton.filled(
                  icon: Icons.add,
                  tooltip: 'Add item',
                  onPressed: () {},
                ),
                SimpleIconButton.outline(
                  icon: Icons.remove,
                  tooltip: 'Remove item',
                  onPressed: () {},
                ),
                SimpleIconButton.filled(
                  icon: Icons.shopping_cart_outlined,
                  tooltip: 'Add to cart',
                  onPressed: () {},
                ),
                const SimpleIconButton.outline(
                  icon: Icons.favorite_border,
                  tooltip: 'Disabled quick action',
                  onPressed: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
