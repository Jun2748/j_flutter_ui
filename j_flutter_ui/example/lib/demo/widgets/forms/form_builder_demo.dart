import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class FormBuilderDemo extends StatelessWidget {
  const FormBuilderDemo({super.key});

  String get title => 'Form Builder';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          const SimpleText.body(
            text:
                'SimpleFormBuilder renders common form controls from a small schema and supports initialValues out of the box.',
          ),
          Gap.h16,
          SimpleCard(
            child: SimpleFormBuilder(
              initialValues: <String, dynamic>{
                // 'name': 'Jun',
                // 'query': 'Flutter UI',
                // 'role': 'Engineer',
                // 'agreeTerms': true,
                // 'workMode': 'Hybrid',
                // 'receivePromo': true,
              },
              fields: <SimpleFormFieldConfig<dynamic>>[
                SimpleFormFieldConfig.text(
                  name: 'name',
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  helperText: 'This uses SimpleTextField internally.',
                  required: true,
                ),
                SimpleFormFieldConfig.search(
                  name: 'query',
                  label: 'Search',
                  hintText: 'Search skills or interests',
                  helperText: 'This uses SimpleSearchField internally.',
                ),
                SimpleFormFieldConfig<String>.dropdown(
                  name: 'role',
                  label: 'Role',
                  hintText: 'Choose a role',
                  helperText: 'This uses SimpleDropdown internally.',
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(
                      value: 'Designer',
                      child: Text('Designer'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Engineer',
                      child: Text('Engineer'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Product Manager',
                      child: Text('Product Manager'),
                    ),
                  ],
                ),
                SimpleFormFieldConfig.checkbox(
                  name: 'agreeTerms',
                  label: 'I agree to the terms and conditions',
                  helperText: 'This uses SimpleCheckbox internally.',
                  required: true,
                ),
                SimpleFormFieldConfig<String>.radio(
                  name: 'workMode',
                  label: 'Preferred Work Mode',
                  helperText: 'This uses SimpleRadio internally.',
                  options: <String>['Remote', 'Hybrid', 'On-site'],
                ),
                SimpleFormFieldConfig.switchField(
                  name: 'receivePromo',
                  label: 'Receive Promotions',
                  helperText: 'This uses SimpleSwitch internally.',
                ),
              ],
              showSubmitButton: true,
              onChanged: (_) {},
              onSubmit: (Map<String, dynamic> values) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Submitted: ${values.toString()}')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
