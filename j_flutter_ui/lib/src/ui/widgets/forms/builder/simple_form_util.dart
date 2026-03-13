import 'package:flutter/material.dart';

import 'simple_form_builder.dart';

/// Escape hatch for rare key-based access to builder-only state.
/// Normal consumers should prefer `SimpleFormController`.
class SimpleFormUtil {
  const SimpleFormUtil._();

  static void setSubmitting(
    GlobalKey<SimpleFormBuilderState> formKey,
    bool value,
  ) {
    formKey.currentState?.setSubmitting(value);
  }

  static bool isSubmitting(GlobalKey<SimpleFormBuilderState> formKey) {
    return formKey.currentState?.isSubmitting ?? false;
  }
}
