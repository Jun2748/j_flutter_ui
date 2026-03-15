import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class FormControllerDemo extends StatefulWidget {
  const FormControllerDemo({super.key});

  String get title => 'Form Controller';

  @override
  State<FormControllerDemo> createState() => _FormControllerDemoState();
}

class _FormControllerDemoState extends State<FormControllerDemo> {
  late final SimpleFormController _controller = SimpleFormController(
    initialValues: <String, dynamic>{'name': 'Jun', 'email': 'jun@example.com'},
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
              SimpleButton.secondary(
                label: 'Set Name',
                onPressed: () {
                  _controller.setValue('name', 'Taylor Swift');
                },
              ),
              SimpleButton.secondary(
                label: 'Patch Email',
                onPressed: () {
                  _controller.patchValues(<String, dynamic>{
                    'email': 'updated@example.com',
                  });
                },
              ),
              SimpleButton.text(
                label: 'Reset To Initial',
                onPressed: () {
                  _controller.resetToInitialValues();
                },
              ),
            ],
          ),
          Gap.h16,
          SimpleCard(
            child: SimpleFormBuilder(
              controller: _controller,
              fields: <SimpleFormFieldConfig<dynamic>>[
                SimpleFormFieldConfig.text(
                  name: 'name',
                  label: 'Name',
                  hintText: 'Enter your name',
                  required: true,
                ),
                SimpleFormFieldConfig.text(
                  name: 'email',
                  label: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  required: true,
                ),
              ],
              showSubmitButton: true,
              onSubmit: (Map<String, dynamic> values) async {},
            ),
          ),
          Gap.h16,
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, _) {
              return SimpleCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SimpleText.heading(text: 'controller.values'),
                    Gap.h8,
                    SimpleText.body(text: _controller.values.toString()),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
