import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

enum _Plan { starter, pro, enterprise }

class SelectionControlsDemo extends StatefulWidget {
  const SelectionControlsDemo({super.key});

  String get title => 'Selection Controls';

  @override
  State<SelectionControlsDemo> createState() => _SelectionControlsDemoState();
}

class _SelectionControlsDemoState extends State<SelectionControlsDemo> {
  bool _newsletter = true;
  bool _notifications = false;
  _Plan _selectedPlan = _Plan.pro;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          const SimpleText.heading(text: 'Checkbox'),
          Gap.h16,
          SimpleCheckbox(
            value: _newsletter,
            label: 'Subscribe to newsletter',
            onChanged: (bool? value) {
              setState(() {
                _newsletter = value ?? false;
              });
            },
          ),
          Gap.h24,
          const SimpleText.heading(text: 'Radio'),
          Gap.h16,
          SimpleRadio<_Plan>(
            value: _Plan.starter,
            groupValue: _selectedPlan,
            label: 'Starter',
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  _selectedPlan = value;
                }
              });
            },
          ),
          SimpleRadio<_Plan>(
            value: _Plan.pro,
            groupValue: _selectedPlan,
            label: 'Pro',
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  _selectedPlan = value;
                }
              });
            },
          ),
          SimpleRadio<_Plan>(
            value: _Plan.enterprise,
            groupValue: _selectedPlan,
            label: 'Enterprise',
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  _selectedPlan = value;
                }
              });
            },
          ),
          Gap.h24,
          const SimpleText.heading(text: 'Switch'),
          Gap.h16,
          SimpleSwitch(
            value: _notifications,
            label: 'Push notifications',
            description: 'Receive updates about new releases and activity.',
            onChanged: (bool value) {
              setState(() {
                _notifications = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
