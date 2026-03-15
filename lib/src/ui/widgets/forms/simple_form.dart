import 'package:flutter/material.dart';

class SimpleForm extends StatelessWidget {
  const SimpleForm({
    super.key,
    required this.child,
    this.formKey,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.padding,
    this.dismissKeyboardOnTap = true,
  });

  final Widget child;
  final Key? formKey;
  final AutovalidateMode autovalidateMode;
  final EdgeInsets? padding;
  final bool dismissKeyboardOnTap;

  @override
  Widget build(BuildContext context) {
    Widget content = Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: child,
    );

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    if (!dismissKeyboardOnTap) {
      return content;
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        final FocusScopeNode focusScope = FocusScope.of(context);
        if (!focusScope.hasPrimaryFocus) {
          focusScope.unfocus();
        }
      },
      child: content,
    );
  }
}
