# j_flutter_ui

`j_flutter_ui` is a reusable Flutter UI library for shared design resources, common widgets, and a practical form system.

## Overview

The package is built to keep app UI consistent across projects with:
- shared design tokens and theme setup
- reusable controls and display widgets
- form controls, form builder, and form controller support
- validation utilities for single-field and cross-field rules
- feedback and navigation widgets
- an example demo app for manual testing

## Features

- Design tokens and theme through `JColors`, `JDimens`, `JInsets`, `JTextStyles`, and `JAppTheme`
- Reusable widgets such as buttons, cards, text, badges, banners, dialogs, tabs, and segmented controls
- Form controls including text, search, dropdown, checkbox, radio, and switch inputs
- `SimpleFormBuilder` for schema-driven forms
- `SimpleFormController` for external state and error management
- Reusable validators like `required`, `email`, `pattern`, and cross-field validators
- Example app with focused demos for forms, feedback, layout, and navigation

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  j_flutter_ui:
    path: ../j_flutter_ui
```

## Basic Usage

Set up the theme and import the package:

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
      theme: JAppTheme.lightTheme,
      darkTheme: JAppTheme.darkTheme,
      home: const DemoPage(),
    );
  }
}
```

Use basic widgets:

```dart
import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const AppBarEx(title: 'Demo'),
      bodyPadding: JInsets.screenPadding,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SimpleText.heading(text: 'Hello'),
          Gap.h16,
          const SimpleCard(
            child: SimpleText.body(text: 'Shared card content'),
          ),
          Gap.h16,
          SimpleButton.primary(
            label: 'Continue',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
```

## Forms Usage

Build forms with `SimpleFormBuilder` and `SimpleFormController`:

```dart
import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final SimpleFormController controller = SimpleFormController(
    initialValues: <String, dynamic>{
      'name': 'Jun',
    },
  );

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
          validator: SimpleFormValidator.combine(<SimpleValidator>[
            SimpleFormValidator.required(),
            SimpleFormValidator.email(),
          ]),
        ),
      ],
      showSubmitButton: true,
      onSubmit: (Map<String, dynamic> values) async {},
    );
  }
}
```

Controller actions:

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

## Backend Error Handling

Set server-side errors through the controller:

```dart
controller.setError('email', 'Email already exists');

controller.setErrors(<String, String>{
  'email': 'Email already exists',
  'username': 'Username is already taken',
});
```

Editing the related field clears that backend error automatically in `SimpleFormBuilder`.

## Demo App

Run the example app for manual verification:

```bash
flutter run -d macos example/lib/main.dart
```

Or from the package root:

```bash
cd example
flutter run
```

## Testing

Run the widget and controller tests with:

```bash
flutter test
```

## Folder Structure

```text
lib/
  src/ui/resources/
  src/ui/widgets/controls/
  src/ui/widgets/display/
  src/ui/widgets/feedback/
  src/ui/widgets/forms/
  src/ui/widgets/layout/
  src/ui/widgets/navigation/
  src/ui/widgets/typography/
example/
  lib/demo/
test/
```
