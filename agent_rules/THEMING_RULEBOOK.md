# Theming Rulebook

> Apply these rules whenever adding or modifying any visual styling in the library.
> For localization rules, see `LOCALIZATION_RULES.md`. For API rules, see `API_DESIGN_RULES.md`.

---

## Approved architecture

- Use Flutter-native `ThemeData` only.
- Use `ThemeExtension<AppThemeTokens>` for library-owned semantic tokens.
- Read tokens via `Theme.of(context).appThemeTokens` — this is the ONLY permitted read path.
- Do NOT access `AppThemeTokens` via any other path.

---

## Style resolution order (STRICT — apply in this exact sequence)

```
1. Explicit widget parameter
2. Material component theme (when semantically correct)
3. AppThemeTokens (ThemeExtension)
4. Final fallback constants (last resort only — document why inline)
```

---

## When to use Material semantics (step 2)

Use Material semantics when the value is a standard Material semantic pairing:

**Color / text semantics:**
- `theme.colorScheme.error`
- `theme.colorScheme.onPrimary`
- `theme.colorScheme.onSurface`
- `theme.textTheme`
- `theme.appBarTheme`
- `theme.iconTheme`
- `theme.iconButtonTheme.style`

**Component theme → widget mapping (prefer before token fallback):**

| Widget | Component theme |
|---|---|
| `AppBarEx` | `theme.appBarTheme.backgroundColor` / `foregroundColor` |
| `SimpleBottomNavBar` | `theme.bottomNavigationBarTheme` |
| `SimpleTabs` | `theme.tabBarTheme` |
| `SimpleCheckbox` | `theme.checkboxTheme` |
| `SimpleSwitch` | `theme.switchTheme` |
| `SimpleAlertDialog` | `theme.dialogTheme` |
| `SimpleBottomSheet` | `theme.bottomSheetTheme` |
| `SimpleLoadingView` | `theme.progressIndicatorTheme` |
| compact icon-action primitives | `theme.iconButtonTheme.style` |

Do NOT hard-override these component themes inside library widgets unless an explicit widget parameter is set.

---

## When to use AppThemeTokens (step 3)

Use `AppThemeTokens` when the library owns the semantic styling:

| Token | Purpose |
|---|---|
| `primary`, `secondary` | Library-owned primary/secondary action colors |
| `cardBackground` | Card / sheet / dialog surface |
| `cardBorderColor` | Card border |
| `inputBackground` | Input fill |
| `inputBorderColor` | Input border |
| `dividerColor` | Dividers |
| `mutedText` | Secondary / muted text |

Paired resolved foregrounds (use these when the background comes from tokens):

| Background token | Paired foreground |
|---|---|
| `tokens.cardBackground` | `tokens.onCardResolved(theme)` |
| `tokens.primary` | `tokens.onPrimaryResolved(theme)` |
| `tokens.secondary` | `tokens.onSecondaryResolved(theme)` |

Do NOT duplicate all of `ColorScheme` or `TextTheme` into `AppThemeTokens`.

---

## Foreground/content color rule

If a widget sets a background using `AppThemeTokens`, ALWAYS use the paired resolved foreground from tokens. Do NOT assume Material `on*` colors remain correct after token overrides.

This rule applies to:
- Card / sheet / dialog / snackbar / banner surfaces → `tokens.onCardResolved(theme)`
- Primary action surfaces / buttons → `tokens.onPrimaryResolved(theme)`
- Token-primary feedback and selection controls (badges, segmented controls, selected switches, selected checkboxes)

---

## Input affordance rule

- Use `prefixIcon` / `suffixIcon` for icons, flags, or interactive affordances inside inputs.
- Reserve `prefix` / `suffix` for simple inline affix content only.

---

## Shared styling helpers

- `JInputDecorations` → all `InputDecoration` construction for inputs.
- `JTints` → all tinted surface/border recipes for feedback components (badge/banner/snackbar/chip).
- Both helpers MUST follow the same resolution order as widgets.
- Do NOT hardcode `JColors` or any color constant directly inside helpers. Resolve through `AppThemeTokens` or Material semantics first.
- Helpers with no theme access are permitted only for purely structural values (padding, radius) that carry no semantic color.

---

## Fallback constants (step 4)

- Allowed only when neither Material semantics nor `AppThemeTokens` can provide the value.
- `Colors.transparent` and structurally harmless constants are always allowed.
- All other hardcoded colors require an inline comment explaining why.
- Fallback constants are safety nets, not the primary styling path.

---

## ThemeExtension registration contract

### Consumer responsibility

```dart
// Option A — custom tokens
ThemeData(
  extensions: [
    AppThemeTokens(
      cardBackground: myColor,
      // ... other tokens
    ),
  ],
)

// Option B — zero-config (derives safe values from ThemeData)
ThemeData theme = ThemeData(...);
theme = theme.copyWith(
  extensions: [AppThemeTokens.defaults(theme)],
);
```

### Canonical accessor (only permitted read path)

```dart
extension AppThemeTokensX on ThemeData {
  AppThemeTokens get appThemeTokens =>
      extension<AppThemeTokens>() ?? AppThemeTokens.defaults(this);
}
```

### Null-safety fallback

- If no `AppThemeTokens` is registered, `theme.appThemeTokens` silently returns `AppThemeTokens.defaults(theme)`.
- Library widgets MUST NEVER throw because a consumer omitted the registration step.
- `AppThemeTokens.defaults` must be pure and free of `BuildContext`.

### Token versioning

| Change | Version impact |
|---|---|
| Adding a new token with a sensible default in `AppThemeTokens.defaults` | Non-breaking (minor) |
| Removing or renaming a token | Breaking (major) — requires `MIGRATION_NOTES.md` entry |

---

## Localization contract (summary — full rules in LOCALIZATION_RULES.md)

### Resolution order

```
1. Caller override (explicit widget parameter)
2. AppLocalizationBridge (host app runtime override)
3. Library JSON (assets/localization/<lang>.json)
4. Key fallback (returns key string — diagnostic only)
5. Plain-string fallback (short English — prevents runtime errors)
```

### Mechanism

```dart
// Read library strings
final loc = JLocalizations.of(context) ?? JLocalizations.fallback();
```

- The delegate must be registered in `MaterialApp.localizationsDelegates`.
- `JLocalizations.fallback()` provides plain-English safe strings. Widgets NEVER throw when delegate is absent.
- Every widget with library-owned copy must expose a nullable string parameter per user-visible string.

---

## Rejected patterns

- Wrapper-based theme injection systems
- Parallel custom theme managers
- App-specific theme containers inside the library
- Duplicating all of `ColorScheme`, `TextTheme`, or Material component themes into `AppThemeTokens`
- Hardcoding `JColors` constants inside `JInputDecorations`, `JTints`, or any shared helper
- Accessing `AppThemeTokens` via any path other than `theme.appThemeTokens`
- Library widgets that throw when `AppThemeTokens` or `JLocalizations` are not registered
- Localization delegates missing keys for any library-owned string
- Token-owned background surfaces paired with Material `on*` foreground colors (use paired token foregrounds instead)

---

## Not debt (these are intentional and correct)

- Safe plain-string fallback as the last resort
- Direct Material semantic usage when it is the correct source
- Small local layout values when no shared token exists
- `AppThemeTokens.defaults(theme)` as the unregistered-consumer fallback
- `JLocalizations.fallback()` as the unregistered-delegate fallback
- `SimpleProgressOverlay` transparent card default is intentional, not a missing token fallback
