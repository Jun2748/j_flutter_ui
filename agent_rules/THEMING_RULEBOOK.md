# Theming Rulebook

## Approved Architecture
- Use Flutter-native `ThemeData`.
- Use `ThemeExtension<AppThemeTokens>` for library-owned semantic tokens.
- Read tokens via `theme.appThemeTokens` (canonical accessor).
- Use Material theme sources for standard Material semantics.
- Use constants such as `JColors` only as the final fallback.

## Style Resolution Order
- Resolve visual values in this order:
  `explicit widget parameter -> Material theme source when semantically correct -> AppThemeTokens -> final fallback constants`

## Use Material Semantics When
- The value is a standard Material semantic or pairing.
- Examples:
  `theme.colorScheme.error`
  `theme.colorScheme.onPrimary`
  `theme.colorScheme.onSurface`
  `theme.textTheme`
  `theme.appBarTheme`
  `theme.iconTheme`
  `theme.iconButtonTheme.style`
- Matching component themes such as:
  `theme.bottomNavigationBarTheme`
  `theme.tabBarTheme`
  `theme.checkboxTheme`
  `theme.switchTheme`
  `theme.dialogTheme`
  `theme.bottomSheetTheme`
  `theme.progressIndicatorTheme`
- `AppBarEx` defaults should read `theme.appBarTheme.backgroundColor` / `foregroundColor` before token fallback.
- Compact icon-action primitives should read `theme.iconButtonTheme.style` before token fallback.
- Navigation wrappers should prefer `BottomNavigationBarThemeData` / `TabBarThemeData` before token fallback.
- Thin wrappers over Material controls should not hard-override `CheckboxThemeData`, `SwitchThemeData`, `DialogThemeData`, `BottomSheetThemeData`, or `ProgressIndicatorThemeData` unless an explicit widget parameter is set.

## Use AppThemeTokens When
- The library owns the semantic styling.
- Current token examples:
  `cardBackground`
  `onCardResolved(theme)` (foreground for `cardBackground`)
  `cardBorderColor`
  `inputBackground`
  `onInputResolved(theme)` (foreground for `inputBackground`)
  `inputBorderColor`
  `dividerColor`
  `mutedText`
- Canonical access:
  `final AppThemeTokens tokens = Theme.of(context).appThemeTokens;`
- Compact primary icon-action surfaces should fall back to `tokens.primary` and `tokens.onPrimaryResolved(theme)` when `IconButtonTheme` does not provide colors.

## Foreground/content color rule (paired semantics)
- If a widget uses a **token-owned surface/background** (e.g. `tokens.cardBackground`, `tokens.primary`), do not assume Material `on*` colors will remain correct after token overrides.
- Prefer the paired resolved foreground from tokens:
  - `tokens.onCardResolved(theme)` for card/sheet/dialog/snackbar surfaces
  - `tokens.onPrimaryResolved(theme)` for primary button backgrounds
  - `tokens.onSecondaryResolved(theme)` for secondary semantic backgrounds (when used)
- This applies to token-primary controls too (for example badges, segmented controls, selected switches, and selected checkboxes).

## Input affordance guidance
- Prefer `prefixIcon` / `suffixIcon` for icons, flags, or interactive affordances inside inputs.
- Reserve `prefix` / `suffix` for simple inline affix content only.

## Shared styling helpers (consistency)
- Prefer reusing centralized helpers over duplicating styling logic:
  - `JInputDecorations`: shared `InputDecoration` building for inputs
  - `JTints`: tinted surface/border recipes for status UI (badge/banner/snackbar/chip)

## Fallback Constants
- Final fallback constants are allowed only when neither Material semantics nor `AppThemeTokens` can provide the value.
- They are safety nets, not the primary path.

## Localization Defaults
- Reusable library-owned copy must resolve in this order:
  `caller override -> localization key/template -> safe plain-string fallback`
- This applies to dialog defaults, submit labels, validation messages, search placeholders, and reusable state/helper messages.

## Not Debt
- Safe plain-string fallback as the last resort.
- Direct Material semantic usage when it is the correct source.
- Small local layout values when no shared token is needed.

## Rejected Patterns
- Wrapper-based theme injection systems
- Parallel custom theme managers
- App-specific theme containers inside the library
- Duplicating all of `ColorScheme`, `TextTheme`, or Material component themes into `AppThemeTokens`
