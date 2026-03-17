import 'simple_regex_patterns.dart';
import 'simple_validation_messages.dart';

typedef SimpleValidator = String? Function(dynamic value);

class SimpleFormValidator {
  SimpleFormValidator._();

  static SimpleValidator required({String? message}) {
    final String resolvedMessage = message ?? SimpleValidationMessages.required;

    return (dynamic value) {
      if (value == null) {
        return resolvedMessage;
      }

      if (value is String && value.trim().isEmpty) {
        return resolvedMessage;
      }

      return null;
    };
  }

  static SimpleValidator email({String? message}) {
    return pattern(
      SimpleRegexPatterns.email,
      message: message ?? SimpleValidationMessages.invalidEmail,
    );
  }

  static SimpleValidator phone({String? message}) {
    final String resolvedMessage =
        message ?? SimpleValidationMessages.invalidPhone;

    return (dynamic value) {
      final String? normalizedValue = _normalizeValue(value);
      if (normalizedValue == null || normalizedValue.isEmpty) {
        return null;
      }

      if (!SimpleRegexPatterns.phone.hasMatch(normalizedValue)) {
        return resolvedMessage;
      }

      final String digitsOnly = normalizedValue.replaceAll(
        RegExp(r'[^0-9]'),
        '',
      );

      if (digitsOnly.length < 7 || digitsOnly.length > 15) {
        return resolvedMessage;
      }

      return null;
    };
  }

  static SimpleValidator pattern(
    RegExp regex, {
    String? message,
  }) {
    final String resolvedMessage =
        message ?? SimpleValidationMessages.invalidFormat;

    return (dynamic value) {
      final String? normalizedValue = _normalizeValue(value);
      if (normalizedValue == null || normalizedValue.isEmpty) {
        return null;
      }

      return regex.hasMatch(normalizedValue) ? null : resolvedMessage;
    };
  }

  static SimpleValidator minLength(int length, {String? message}) {
    final String resolvedMessage =
        message ?? SimpleValidationMessages.minLength(length);

    return (dynamic value) {
      final String? normalizedValue = _normalizeValue(value);
      if (normalizedValue == null || normalizedValue.isEmpty) {
        return null;
      }

      if (normalizedValue.length >= length) {
        return null;
      }

      return resolvedMessage;
    };
  }

  static SimpleValidator maxLength(int length, {String? message}) {
    final String resolvedMessage =
        message ?? SimpleValidationMessages.maxLength(length);

    return (dynamic value) {
      final String? normalizedValue = _normalizeValue(value);
      if (normalizedValue == null || normalizedValue.isEmpty) {
        return null;
      }

      if (normalizedValue.length <= length) {
        return null;
      }

      return resolvedMessage;
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
