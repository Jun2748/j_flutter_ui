import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class CheckboxDemo extends StatefulWidget {
  const CheckboxDemo({super.key});

  String get title => 'Checkbox';

  @override
  State<CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<CheckboxDemo> {
  bool _newsletter = true;
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          Section(
            title: 'Labeled checkbox states',
            child: SimpleCard(
              child: Column(
                children: <Widget>[
                  SimpleCheckbox(
                    value: _newsletter,
                    label: 'Subscribe to product updates',
                    onChanged: (bool? value) {
                      setState(() {
                        _newsletter = value ?? false;
                      });
                    },
                  ),
                  Gap.h8,
                  SimpleCheckbox(
                    value: _termsAccepted,
                    label: 'I agree to the terms and conditions',
                    onChanged: (bool? value) {
                      setState(() {
                        _termsAccepted = value ?? false;
                      });
                    },
                  ),
                  Gap.h8,
                  const SimpleCheckbox(
                    value: true,
                    label: 'This checked option is disabled',
                    enabled: false,
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
                const SimpleText.label(text: 'Current values'),
                Gap.h8,
                SimpleText.body(
                  text:
                      'newsletter=$_newsletter, termsAccepted=$_termsAccepted',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
