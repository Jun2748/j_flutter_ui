typedef SimpleCrossFieldValidator =
    String? Function(dynamic value, Map<String, dynamic> values);

class SimpleCrossFieldValidators {
  SimpleCrossFieldValidators._();

  static SimpleCrossFieldValidator matchField(
    String otherFieldName, {
    required String message,
  }) {
    return (dynamic value, Map<String, dynamic> values) {
      final dynamic otherValue = values[otherFieldName];
      if (_isMissingValue(value) || _isMissingValue(otherValue)) {
        return null;
      }

      return value == otherValue ? null : message;
    };
  }

  static SimpleCrossFieldValidator greaterThanField(
    String otherFieldName, {
    required String message,
  }) {
    return (dynamic value, Map<String, dynamic> values) {
      final dynamic otherValue = values[otherFieldName];
      if (_isMissingValue(value) || _isMissingValue(otherValue)) {
        return null;
      }

      final num? currentNumber = _toNum(value);
      final num? otherNumber = _toNum(otherValue);
      if (currentNumber == null || otherNumber == null) {
        return null;
      }

      return currentNumber > otherNumber ? null : message;
    };
  }

  static SimpleCrossFieldValidator lessThanField(
    String otherFieldName, {
    required String message,
  }) {
    return (dynamic value, Map<String, dynamic> values) {
      final dynamic otherValue = values[otherFieldName];
      if (_isMissingValue(value) || _isMissingValue(otherValue)) {
        return null;
      }

      final num? currentNumber = _toNum(value);
      final num? otherNumber = _toNum(otherValue);
      if (currentNumber == null || otherNumber == null) {
        return null;
      }

      return currentNumber < otherNumber ? null : message;
    };
  }

  static SimpleCrossFieldValidator afterField(
    String otherFieldName, {
    required String message,
  }) {
    return (dynamic value, Map<String, dynamic> values) {
      final dynamic otherValue = values[otherFieldName];
      if (_isMissingValue(value) || _isMissingValue(otherValue)) {
        return null;
      }

      final int? comparison = _compareValues(value, otherValue);
      if (comparison == null) {
        return null;
      }

      return comparison > 0 ? null : message;
    };
  }

  static SimpleCrossFieldValidator beforeField(
    String otherFieldName, {
    required String message,
  }) {
    return (dynamic value, Map<String, dynamic> values) {
      final dynamic otherValue = values[otherFieldName];
      if (_isMissingValue(value) || _isMissingValue(otherValue)) {
        return null;
      }

      final int? comparison = _compareValues(value, otherValue);
      if (comparison == null) {
        return null;
      }

      return comparison < 0 ? null : message;
    };
  }

  static SimpleCrossFieldValidator combine(
    List<SimpleCrossFieldValidator> validators,
  ) {
    return (dynamic value, Map<String, dynamic> values) {
      for (final SimpleCrossFieldValidator validator in validators) {
        final String? error = validator(value, values);
        if (error != null && error.isNotEmpty) {
          return error;
        }
      }

      return null;
    };
  }

  static bool _isMissingValue(dynamic value) {
    return value == null || (value is String && value.trim().isEmpty);
  }

  static num? _toNum(dynamic value) {
    if (value is num) {
      return value;
    }

    if (value is String) {
      return num.tryParse(value.trim());
    }

    return null;
  }

  static int? _compareValues(dynamic value, dynamic otherValue) {
    if (value is Comparable<dynamic>) {
      try {
        return value.compareTo(otherValue);
      } catch (_) {
        return null;
      }
    }

    return null;
  }
}
