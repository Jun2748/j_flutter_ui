import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class TextFieldDemo extends StatefulWidget {
  const TextFieldDemo({super.key});

  @override
  State<TextFieldDemo> createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  late final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String tr(String key) => Intl.text(key, context: context);

    return AppScaffold(
      appBar: AppBarEx(title: tr(L.demoTextFieldTitle)),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          Section(
            title: tr(L.demoTextFieldBasicTitle),
            child: SimpleTextField(
              controller: _controller,
              labelText: tr(L.commonName),
              hintText: tr(L.demoTextFieldNameHint),
              helperText: tr(L.demoTextFieldBasicHelper),
              prefixIcon: const Icon(Icons.person_outline),
            ),
          ),
          JGaps.h24,
          Section(
            title: tr(L.demoTextFieldAffordancesTitle),
            child: SimpleTextField(
              labelText: tr(L.loginPhone),
              hintText: '000000000',
              helperText: tr(L.demoTextFieldPhoneHelper),
              prefix: const Padding(
                padding: JInsets.horizontal12,
                child: SimpleText.body(text: '+00'),
              ),
              suffix: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.contact_phone_outlined),
              ),
            ),
          ),
          JGaps.h24,
          Section(
            title: tr(L.demoTextFieldReadOnlyTitle),
            child: SimpleTextField(
              labelText: tr(L.commonReference),
              hintText: tr(L.demoTextFieldReadOnlyHint),
              helperText: tr(L.demoTextFieldReadOnlyHelper),
              readOnly: true,
            ),
          ),
          JGaps.h24,
          Section(
            title: tr(L.demoTextFieldDisabledTitle),
            child: SimpleTextField(
              labelText: tr(L.commonName),
              hintText: tr(L.demoTextFieldNameHint),
              helperText: tr(L.demoTextFieldDisabledHelper),
              enabled: false,
            ),
          ),
          JGaps.h24,
          Section(
            title: tr(L.demoTextFieldErrorTitle),
            child: SimpleTextField(
              labelText: tr(L.commonEmail),
              hintText: tr(L.demoTextFieldEmailHint),
              errorText: tr(L.demoTextFieldEmailError),
              keyboardType: TextInputType.emailAddress,
              suffixIcon: Icon(Icons.error_outline),
            ),
          ),
        ],
      ),
    );
  }
}
