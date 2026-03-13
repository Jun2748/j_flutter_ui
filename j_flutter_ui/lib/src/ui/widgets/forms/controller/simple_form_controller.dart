import 'package:flutter/foundation.dart';

import 'simple_form_state_snapshot.dart';

abstract class SimpleFormControllerHost {
  bool validate();
  Future<void> submit();
}

class SimpleFormController extends ChangeNotifier {
  SimpleFormController({Map<String, dynamic>? initialValues})
    : _initialValues = Map<String, dynamic>.from(
        initialValues ?? <String, dynamic>{},
      ),
      _values = Map<String, dynamic>.from(initialValues ?? <String, dynamic>{});

  final Map<String, dynamic> _values;
  final Map<String, dynamic> _initialValues;
  final Map<String, String?> _errors = <String, String?>{};
  SimpleFormControllerHost? _attachedHost;

  Map<String, dynamic> get values => Map<String, dynamic>.from(_values);

  Map<String, dynamic> get initialValues =>
      Map<String, dynamic>.from(_initialValues);

  Map<String, String?> get errors => Map<String, String?>.from(_errors);

  SimpleFormStateSnapshot get snapshot => SimpleFormStateSnapshot(
    values: _values,
    errors: _errors,
    initialValues: _initialValues,
  );

  dynamic getValue(String name) {
    return _values[name];
  }

  void setValue(String name, dynamic value) {
    if (_values.containsKey(name) && _values[name] == value) {
      return;
    }
    _values[name] = value;
    notifyListeners();
  }

  void setValues(Map<String, dynamic> values) {
    bool changed = false;

    for (final MapEntry<String, dynamic> entry in values.entries) {
      if (!_values.containsKey(entry.key) ||
          _values[entry.key] != entry.value) {
        _values[entry.key] = entry.value;
        changed = true;
      }
    }

    if (changed) {
      notifyListeners();
    }
  }

  void patchValues(Map<String, dynamic> values) {
    setValues(values);
  }

  String? getError(String name) {
    return _errors[name];
  }

  void setError(String name, String? error) {
    final String? normalizedError = _normalizeError(error);

    if (normalizedError == null) {
      if (_errors.remove(name) != null) {
        notifyListeners();
      }
      return;
    }

    if (_errors[name] == normalizedError) {
      return;
    }

    _errors[name] = normalizedError;
    notifyListeners();
  }

  void setErrors(Map<String, String> errors) {
    bool changed = false;

    for (final MapEntry<String, String> entry in errors.entries) {
      final String? normalizedError = _normalizeError(entry.value);
      if (normalizedError == null) {
        if (_errors.remove(entry.key) != null) {
          changed = true;
        }
        continue;
      }

      if (_errors[entry.key] != normalizedError) {
        _errors[entry.key] = normalizedError;
        changed = true;
      }
    }

    if (changed) {
      notifyListeners();
    }
  }

  void clearError(String name) {
    if (_errors.remove(name) != null) {
      notifyListeners();
    }
  }

  void clearErrors() {
    if (_errors.isEmpty) {
      return;
    }

    _errors.clear();
    notifyListeners();
  }

  @internal
  void attachHost(SimpleFormControllerHost host) {
    _attachedHost = host;
  }

  @internal
  void detachHost(SimpleFormControllerHost host) {
    if (identical(_attachedHost, host)) {
      _attachedHost = null;
    }
  }

  void reset() {
    if (_values.isEmpty && _errors.isEmpty) {
      return;
    }

    _values.clear();
    _errors.clear();
    notifyListeners();
  }

  void resetToInitialValues() {
    bool changed = false;

    final List<String> valueKeys = _values.keys.toList();
    for (final String key in valueKeys) {
      if (!_initialValues.containsKey(key)) {
        _values.remove(key);
        changed = true;
      }
    }

    for (final MapEntry<String, dynamic> entry in _initialValues.entries) {
      if (!_values.containsKey(entry.key) ||
          _values[entry.key] != entry.value) {
        _values[entry.key] = entry.value;
        changed = true;
      }
    }

    if (_errors.isNotEmpty) {
      _errors.clear();
      changed = true;
    }

    if (changed) {
      notifyListeners();
    }
  }

  bool validate() {
    return _attachedHost?.validate() ?? false;
  }

  Future<void> submit() async {
    await _attachedHost?.submit();
  }

  String? _normalizeError(String? error) {
    if (error == null || error.trim().isEmpty) {
      return null;
    }
    return error;
  }
}
