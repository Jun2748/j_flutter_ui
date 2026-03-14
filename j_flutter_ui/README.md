# j_flutter_ui

`j_flutter_ui` is a reusable Flutter UI library for shared design resources, theme setup, common widgets, and a practical form system.

## Overview

The package is designed to help apps share a consistent UI layer across projects, including:
- design resources and theme
- shared widgets
- form controls
- form builder and form controller support
- validation utilities
- state, feedback, navigation, and overlay widgets

## Features

- Design tokens and app theme through `JColors`, `JDimens`, `JInsets`, `JTextStyles`, and `JAppTheme`
- Typography, layout, and shared UI resources
- Buttons, cards, text, bars, and feedback widgets
- Overlay helpers such as bottom sheet, snackbar, and dialog
- Loading, empty, and error state views
- Form controls including text, search, dropdown, checkbox, radio, and switch
- `SimpleFormBuilder` for schema-driven forms
- `SimpleFormController` for external value, error, and submit flow control
- Reusable validators and cross-field validation helpers
- Example demo app for manual testing and API review

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  j_flutter_ui:
    path: ../j_flutter_ui
```

## Basic Setup

Import the package and use the shared theme:

```dart
import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: JAppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const AppBarEx(title: 'j_flutter_ui'),
      bodyPadding: JInsets.screenPadding,
      body: const Center(
        child: SimpleText.heading(text: 'Hello from j_flutter_ui'),
      ),
    );
  }
}
```

## Basic Widget Usage

```dart
import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class WidgetExamples extends StatelessWidget {
  const WidgetExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SimpleText.heading(text: 'Profile'),
        Gap.h16,
        SimpleButton.primary(
          label: 'Save Changes',
          onPressed: () {},
        ),
        Gap.h16,
        const SimpleCard(
          child: SimpleText.body(text: 'Shared card content'),
        ),
        Gap.h16,
        const SimpleBadge.success(label: 'Active'),
        Gap.h16,
        const SimpleBanner.info(
          title: 'Heads up',
          message: 'Your profile is almost complete.',
        ),
      ],
    );
  }
}
```

```dart
await SimpleDialog.show<void>(
  context,
  title: 'Delete item',
  message: 'Are you sure you want to delete this item?',
  cancelText: 'Cancel',
  confirmText: 'Delete',
);

SimpleSnackbar.showSuccess(
  context,
  message: 'Profile updated successfully',
);

await SimpleBottomSheet.show<void>(
  context,
  title: 'Choose an option',
  child: const Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SimpleText.body(text: 'Bottom sheet content'),
    ],
  ),
);
```

## Form Usage

```dart
import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ProfileFormPage extends StatefulWidget {
  const ProfileFormPage({super.key});

  @override
  State<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  final SimpleFormController controller = SimpleFormController(
    initialValues: <String, dynamic>{
      'name': 'Jun',
      'email': 'jun@example.com',
    },
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleFormBuilder(
      controller: controller,
      fields: <SimpleFormFieldConfig<dynamic>>[
        SimpleFormFieldConfig.text(
          name: 'name',
          label: 'Name',
          validator: SimpleFormValidator.required(),
        ),
        SimpleFormFieldConfig.text(
          name: 'email',
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: SimpleFormValidator.combine(<SimpleValidator>[
            SimpleFormValidator.required(),
            SimpleFormValidator.email(),
          ]),
        ),
      ],
      submitLabel: 'Save Profile',
      onSubmit: (Map<String, dynamic> values) async {
        await Future<void>.delayed(const Duration(milliseconds: 300));
      },
    );
  }
}
```

```dart
controller.setValue('name', 'Taylor');
controller.patchValues(<String, dynamic>{
  'email': 'taylor@example.com',
});

final bool valid = await controller.validateAndScrollToFirstError();
if (valid) {
  await controller.submit();
}
```

Backend errors can be pushed in from API responses:

```dart
controller.setError('email', 'Email already exists');

controller.setErrors(<String, String>{
  'email': 'Email already exists',
  'username': 'Username is already taken',
});
```

## Validation Usage

Single-field validation:

```dart
validator: SimpleFormValidator.required(),
```

```dart
validator: SimpleFormValidator.combine(<SimpleValidator>[
  SimpleFormValidator.required(),
  SimpleFormValidator.email(),
]),
```

```dart
validator: SimpleFormValidator.pattern(
  SimpleRegexPatterns.alphanumeric,
  message: 'Only letters and numbers are allowed',
),
```

Cross-field validation:

```dart
SimpleFormFieldConfig.text(
  name: 'confirmPassword',
  label: 'Confirm Password',
  validator: SimpleFormValidator.required(),
  crossValidators: <SimpleCrossFieldValidator>[
    SimpleCrossFieldValidators.matchField(
      'password',
      message: 'Passwords do not match',
    ),
  ],
)
```

## Demo App

Run the example app from the package root:

```bash
cd example
flutter run
```

## Notes on Current Status

- The package API is still evolving.
- Demo coverage is being prioritized first so the widget system stays easy to review manually.
- Broader automated test coverage will be added after the API stabilizes.

## Simplified Folder Structure

```text
lib/
  j_flutter_ui.dart
  src/ui/resources/
  src/ui/widgets/
    controls/
    display/
    feedback/
    forms/
    layout/
    navigation/
    overlays/
    states/
    typography/
example/
  lib/demo/
README.md
```
