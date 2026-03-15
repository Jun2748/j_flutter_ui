import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class InvalidScrollDemo extends StatelessWidget {
  const InvalidScrollDemo({super.key});

  String get title => 'Invalid Scroll';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          const SimpleBanner.info(
            title: 'Scroll to first invalid field',
            message:
                'Leave the form empty and submit to verify that the builder scrolls and focuses the first invalid field.',
          ),
          Gap.h16,
          SimpleCard(
            child: SimpleFormBuilder(
              fields: <SimpleFormFieldConfig<dynamic>>[
                for (int index = 0; index < 8; index++)
                  SimpleFormFieldConfig.text(
                    name: 'field_$index',
                    label: 'Field ${index + 1}',
                    hintText: 'Enter value for field ${index + 1}',
                    required: true,
                  ),
              ],
              showSubmitButton: true,
              submitLabel: 'Submit Long Form',
              onSubmit: (Map<String, dynamic> values) async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Long form submitted')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
