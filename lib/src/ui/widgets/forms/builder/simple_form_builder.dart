import 'dart:async';

import 'package:flutter/material.dart';

import '../../../localization/intl.dart';
import '../../../localization/l.dart';
import '../../../resources/dimens.dart';
import '../../controls/buttons/simple_button.dart';
import '../../controls/dropdown/simple_dropdown.dart';
import '../../controls/inputs/simple_checkbox.dart';
import '../../controls/inputs/simple_radio.dart';
import '../../controls/inputs/simple_search_field.dart';
import '../../controls/inputs/simple_switch.dart';
import '../../controls/inputs/simple_text_field.dart';
import '../controller/simple_form_controller.dart';
import '../form_field_wrapper.dart';
import '../simple_form.dart';
import '../validation/simple_cross_field_validator.dart';
import '../validation/simple_form_validator.dart';
import '../validation/simple_validation_messages.dart';
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
    this.fieldSpacing = JDimens.dp16,
    this.showSubmitButton = false,
    this.submitLabel = '',
    this.clearBackendErrorsOnSubmit = true,
    this.enabled = true,
    this.controller,
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
  final SimpleFormController? controller;

  @override
  State<SimpleFormBuilder> createState() => SimpleFormBuilderState();
}

class SimpleFormBuilderState extends State<SimpleFormBuilder>
    implements SimpleFormControllerHost {
  final GlobalKey<FormState> _internalFormKey = GlobalKey<FormState>();
  final Map<String, dynamic> _values = <String, dynamic>{};
  final Map<String, String?> _errors = <String, String?>{};
  final Map<String, String?> _fieldErrors = <String, String?>{};
  final Map<String, GlobalKey> _fieldKeys = <String, GlobalKey>{};
  final Map<String, TextEditingController> _controllers =
      <String, TextEditingController>{};
  final Map<String, FocusNode> _focusNodes = <String, FocusNode>{};
  bool _isSubmitting = false;
  bool _isSyncingFromController = false;
  bool _isSyncingToController = false;

  bool get isSubmitting => _isSubmitting;

  @override
  void initState() {
    super.initState();
    _bindController(widget.controller);
    _syncFieldState();
    _syncErrorStateFromController();
  }

  @override
  void didUpdateWidget(SimpleFormBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _unbindController(oldWidget.controller);
      _bindController(widget.controller);
      _values.clear();
      _fieldErrors.clear();
    }
    _syncFieldState();
    _syncErrorStateFromController();
  }

  @override
  void dispose() {
    _unbindController(widget.controller);
    for (final TextEditingController controller in _controllers.values) {
      controller.dispose();
    }
    for (final FocusNode focusNode in _focusNodes.values) {
      focusNode.dispose();
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
    final String resolvedSubmitLabel = _resolveSubmitLabel();

    if (widget.showSubmitButton && widget.onSubmit != null) {
      if (children.isNotEmpty) {
        children.add(SizedBox(height: widget.fieldSpacing));
      }
      children.add(
        SimpleButton.primary(
          label: resolvedSubmitLabel,
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
    _syncCurrentTextValuesFromControllers(fieldNames: <String>[name]);
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
    _syncCurrentTextValuesFromControllers();
    return Map<String, dynamic>.from(_values);
  }

  @override
  bool validate() {
    _syncCurrentTextValuesFromControllers(syncController: true);
    final bool formValid = _internalFormKey.currentState?.validate() ?? true;
    final Map<String, String?> validationErrors = _collectValidationErrors();
    _applyValidationErrors(validationErrors);
    return formValid && !_hasValidationErrors(validationErrors);
  }

  @override
  Future<void> scrollToField(String fieldName) {
    final Completer<void> completer = Completer<void>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) {
        completer.complete();
        return;
      }

      final BuildContext? fieldContext = _fieldKeys[fieldName]?.currentContext;
      if (fieldContext == null) {
        completer.complete();
        return;
      }

      try {
        await Scrollable.ensureVisible(
          fieldContext,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
      } finally {
        if (!completer.isCompleted) {
          completer.complete();
        }
      }
    });

    return completer.future;
  }

  @override
  Future<void> focusField(String fieldName) {
    final Completer<void> completer = Completer<void>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        completer.complete();
        return;
      }

      final FocusNode? focusNode = _focusNodes[fieldName];
      if (focusNode == null || !focusNode.canRequestFocus) {
        completer.complete();
        return;
      }

      focusNode.requestFocus();
      completer.complete();
    });

    return completer.future;
  }

  @override
  Future<bool> validateAndScrollToFirstError() async {
    _syncCurrentTextValuesFromControllers(syncController: true);
    final bool formValid = _internalFormKey.currentState?.validate() ?? true;
    final Map<String, String?> validationErrors = _collectValidationErrors();
    _applyValidationErrors(validationErrors);
    final bool valid = formValid && !_hasValidationErrors(validationErrors);
    if (valid) {
      return true;
    }

    final String? firstInvalidFieldName = _findFirstInvalidFieldName(
      validationErrors,
    );
    if (firstInvalidFieldName == null) {
      return false;
    }

    await scrollToField(firstInvalidFieldName);
    await focusField(firstInvalidFieldName);
    return false;
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

    final bool changed = _setBackendErrorLocally(name, error);
    if (!changed) {
      return;
    }

    _syncControllerErrorsFromBuilder(fieldNames: <String>[name]);
  }

  void setFieldErrors(Map<String, String> errors) {
    bool changed = false;

    _applyState(() {
      for (final MapEntry<String, String> entry in errors.entries) {
        if (_findField(entry.key) == null) {
          continue;
        }

        final String? normalizedError = _normalizeError(entry.value);
        if (normalizedError == null) {
          if (_fieldErrors.remove(entry.key) != null) {
            changed = true;
          }
          continue;
        }

        if (_fieldErrors[entry.key] != normalizedError) {
          _fieldErrors[entry.key] = normalizedError;
          changed = true;
        }
      }
    });

    if (changed) {
      _syncControllerErrorsFromBuilder(fieldNames: errors.keys.toList());
    }
  }

  void clearFieldError(String name) {
    bool changed = false;

    _applyState(() {
      changed = _fieldErrors.remove(name) != null;
    });

    if (changed) {
      _syncControllerErrorsFromBuilder(fieldNames: <String>[name]);
    }
  }

  void clearFieldErrors() {
    if (_fieldErrors.isEmpty) {
      return;
    }

    _applyState(() {
      _fieldErrors.clear();
    });
    _syncControllerErrorsFromBuilder(clearAll: true);
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
    final List<String> fieldNames = widget.fields
        .map((SimpleFormFieldConfig<dynamic> field) => field.name)
        .toList();

    _applyState(() {
      _errors.clear();
      _fieldErrors.clear();
      for (final SimpleFormFieldConfig<dynamic> field in widget.fields) {
        _values[field.name] = null;
        _syncControllerValue(field.name, null);
      }
    });

    // `reset()` intentionally clears the form to a blank/null state.
    _syncControllerFromBuilder(fieldNames: fieldNames);
    _syncControllerErrorsFromBuilder(clearAll: true);
    widget.onChanged?.call(Map<String, dynamic>.from(_values));
  }

  @override
  Future<void> submit() async {
    if (_isSubmitting) {
      return;
    }

    final bool valid = await validateAndScrollToFirstError();
    if (!valid) {
      return;
    }

    if (widget.onSubmit == null) {
      return;
    }

    if (widget.clearBackendErrorsOnSubmit) {
      clearFieldErrors();
    }

    _syncCurrentTextValuesFromControllers(syncController: true);
    final Map<String, dynamic> submitValues = getValues();

    setSubmitting(true);
    try {
      await widget.onSubmit?.call(submitValues);
    } finally {
      setSubmitting(false);
    }
  }

  Widget _buildField(SimpleFormFieldConfig<dynamic> field) {
    final dynamic value = _values[field.name];
    final String? errorText = _fieldErrors[field.name] ?? _errors[field.name];
    final bool effectiveEnabled = _isFieldEnabled(field);
    final FocusNode? focusNode = _focusNodes[field.name];

    Widget child;

    switch (field.type) {
      case SimpleFormFieldType.text:
        child = FormFieldWrapper(
          label: field.label,
          labelWidget: field.labelWidget,
          helperText: errorText == null ? field.helperText : null,
          helper: errorText == null ? field.helper : null,
          required: field.required,
          child: SimpleTextField(
            controller: _controllers[field.name],
            focusNode: focusNode,
            hintText: field.hintText,
            errorText: errorText,
            prefix: field.prefix,
            suffix: field.suffix,
            prefixIcon: field.prefixIcon,
            suffixIcon: field.suffixIcon,
            keyboardType: field.keyboardType,
            textInputAction: field.textInputAction,
            autofillHints: field.autofillHints,
            obscureText: field.obscureText,
            enabled: effectiveEnabled,
            onChanged: (String text) => _updateValue(field, text),
            onFieldSubmitted: field.onFieldSubmitted,
          ),
        );
        break;
      case SimpleFormFieldType.search:
        child = FormFieldWrapper(
          label: field.label,
          labelWidget: field.labelWidget,
          helperText: field.helperText,
          helper: field.helper,
          errorText: errorText,
          required: field.required,
          child: SimpleSearchField(
            controller: _controllers[field.name],
            focusNode: focusNode,
            hintText: field.hintText,
            enabled: effectiveEnabled,
            onChanged: (String text) => _updateValue(field, text),
          ),
        );
        break;
      case SimpleFormFieldType.dropdown:
        child = FormFieldWrapper(
          label: field.label,
          labelWidget: field.labelWidget,
          helperText: errorText == null ? field.helperText : null,
          helper: errorText == null ? field.helper : null,
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
        break;
      case SimpleFormFieldType.checkbox:
        child = FormFieldWrapper(
          helperText: field.helperText,
          helper: field.helper,
          errorText: errorText,
          required: field.required,
          child: SimpleCheckbox(
            value: value as bool?,
            label: field.label,
            labelWidget: field.labelWidget,
            onChanged: effectiveEnabled
                ? (bool? checked) => _updateValue(field, checked ?? false)
                : null,
          ),
        );
        break;
      case SimpleFormFieldType.radio:
        child = FormFieldWrapper(
          label: field.label,
          labelWidget: field.labelWidget,
          helperText: field.helperText,
          helper: field.helper,
          errorText: errorText,
          required: field.required,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int index = 0; index < (field.options?.length ?? 0); index++)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: index == (field.options!.length - 1)
                        ? JDimens.dp0
                        : JDimens.dp8,
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
        break;
      case SimpleFormFieldType.switchField:
        child = FormFieldWrapper(
          helperText: field.helperText,
          helper: field.helper,
          errorText: errorText,
          required: field.required,
          child: SimpleSwitch(
            value: value as bool?,
            label: field.label,
            labelWidget: field.labelWidget,
            onChanged: effectiveEnabled
                ? (bool selected) => _updateValue(field, selected)
                : null,
          ),
        );
        break;
    }

    return Container(key: _fieldKeys[field.name], child: child);
  }

  void _syncFieldState() {
    final Set<String> nextFieldNames = widget.fields
        .map((SimpleFormFieldConfig<dynamic> field) => field.name)
        .toSet();

    final List<String> fieldKeyNames = _fieldKeys.keys.toList();
    for (final String key in fieldKeyNames) {
      if (!nextFieldNames.contains(key)) {
        _fieldKeys.remove(key);
      }
    }

    final List<String> controllerKeys = _controllers.keys.toList();
    for (final String key in controllerKeys) {
      if (!nextFieldNames.contains(key)) {
        _controllers.remove(key)?.dispose();
      }
    }

    final List<String> focusNodeKeys = _focusNodes.keys.toList();
    for (final String key in focusNodeKeys) {
      if (!nextFieldNames.contains(key) ||
          !_supportsFocus(_findFieldType(key))) {
        _focusNodes.remove(key)?.dispose();
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
      _fieldKeys.putIfAbsent(field.name, GlobalKey.new);
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

      if (_supportsFocus(field.type)) {
        _focusNodes.putIfAbsent(field.name, FocusNode.new);
      }
    }
  }

  dynamic _resolveInitialValue(SimpleFormFieldConfig<dynamic> field) {
    if (field.initialValue != null) {
      return field.initialValue;
    }
    final Map<String, dynamic>? controllerValues = widget.controller?.values;
    if (controllerValues != null && controllerValues.containsKey(field.name)) {
      return controllerValues[field.name];
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

  /// Default value for a field type when the external controller
  /// does not provide one (e.g. text → '', checkbox → false).
  dynamic _defaultValueForType(SimpleFormFieldType type) {
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

  bool _supportsFocus(SimpleFormFieldType? type) {
    return type == SimpleFormFieldType.text ||
        type == SimpleFormFieldType.search;
  }

  SimpleFormFieldType? _findFieldType(String name) {
    return _findField(name)?.type;
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

  void _syncCurrentTextValuesFromControllers({
    List<String>? fieldNames,
    bool syncController = false,
  }) {
    final Iterable<SimpleFormFieldConfig<dynamic>> fieldsToSync =
        fieldNames == null
        ? widget.fields
        : widget.fields.where(
            (SimpleFormFieldConfig<dynamic> field) =>
                fieldNames.contains(field.name),
          );

    final List<String> changedFieldNames = <String>[];

    for (final SimpleFormFieldConfig<dynamic> field in fieldsToSync) {
      if (!_usesTextController(field.type)) {
        continue;
      }

      final TextEditingController? controller = _controllers[field.name];
      if (controller == null) {
        continue;
      }

      final String currentTextValue = controller.text;
      final dynamic currentValue = _values[field.name];
      if (currentValue == null && currentTextValue.isEmpty) {
        continue;
      }

      if (currentValue == currentTextValue) {
        continue;
      }

      _values[field.name] = currentTextValue;
      changedFieldNames.add(field.name);
    }

    if (syncController && changedFieldNames.isNotEmpty) {
      _syncControllerFromBuilder(fieldNames: changedFieldNames);
    }
  }

  void _applyFieldValue(SimpleFormFieldConfig<dynamic> field, dynamic value) {
    bool backendErrorCleared = false;

    _applyState(() {
      _values[field.name] = value;
      backendErrorCleared = _fieldErrors.remove(field.name) != null;
      _syncControllerValue(field.name, value);
      if (_errors[field.name] != null) {
        _errors[field.name] = _validateField(field, value);
      }
      _revalidateCrossValidatorFields();
    });

    _syncControllerFromBuilder(fieldNames: <String>[field.name]);
    if (backendErrorCleared) {
      _syncControllerErrorsFromBuilder(fieldNames: <String>[field.name]);
    }
    field.onChanged?.call(value);
    widget.onChanged?.call(Map<String, dynamic>.from(_values));
  }

  Map<String, String?> _collectValidationErrors() {
    final Map<String, String?> nextErrors = <String, String?>{};
    for (final SimpleFormFieldConfig<dynamic> field in widget.fields) {
      nextErrors[field.name] = _validateField(field, _values[field.name]);
    }

    return nextErrors;
  }

  void _applyValidationErrors(Map<String, String?> validationErrors) {
    _applyState(() {
      _errors
        ..clear()
        ..addAll(validationErrors);
    });
  }

  bool _hasValidationErrors(Map<String, String?> validationErrors) {
    return validationErrors.values.any(
      (String? error) => error != null && error.isNotEmpty,
    );
  }

  String? _findFirstInvalidFieldName(Map<String, String?> validationErrors) {
    for (final SimpleFormFieldConfig<dynamic> field in widget.fields) {
      final String? error = validationErrors[field.name];
      if (error != null && error.isNotEmpty) {
        return field.name;
      }
    }
    return null;
  }

  void _applyState(VoidCallback updates) {
    if (!mounted) {
      return;
    }
    setState(updates);
  }

  String? _validateField(SimpleFormFieldConfig<dynamic> field, dynamic value) {
    final List<SimpleValidator> validators = <SimpleValidator>[
      if (field.required) _requiredValidator(field),
      if (field.validator != null)
        (dynamic nextValue) => field.validator?.call(nextValue),
    ];

    final String? singleFieldError = validators.isEmpty
        ? null
        : SimpleFormValidator.combine(validators)(value);
    if (singleFieldError != null && singleFieldError.isNotEmpty) {
      return singleFieldError;
    }

    if (field.crossValidators.isEmpty) {
      return null;
    }

    return SimpleCrossFieldValidators.combine(field.crossValidators)(
      value,
      Map<String, dynamic>.from(_values),
    );
  }

  void _revalidateCrossValidatorFields() {
    for (final SimpleFormFieldConfig<dynamic> field in widget.fields) {
      if (field.crossValidators.isEmpty) {
        continue;
      }

      _errors[field.name] = _validateField(field, _values[field.name]);
    }
  }

  SimpleValidator _requiredValidator(SimpleFormFieldConfig<dynamic> field) {
    final String message = _requiredMessage(field);

    switch (field.type) {
      case SimpleFormFieldType.text:
      case SimpleFormFieldType.search:
        return SimpleFormValidator.required(message: message);
      case SimpleFormFieldType.dropdown:
      case SimpleFormFieldType.radio:
        return (dynamic value) => value == null ? message : null;
      case SimpleFormFieldType.checkbox:
      case SimpleFormFieldType.switchField:
        return (dynamic value) => value == true ? null : message;
    }
  }

  String _requiredMessage(SimpleFormFieldConfig<dynamic> field) {
    final String label = (field.label ?? field.name).trim();
    if (label.isEmpty) {
      return SimpleValidationMessages.requiredText(context: context);
    }
    return SimpleValidationMessages.requiredField(label, context: context);
  }

  String _resolveSubmitLabel() {
    final String customLabel = widget.submitLabel.trim();
    if (customLabel.isNotEmpty) {
      return customLabel;
    }

    return _localizedText(L.formSubmit, fallback: 'Submit');
  }

  String _localizedText(
    String key, {
    required String fallback,
    Map<String, String>? args,
  }) {
    final String localized = Intl.text(key, context: context, args: args);
    if (localized.isEmpty || localized == key) {
      return fallback;
    }
    return localized;
  }

  String? _normalizeError(String? error) {
    if (error == null || error.trim().isEmpty) {
      return null;
    }
    return error;
  }

  bool _setBackendErrorLocally(String name, String? error) {
    final String? normalizedError = _normalizeError(error);
    bool changed = false;

    _applyState(() {
      if (normalizedError == null) {
        changed = _fieldErrors.remove(name) != null;
      } else if (_fieldErrors[name] != normalizedError) {
        _fieldErrors[name] = normalizedError;
        changed = true;
      }
    });

    return changed;
  }

  void _bindController(SimpleFormController? controller) {
    controller?.attachHost(this);
    controller?.addListener(_handleControllerChanged);
  }

  void _unbindController(SimpleFormController? controller) {
    controller?.removeListener(_handleControllerChanged);
    controller?.detachHost(this);
  }

  void _handleControllerChanged() {
    if (_isSyncingToController) {
      return;
    }

    final SimpleFormController? controller = widget.controller;
    if (controller == null) {
      return;
    }

    final Map<String, dynamic> controllerValues = controller.values;
    bool valuesChanged = false;

    _isSyncingFromController = true;
    _applyState(() {
      for (final SimpleFormFieldConfig<dynamic> field in widget.fields) {
        final dynamic controllerValue = controllerValues.containsKey(field.name)
            ? controllerValues[field.name]
            : _defaultValueForType(field.type);
        if (_values[field.name] == controllerValue) {
          continue;
        }

        _values[field.name] = controllerValue;
        _syncControllerValue(field.name, controllerValue);
        valuesChanged = true;
      }

      _revalidateCrossValidatorFields();
      _syncErrorStateFromControllerInsideSetState(controller);
    });
    _isSyncingFromController = false;

    if (valuesChanged) {
      widget.onChanged?.call(Map<String, dynamic>.from(_values));
    }
  }

  void _syncControllerFromBuilder({List<String>? fieldNames}) {
    final SimpleFormController? controller = widget.controller;
    if (controller == null || _isSyncingFromController) {
      return;
    }

    final Map<String, dynamic> controllerValues = controller.values;
    final Iterable<String> names =
        fieldNames ??
        widget.fields.map((SimpleFormFieldConfig<dynamic> field) => field.name);
    final Map<String, dynamic> nextValues = <String, dynamic>{};

    for (final String name in names) {
      if (!_values.containsKey(name)) {
        continue;
      }

      final bool hasControllerValue = controllerValues.containsKey(name);
      final dynamic currentValue = _values[name];
      if (!hasControllerValue || controllerValues[name] != currentValue) {
        nextValues[name] = currentValue;
      }
    }

    if (nextValues.isEmpty) {
      return;
    }

    _isSyncingToController = true;
    controller.patchValues(nextValues);
    _isSyncingToController = false;
  }

  void _syncErrorStateFromController() {
    final SimpleFormController? controller = widget.controller;
    if (controller == null) {
      return;
    }

    _applyState(() {
      _syncErrorStateFromControllerInsideSetState(controller);
    });
  }

  void _syncErrorStateFromControllerInsideSetState(
    SimpleFormController controller,
  ) {
    final Map<String, String?> controllerErrors = controller.errors;

    final List<String> errorKeys = _fieldErrors.keys.toList();
    for (final String key in errorKeys) {
      if (!controllerErrors.containsKey(key)) {
        _fieldErrors.remove(key);
      }
    }

    for (final SimpleFormFieldConfig<dynamic> field in widget.fields) {
      final String fieldName = field.name;
      final String? controllerError = controllerErrors[fieldName];
      if (controllerError == null) {
        _fieldErrors.remove(fieldName);
        continue;
      }
      _fieldErrors[fieldName] = controllerError;
    }
  }

  void _syncControllerErrorsFromBuilder({
    List<String>? fieldNames,
    bool clearAll = false,
  }) {
    final SimpleFormController? controller = widget.controller;
    if (controller == null || _isSyncingFromController) {
      return;
    }

    _isSyncingToController = true;
    if (clearAll) {
      controller.clearErrors();
    } else if (fieldNames != null) {
      for (final String name in fieldNames) {
        final String? error = _fieldErrors[name];
        if (error == null) {
          controller.clearError(name);
        } else {
          controller.setError(name, error);
        }
      }
    }
    _isSyncingToController = false;
  }
}
