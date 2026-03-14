import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class FormBuilderDemo extends StatefulWidget {
  const FormBuilderDemo({super.key});

  String get title => 'Form Builder';

  @override
  State<FormBuilderDemo> createState() => _FormBuilderDemoState();
}

class _FormBuilderDemoState extends State<FormBuilderDemo> {
  late final SimpleFormController _controller = SimpleFormController(
    initialValues: <String, dynamic>{
      'name': 'Jun',
      'email': 'jun@example.com',
      'query': 'Flutter UI',
      'role': 'Engineer',
      'agreeTerms': true,
      'workMode': 'Hybrid',
      'receivePromo': true,
    },
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          const SimpleText.body(
            text:
                'SimpleFormBuilder syncs with SimpleFormController for values, errors, validation, and submit flow. Editing a field automatically clears its backend error.',
          ),
          Gap.h16,
          Wrap(
            spacing: JDimens.dp8,
            runSpacing: JDimens.dp8,
            children: <Widget>[
              SimpleButton.secondary(
                label: 'Set Name',
                onPressed: () {
                  _controller.setValue('name', 'Jun Lim');
                },
              ),
              SimpleButton.secondary(
                label: 'Patch Email',
                onPressed: () {
                  _controller.patchValues(<String, dynamic>{
                    'email': 'new@example.com',
                  });
                },
              ),
              SimpleButton.secondary(
                label: 'Set Values',
                onPressed: () {
                  _controller.setValues(<String, dynamic>{
                    'name': 'Jun Lee',
                    'email': 'junlee@example.com',
                  });
                },
              ),
              SimpleButton.outline(
                label: 'Set Email Error',
                onPressed: () {
                  _controller.setError('email', 'Email already exists');
                },
              ),
              SimpleButton.outline(
                label: 'Set Multi Errors',
                onPressed: () {
                  _controller.setErrors(<String, String>{
                    'email': 'Email already exists',
                    'query': 'Search term is too broad',
                    'role': 'choose a new role',
                    'agreeTerms': 'accept the terms',
                  });
                },
              ),
              SimpleButton.text(
                label: 'ResetToInitialValue',
                onPressed: () {
                  _controller.resetToInitialValues();
                },
              ),
              SimpleButton.text(
                label: 'Reset All',
                onPressed: () {
                  _controller.reset();
                },
              ),
              SimpleButton.text(
                label: 'Validate',
                onPressed: () {
                  final bool isValid = _controller.validate();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Valid: $isValid')));
                },
              ),
            ],
          ),
          Gap.h16,
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, _) {
              return SimpleCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SimpleText.heading(text: 'Controller State'),
                    Gap.h8,
                    SimpleText.caption(
                      text: 'Values: ${_controller.values.toString()}',
                    ),
                    Gap.h8,
                    SimpleText.caption(
                      text: 'Errors: ${_controller.errors.toString()}',
                    ),
                  ],
                ),
              );
            },
          ),
          Gap.h16,
          SimpleCard(
            child: SimpleFormBuilder(
              controller: _controller,
              fields: <SimpleFormFieldConfig<dynamic>>[
                SimpleFormFieldConfig.text(
                  name: 'name',
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  helperText: 'This uses SimpleTextField internally.',
                  required: true,
                ),
                SimpleFormFieldConfig.text(
                  name: 'email',
                  label: 'Email',
                  hintText: 'Enter your email',
                  helperText:
                      'Use "Set Email Error" to simulate a backend error. Editing this field will clear that error automatically.',
                  keyboardType: TextInputType.emailAddress,
                  required: true,
                ),
                SimpleFormFieldConfig.search(
                  name: 'query',
                  label: 'Search',
                  hintText: 'Search skills or interests',
                  helperText: 'This uses SimpleSearchField internally.',
                  required: true,
                ),
                SimpleFormFieldConfig<String>.dropdown(
                  name: 'role',
                  label: 'Role',
                  hintText: 'Choose a role',
                  helperText: 'This uses SimpleDropdown internally.',
                  required: true,
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
                  required: true,
                ),
                SimpleFormFieldConfig.switchField(
                  name: 'receivePromo',
                  label: 'Receive Promotions',
                  helperText: 'This uses SimpleSwitch internally.',
                  required: true,
                ),
              ],
              showSubmitButton: true,
              onSubmit: (Map<String, dynamic> values) async {
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
