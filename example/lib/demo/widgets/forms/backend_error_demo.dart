import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class BackendErrorDemo extends StatefulWidget {
  const BackendErrorDemo({super.key});

  String get title => 'Backend Errors';

  @override
  State<BackendErrorDemo> createState() => _BackendErrorDemoState();
}

class _BackendErrorDemoState extends State<BackendErrorDemo> {
  late final SimpleFormController _controller = SimpleFormController(
    initialValues: <String, dynamic>{
      'email': 'jun@example.com',
      'username': 'jun_dev',
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
          Wrap(
            spacing: JDimens.dp8,
            runSpacing: JDimens.dp8,
            children: <Widget>[
              SimpleButton.outline(
                label: 'Set Email Error',
                onPressed: () {
                  _controller.setError('email', 'Email already exists');
                },
              ),
              SimpleButton.outline(
                label: 'Set Multiple Errors',
                onPressed: () {
                  _controller.setErrors(<String, String>{
                    'email': 'Email already exists',
                    'username': 'Username is already taken',
                  });
                },
              ),
            ],
          ),
          JGaps.h16,
          const SimpleBanner.warning(
            title: 'Manual test hint',
            message: 'Editing a field should clear its backend error.',
          ),
          JGaps.h16,
          SimpleCard(
            child: SimpleFormBuilder(
              controller: _controller,
              fields: <SimpleFormFieldConfig<dynamic>>[
                SimpleFormFieldConfig.text(
                  name: 'email',
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SimpleFormFieldConfig.text(name: 'username', label: 'Username'),
              ],
              showSubmitButton: true,
              onSubmit: (Map<String, dynamic> values) async {},
            ),
          ),
        ],
      ),
    );
  }
}
