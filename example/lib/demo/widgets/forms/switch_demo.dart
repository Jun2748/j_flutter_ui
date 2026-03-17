import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class SwitchDemo extends StatefulWidget {
  const SwitchDemo({super.key});

  String get title => 'Switch';

  @override
  State<SwitchDemo> createState() => _SwitchDemoState();
}

class _SwitchDemoState extends State<SwitchDemo> {
  bool _notifications = true;
  bool _marketing = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          Section(
            title: 'Labeled switch usage',
            child: SimpleCard(
              child: Column(
                children: <Widget>[
                  SimpleSwitch(
                    value: _notifications,
                    label: 'Push notifications',
                    description:
                        'Receive booking updates and account activity alerts.',
                    onChanged: (bool value) {
                      setState(() {
                        _notifications = value;
                      });
                    },
                  ),
                  JGaps.h16,
                  SimpleSwitch(
                    value: _marketing,
                    label: 'Marketing emails',
                    description:
                        'Get occasional product updates and promotional offers.',
                    onChanged: (bool value) {
                      setState(() {
                        _marketing = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          JGaps.h16,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SimpleText.label(text: 'Current values'),
                JGaps.h8,
                SimpleText.body(
                  text: 'notifications=$_notifications, marketing=$_marketing',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
