# j_flutter_ui

`j_flutter_ui` is a reusable Flutter UI component library designed to standardize UI development across multiple applications.

The goal of this library is to provide:

- consistent design tokens
- reusable UI primitives
- composable widgets
- form infrastructure
- asset helpers
- predictable layout utilities

This library is intended to scale across multiple Flutter projects while keeping the UI layer easy to understand, easy to extend, and safe to evolve.

## Purpose

`j_flutter_ui` exists to move shared UI concerns out of individual apps and into a single reusable package. Instead of each application rebuilding its own buttons, forms, spacing rules, app bars, list rows, and asset loading patterns, this library provides a common system.

The package is designed to support:

- shared design tokens
- consistent widget APIs
- predictable composition patterns
- reusable form workflows
- centralized asset access
- example-driven development through the bundled demo app

## Design Principles

### 1. Consistency

All UI elements should rely on centralized design tokens.

Avoid magic numbers such as:

```dart
const SizedBox(height: 13)
```

Prefer tokens and shared primitives such as:

```dart
const Gap.h(JDimens.dp16)
```

or:

```dart
padding: JInsets.screenPadding
```

### 2. Composability

Widgets should be small, reusable primitives that compose together cleanly.

Example:

```text
SimpleListItem -> base row primitive
SimpleMenuTile -> more opinionated higher-level row
```

The package should favor layering behavior on top of primitives instead of duplicating layouts in multiple widgets.

### 3. Predictable API

Public widgets should follow consistent naming patterns.

Examples:

- `SimpleButton`
- `SimpleTextField`
- `SimpleCard`
- `SimpleListItem`
- `SimpleFlag`

Helpers and resources should also be predictable:

- `Images`
- `Flags`
- `UiIcons`
- `Illustrations`
- `FlagUtils`

### 4. Asset Abstraction

SVG assets should never be loaded directly using `SvgPicture.asset(...)` in library or demo code.

Use:

```dart
Images.svg(asset)
```

This keeps asset loading centralized and package-safe.

## Library Architecture

Current structure under `lib/src/ui/`:

```text
lib/src/ui
├── constants
│   ├── country_codes.dart
│   └── currency_codes.dart
├── resources
│   ├── colors.dart
│   ├── dimens.dart
│   ├── flags.dart
│   ├── illustrations.dart
│   ├── images.dart
│   ├── index.dart
│   ├── styles.dart
│   ├── theme.dart
│   ├── ui_icons.dart
│   └── videos.dart
├── utils
│   └── flag_utils.dart
└── widgets
    ├── controls
    │   ├── buttons
    │   ├── dropdown
    │   ├── inputs
    │   └── segmented
    ├── display
    │   ├── simple_card.dart
    │   ├── simple_chip.dart
    │   ├── simple_divider.dart
    │   ├── simple_list_item.dart
    │   ├── simple_menu_page.dart
    │   ├── simple_menu_section.dart
    │   └── simple_menu_tile.dart
    ├── feedback
    │   ├── simple_badge.dart
    │   ├── simple_banner.dart
    │   ├── simple_dialog.dart
    │   └── simple_snackbar.dart
    ├── flags
    │   └── simple_flag.dart
    ├── forms
    │   ├── builder
    │   ├── controller
    │   └── validation
    ├── layout
    │   ├── app_scaffold.dart
    │   ├── gap.dart
    │   └── section.dart
    ├── navigation
    │   ├── app_bar_ex.dart
    │   ├── simple_bottom_nav_bar.dart
    │   └── simple_tabs.dart
    ├── overlays
    │   └── simple_bottom_sheet.dart
    ├── states
    │   ├── simple_empty_state.dart
    │   ├── simple_error_view.dart
    │   └── simple_loading_view.dart
    └── typography
        └── simple_text.dart
```

### Architectural Layers

- `constants/`: shared code constants such as country and currency codes
- `resources/`: design tokens, theme, assets, and resource lookup classes
- `utils/`: non-widget helpers such as flag lookup logic
- `widgets/`: reusable UI components organized by domain

## Design Tokens

Design tokens centralize styling and layout.

Current token classes include:

- `JColors`
- `JDimens`
- `JGaps`
- `JFontSizes`
- `JLineHeights`
- `JIconSizes`
- `JInsets`
- `JHeights`
- `JTextStyles`
- `JAppTheme`

These tokens exist to ensure visual consistency and reduce one-off styling decisions in application code.

## Assets

Assets are centralized behind resource helpers rather than referenced as raw paths throughout the codebase.

### Icons

Use:

```dart
Images.svg(UiIcons.search)
```

### Flags

Use:

```dart
SimpleFlag.countryCode(CountryCodes.my)
```

or:

```dart
FlagUtils.flagByCountry(CountryCodes.sg, size: 20)
```

### Raster Images

Use:

```dart
Image(
  image: Images.asset('logo'),
)
```

### Important Rule

