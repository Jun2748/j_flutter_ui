import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class VerticalRailDemo extends StatefulWidget {
  const VerticalRailDemo({super.key});

  String get title => 'Vertical Rail';

  @override
  State<VerticalRailDemo> createState() => _VerticalRailDemoState();
}

class _VerticalRailDemoState extends State<VerticalRailDemo> {
  static const List<SimpleVerticalRailItem> _compactItems =
      <SimpleVerticalRailItem>[
    SimpleVerticalRailItem(icon: Icons.home_outlined, label: 'Home'),
    SimpleVerticalRailItem(icon: Icons.explore_outlined, label: 'Explore'),
    SimpleVerticalRailItem(icon: Icons.receipt_long_outlined, label: 'Orders'),
    SimpleVerticalRailItem(icon: Icons.person_outline_rounded, label: 'Me'),
  ];

  static const List<SimpleVerticalRailItem> _largeItems =
      <SimpleVerticalRailItem>[
    SimpleVerticalRailItem(
      icon: Icons.local_cafe_outlined,
      label: 'Milk Tea',
    ),
    SimpleVerticalRailItem(
      icon: Icons.shopping_bag_outlined,
      label: 'Bundles',
    ),
    SimpleVerticalRailItem(
      icon: Icons.local_florist_outlined,
      label: 'Seasonal',
    ),
    SimpleVerticalRailItem(
      icon: Icons.redeem_outlined,
      label: 'Merch',
    ),
  ];

  int _compactIndex = 0;
  int _largeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: SingleChildScrollView(
        padding: JInsets.screenPadding,
        child: VStack(
          gap: JDimens.dp24,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _RailSection(
              label: 'Compact — default (76dp, lg icons, label style)',
              child: SizedBox(
                height: 320,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      width: 76,
                      child: SimpleVerticalRail(
                        items: _compactItems,
                        selectedIndex: _compactIndex,
                        onSelected: (int i) =>
                            setState(() => _compactIndex = i),
                      ),
                    ),
                    Expanded(
                      child: _ContentArea(
                        label: _compactItems[_compactIndex].label,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _RailSection(
              label:
                  'Large variant — itemHeight: 104, xl icons, body1 label style',
              child: SizedBox(
                height: 420,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      child: SimpleVerticalRail(
                        items: _largeItems,
                        selectedIndex: _largeIndex,
                        onSelected: (int i) =>
                            setState(() => _largeIndex = i),
                        itemHeight: 104,
                        iconSize: JIconSizes.xl,
                        labelStyle: JTextStyles.body1,
                      ),
                    ),
                    Expanded(
                      child: _ContentArea(
                        label: _largeItems[_largeIndex].label,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RailSection extends StatelessWidget {
  const _RailSection({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;

    return VStack(
      gap: JDimens.dp8,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SimpleText.label(text: label, color: tokens.mutedText),
        ClipRRect(
          borderRadius: BorderRadius.circular(JDimens.dp12),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: tokens.cardBorderColor),
              borderRadius: BorderRadius.circular(JDimens.dp12),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}

class _ContentArea extends StatelessWidget {
  const _ContentArea({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: VStack(
        gap: JDimens.dp8,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SimpleText.label(text: 'Selected'),
          SimpleText.heading(text: label),
        ],
      ),
    );
  }
}
