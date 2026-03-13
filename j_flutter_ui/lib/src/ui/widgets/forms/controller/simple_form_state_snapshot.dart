class SimpleFormStateSnapshot {
  SimpleFormStateSnapshot({
    required Map<String, dynamic> values,
    Map<String, dynamic>? initialValues,
  }) : _values = Map<String, dynamic>.unmodifiable(
         Map<String, dynamic>.from(values),
       ),
       _initialValues = initialValues == null
           ? null
           : Map<String, dynamic>.unmodifiable(
               Map<String, dynamic>.from(initialValues),
             );

  final Map<String, dynamic> _values;
  final Map<String, dynamic>? _initialValues;

  Map<String, dynamic> get values => Map<String, dynamic>.from(_values);

  Map<String, dynamic>? get initialValues =>
      _initialValues == null ? null : Map<String, dynamic>.from(_initialValues);
}
