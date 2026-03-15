import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('SimpleFormController', () {
    test('setValue updates one field', () {
      final SimpleFormController controller = SimpleFormController(
        initialValues: <String, dynamic>{'name': 'Jun'},
      );

      controller.setValue('name', 'Taylor');

      expect(controller.getValue('name'), 'Taylor');
    });

    test('setValues updates multiple fields', () {
      final SimpleFormController controller = SimpleFormController(
        initialValues: <String, dynamic>{
          'name': 'Jun',
          'email': 'jun@example.com',
        },
      );

      controller.setValues(<String, dynamic>{
        'name': 'Taylor',
        'email': 'taylor@example.com',
      });

      expect(controller.values, <String, dynamic>{
        'name': 'Taylor',
        'email': 'taylor@example.com',
      });
    });

    test('patchValues updates only provided keys', () {
      final SimpleFormController controller = SimpleFormController(
        initialValues: <String, dynamic>{
          'name': 'Jun',
          'email': 'jun@example.com',
        },
      );

      controller.patchValues(<String, dynamic>{'email': 'updated@example.com'});

      expect(controller.values['name'], 'Jun');
      expect(controller.values['email'], 'updated@example.com');
    });

    test('resetToInitialValues restores original values', () {
      final SimpleFormController controller = SimpleFormController(
        initialValues: <String, dynamic>{
          'name': 'Jun',
          'email': 'jun@example.com',
        },
      );

      controller.setValue('name', 'Taylor');
      controller.setError('email', 'Email already exists');
      controller.resetToInitialValues();

      expect(controller.values, <String, dynamic>{
        'name': 'Jun',
        'email': 'jun@example.com',
      });
      expect(controller.errors, isEmpty);
    });

    test('listeners are notified', () {
      final SimpleFormController controller = SimpleFormController();
      int notifications = 0;

      controller.addListener(() {
        notifications += 1;
      });

      controller.setValue('name', 'Jun');
      controller.setValues(<String, dynamic>{'email': 'jun@example.com'});
      controller.setError('email', 'Email already exists');

      expect(notifications, 3);
    });
  });
}
