import 'dart:async';

import 'package:flutter/material.dart';

import '../../controls/buttons/simple_button.dart';
import '../../controls/dropdown/simple_dropdown.dart';
import '../../controls/inputs/simple_checkbox.dart';
import '../../controls/inputs/simple_radio.dart';
import '../../controls/inputs/simple_search_field.dart';
import '../../controls/inputs/simple_switch.dart';
import '../../controls/inputs/simple_text_field.dart';
import '../form_field_wrapper.dart';
import '../simple_form.dart';
import 'simple_form_field_config.dart';
import 'simple_form_field_type.dart';

class SimpleFormBuilder extends StatefulWidget {
  const SimpleFormBuilder({
    super.key,
    required this.fields,
    this.initialValues,
    this.onChanged,
    this.onSubmit,
    this.padding,
    this.fieldSpacing = 16,
    this.showSubmitButton = false,
    this.submitLabel = 'Submit',
    this.clearBackendErrorsOnSubmit = true,
    this.enabled = true,
  });

  final List<SimpleFormFieldConfig<dynamic>> fields;
  final Map<String, dynamic>? initialValues;
  final ValueChanged<Map<String, dynamic>>? onChanged;
  final FutureOr<void> Function(Map<String, dynamic> values)? onSubmit;
  final EdgeInsets? padding;
  final double fieldSpacing;
  final bool showSubmitButton;
  final String submitLabel;
  final bool clearBackendErrorsOnSubmit;
  final bool enabled;

  @override
  State<SimpleFormBuilder> createState() => SimpleFormBuilderState();
}

class SimpleFormBuilderState extends State<SimpleFormBuilder> {
  final GlobalKey<FormState> _internalFormKey = GlobalKey<FormState>();
  final Map<String, dynamic> _values = <String, dynamic>{};
  final Map<String, String?> _errors = <String, String?>{};
  final Map<String, String?> _fieldErrors = <String, String?>{};
  final Map<String, TextEditingController> _controllers =
      <String, TextEditingController>{};
  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  @override
  void initState() {
    super.initState();
    _syncFieldState();
  }

  @override
  void didUpdateWidget(SimpleFormBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncFieldState();
  }

