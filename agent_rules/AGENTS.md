# j_flutter_ui — Agent & Maintainer Rules

Read this file before changing code.

## Purpose
- `j_flutter_ui` is a reusable Flutter UI library and design system.
- It must remain **app-agnostic**, **themeable**, **localization-safe**, and **stable** for multiple downstream apps.
- Do not “fix” library issues by changing consumer app code.

## Non‑negotiables
- **Public API stability**: avoid breaking changes; avoid renames/moves of exported symbols unless explicitly planned.
- **Focused diffs**: no drive-by refactors in the same change.
- **No parallel theme systems**: use Flutter-native `ThemeData` + `ThemeExtension`.
- **Null-safety discipline**: avoid `!` unless the guarantee is obvious and local.

## Repo map (mental model)
- `lib/j_flutter_ui.dart`: the public entrypoint. Anything exported here is public API.
- `lib/src/ui/resources/`: tokens (`JDimens`, `JInsets`, `JTextStyles`), `JAppTheme`, `AppThemeTokens`.
- `lib/src/ui/widgets/`: primitives + patterns.
- `lib/src/ui/localization/`: library JSON localization + app override bridge.
- `example/`: demo catalog and QA surface. Keep it working.
- `test/`: regression suite. Add tests for risky theming/null behavior.

## Widget layering (keep it enforceable)
- **Primitives**: single responsibility, thin wrappers around Material semantics.
  - Examples: `SimpleText`, `SimpleButton`, `SimpleCard`, `SimpleTextField`, `SimpleListItem`.
- **Patterns**: compose primitives; do not rebuild styling logic from scratch.
  - Examples: `SimpleMenuTile`, `SimpleMenuSection`, `SimpleMenuPage`, `SimpleBottomNavBar`, `SimpleFormBuilder`.

## Theming contract (what downstream apps rely on)
Use Flutter-native theming only.

### Resolution order (default)
Every visual value should resolve in this order:
`explicit widget parameter -> AppThemeTokens (ThemeExtension) -> Material semantic theme source -> final fallback constants`

Rationale: downstream apps typically customize this library by providing `AppThemeTokens`. Material component themes remain valid, but **tokens are the primary semantic override mechanism** for this design system.

### Use Material semantics when
- The value is a standard Material semantic pairing.
- Examples: `theme.colorScheme.error`, `theme.colorScheme.onSurface`, `theme.textTheme`, `theme.appBarTheme`, `theme.iconTheme`.

### Use `AppThemeTokens` when
- The library owns the semantic styling (surfaces, borders, muted text, input fills).
- Avoid duplicating all of `ColorScheme`/`TextTheme` into tokens.

### Foreground/content colors for token-owned surfaces
If a widget uses a token-owned background (e.g. `tokens.cardBackground`, `tokens.primary`), prefer a paired token foreground:
- `tokens.onCardResolved(theme)` for card-like surfaces
- `tokens.onPrimaryResolved(theme)` for primary action surfaces
Rationale: downstream apps often override token backgrounds; relying on Material `onSurface`/`onPrimary` can break contrast.

### Allowed constants
- `Colors.transparent` and similar “harmless constants” are fine.
- Other hardcoded colors should be a last-resort fallback only.

### Theme safety rules
- Do not assume `ThemeData` subfields are non-null.
- Prefer “resolve once at the top of `build`” to keep widget code readable.

## Spacing & sizing rules
- Use **`JGaps`** for fixed gaps.
- Use **`JInsets`** for padding.
- Use **`JDimens` / `JHeights` / `JIconSizes` / `JFontSizes` / `JLineHeights`** for shared scales.
- Avoid magic numbers for shared spacing/radius/heights/border widths/icon sizes/font sizes.
- Only add new shared tokens if reused or system-scale relevant.

## Text & localization rules
- `SimpleText` is the default.
- `AppText` is for library-owned text that needs localization, HTML, semantics label, or auto-fit.
- Use raw `Text` only when required by Flutter/third-party APIs or when you must inherit Material component text styling.
- If truncation is possible, set `maxLines` and `overflow` explicitly.
- **Do not hardcode app/business copy** in reusable widgets.

### Localization resolution order
Library-owned copy must resolve:
`app override (AppLocalizationBridge) -> library JSON localization -> key fallback -> safe plain-string fallback`

Never concatenate translated fragments into a sentence.

## Forms (core infrastructure)
- Keep separation between builder/controller/validation/utilities.
- Preserve app-level override capability for backend errors.
- Avoid making the form layer “too smart” (no hidden flows).

## Review workflow (what to do before you edit)
- Identify whether you’re touching **public API** (exported via `j_flutter_ui.dart`).
- Check for existing primitives/patterns before adding new ones.
- Ensure theming and tokens are resolved predictably.
- Add/adjust tests when behavior changes (especially fallbacks and null cases).

## Labels for partial migrations (use consistently in PRs)
- `fully migrated`
- `partially migrated`
- `acceptable fallback`
- `intentional Material semantic usage`

