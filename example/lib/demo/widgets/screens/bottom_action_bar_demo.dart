import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class BottomActionBarDemo extends StatefulWidget {
  const BottomActionBarDemo({super.key});

  String get title => 'Bottom Action Bar';

  @override
  State<BottomActionBarDemo> createState() => _BottomActionBarDemoState();
}

class _BottomActionBarDemoState extends State<BottomActionBarDemo> {
  bool _loading = false;

  void _simulateAction() {
    setState(() => _loading = true);
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          const SimpleText.label(text: 'Label + price + CTA (standard)'),
          JGaps.h8,
          const SimpleText.caption(
            text:
                'The canonical F&B / e-commerce layout. Label above price on the left, primary CTA on the right.',
          ),
          JGaps.h12,
          SimpleBottomActionBar(
            actionLabel: 'Add to Cart',
            onAction: _simulateAction,
            labelText: 'Total',
            priceText: 'RM 16.90',
            loading: _loading,
          ),

          JGaps.h32,
          const SimpleText.label(text: 'Price only (no label)'),
          JGaps.h8,
          const SimpleText.caption(
            text: 'When only priceText is set, the label row is omitted.',
          ),
          JGaps.h12,
          SimpleBottomActionBar(
            actionLabel: 'Checkout',
            onAction: () {},
            priceText: 'RM 42.00',
          ),

          JGaps.h32,
          const SimpleText.label(text: 'Button only (no left content)'),
          JGaps.h8,
          const SimpleText.caption(
            text:
                'When both labelText and priceText are null the button expands to full width.',
          ),
          JGaps.h12,
          SimpleBottomActionBar(
            actionLabel: 'Place Order',
            onAction: () {},
          ),

          JGaps.h32,
          const SimpleText.label(text: 'Disabled (onAction: null)'),
          JGaps.h8,
          const SimpleText.caption(
            text: 'Passing null to onAction disables the CTA.',
          ),
          JGaps.h12,
          const SimpleBottomActionBar(
            actionLabel: 'Confirm',
            onAction: null,
            labelText: '3 items',
            priceText: 'RM 28.50',
          ),

          JGaps.h32,
          const SimpleText.label(text: 'Tap "Add to Cart" above to test loading'),
          JGaps.h8,
          const SimpleText.caption(
            text:
                'The first example simulates a 2-second async action. The button shows a loading spinner and disables tap until the action resolves.',
          ),
          JGaps.h32,
        ],
      ),
    );
  }
}
