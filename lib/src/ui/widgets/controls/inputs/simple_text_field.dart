import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../../../resources/dimens.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    final Color surface = JColors.getColor(context, lightKey: 'surface');
    final Color card = JColors.getColor(context, lightKey: 'card');
    final Color textDisabled = JColors.getColor(
      context,
      lightKey: 'textDisabled',
    );
    final OutlineInputBorder inputBorder = _buildBorder(
      context,
      lightKey: 'border',
    );

    final Widget textField = TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      showCursor: !readOnly,
      enableInteractiveSelection: !readOnly,
      maxLines: obscureText ? 1 : maxLines,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        prefix: prefix,
        suffix: suffix,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: readOnly || !enabled,
        fillColor: readOnly
            ? surface
            : (!enabled ? surface.withAlpha(180) : card),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: _buildBorder(context, lightKey: 'primary', width: 1.4),
        disabledBorder: inputBorder,
        errorBorder: _buildBorder(context, lightKey: 'error'),
        focusedErrorBorder: _buildBorder(
          context,
          lightKey: 'error',
          width: 1.4,
        ),
        hintStyle: TextStyle(color: readOnly ? textDisabled : null),
      ),
      style: TextStyle(color: readOnly ? textDisabled : null),
    );

    if (!readOnly) {
      return textField;
    }

    return Focus(
      canRequestFocus: false,
      skipTraversal: true,
      child: IgnorePointer(ignoring: true, child: textField),
    );
  }

  OutlineInputBorder _buildBorder(
    BuildContext context, {
    required String lightKey,
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(JDimens.dp12),
      borderSide: BorderSide(
        color: JColors.getColor(context, lightKey: lightKey),
        width: width,
      ),
    );
  }
}