  @override
  void dispose() {
    for (final TextEditingController controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      for (int index = 0; index < widget.fields.length; index++) ...<Widget>[
        _buildField(widget.fields[index]),
        if (index < widget.fields.length - 1)
          SizedBox(height: widget.fieldSpacing),
      ],
    ];

    if (widget.showSubmitButton && widget.onSubmit != null) {
      if (children.isNotEmpty) {
        children.add(SizedBox(height: widget.fieldSpacing));
      }
      children.add(
        SimpleButton.primary(
          label: widget.submitLabel,
          width: double.infinity,
          loading: _isSubmitting,
          onPressed: _isFormEnabled && !_isSubmitting ? submit : null,
        ),
      );
    }

    return SimpleForm(
      formKey: _internalFormKey,
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  dynamic getFieldValue(String name) {
    return _values[name];
  }

  String? getFieldError(String name) {
    return _fieldErrors[name];
  }

  void setFieldValue(String name, dynamic value) {
    final SimpleFormFieldConfig<dynamic>? field = _findField(name);
    if (field == null) {
      return;
    }
    _applyFieldValue(field, value);
  }

  Map<String, dynamic> getValues() {
    return Map<String, dynamic>.from(_values);
  }

  bool validate() {
    final bool formValid = _internalFormKey.currentState?.validate() ?? false;
    final bool fieldsValid = _validateFields();
    return formValid && fieldsValid;
  }

  bool isValid() {
    return validate();
  }

  Map<String, String?> getFieldErrors() {
    return Map<String, String?>.from(_fieldErrors);
  }

  void setFieldError(String name, String? error) {
    if (_findField(name) == null) {
      return;
    }

    _applyState(() {
      if (error == null || error.trim().isEmpty) {
        _fieldErrors.remove(name);
      } else {
        _fieldErrors[name] = error;
      }
    });
  }

  void setFieldErrors(Map<String, String> errors) {
    _applyState(() {
      for (final MapEntry<String, String> entry in errors.entries) {
        if (_findField(entry.key) == null) {
          continue;
        }
        _fieldErrors[entry.key] = entry.value;
      }
    });
  }

  void clearFieldError(String name) {
    _applyState(() {
      _fieldErrors.remove(name);
    });
  }

  void clearFieldErrors() {
    _applyState(() {
      _fieldErrors.clear();
    });
  }

  void setSubmitting(bool value) {
    if (_isSubmitting == value) {
      return;
    }
    _applyState(() {
      _isSubmitting = value;
    });
  }

  void reset() {
    _applyState(() {
      _errors.clear();
      _fieldErrors.clear();
      for (final SimpleFormFieldConfig<dynamic> field in widget.fields) {
        final dynamic resetValue = _resolveResetValue(field.type);
        _values[field.name] = resetValue;
        _syncControllerValue(field.name, resetValue);
      }
    });

    widget.onChanged?.call(Map<String, dynamic>.from(_values));
  }

  Future<void> submit() async {
    if (_isSubmitting) {
      return;
    }

    final bool valid = validate();
    if (!valid) {
      return;
    }

    if (widget.onSubmit == null) {
      return;
    }

    if (widget.clearBackendErrorsOnSubmit) {
      clearFieldErrors();
    }

    setSubmitting(true);
    try {
      await widget.onSubmit?.call(Map<String, dynamic>.from(_values));
    } finally {
      setSubmitting(false);
    }
  }

  Widget _buildField(SimpleFormFieldConfig<dynamic> field) {
    final dynamic value = _values[field.name];
    final String? errorText = _fieldErrors[field.name] ?? _errors[field.name];
    final bool effectiveEnabled = _isFieldEnabled(field);

    switch (field.type) {
      case SimpleFormFieldType.text:
        return FormFieldWrapper(
          label: field.label,
          helperText: errorText == null ? field.helperText : null,
          required: field.required,
          child: SimpleTextField(
            controller: _controllers[field.name],
            hintText: field.hintText,
            errorText: errorText,
            keyboardType: field.keyboardType,
            obscureText: field.obscureText,
            enabled: effectiveEnabled,
            onChanged: (String text) => _updateValue(field, text),
          ),
        );
      case SimpleFormFieldType.search:
        return FormFieldWrapper(
          label: field.label,
          helperText: field.helperText,
          errorText: errorText,
          required: field.required,
          child: SimpleSearchField(
            controller: _controllers[field.name],
            hintText: field.hintText ?? 'Search',
            enabled: effectiveEnabled,
            onChanged: (String text) => _updateValue(field, text),
          ),
        );
      case SimpleFormFieldType.dropdown:
        return FormFieldWrapper(
          label: field.label,
          helperText: errorText == null ? field.helperText : null,
          required: field.required,
          child: SimpleDropdown<dynamic>(
            key: ValueKey<String>(
              '${field.name}-${value?.toString() ?? 'empty'}',
            ),
            value: value,
            items: field.items,
            hintText: field.hintText,
            errorText: errorText,
            enabled: effectiveEnabled,
            onChanged: (dynamic selected) => _updateValue(field, selected),
          ),
        );
      case SimpleFormFieldType.checkbox:
        return FormFieldWrapper(
          helperText: field.helperText,
          errorText: errorText,
          required: field.required,
          child: SimpleCheckbox(
            value: value as bool?,
            label: field.label,
            enabled: effectiveEnabled,
            onChanged: (bool? checked) => _updateValue(field, checked ?? false),
          ),
        );
      case SimpleFormFieldType.radio:
        return FormFieldWrapper(
          label: field.label,
          helperText: field.helperText,
          errorText: errorText,
          required: field.required,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int index = 0; index < (field.options?.length ?? 0); index++)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: index == (field.options!.length - 1) ? 0 : 8,
                  ),
                  child: SimpleRadio<dynamic>(
                    value: field.options![index],
                    groupValue: value,
                    onChanged: effectiveEnabled
                        ? (dynamic selected) => _updateValue(field, selected)
                        : null,
                    label: _resolveOptionLabel(field, field.options![index]),
                  ),
                ),
            ],
          ),
        );
      case SimpleFormFieldType.switchField:
        return FormFieldWrapper(
          helperText: field.helperText,
          errorText: errorText,
          required: field.required,
          child: SimpleSwitch(
            value: value as bool?,
            label: field.label,
            onChanged: effectiveEnabled
                ? (bool selected) => _updateValue(field, selected)
                : null,
          ),
        );
    }
  }

  void _syncFieldState() {
    final Set<String> nextFieldNames = widget.fields
        .map((SimpleFormFieldConfig<dynamic> field) => field.name)
        .toSet();

    final List<String> controllerKeys = _controllers.keys.toList();
    for (final String key in controllerKeys) {
      if (!nextFieldNames.contains(key)) {
        _controllers.remove(key)?.dispose();
      }
    }

    final List<String> valueKeys = _values.keys.toList();
    for (final String key in valueKeys) {
      if (!nextFieldNames.contains(key)) {
        _values.remove(key);
        _errors.remove(key);
        _fieldErrors.remove(key);
      }
    }

    for (final SimpleFormFieldConfig<dynamic> field in widget.fields) {
      final dynamic resolvedValue = _values.containsKey(field.name)
          ? _values[field.name]
          : _resolveInitialValue(field);
      _values[field.name] = resolvedValue;

      if (_usesTextController(field.type)) {
        final String textValue = (resolvedValue ?? '').toString();
        final TextEditingController controller =
            _controllers[field.name] ?? TextEditingController(text: textValue);

        if (!_controllers.containsKey(field.name)) {
          _controllers[field.name] = controller;
        } else if (controller.text != textValue) {
          controller.value = controller.value.copyWith(
            text: textValue,
            selection: TextSelection.collapsed(offset: textValue.length),
            composing: TextRange.empty,
          );
        }
      }
    }
  }

  dynamic _resolveInitialValue(SimpleFormFieldConfig<dynamic> field) {
    if (field.initialValue != null) {
      return field.initialValue;
    }
    if (widget.initialValues != null &&
        widget.initialValues!.containsKey(field.name)) {
      return widget.initialValues![field.name];
    }
    switch (field.type) {
      case SimpleFormFieldType.text:
      case SimpleFormFieldType.search:
        return '';
      case SimpleFormFieldType.checkbox:
      case SimpleFormFieldType.switchField:
        return false;
      case SimpleFormFieldType.dropdown:
      case SimpleFormFieldType.radio:
        return null;
    }
  }

  dynamic _resolveResetValue(SimpleFormFieldType type) {
    switch (type) {
      case SimpleFormFieldType.text:
      case SimpleFormFieldType.search:
        return '';
      case SimpleFormFieldType.checkbox:
      case SimpleFormFieldType.switchField:
        return false;
      case SimpleFormFieldType.dropdown:
      case SimpleFormFieldType.radio:
        return null;
    }
  }

  bool _usesTextController(SimpleFormFieldType type) {
    return type == SimpleFormFieldType.text ||
        type == SimpleFormFieldType.search;
  }

  bool get _isFormEnabled => widget.enabled;

  bool _isFieldEnabled(SimpleFormFieldConfig<dynamic> field) {
    return _isFormEnabled && !_isSubmitting && field.enabled;
  }

  SimpleFormFieldConfig<dynamic>? _findField(String name) {
    for (final SimpleFormFieldConfig<dynamic> field in widget.fields) {
      if (field.name == name) {
        return field;
      }
    }
    return null;
  }

  void _syncControllerValue(String name, dynamic value) {
    final TextEditingController? controller = _controllers[name];
    if (controller == null) {
      return;
    }

    final String textValue = (value ?? '').toString();
    if (controller.text == textValue) {
      return;
    }

    controller.value = controller.value.copyWith(
      text: textValue,
      selection: TextSelection.collapsed(offset: textValue.length),
      composing: TextRange.empty,
    );
  }

  String _resolveOptionLabel(
    SimpleFormFieldConfig<dynamic> field,
    dynamic option,
  ) {
    final String Function(dynamic value)? builder = field.optionLabelBuilder;
    if (builder != null) {
      return builder(option);
    }
    return option?.toString() ?? '';
  }

  void _updateValue(SimpleFormFieldConfig<dynamic> field, dynamic value) {
    _applyFieldValue(field, value);
  }

  void _applyFieldValue(SimpleFormFieldConfig<dynamic> field, dynamic value) {
    _applyState(() {
      _values[field.name] = value;
      _fieldErrors.remove(field.name);
      _syncControllerValue(field.name, value);
      if (_errors[field.name] != null) {
        _errors[field.name] = _validateField(field, value);
      }
    });

    field.onChanged?.call(value);
    widget.onChanged?.call(Map<String, dynamic>.from(_values));
  }

  bool _validateFields() {
    bool hasError = false;
    final Map<String, String?> nextErrors = <String, String?>{};

    for (final SimpleFormFieldConfig<dynamic> field in widget.fields) {
      final String? error = _validateField(field, _values[field.name]);
      nextErrors[field.name] = error;
      if (error != null && error.isNotEmpty) {
        hasError = true;
      }
    }

    _applyState(() {
      _errors
        ..clear()
        ..addAll(nextErrors);
    });

    return !hasError;
  }

  void _applyState(VoidCallback updates) {
    if (!mounted) {
      return;
    }
    setState(updates);
  }

  String? _validateField(SimpleFormFieldConfig<dynamic> field, dynamic value) {
    if (field.required && _isEmptyValue(field.type, value)) {
      return '${field.label ?? field.name} is required';
    }
    return field.validator?.call(value);
  }

  bool _isEmptyValue(SimpleFormFieldType type, dynamic value) {
    switch (type) {
      case SimpleFormFieldType.text:
      case SimpleFormFieldType.search:
        return value == null || value.toString().trim().isEmpty;
      case SimpleFormFieldType.dropdown:
      case SimpleFormFieldType.radio:
        return value == null;
      case SimpleFormFieldType.checkbox:
      case SimpleFormFieldType.switchField:
        return value != true;
    }
  }
}