Never load assets directly in feature code with raw asset paths or direct `SvgPicture.asset(...)` calls. Always go through the library resource helpers.

## Country, Flag, and Currency Model

The flag system is country-first.

Primary model:

```text
countryCode -> flag asset
```

Secondary convenience model:

```text
currencyCode -> countryCode -> flag asset
```

This means the preferred APIs are:

```dart
FlagUtils.flagAssetFromCountry(CountryCodes.sg);
FlagUtils.flagByCountry(CountryCodes.my, size: 20);
```

Currency mapping still exists for convenience:

```dart
FlagUtils.countryCodeFromCurrency(CurrencyCodes.usd);
FlagUtils.flagByCurrency(CurrencyCodes.myr, size: 20);
```

## Forms System

The forms layer provides reusable building blocks for complex form workflows.

Core pieces include:

- `SimpleForm`
- `SimpleFormController`
- `SimpleFormBuilder`
- `SimpleFormFieldConfig`
- `SimpleFormFieldType`
- `SimpleFormValidator`
- `SimpleCrossFieldValidators`
- `SimpleRegexPatterns`
- `SimpleValidationMessages`

This supports:

- schema-driven form construction
- centralized validation rules
- cross-field validation
- external form control
- backend error injection
- predictable submission state

## Core Primitive Widgets

Important base components include:

- `SimpleText`
- `SimpleButton`
- `SimpleCard`
- `SimpleListItem`
- `SimpleTextField`
- `AppScaffold`
- `AppBarEx`

Higher-level widgets should build on these primitives whenever practical.

Example:

```text
SimpleListItem -> general-purpose row primitive
SimpleMenuTile -> menu-specific row built with stronger assumptions
```

## Example App

The example app under `example/` acts as living documentation for the package.

It provides demo coverage for:

- foundations
- controls
- display widgets
- forms
- navigation
- layout
- overlays
- states
- screen compositions

The example app should be updated whenever new reusable components are added or significant APIs change.

## Basic Usage

### App setup

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
      darkTheme: JAppTheme.darkTheme,
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

### Primitive widget usage

```dart
Column(
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
    const SimpleListItem(
      title: SimpleText.body(text: 'Email'),
      subtitle: SimpleText.caption(text: 'user@email.com'),
    ),
  ],
)
```

## Rules for Extending the Library

When adding new widgets or helpers:

1. Prefer composition over duplication.
2. Use shared design tokens instead of hardcoded dimensions.
3. Avoid introducing one-off naming patterns.
4. Follow the established `Simple*` widget naming convention where appropriate.
5. Add example/demo coverage in the example app.
6. Export public widgets and helpers from `lib/j_flutter_ui.dart`.
7. Keep assets and resource paths centralized.
8. Avoid business-specific behavior in reusable package code.

## Safe Extension Guidelines

When extending this library, ask:

- Is this a primitive or a composed widget?
- Does this belong in `resources`, `utils`, or `widgets`?
- Can it be built from an existing primitive?
- Is there already a token for the spacing, size, or color I need?
- Does the new API match the rest of the package?

Good extension pattern:

```text
primitive widget
-> reusable composed widget
-> example demo
-> barrel export
```

Avoid:

- direct SVG loading in widget code
- magic numbers for spacing and sizing
- duplicating existing widget layouts
- introducing app-specific logic into the library

## AI Assistant Guidelines

This section is intentionally written for AI tools such as Codex and ChatGPT.

When modifying this library:

- Do not break existing public widget APIs without clear justification.
- Avoid renaming public classes casually.
- Keep design tokens centralized.
- Use `Images.svg(...)` for SVG rendering.
- Use `UiIcons`, `Flags`, `Illustrations`, and `Images` resource helpers instead of raw asset paths.
- Use `CountryCodes` and `CurrencyCodes` constants instead of hardcoded values.
- Avoid introducing magic numbers when tokens already exist.
- Preserve the current folder structure unless there is a strong architectural reason to change it.
- Prefer low-level primitives over creating many highly opinionated one-off widgets.
- Update the example app when adding or changing public components.
- Export new public APIs from `lib/j_flutter_ui.dart`.

When uncertain, prefer:

- composition over duplication
- clarity over cleverness
- stable public APIs over churn

## Development Notes

- Asset SVGs are loaded through `flutter_svg` via `Images.svg(...)`.
- The package currently uses a mix of newer resource names such as `UiIcons`, `Images`, `Flags`, and `Illustrations`, alongside older token names such as `JColors`, `JDimens`, and `JTextStyles`.
- The example app under `example/` is part of the development workflow and should be kept in sync with the public library API.

## Roadmap

Future improvements may include:

- more layout primitives
- animation helpers
- theme extensions
- advanced form features
- more asset-backed widgets
- richer example coverage

## Versioning

Semantic versioning is used.

- `0.x`: evolving architecture and API refinement
- `1.0`: stable public API target

