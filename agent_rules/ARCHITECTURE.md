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
  - shared styling helpers:
    - `JInputDecorations` (shared `InputDecoration` building for inputs)
    - `JTints` (shared tinted surface/border recipes)

- `lib/src/ui/widgets/`
  - **primitives**: thin wrappers over Material semantics
  - **patterns**: compositions of primitives (avoid re-implementing styling logic)
  - compact icon-action affordances belong in primitives; app-specific counters, badges, and commerce flows belong in app-layer composition
  - overlay patterns: `SimpleBottomSheet`, `SimpleFloatingBanner`
    - `SimpleFloatingBanner` — centered floating promo/announcement surface over a dimmed backdrop. Keep it generic and composition-first; image/media and content belong in slots, while brand campaign structure stays in the app layer.
  - navigation patterns: `SimpleBottomNavBar`, `SimpleTabs`, `SimpleVerticalRail`
    - `SimpleVerticalRail` — compact left-edge icon-label rail. Supports color-change active state plus an optional selected background highlight. App-local animated overlays (dots, bars) are `Stack` composition on top, not part of the widget.
    - `SimpleBottomNavBar` — bottom navigation wrapper with standard active-color treatment and an optional active icon background. It should respect `BottomNavigationBarThemeData` before token fallback. Keep it a semantic navigation pattern, not a custom item renderer.
    - `SimpleTabs` — tab wrapper that should respect `TabBarThemeData` before token fallback.
  - Material-control wrappers such as `SimpleCheckbox`, `SimpleSwitch`, `SimpleAlertDialog`, `SimpleBottomSheet`, and `SimpleLoadingView` should respect their matching component theme before token fallback.

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
- paired foregrounds: `onPrimary`, `onSecondary`, `onCard`, `onInput` (or the resolved helpers)
- surfaces: `cardBackground`, `inputBackground`
- borders/dividers: `cardBorderColor`, `inputBorderColor`, `dividerColor`
- text: `mutedText`

Downstream apps typically override via:
- `ThemeData.extensions: [const AppThemeTokens(...)]`

## Widget resolution rules
All widgets should normalize values early and resolve styling predictably:
- `explicit widget parameter`
- Material semantic theme (`ColorScheme`, `TextTheme`, component themes) when semantically correct
- `AppThemeTokens` (ThemeExtension)
- final fallback constants (rare; document why)
- For icon-first compact action primitives, `IconButtonTheme` is the primary Material component theme source before token fallback.
- For thin wrappers over built-in Material controls, the matching component theme is part of the Material semantic layer and should participate before token fallback.

### Foreground/content colors for token-owned surfaces
If a widget sets a background using `AppThemeTokens` (e.g. `tokens.cardBackground`, `tokens.primary`), prefer the **paired resolved foreground** from tokens:
- `tokens.onCardResolved(theme)` for card-like surfaces (dialogs, sheets, snackbars, banners)
- `tokens.onPrimaryResolved(theme)` for primary actions/buttons
- This rule also applies to token-primary feedback and selection controls.

## Form reset semantics
- `SimpleFormBuilderState.reset()` is the builder-level blank-form reset. It clears configured field values to `null`, syncs text controllers to empty strings, and clears errors.
- `SimpleFormController.resetToInitialValues()` restores original controller values.
- `SimpleFormController.reset()` remains the controller-only clear path.

## Search field variants
- `SimpleSearchField` defaults to the standard input treatment.
- `SimpleSearchFieldVariant.quiet` is the reusable pill-like search presentation for soft-background search bars.
- Keep variant behavior semantic and reusable; do not add app/brand-specific search chrome or route-local hacks when the variant should cover the need.

## Shared styling helpers (avoid drift)
If a styling recipe appears in 3+ widgets, prefer centralizing it under `resources/` and reusing it.

- Use `JInputDecorations` for `SimpleTextField`/`SimpleDropdown`-like `InputDecoration` building so focus/error/disabled borders remain consistent.
- Use `JTints` for tinted surface/border recipes in feedback/display components (badge/banner/snackbar/chip).

## When to add a new token
Add a shared token only if:
- reused across multiple widgets, or
- part of the system scale that must remain consistent

Otherwise keep the value local, but prefer `JDimens` over raw numbers.
