import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class StepIndicatorDemo extends StatefulWidget {
  const StepIndicatorDemo({super.key});

  String get title => 'Step Indicator';

  @override
  State<StepIndicatorDemo> createState() => _StepIndicatorDemoState();
}

class _StepIndicatorDemoState extends State<StepIndicatorDemo> {
  static const List<SimpleStepItem> _orderSteps = <SimpleStepItem>[
    SimpleStepItem(label: 'Placed', icon: Icons.check),
    SimpleStepItem(label: 'Preparing', icon: Icons.coffee_maker_outlined),
    SimpleStepItem(label: 'Ready', icon: Icons.local_cafe_outlined),
    SimpleStepItem(label: 'Picked Up', icon: Icons.check_circle_outline),
  ];

  static const List<SimpleStepItem> _checkoutSteps = <SimpleStepItem>[
    SimpleStepItem(label: 'Cart'),
    SimpleStepItem(label: 'Details'),
    SimpleStepItem(label: 'Payment'),
    SimpleStepItem(label: 'Confirm'),
  ];

  int _orderStep = 1;
  int _checkoutStep = 2;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleText.sectionLabel(text: 'ORDER TRACKING (with icons)'),
          JGaps.h8,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleStepIndicator(
                  steps: _orderSteps,
                  currentStep: _orderStep,
                ),
                JGaps.h16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SimpleButton.smallOutline(
                      label: '◀ Prev',
                      onPressed: _orderStep > 0
                          ? () => setState(() => _orderStep--)
                          : null,
                    ),
                    JGaps.w12,
                    SimpleButton.smallOutline(
                      label: 'Next ▶',
                      onPressed: _orderStep < _orderSteps.length - 1
                          ? () => setState(() => _orderStep++)
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
          JGaps.h16,
          SimpleText.sectionLabel(text: 'CHECKOUT (no icons)'),
          JGaps.h8,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleStepIndicator(
                  steps: _checkoutSteps,
                  currentStep: _checkoutStep,
                ),
                JGaps.h16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SimpleButton.smallOutline(
                      label: '◀ Prev',
                      onPressed: _checkoutStep > 0
                          ? () => setState(() => _checkoutStep--)
                          : null,
                    ),
                    JGaps.w12,
                    SimpleButton.smallOutline(
                      label: 'Next ▶',
                      onPressed: _checkoutStep < _checkoutSteps.length - 1
                          ? () => setState(() => _checkoutStep++)
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
