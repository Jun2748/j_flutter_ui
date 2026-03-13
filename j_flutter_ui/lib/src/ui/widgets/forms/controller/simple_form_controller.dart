import 'package:flutter/foundation.dart';

import 'simple_form_state_snapshot.dart';

class SimpleFormController extends ChangeNotifier {
  SimpleFormController({Map<String, dynamic>? initialValues})
    : _initialValues = Map<String, dynamic>.from(
        initialValues ?? <String, dynamic>{},
      ),
      _values = Map<String, dynamic>.from(initialValues ?? <String, dynamic>{});

  final Map<String, dynamic> _values;
  final Map<String, dynamic> _initialValues;

  Map<String, dynamic> get values => Map<String, dynamic>.from(_values);

  Map<String, dynamic> get initialValues =>
      Map<String, dynamic>.from(_initialValues);

  SimpleFormStateSnapshot get snapshot =>
      SimpleFormStateSnapshot(values: _values, initialValues: _initialValues);

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

  void reset() {
    if (_values.isEmpty) {
      return;
    }

    _values.clear();
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

    if (changed) {
      notifyListeners();
    }
  }
}
