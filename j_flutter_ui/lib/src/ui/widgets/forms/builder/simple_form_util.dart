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

  static void reset(GlobalKey<SimpleFormBuilderState> formKey) {
    formKey.currentState?.reset();
  }
}
