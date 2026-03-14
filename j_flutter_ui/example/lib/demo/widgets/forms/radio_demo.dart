import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

enum _Plan { starter, pro, enterprise }

class RadioDemo extends StatefulWidget {
  const RadioDemo({super.key});

  String get title => 'Radio';

  @override
  State<RadioDemo> createState() => _RadioDemoState();
}

class _RadioDemoState extends State<RadioDemo> {
  _Plan _selectedPlan = _Plan.pro;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          Section(
            title: 'Working radio group',
            child: SimpleCard(
              child: Column(
                children: <Widget>[
                  SimpleRadio<_Plan>(
                    value: _Plan.starter,
                    groupValue: _selectedPlan,
                    label: 'Starter',
                    onChanged: _onPlanChanged,
                  ),
                  SimpleRadio<_Plan>(
                    value: _Plan.pro,
                    groupValue: _selectedPlan,
                    label: 'Pro',
                    onChanged: _onPlanChanged,
                  ),
                  SimpleRadio<_Plan>(
                    value: _Plan.enterprise,
                    groupValue: _selectedPlan,
                    label: 'Enterprise',
                    onChanged: _onPlanChanged,
                  ),
                ],
              ),
            ),
          ),
          Gap.h16,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SimpleText.label(text: 'Current selection'),
                Gap.h8,
                SimpleText.heading(text: _selectedPlan.name),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPlanChanged(_Plan? value) {
    if (value == null) {
      return;
    }

    setState(() {
      _selectedPlan = value;
    });
  }
}
