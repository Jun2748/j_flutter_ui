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
  });

  final List<SimpleFormFieldConfig<dynamic>> fields;
  final Map<String, dynamic>? initialValues;
  final ValueChanged<Map<String, dynamic>>? onChanged;
  final ValueChanged<Map<String, dynamic>>? onSubmit;
  final EdgeInsets? padding;
  final double fieldSpacing;
  final bool showSubmitButton;
  final String submitLabel;

  @override
  State<SimpleFormBuilder> createState() => _SimpleFormBuilderState();
}

class _SimpleFormBuilderState extends State<SimpleFormBuilder> {
  final Map<String, dynamic> _values = <String, dynamic>{};
  final Map<String, String?> _errors = <String, String?>{};
  final Map<String, TextEditingController> _controllers =
      <String, TextEditingController>{};

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
          onPressed: _handleSubmit,
        ),
      );
    }

    return SimpleForm(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildField(SimpleFormFieldConfig<dynamic> field) {
    final dynamic value = _values[field.name];
    final String? errorText = _errors[field.name];

    switch (field.type) {
      case SimpleFormFieldType.text:
        return FormFieldWrapper(
          label: field.label,
          helperText: field.helperText,
          errorText: errorText,
          required: field.required,
          child: SimpleTextField(
            controller: _controllers[field.name],
            hintText: field.hintText,
            keyboardType: field.keyboardType,
            obscureText: field.obscureText,
            enabled: field.enabled,
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
            enabled: field.enabled,
            onChanged: (String text) => _updateValue(field, text),
          ),
        );
      case SimpleFormFieldType.dropdown:
        return FormFieldWrapper(
          label: field.label,
          helperText: field.helperText,
          errorText: errorText,
          required: field.required,
          child: SimpleDropdown<dynamic>(
            key: ValueKey<String>(
              '${field.name}-${value?.toString() ?? 'empty'}',
            ),
            value: value,
            items: field.items,
            hintText: field.hintText,
            enabled: field.enabled,
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
            enabled: field.enabled,
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
                    onChanged: field.enabled
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
            onChanged: field.enabled
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

  bool _usesTextController(SimpleFormFieldType type) {
    return type == SimpleFormFieldType.text ||
        type == SimpleFormFieldType.search;
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
    setState(() {
      _values[field.name] = value;
      if (_errors[field.name] != null) {
        _errors[field.name] = _validateField(field, value);
      }
    });

    field.onChanged?.call(value);
    widget.onChanged?.call(Map<String, dynamic>.from(_values));
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

  void _handleSubmit() {
    final Map<String, String?> nextErrors = <String, String?>{};
    bool hasError = false;

    for (final SimpleFormFieldConfig<dynamic> field in widget.fields) {
      final String? error = _validateField(field, _values[field.name]);
      nextErrors[field.name] = error;
      if (error != null && error.isNotEmpty) {
        hasError = true;
      }
    }

    setState(() {
      _errors
        ..clear()
        ..addAll(nextErrors);
    });

    if (!hasError) {
      widget.onSubmit?.call(Map<String, dynamic>.from(_values));
    }
  }
}
