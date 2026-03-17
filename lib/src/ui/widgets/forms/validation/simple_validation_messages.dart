import '../../../localization/intl.dart';
import '../../../localization/l.dart';

class SimpleValidationMessages {
  SimpleValidationMessages._();

  static String get required => _localizedText(
    L.formValidationRequired,
    fallback: 'This field is required',
  );

  static String requiredField(String field) => _localizedText(
    L.formValidationRequiredField,
    fallback: '$field is required',
    args: <String, String>{'field': field},
  );

  static String get invalidEmail => _localizedText(
    L.formValidationInvalidEmail,
    fallback: 'Please enter a valid email address',
  );

  static String get invalidPhone => _localizedText(
    L.formValidationInvalidPhone,
    fallback: 'Please enter a valid phone number',
  );

  static String get invalidFormat => _localizedText(
    L.formValidationInvalidFormat,
    fallback: 'Please enter a valid value',
  );

  static String minLength(int length) => _localizedText(
    L.formValidationMinLength,
    fallback: 'Must be at least $length characters',
    args: <String, String>{'length': '$length'},
  );

  static String maxLength(int length) => _localizedText(
    L.formValidationMaxLength,
    fallback: 'Must be at most $length characters',
    args: <String, String>{'length': '$length'},
  );

  static String _localizedText(
    String key, {
    required String fallback,
    Map<String, String>? args,
  }) {
    final String localized = Intl.text(key, args: args);
    if (localized.isEmpty || localized == key) {
      return fallback;
    }
    return localized;
  }
}
