import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class FormBuilderDemo extends StatefulWidget {
  const FormBuilderDemo({super.key});

  String get title => 'Form Builder';

  @override
  State<FormBuilderDemo> createState() => _FormBuilderDemoState();
}

class _FormBuilderDemoState extends State<FormBuilderDemo> {
  static const String _selectedPhoneCountryCode = CountryCodes.my;

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
                'This page focuses on SimpleFormBuilder as a schema-driven form and shows the recommended controller initialization pattern. Dedicated demos cover controller actions, backend errors, validation states, and invalid-scroll behavior in more detail.',
          ),
          JGaps.h16,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SimpleText.heading(text: 'Controller initialization'),
                JGaps.h8,
                const SimpleText.caption(
                  text:
                      'This form is connected to a SimpleFormController with initialValues so the builder starts with prefilled data.',
                ),
              ],
            ),
          ),
          JGaps.h16,
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
                  helperText: 'Required plus reusable email format validation.',
                  keyboardType: TextInputType.emailAddress,
                  required: true,
                  validator: SimpleFormValidator.email(),
                ),
                SimpleFormFieldConfig.text(
                  name: 'phone',
                  labelWidget: const HStack(
                    gap: JDimens.dp8,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SimpleText.label(text: 'Phone', weight: FontWeight.w600),
                      SimpleBadge.neutral(label: 'Widget label'),
                    ],
                  ),
                  hintText: 'Enter your phone number',
                  helperText: 'Optional field using reusable phone validation.',
                  prefix: const Padding(
                    padding: JInsets.horizontal4,
                    child: HStack(
                      gap: JDimens.dp8,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SimpleFlag.countryCode(
                          _selectedPhoneCountryCode,
                          size: JIconSizes.md,
                        ),
                      ],
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: SimpleFormValidator.phone(),
                ),
                SimpleFormFieldConfig.text(
                  name: 'password',
                  label: 'Password',
                  hintText: 'Enter your password',
                  helper: const HStack(
                    gap: JDimens.dp8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: JInsets.vertical4,
                        child: Icon(Icons.info_outline, size: JIconSizes.sm),
                      ),
                      Expanded(
                        child: SimpleText.caption(
                          text:
                              'Use at least 8 characters. This helper is rendered from a widget override.',
                        ),
                      ),
                    ],
                  ),
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
                  items: const <DropdownMenuItem<String>>[
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
          JGaps.h16,
          SimpleCard(
            child: VStack(
              gap: JDimens.dp16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SimpleText.heading(
                  text: 'SimpleTextField prefix and suffix',
                ),
                const SimpleText.caption(
                  text:
                      'These examples complement the builder demo by showing the lower-level SimpleTextField API that powers many form inputs.',
                ),
                const SimpleTextField(
                  labelText: 'Phone prefix',
                  hintText: '123456789',
                  helperText:
                      'Prefix is useful for country codes or inline context.',
                  prefix: Padding(
                    padding: JInsets.horizontal12,
                    child: SimpleText.body(text: '+60'),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SimpleTextField(
                  labelText: 'Password suffix',
                  hintText: 'Enter your password',
                  helperText:
                      'Suffix can host visibility toggles or status actions.',
                  obscureText: true,
                  suffix: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility_off_outlined),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
