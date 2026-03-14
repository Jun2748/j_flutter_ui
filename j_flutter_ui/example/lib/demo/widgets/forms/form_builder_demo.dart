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
      'phone': '+60123456789',
      'query': 'FlutterUI',
      'password': 'secret123',
      'confirmPassword': 'secret1234',
      'minPrice': '100',
      'maxPrice': '250',
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
                'SimpleFormBuilder syncs with SimpleFormController for values, errors, validation, and submit flow. This demo also shows reusable validators for required, email, phone, format checks, and cross-field validation.',
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
                label: 'Validate & Scroll',
                onPressed: () async {
                  final bool isValid = await _controller
                      .validateAndScrollToFirstError();
                  if (!context.mounted) {
                    return;
                  }
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
                  helperText:
                      'This uses SimpleTextField internally with combined min/max length validation.',
                  required: true,
                  validator: SimpleFormValidator.combine(<SimpleValidator>[
                    SimpleFormValidator.minLength(3),
                    SimpleFormValidator.maxLength(40),
                  ]),
                ),
                SimpleFormFieldConfig.text(
                  name: 'email',
                  label: 'Email',
                  hintText: 'Enter your email',
                  helperText:
                      'Required plus reusable email format validation. Use "Set Email Error" to simulate a backend error.',
                  keyboardType: TextInputType.emailAddress,
                  required: true,
                  validator: SimpleFormValidator.email(),
                ),
                SimpleFormFieldConfig.text(
                  name: 'phone',
                  label: 'Phone',
                  hintText: 'Enter your phone number',
                  helperText: 'Optional field using reusable phone validation.',
                  keyboardType: TextInputType.phone,
                  validator: SimpleFormValidator.phone(),
                ),
                SimpleFormFieldConfig.text(
                  name: 'password',
                  label: 'Password',
                  hintText: 'Enter your password',
                  helperText:
                      'Required password field with reusable min length validation.',
                  required: true,
                  obscureText: true,
                  validator: SimpleFormValidator.minLength(8),
                ),
                SimpleFormFieldConfig.text(
                  name: 'confirmPassword',
                  label: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  helperText:
                      'Cross-field validation checks that this matches the password field.',
                  required: true,
                  obscureText: true,
                  crossValidators: <SimpleCrossFieldValidator>[
                    SimpleCrossFieldValidators.matchField(
                      'password',
                      message: 'Passwords do not match',
                    ),
                  ],
                ),
                SimpleFormFieldConfig.text(
                  name: 'minPrice',
                  label: 'Min Price',
                  hintText: 'Enter minimum price',
                  helperText:
                      'Required numeric field used by max price cross-field validation.',
                  required: true,
                  keyboardType: TextInputType.number,
                  validator: SimpleFormValidator.pattern(
                    SimpleRegexPatterns.numbersOnly,
                    message: 'Only numbers are allowed',
                  ),
                ),
                SimpleFormFieldConfig.text(
                  name: 'maxPrice',
                  label: 'Max Price',
                  hintText: 'Enter maximum price',
                  helperText:
                      'Must be numeric and greater than the minimum price.',
                  required: true,
                  keyboardType: TextInputType.number,
                  validator: SimpleFormValidator.pattern(
                    SimpleRegexPatterns.numbersOnly,
                    message: 'Only numbers are allowed',
                  ),
                  crossValidators: <SimpleCrossFieldValidator>[
                    SimpleCrossFieldValidators.greaterThanField(
                      'minPrice',
                      message: 'Max price must be greater than min price',
                    ),
                  ],
                ),
                SimpleFormFieldConfig.search(
                  name: 'query',
                  label: 'Search',
                  hintText: 'Search skills or interests',
                  helperText:
                      'Required plus alphanumeric pattern validation using reusable regex patterns.',
                  required: true,
                  validator: SimpleFormValidator.pattern(
                    SimpleRegexPatterns.alphanumeric,
                    message: 'Only letters and numbers are allowed',
                  ),
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
