class SimpleFormStateSnapshot {
  SimpleFormStateSnapshot({
    required Map<String, dynamic> values,
    required Map<String, String?> errors,
    Map<String, dynamic>? initialValues,
  }) : _values = Map<String, dynamic>.unmodifiable(
         Map<String, dynamic>.from(values),
       ),
       _errors = Map<String, String?>.unmodifiable(
         Map<String, String?>.from(errors),
       ),
       _initialValues = initialValues == null
           ? null
           : Map<String, dynamic>.unmodifiable(
               Map<String, dynamic>.from(initialValues),
             );

  final Map<String, dynamic> _values;
  final Map<String, String?> _errors;
  final Map<String, dynamic>? _initialValues;

  Map<String, dynamic> get values => Map<String, dynamic>.from(_values);

  Map<String, String?> get errors => Map<String, String?>.from(_errors);

  Map<String, dynamic>? get initialValues =>
      _initialValues == null ? null : Map<String, dynamic>.from(_initialValues);
}
