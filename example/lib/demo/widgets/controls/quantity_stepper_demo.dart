import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class QuantityStepperDemo extends StatefulWidget {
  const QuantityStepperDemo({super.key});

  String get title => 'Quantity Stepper';

  @override
  State<QuantityStepperDemo> createState() => _QuantityStepperDemoState();
}

class _QuantityStepperDemoState extends State<QuantityStepperDemo> {
  int _value = 1;
  int _bounded = 3;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleText.sectionLabel(text: 'DEFAULT'),
          JGaps.h8,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleQuantityStepper(
                  value: _value,
                  onChanged: (int v) => setState(() => _value = v),
                ),
                JGaps.h12,
                SimpleText.label(text: 'Value: $_value'),
              ],
            ),
          ),
          JGaps.h16,
          SimpleText.sectionLabel(text: 'WITH MIN / MAX (1–5)'),
          JGaps.h8,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleQuantityStepper(
                  value: _bounded,
                  minValue: 1,
                  maxValue: 5,
                  onChanged: (int v) => setState(() => _bounded = v),
                ),
                JGaps.h12,
                SimpleText.label(text: 'Value: $_bounded'),
              ],
            ),
          ),
          JGaps.h16,
          SimpleText.sectionLabel(text: 'READ-ONLY (no onChanged)'),
          JGaps.h8,
          SimpleCard(
            child: SimpleQuantityStepper(value: 2),
          ),
        ],
      ),
    );
  }
}
