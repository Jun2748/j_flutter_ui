import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class FormBuilderDemo extends StatefulWidget {
  const FormBuilderDemo({super.key});

  String get title => 'Form Builder';

  @override
  State<FormBuilderDemo> createState() => _FormBuilderDemoState();
}

class _FormBuilderDemoState extends State<FormBuilderDemo> {
  final GlobalKey<SimpleFormBuilderState> _formKey =
      GlobalKey<SimpleFormBuilderState>();
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
  late Map<String, dynamic> _controllerValues = _controller.values;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
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
                'SimpleFormBuilder can also sync with SimpleFormController. Use the buttons below to update values externally and watch the form stay in sync.',
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
                  SimpleFormUtil.setError(
                    _formKey,
                    'email',
                    'Email already exists',
                  );
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
            ],
          ),
          Gap.h16,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SimpleText.heading(text: 'Controller Values'),
                Gap.h8,
                SimpleText.caption(text: _controllerValues.toString()),
              ],
            ),
          ),
          Gap.h16,
          SimpleCard(
            child: SimpleFormBuilder(
              key: _formKey,
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

  void _handleControllerChanged() {
    setState(() {
      _controllerValues = _controller.values;
    });
  }
}
