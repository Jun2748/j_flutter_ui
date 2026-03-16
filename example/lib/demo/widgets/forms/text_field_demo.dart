import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class TextFieldDemo extends StatefulWidget {
  const TextFieldDemo({super.key});

  String get title => 'Text Field';

  @override
  State<TextFieldDemo> createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  late final TextEditingController _controller = TextEditingController(
    text: 'Initial value',
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
          Section(
            title: 'Label, hint, helper, and prefix icon',
            child: SimpleTextField(
              controller: _controller,
              labelText: 'Name',
              hintText: 'Enter your name',
              helperText: 'This field uses SimpleTextField.',
              prefixIcon: const Icon(Icons.person_outline),
            ),
          ),
          Gap.h24,
          Section(
            title: 'Prefix and suffix widgets',
            child: SimpleTextField(
              labelText: 'Phone',
              hintText: '123456789',
              helperText: 'Use prefix and suffix for richer input affordances.',
              prefix: const Padding(
                padding: JInsets.horizontal12,
                child: SimpleText.body(text: '+60'),
              ),
              suffix: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.contact_phone_outlined),
              ),
            ),
          ),
          Gap.h24,
          Section(
            title: 'Read only',
            child: const SimpleTextField(
              labelText: 'Reference',
              hintText: 'Read only',
              helperText: 'Useful for generated or synced values.',
              readOnly: true,
            ),
          ),
          Gap.h24,
          Section(
            title: 'Error state',
            child: const SimpleTextField(
              labelText: 'Email',
              hintText: 'name@example.com',
              errorText: 'Please enter a valid email address.',
              keyboardType: TextInputType.emailAddress,
              suffixIcon: Icon(Icons.error_outline),
            ),
          ),
        ],
      ),
    );
  }
}
