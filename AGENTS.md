# j_flutter_ui Agent Rules

Read this file before changing code.

## Purpose
- `j_flutter_ui` is a reusable Flutter UI library and design system.
- Keep it app-agnostic, production-grade, readable, maintainable, and reusable across multiple apps.
- Do not solve library debt by changing consumer app code.

## Core Rules

- New and modified code must follow these rules.
- When touching legacy code, migrate it incrementally toward these rules.
- Do not add abstraction layers unless they clearly improve maintainability.
- If a change makes the code harder to read, it is incorrect.
- Preserve public API stability whenever possible.
- Do not rename or move public files/classes without strong reason.
- Avoid unrelated refactors in the same change.

## Theme And Style Resolution

Use Flutter-native theming only.

- Use `ThemeData` and `ThemeExtension`.
- Do not build wrapper-based or parallel theme systems.
- Every visual widget must resolve values in this order:
  `widget prop -> host theme -> library fallback`
- Prefer semantic tokens and theme values over raw styling.
- Do not hardcode widget colors except clearly harmless constants such as `Colors.transparent`.
- Do not add new `JColors.getColor` usage. It is compatibility-only.
- Keep components dark-mode safe and theme-aware.

## Spacing, Dimensions, And Tokens

- Use `JGaps` for fixed spacing between elements.
- Use `JInsets` for padding.
- Use `JDimens`, `JHeights`, `JIconSizes`, `JFontSizes`, and `JLineHeights` for shared sizes.
- Do not use `Gap`.
- Do not use raw `SizedBox(height/width)` or raw `EdgeInsets` when an existing shared value fits.
- Do not use magic numbers for shared spacing, radius, height, border width, icon size, or text size.
- Add a shared token only if it is reused, part of the system scale, or should stay consistent across widgets.
- Keep one-off or highly specific values local.
- Do not put colors, alpha values, durations, or one-off animation values into `JDimens`.

## Widget Layering

Use the existing layering model.

- Primitives stay thin: `SimpleText`, `SimpleButton`, `SimpleCard`, `SimpleTextField`, `SimpleListItem`.
- Patterns compose primitives: `SimpleMenuTile`, `SimpleMenuSection`, `SimpleMenuPage`, `SimpleBottomNavBar`, `SimpleFormBuilder`.
- Do not create a new pattern widget if existing primitives already solve the problem.
- Do not turn primitives into multi-responsibility widgets.

## Text And Localization

- `SimpleText` is the default text widget.
- `AppText` is for library-owned text that needs localization, HTML, semantics, or auto-fit.
- Use raw `Text` only when required by Flutter or a third-party API.
- Resolve text style from host theme first, then library fallback.
- Do not hide truncation defaults. If text is capped, set `maxLines` and `overflow` explicitly.
- Do not hardcode user-facing strings in reusable widgets.
- The host app owns app/business copy.
- The library may own only generic reusable copy and demo copy.
- Localization resolution should prefer:
  `app override -> library localization -> key fallback`
- Do not concatenate translated fragments into sentences.

## Assets

- Use centralized asset helpers and constants.
- Do not hardcode asset paths in widgets.
- Prefer helpers such as `Images`, `UiIcons`, `Flags`, and `SimpleFlag`.
- Flags are country-first:
  `countryCode -> flag`
  `currencyCode -> countryCode -> flag`

## Forms

The form system is core library infrastructure.

- Preserve clean separation between builder, controller, validation, and utilities.
- Keep validation predictable.
- Avoid overengineering form flows.
- Maintain app-level override capability for backend errors.

## Example App

The example app is required.

- Use it as documentation, QA, dark mode verification, and API validation.
- When adding or materially changing reusable widgets or systems, add or update demos when useful.
- Keep demos simple and educational.
- Prefer showcase clarity over fancy behavior.

## Export And Consumption Rules

- Consumer apps should import `package:j_flutter_ui/j_flutter_ui.dart`.
- Do not rely on deep `src/...` imports from consumer apps.
- New public library APIs must be exported through `j_flutter_ui.dart`.

## Before Adding Or Changing Code

Before adding a new widget, ask:
- Can this be built from existing primitives?
- Is it reusable across multiple screens/apps?
- Is it system-level or still feature-specific?

Before modifying code, check:
- Does this break the public API?
- Does this bypass theming or shared tokens?
- Does this duplicate an existing pattern?
- Does this need a demo update?
- Does this still work in dark mode?

## Change Style

- Keep diffs focused and compile-friendly.
- Favor explicit naming and predictable fallback logic.
- Normalize nullable values once near the top of `build`.
- Avoid `!` unless the guarantee is obvious and safe.
- Never assume theme subfields are non-null without fallback.

## Addendum

- Keep the existing content in this file intact unless the task explicitly asks to replace it.
- Use [`THEMING_RULEBOOK.md`] as the short reference for the final approved theming and localization standard.
- When deciding between styling sources, prefer:
  `explicit widget parameter -> Material semantic theme source when correct -> AppThemeTokens -> final fallback constants`
- Treat these labels consistently in reviews and follow-up work:
  `fully migrated`
  `partially migrated`
  `acceptable fallback`
  `intentional Material semantic usage`
