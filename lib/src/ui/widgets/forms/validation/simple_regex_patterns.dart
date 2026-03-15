class SimpleRegexPatterns {
  SimpleRegexPatterns._();

  static final RegExp email = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );

  static final RegExp numbersOnly = RegExp(r'^\d+$');

  static final RegExp alphanumeric = RegExp(r'^[A-Za-z0-9]+$');

  static final RegExp phone = RegExp(r'^\+?[0-9\s().-]+$');
}
