# j_flutter_ui Architecture

## What this repository is
`j_flutter_ui` is a reusable Flutter UI library/design system. It is **not** an app.

Primary goals:
- app-agnostic, production-grade primitives and patterns
- predictable theming/overrides for multiple downstream apps
- safe fallbacks (no surprising null crashes)
- localization-safe library-owned copy
- demo-driven documentation via `example/`

## Source layout
- `lib/j_flutter_ui.dart`
  - The **only** supported import for consumers: `package:j_flutter_ui/j_flutter_ui.dart`
  - Everything exported here is **public API**; treat changes as semver-impacting

- `lib/src/ui/resources/`
  - design tokens and theme infrastructure
  - tokens: `JDimens`, `JGaps`, `JInsets`, `JHeights`, `JIconSizes`, `JFontSizes`, `JLineHeights`
  - typography: `JTextStyles`
  - theming: `JAppTheme`, `AppThemeTokens` (`ThemeExtension`)

- `lib/src/ui/widgets/`
  - **primitives**: thin wrappers over Material semantics
  - **patterns**: compositions of primitives (avoid re-implementing styling logic)

- `lib/src/ui/localization/`
  - library JSON localization (`assets/localization/*.json`)
  - override bridge for host apps (`AppLocalizationBridge`)

- `assets/`
  - icons/images/flags/illustrations + library localization JSON

- `example/`
  - catalog + QA harness (light/dark, tokens, overrides)

- `test/`
  - regression tests focused on fallbacks, theming overrides, and widget rendering behavior

## Theming architecture
`ThemeData` is the source of truth, augmented by `ThemeExtension<AppThemeTokens>` for library-owned semantic tokens.

### Token resolution
Use `AppThemeTokens.resolve(theme)` (via `theme.appThemeTokens`) to read:
- `primary`, `secondary`
- surfaces: `cardBackground`, `inputBackground`
- borders/dividers: `cardBorderColor`, `inputBorderColor`, `dividerColor`
- text: `mutedText`

Downstream apps typically override via:
- `ThemeData.extensions: [const AppThemeTokens(...)]`

## Widget resolution rules
All widgets should normalize values early and resolve styling predictably:
- `explicit widget parameter`
- `AppThemeTokens` (ThemeExtension)
- Material semantic theme (`ColorScheme`, `TextTheme`, component themes)
- final fallback constants (rare; document why)

## When to add a new token
Add a shared token only if:
- reused across multiple widgets, or
- part of the system scale that must remain consistent

Otherwise keep the value local, but prefer `JDimens` over raw numbers.

