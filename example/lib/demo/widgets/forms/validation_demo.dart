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
                'This form focuses on reusable required and email validation with inline error rendering.',
          ),
          Gap.h16,
          SimpleCard(
            child: SimpleFormBuilder(
              fields: <SimpleFormFieldConfig<dynamic>>[
                SimpleFormFieldConfig.text(
                  name: 'name',
                  label: 'Name',
                  hintText: 'Enter your name',
                  validator: SimpleFormValidator.required(),
                ),
                SimpleFormFieldConfig.text(
                  name: 'email',
                  label: 'Email',
                  hintText: 'name@example.com',
                  validator: SimpleFormValidator.combine(<SimpleValidator>[
                    SimpleFormValidator.required(),
                    SimpleFormValidator.email(),
                  ]),
                ),
              ],
              showSubmitButton: true,
              submitLabel: 'Validate Form',
              onSubmit: (Map<String, dynamic> values) async {
                SimpleSnackbar.showSuccess(
                  context,
                  message: 'Validation passed',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
