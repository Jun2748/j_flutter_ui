---

# 2. `README.md`

```md
# j_flutter_ui

A reusable Flutter UI component library designed to standardize UI development across multiple applications.

`j_flutter_ui` provides:
- centralized design tokens
- reusable UI primitives
- composable widget patterns
- form infrastructure
- asset helpers
- demo-driven documentation

The goal is to behave like a lightweight design system, not just a collection of random widgets.

---

## Features

### Design tokens
The library centralizes:
- colors
- spacing
- dimensions
- typography
- insets
- heights

### Asset system
The library provides:
- icon asset constants
- image helpers
- flag helpers
- illustration helpers

### Reusable widgets
The library includes:
- buttons
- text fields
- cards
- list items
- chips
- badges
- banners
- dialogs
- bottom sheets
- loading / empty / error states
- navigation widgets
- menu patterns

### Form system
The form layer includes:
- `SimpleForm`
- `SimpleFormBuilder`
- `SimpleFormController`
- validators
- cross-field validators
- backend error integration helpers

### Example app
The repository contains an example app that acts as:
- a component catalog
- a visual QA tool
- a usage reference

---

## Project Structure

Main code lives under:

```text
lib/src/ui
constants/
resources/
utils/
widgets/

constants

Shared codes and constants.

Examples:
	•	country_codes.dart
	•	currency_codes.dart

resources

Design tokens and asset helpers.

Examples:
	•	colors.dart
	•	dimens.dart
	•	styles.dart
	•	theme.dart
	•	images.dart
	•	flags.dart
	•	illustrations.dart
	•	ui_icons.dart

utils

Reusable helper utilities.

Examples:
	•	flag_utils.dart

widgets

Reusable UI widgets grouped by category.

Examples:
	•	controls
	•	display
	•	feedback
	•	forms
	•	layout
	•	navigation
	•	overlays
	•	states
	•	typography

⸻

Installation

Add the package to your Flutter app.
dependencies:
  j_flutter_ui:
    path: ../j_flutter_ui

Usage

Import the library through the public entry point only:

Design Tokens

Use centralized tokens instead of hardcoded styling.
Avoid
SizedBox(height: 13);
EdgeInsets.all(15);
TextStyle(fontSize: 17);

Prefer
JGaps.h16;
JInsets.all16;
JTextStyles.body;


Asset Usage

Do not load SVGs directly in app code.

Preferred usage
Images.svg(UiIcons.search);
Images.svg(Flags.malaysia);
Images.svg(Illustrations.emptyState);

Flag usage
SimpleFlag.countryCode(CountryCodes.my);
FlagUtils.flagByCountry(CountryCodes.my);

Flags are country-first. Currency mapping is only a convenience helper.

⸻

Core Primitive Widgets

Some of the main primitives include:
	•	SimpleText
	•	SimpleButton
	•	SimpleCard
	•	SimpleListItem
	•	SimpleTextField

Higher-level widgets should build on top of these primitives whenever possible.

⸻

Forms

The library includes a form system for building and controlling forms consistently.

Main classes
	•	SimpleForm
	•	SimpleFormBuilder
	•	SimpleFormController
	•	SimpleFormValidator
	•	SimpleCrossFieldValidators

Example
final controller = SimpleFormController();
Use the controller-driven form system instead of ad-hoc field state where practical.

⸻

Example App

The example app lives under:
example/lib

It contains demos for:
	•	controls
	•	forms
	•	layout
	•	navigation
	•	states
	•	feedback
	•	assets

Use the example app to:
	•	understand intended usage
	•	test dark mode
	•	validate visual consistency
	•	review component composition

⸻

Rules for Extending the Library

When adding new components:
	1.	Prefer composition over duplication
	2.	Use design tokens instead of magic numbers
	3.	Follow existing naming conventions
	4.	Keep primitives thin
	5.	Add or update demo pages
	6.	Export new public APIs through j_flutter_ui.dart

⸻

Library Philosophy

This project is intended to grow as a reusable UI platform.

The focus is on:
	•	composable primitives
	•	predictable APIs
	•	token-based styling
	•	reusable patterns
	•	demo-backed development

The library should remain:
	•	clean
	•	maintainable
	•	scalable
	•	app-agnostic

⸻

Versioning

Semantic versioning should be used.

General guideline:
0.x → evolving architecture
1.0 → stable API

Example roadmap:
0.1.0 → core widgets and asset system
0.2.0 → form system
0.3.0 → navigation and menu patterns
0.4.0 → scenario demos and stabilization
1.0.0 → stable public API