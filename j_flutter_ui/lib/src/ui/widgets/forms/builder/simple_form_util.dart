import 'package:flutter/material.dart';

import 'simple_form_builder.dart';

class SimpleFormUtil {
  const SimpleFormUtil._();

  static dynamic getValue(
    GlobalKey<SimpleFormBuilderState> formKey,
    String fieldName,
  ) {
    return formKey.currentState?.getFieldValue(fieldName);
  }

  static void setValue(
    GlobalKey<SimpleFormBuilderState> formKey,
    String fieldName,
    dynamic value,
  ) {
    formKey.currentState?.setFieldValue(fieldName, value);
  }

  static Map<String, dynamic> getValues(
    GlobalKey<SimpleFormBuilderState> formKey,
  ) {
    return formKey.currentState?.getValues() ?? <String, dynamic>{};
  }

  static bool validate(GlobalKey<SimpleFormBuilderState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  static bool isValid(GlobalKey<SimpleFormBuilderState> formKey) {
    return formKey.currentState?.isValid() ?? false;
  }

  static void setError(
    GlobalKey<SimpleFormBuilderState> formKey,
    String fieldName,
    String error,
  ) {
    formKey.currentState?.setFieldError(fieldName, error);
  }

  static void setErrors(
    GlobalKey<SimpleFormBuilderState> formKey,
    Map<String, String> errors,
  ) {
    formKey.currentState?.setFieldErrors(errors);
  }

  static String? getError(
    GlobalKey<SimpleFormBuilderState> formKey,
    String fieldName,
  ) {
    return formKey.currentState?.getFieldError(fieldName);
  }

  static Map<String, String?> getErrors(
    GlobalKey<SimpleFormBuilderState> formKey,
  ) {
    return formKey.currentState?.getFieldErrors() ?? <String, String?>{};
  }

  static void clearError(
    GlobalKey<SimpleFormBuilderState> formKey,
    String fieldName,
  ) {
    formKey.currentState?.clearFieldError(fieldName);
  }

  static void clearErrors(GlobalKey<SimpleFormBuilderState> formKey) {
    formKey.currentState?.clearFieldErrors();
  }

  static Future<void> submit(GlobalKey<SimpleFormBuilderState> formKey) async {
    await formKey.currentState?.submit();
  }

  static void setSubmitting(
    GlobalKey<SimpleFormBuilderState> formKey,
    bool value,
  ) {
    formKey.currentState?.setSubmitting(value);
  }

  static bool isSubmitting(GlobalKey<SimpleFormBuilderState> formKey) {
    return formKey.currentState?.isSubmitting ?? false;
  }

  static void reset(GlobalKey<SimpleFormBuilderState> formKey) {
    formKey.currentState?.reset();
  }
}
