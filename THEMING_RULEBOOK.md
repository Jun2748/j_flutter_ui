# Theming Rulebook

## Approved Architecture
- Use Flutter-native `ThemeData`.
- Use `ThemeExtension<AppThemeTokens>` for library-owned semantic tokens.
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

## Use AppThemeTokens When
- The library owns the semantic styling.
- Current token examples:
  `cardBackground`
  `cardBorderColor`
  `inputBackground`
  `inputBorderColor`
  `dividerColor`
  `mutedText`

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
