import 'package:flutter/widgets.dart';

import '../../../localization/intl.dart';
import '../../../localization/l.dart';

class SimpleValidationMessages {
  SimpleValidationMessages._();

  static String get required => requiredText();

  static String requiredText({BuildContext? context}) => _localizedText(
    L.formValidationRequired,
    context: context,
    fallback: 'This field is required',
  );

  static String requiredField(String field, {BuildContext? context}) =>
      _localizedText(
        L.formValidationRequiredField,
        context: context,
        fallback: '$field is required',
        args: <String, String>{'field': field},
      );

  static String get invalidEmail => invalidEmailText();

  static String invalidEmailText({BuildContext? context}) => _localizedText(
    L.formValidationInvalidEmail,
    context: context,
    fallback: 'Please enter a valid email address',
  );

  static String get invalidPhone => invalidPhoneText();

  static String invalidPhoneText({BuildContext? context}) => _localizedText(
    L.formValidationInvalidPhone,
    context: context,
    fallback: 'Please enter a valid phone number',
  );

  static String get invalidFormat => invalidFormatText();

  static String invalidFormatText({BuildContext? context}) => _localizedText(
    L.formValidationInvalidFormat,
    context: context,
    fallback: 'Please enter a valid value',
  );

  static String minLength(int length, {BuildContext? context}) =>
      _localizedText(
        L.formValidationMinLength,
        context: context,
        fallback: 'Must be at least $length characters',
        args: <String, String>{'length': '$length'},
      );

  static String maxLength(int length, {BuildContext? context}) =>
      _localizedText(
        L.formValidationMaxLength,
        context: context,
        fallback: 'Must be at most $length characters',
        args: <String, String>{'length': '$length'},
      );

  static String _localizedText(
    String key, {
    BuildContext? context,
    required String fallback,
    Map<String, String>? args,
  }) {
    final String localized = Intl.text(key, context: context, args: args);
    if (localized.isEmpty || localized == key) {
      return fallback;
    }
    return localized;
  }
}
