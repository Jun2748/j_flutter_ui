# CODING_RULES — j_flutter_ui

This file defines coding rules for contributors and AI assistants working on `j_flutter_ui`.

The goal is to preserve consistency, composability, and maintainability across the library.

---

## 1. General Principles

- Keep changes focused and minimal.
- Prefer extending existing components over creating duplicates.
- Preserve public API stability whenever possible.
- Avoid unrelated refactors in the same change.
- Write compile-friendly, readable Flutter code.

---

## 2. Design Tokens First

Always prefer centralized tokens over hardcoded values.

### Do not write

```dart
SizedBox(height: 13)
EdgeInsets.all(15)
TextStyle(fontSize: 17)

Prefer
JGaps.h16
JInsets.all16
JTextStyles.body

3. No Magic Numbers

Avoid raw numeric values for:
	•	spacing
	•	padding
	•	radius
	•	icon sizes
	•	heights
	•	text sizes

Allowed exceptions:
	•	temporary prototype code in example/demo only if unavoidable
	•	values dictated by Flutter APIs that do not fit the token system cleanly

Even in demos, prefer tokens when possible.

⸻

4. Asset Loading Rules

Do not use raw SvgPicture.asset(...) directly in widgets if the library helper exists.

Prefer

Images.svg(UiIcons.search)
SimpleIcon(UiIcons.search)
SimpleFlag.countryCode(CountryCodes.my)


Do not hardcode asset paths inside widgets.

Asset constants must live in resource files.

⸻

5. Widget Layering

Follow this mental model:

Primitives

Low-level reusable UI building blocks.

Examples:
	•	SimpleText
	•	SimpleButton
	•	SimpleCard
	•	SimpleTextField
	•	SimpleListItem

Patterns

Compositions built from primitives.

Examples:
	•	SimpleMenuTile
	•	SimpleMenuSection
	•	SimpleMenuPage
	•	SimpleBottomNavBar
	•	SimpleFormBuilder

Do not create a new pattern widget if existing primitives already solve the problem cleanly.

⸻

6. Keep Primitives Thin

Base primitives must stay simple.

Examples:
	•	SimpleText should remain a text primitive
	•	smart behavior should go into AppText, not SimpleText
	•	SimpleListItem is a base row primitive
	•	SimpleMenuTile is a higher-level pattern

Do not turn primitives into giant multi-responsibility widgets.

⸻

7. Naming Rules

Use existing naming patterns consistently.

Reusable widgets
	•	SimpleButton
	•	SimpleText
	•	SimpleCard
	•	SimpleListItem

Higher-level smart widgets
	•	AppText

Resource constants
	•	UiIcons
	•	Images
	•	Flags
	•	Illustrations

Constants
	•	CountryCodes
	•	CurrencyCodes

Do not introduce inconsistent prefixes or business-specific names.

⸻

8. Flag System Rules
Flags are country-first.
Primary mapping:
countryCode -> flag asset
currencyCode -> countryCode -> flag asset
SimpleFlag.countryCode(CountryCodes.my)
FlagUtils.flagByCountry(CountryCodes.my)

. Form System Rules

The form system is a core part of the library.

Maintain separation between:
	•	builder
	•	controller
	•	validation
	•	utilities

Core classes include:
	•	SimpleForm
	•	SimpleFormBuilder
	•	SimpleFormController
	•	SimpleFormValidator
	•	SimpleCrossFieldValidators

When changing the form system:
	•	preserve predictability
	•	avoid overengineering
	•	keep validation flow clear
	•	maintain app-level override capability for backend errors

⸻

10. Localization Rules

The library may support:
	•	common/demo strings
	•	localization hooks
	•	app override bridge
	•	AppText

The library should not become the owner of app business copy.

Correct resolution order:

app override -> library localization -> key fallback

11. Demo App Rules

The example app is required and acts as:
	•	component catalog
	•	visual QA surface
	•	documentation
	•	dark mode testing playground

When adding meaningful new widgets or systems:
	•	add or update demo pages
	•	keep demos simple and educational
	•	prefer showcase clarity over cleverness

⸻

12. Dark Mode Rules

All components should be theme-aware.

Do not hardcode colors that break in dark mode.

Prefer token-driven styling and theme-based colors.

Whenever practical:
	•	test components in both light and dark modes
	•	ensure text and icon contrast remains readable

⸻

13. Export Rules

Public consumers should import only:
import 'package:j_flutter_ui/j_flutter_ui.dart';

Do not rely on deep src/... imports from consuming apps.

New public widgets/utilities should be exported through j_flutter_ui.dart.

⸻

14. Before Adding a New Widget

Ask these questions:
	1.	Can this be built from existing primitives?
	2.	Is this reusable across multiple screens/apps?
	3.	Is it feature-specific or system-level?
	4.	Should it remain feature-local until proven reusable?

Only promote widgets into the library when they solve repeated UI problems cleanly.

⸻

15. Before Modifying Existing Code

Check:
	•	does this break the public API?
	•	does this bypass design tokens?
	•	does this duplicate an existing pattern?
	•	does this require a demo update?
	•	does this affect dark mode behavior?

⸻

16. Preferred Change Style

When making changes:
	•	use small diffs
	•	preserve architecture
	•	mention affected files clearly
	•	avoid speculative cleanup
	•	do not rename files/classes unnecessarily

Act like a careful maintainer of a shared design system.
