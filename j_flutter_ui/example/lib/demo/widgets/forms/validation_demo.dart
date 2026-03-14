import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ValidationDemo extends StatelessWidget {
  const ValidationDemo({super.key});

  String get title => 'Validation';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          const SimpleBanner.info(
            title: 'Validation demo',
            message:
                'This form shows required, email, and cross-field password validation.',
          ),
          Gap.h16,
          SimpleCard(
            child: SimpleFormBuilder(
              fields: <SimpleFormFieldConfig<dynamic>>[
                SimpleFormFieldConfig.text(
                  name: 'email',
                  label: 'Email',
                  hintText: 'name@example.com',
                  validator: SimpleFormValidator.combine(<SimpleValidator>[
                    SimpleFormValidator.required(),
                    SimpleFormValidator.email(),
                  ]),
                ),
                SimpleFormFieldConfig.text(
                  name: 'password',
                  label: 'Password',
                  hintText: 'Enter password',
                  obscureText: true,
                  validator: SimpleFormValidator.combine(<SimpleValidator>[
                    SimpleFormValidator.required(),
                    SimpleFormValidator.minLength(8),
                  ]),
                ),
                SimpleFormFieldConfig.text(
                  name: 'confirmPassword',
                  label: 'Confirm Password',
                  hintText: 'Re-enter password',
                  obscureText: true,
                  validator: SimpleFormValidator.required(),
                  crossValidators: <SimpleCrossFieldValidator>[
                    SimpleCrossFieldValidators.matchField(
                      'password',
                      message: 'Passwords do not match',
                    ),
                  ],
                ),
              ],
              showSubmitButton: true,
              submitLabel: 'Validate Form',
              onSubmit: (Map<String, dynamic> values) async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Validation passed')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
