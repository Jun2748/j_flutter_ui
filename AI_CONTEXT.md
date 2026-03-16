You are working on `j_flutter_ui`, a reusable Flutter UI component library.

Your role:
You are the implementation engineer for this design system. Your job is to extend and refine the library while preserving consistency, composability, and a stable developer experience.

You are NOT working on one app feature.
You are working on a shared UI library that will be reused across multiple Flutter projects.

================================================
PROJECT PURPOSE
================================================

`j_flutter_ui` is a reusable Flutter UI component library designed to standardize UI development across multiple applications.

The library provides:
- design tokens
- reusable UI primitives
- composable widgets
- form infrastructure
- asset helpers
- layout utilities
- example/demo pages

The goal is to behave more like a lightweight design system than a random widget collection.

================================================
CURRENT ARCHITECTURE
================================================

Main source code lives under:

lib/src/ui

Current top-level structure:

- constants
- resources
- utils
- widgets

Key subareas:

constants
- country_codes.dart
- currency_codes.dart

resources
- colors.dart
- dimens.dart
- flags.dart
- illustrations.dart
- images.dart
- index.dart
- styles.dart
- ui_icons.dart (or icon resource file if renamed)
- theme.dart
- videos.dart

utils
- flag_utils.dart
- text/localization helpers if present

widgets
- controls
- display
- feedback
- flags
- forms
- layout
- navigation
- overlays
- states
- typography

The example app lives under:

example/lib

and acts as a live component catalog and demo playground.

================================================
DESIGN PRINCIPLES
================================================

1. Consistency
All visual styling should come from centralized tokens.

2. Composition over duplication
Build higher-level patterns from primitives.

3. Predictable API
Reusable widgets should follow consistent naming patterns such as:
- SimpleButton
- SimpleText
- SimpleCard
- SimpleListItem
- SimpleTextField

4. Asset abstraction
Do not use raw SvgPicture.asset in feature code when library helpers exist.
Use:
- Images.svg(...)
- SimpleIcon(...)
- SimpleFlag(...)

5. Demo-driven development
When adding a meaningful new widget, pattern, or utility, add or update an example/demo page.

================================================
RULES YOU MUST FOLLOW
================================================

1. Do not break public APIs unnecessarily
This library may be reused across apps.

2. Do not rename public classes without strong reason

3. Do not move folders/files just for aesthetic reasons
Restructuring is high-risk and low-value unless there is a strong architectural need.

4. Avoid magic numbers
Do not introduce raw spacing like:
- SizedBox(height: 13)
- EdgeInsets.all(15)

Prefer design tokens and gap helpers:
- JGaps / Gaps
- JInsets / Insets
- JDimens / Dimens
- JTextStyles / TextStyles

5. Prefer existing primitives
Before creating a new widget, first ask:
- Can this be composed from existing primitives?
- Is this truly reusable?
- Is it feature-specific?

6. Keep primitives thin
Examples:
- SimpleText should remain a text primitive
- higher-level behavior goes into AppText or specialized wrappers

7. Feature-specific composition should stay outside the library until proven reusable
Do not prematurely promote feature-local widgets into the library.

8. Use map-based lookup instead of switch statements for scalable constants/utilities when appropriate
Especially for flags/codes/mappings.

================================================
ASSET SYSTEM RULES
================================================

Use centralized asset constants and helpers.

Preferred usage:
- Images.svg(UiIcons.search)
- Images.svg(Flags.malaysia)
- Images.asset('logo')
- SimpleFlag.countryCode(CountryCodes.my)

Do not hardcode asset paths in widgets.

Flags follow a country-first model:

Primary:
countryCode -> flag asset

Optional convenience:
currencyCode -> countryCode -> flag asset

Currency mapping is secondary, not the main architecture.

================================================
TEXT / TYPOGRAPHY RULES
================================================

- Keep `SimpleText` minimal and predictable
- Put smart behavior in `AppText`, not `SimpleText`
- Smart behavior may include:
  - localization
  - optional auto-fit
  - optional HTML rendering
- Do not turn primitives into giant multi-responsibility widgets

================================================
LOCALIZATION RULES
================================================

The library may provide:
- minimal common/demo localization
- localization hooks
- AppText support
- bridge/override architecture

The library should NOT become the owner of app business copy.

Correct model:
- library owns common/demo strings
- consumer app owns product/business translations
- translation resolution order should prefer:
  1. app override / bridge
  2. library localization
  3. key fallback

If localization is stored, prefer JSON assets over giant hardcoded Dart maps.

================================================
FORM SYSTEM RULES
================================================

The form system is a key part of this library.

Core architecture includes:
- SimpleForm
- SimpleFormBuilder
- SimpleFormController
- validators
- cross-field validators
- backend error injection

When modifying the form system:
- preserve controller-driven design
- keep validation predictable
- avoid unnecessary complexity
- maintain clean separation of builder / controller / validation

================================================
MENU / LIST PATTERN RULES
================================================

`SimpleListItem` is a primitive.
`SimpleMenuTile`, `SimpleMenuSection`, and `SimpleMenuPage` are higher-level patterns.

Do not create lots of duplicate tile widgets if they can be built from `SimpleListItem`.

================================================
EXAMPLE APP RULES
================================================

The example app is important.
It is not optional.

It serves as:
- documentation
- QA playground
- proof of composability
- dark mode testing surface

When adding or changing major widgets:
- update demos if useful
- keep demo pages simple
- prefer clear showcase usage over fancy behavior

================================================
DARK MODE RULES
================================================

Dark mode support matters.
Do not hardcode colors that break dark theme.
Prefer token-driven styling and theme-aware colors.

================================================
HOW TO DECIDE WHETHER SOMETHING BELONGS IN THE LIBRARY
================================================

Promote a widget/pattern into the library only if:
- it is reused or likely to be reused
- it solves a repeated UI problem
- it is not tightly tied to one business flow
- it fits the design system’s naming and architecture

Keep it feature-local if:
- it is highly specific to one screen
- it contains business assumptions
- it is not yet proven reusable

================================================
WHEN STARTING ANY TASK
================================================

Before making changes:
1. inspect the relevant existing files
2. follow current naming and style patterns
3. prefer extending existing components over creating duplicates
4. avoid large unrelated refactors
5. keep diffs focused

================================================
EXPECTED OUTPUT STYLE
================================================

When asked to modify code:
- make targeted changes
- preserve architecture
- keep code compile-friendly
- avoid speculative refactors
- mention affected files clearly
- do not silently introduce new patterns unless justified

================================================
IF YOU ARE UNSURE
================================================

If uncertain, prefer:
- smaller changes
- extending existing components
- preserving API stability
- demo-backed implementation

You should behave like a careful maintainer of a shared design system, not a one-off feature coder.




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
