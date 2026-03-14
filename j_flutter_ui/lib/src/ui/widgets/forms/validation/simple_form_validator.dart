import 'simple_regex_patterns.dart';
import 'simple_validation_messages.dart';

typedef SimpleValidator = String? Function(dynamic value);

class SimpleFormValidator {
  SimpleFormValidator._();

  static SimpleValidator required({
    String message = SimpleValidationMessages.required,
  }) {
    return (dynamic value) {
      if (value == null) {
        return message;
      }

      if (value is String && value.trim().isEmpty) {
        return message;
      }

      return null;
    };
  }

  static SimpleValidator email({
    String message = SimpleValidationMessages.invalidEmail,
  }) {
    return pattern(SimpleRegexPatterns.email, message: message);
  }

  static SimpleValidator phone({
    String message = SimpleValidationMessages.invalidPhone,
  }) {
    return (dynamic value) {
      final String? normalizedValue = _normalizeValue(value);
      if (normalizedValue == null || normalizedValue.isEmpty) {
        return null;
      }

      if (!SimpleRegexPatterns.phone.hasMatch(normalizedValue)) {
        return message;
      }

      final String digitsOnly = normalizedValue.replaceAll(
        RegExp(r'[^0-9]'),
        '',
      );

      if (digitsOnly.length < 7 || digitsOnly.length > 15) {
        return message;
      }

      return null;
    };
  }

  static SimpleValidator pattern(
    RegExp regex, {
    String message = SimpleValidationMessages.invalidFormat,
  }) {
    return (dynamic value) {
      final String? normalizedValue = _normalizeValue(value);
      if (normalizedValue == null || normalizedValue.isEmpty) {
        return null;
      }

      return regex.hasMatch(normalizedValue) ? null : message;
    };
  }

  static SimpleValidator minLength(int length, {String? message}) {
    return (dynamic value) {
      final String? normalizedValue = _normalizeValue(value);
      if (normalizedValue == null || normalizedValue.isEmpty) {
        return null;
      }

      if (normalizedValue.length >= length) {
        return null;
      }

      return message ?? 'Must be at least $length characters';
    };
  }

  static SimpleValidator maxLength(int length, {String? message}) {
    return (dynamic value) {
      final String? normalizedValue = _normalizeValue(value);
      if (normalizedValue == null || normalizedValue.isEmpty) {
        return null;
      }

      if (normalizedValue.length <= length) {
        return null;
      }

      return message ?? 'Must be at most $length characters';
    };
  }

  static SimpleValidator combine(List<SimpleValidator> validators) {
    return (dynamic value) {
      for (final SimpleValidator validator in validators) {
        final String? error = validator(value);
        if (error != null && error.isNotEmpty) {
          return error;
        }
      }

      return null;
    };
  }

  static String? _normalizeValue(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is String) {
      return value.trim();
    }

    return value.toString().trim();
  }
}
