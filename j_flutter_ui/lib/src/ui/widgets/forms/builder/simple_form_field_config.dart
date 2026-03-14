import 'package:flutter/material.dart';

import '../validation/simple_cross_field_validator.dart';
import 'simple_form_field_type.dart';

class SimpleFormFieldConfig<T> {
  const SimpleFormFieldConfig({
    required this.name,
    required this.type,
    this.label,
    this.hintText,
    this.helperText,
    this.required = false,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.items,
    this.options,
    this.initialValue,
    this.validator,
    this.crossValidators = const <SimpleCrossFieldValidator>[],
    this.onChanged,
    this.optionLabelBuilder,
  });

  factory SimpleFormFieldConfig.text({
    required String name,
    String? label,
    String? hintText,
    String? helperText,
    bool required = false,
    bool enabled = true,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? initialValue,
    String? Function(dynamic value)? validator,
    List<SimpleCrossFieldValidator> crossValidators =
        const <SimpleCrossFieldValidator>[],
    ValueChanged<String?>? onChanged,
  }) {
    return SimpleFormFieldConfig<String>(
          name: name,
          type: SimpleFormFieldType.text,
          label: label,
          hintText: hintText,
          helperText: helperText,
          required: required,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          initialValue: initialValue,
          validator: validator,
          crossValidators: crossValidators,
          onChanged: onChanged,
        )
        as SimpleFormFieldConfig<T>;
  }

  factory SimpleFormFieldConfig.search({
    required String name,
    String? label,
    String? hintText,
    String? helperText,
    bool required = false,
    bool enabled = true,
    String? initialValue,
    String? Function(dynamic value)? validator,
    List<SimpleCrossFieldValidator> crossValidators =
        const <SimpleCrossFieldValidator>[],
    ValueChanged<String?>? onChanged,
  }) {
    return SimpleFormFieldConfig<String>(
          name: name,
          type: SimpleFormFieldType.search,
          label: label,
          hintText: hintText,
          helperText: helperText,
          required: required,
          enabled: enabled,
          initialValue: initialValue,
          validator: validator,
          crossValidators: crossValidators,
          onChanged: onChanged,
        )
        as SimpleFormFieldConfig<T>;
  }

  factory SimpleFormFieldConfig.dropdown({
    required String name,
    String? label,
    String? hintText,
    String? helperText,
    bool required = false,
    bool enabled = true,
    List<DropdownMenuItem<T>>? items,
    T? initialValue,
    String? Function(dynamic value)? validator,
    List<SimpleCrossFieldValidator> crossValidators =
        const <SimpleCrossFieldValidator>[],
    ValueChanged<T?>? onChanged,
  }) {
    return SimpleFormFieldConfig<T>(
      name: name,
      type: SimpleFormFieldType.dropdown,
      label: label,
      hintText: hintText,
      helperText: helperText,
      required: required,
      enabled: enabled,
      items: items,
      initialValue: initialValue,
      validator: validator,
      crossValidators: crossValidators,
      onChanged: onChanged,
    );
  }

  factory SimpleFormFieldConfig.checkbox({
    required String name,
    String? label,
    String? hintText,
    String? helperText,
    bool required = false,
    bool enabled = true,
    bool? initialValue,
    String? Function(dynamic value)? validator,
    List<SimpleCrossFieldValidator> crossValidators =
        const <SimpleCrossFieldValidator>[],
    ValueChanged<bool?>? onChanged,
  }) {
    return SimpleFormFieldConfig<bool>(
          name: name,
          type: SimpleFormFieldType.checkbox,
          label: label,
          hintText: hintText,
          helperText: helperText,
          required: required,
          enabled: enabled,
          initialValue: initialValue,
          validator: validator,
          crossValidators: crossValidators,
          onChanged: onChanged,
        )
        as SimpleFormFieldConfig<T>;
  }

  factory SimpleFormFieldConfig.radio({
    required String name,
    String? label,
    String? hintText,
    String? helperText,
    bool required = false,
    bool enabled = true,
    required List<T> options,
    T? initialValue,
    String? Function(dynamic value)? validator,
    List<SimpleCrossFieldValidator> crossValidators =
        const <SimpleCrossFieldValidator>[],
    ValueChanged<T?>? onChanged,
    String Function(T value)? optionLabelBuilder,
  }) {
    return SimpleFormFieldConfig<T>(
      name: name,
      type: SimpleFormFieldType.radio,
      label: label,
      hintText: hintText,
      helperText: helperText,
      required: required,
      enabled: enabled,
      options: options,
      initialValue: initialValue,
      validator: validator,
      crossValidators: crossValidators,
      onChanged: onChanged,
      optionLabelBuilder: optionLabelBuilder,
    );
  }

  factory SimpleFormFieldConfig.switchField({
    required String name,
    String? label,
    String? hintText,
    String? helperText,
    bool required = false,
    bool enabled = true,
    bool? initialValue,
    String? Function(dynamic value)? validator,
    List<SimpleCrossFieldValidator> crossValidators =
        const <SimpleCrossFieldValidator>[],
    ValueChanged<bool?>? onChanged,
  }) {
    return SimpleFormFieldConfig<bool>(
          name: name,
          type: SimpleFormFieldType.switchField,
          label: label,
          hintText: hintText,
          helperText: helperText,
          required: required,
          enabled: enabled,
          initialValue: initialValue,
          validator: validator,
          crossValidators: crossValidators,
          onChanged: onChanged,
        )
        as SimpleFormFieldConfig<T>;
  }

  final String name;
  final SimpleFormFieldType type;
  final String? label;
  final String? hintText;
  final String? helperText;
  final bool required;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<DropdownMenuItem<T>>? items;
  final List<T>? options;
  final T? initialValue;
  final String? Function(dynamic value)? validator;
  final List<SimpleCrossFieldValidator> crossValidators;
  final ValueChanged<T?>? onChanged;
  final String Function(T value)? optionLabelBuilder;
}
