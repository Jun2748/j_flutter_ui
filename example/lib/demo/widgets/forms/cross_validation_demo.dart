import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class CrossValidationDemo extends StatelessWidget {
  const CrossValidationDemo({super.key});

  String get title => 'Cross Validation';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          const SimpleBanner.info(
            title: 'Confirm password flow',
            message:
                'This example focuses on cross-field validation where confirm password must match password.',
          ),
          Gap.h16,
          SimpleCard(
            child: SimpleFormBuilder(
              fields: <SimpleFormFieldConfig<dynamic>>[
                SimpleFormFieldConfig.text(
                  name: 'password',
                  label: 'Password',
                  hintText: 'Enter a password',
                  obscureText: true,
                  validator: SimpleFormValidator.combine(<SimpleValidator>[
                    SimpleFormValidator.required(),
                    SimpleFormValidator.minLength(8),
                  ]),
                ),
                SimpleFormFieldConfig.text(
                  name: 'confirmPassword',
                  label: 'Confirm Password',
                  hintText: 'Re-enter the password',
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
              submitLabel: 'Validate Match',
              onSubmit: (Map<String, dynamic> values) async {
                SimpleSnackbar.showSuccess(
                  context,
                  message: 'Passwords match and validation passed.',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
