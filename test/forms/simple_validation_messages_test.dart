import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SimpleValidationMessages', () {
    test('localized defaults resolve with safe interpolation', () async {
      await AppLocalizations.load(const Locale('en'));

      expect(SimpleValidationMessages.required, 'This field is required');
      expect(
        SimpleValidationMessages.requiredField('Email'),
        'Email is required',
      );
      expect(
        SimpleValidationMessages.invalidEmail,
        'Please enter a valid email address',
      );
      expect(
        SimpleValidationMessages.invalidPhone,
        'Please enter a valid phone number',
      );
      expect(
        SimpleValidationMessages.invalidFormat,
        'Please enter a valid value',
      );
      expect(
        SimpleValidationMessages.minLength(8),
        'Must be at least 8 characters',
      );
      expect(
        SimpleValidationMessages.maxLength(16),
        'Must be at most 16 characters',
      );
    });
  });
}
