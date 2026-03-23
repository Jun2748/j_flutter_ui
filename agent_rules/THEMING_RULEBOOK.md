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
1. Explicit widget parameter       ← design spec values live here
2. Material component theme        (when semantically correct)
3. AppThemeTokens (ThemeExtension)
4. Final fallback constants        (last resort only — document why inline)
```

Step 1 is where design-specified values belong. When a design spec provides an exact
color, size, or style that differs from a token default, pass it as an explicit widget
parameter — do NOT skip step 1 and let the token win by default.

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
| `SimpleMultiSelectChipBar` | `theme.chipTheme` (padding, shape, side, label style, selected color) |

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

## Design-provided colors vs token defaults

When a design spec provides a color value that differs from the current `AppThemeTokens` default:

- **Light mode**: pass the color as an explicit widget parameter (step 1 in the resolution
  order). Do NOT let the token default win when a spec value exists.
- **Dark mode**: if the dark-mode spec color also differs from the token default, apply
  the override at the `JAppTheme.darkTheme` registration level — not as an inline
  `Theme.of(context).brightness` conditional inside a widget.
- Do NOT hardcode `brightness`-conditional colors inline:
  ```dart
  // WRONG — hardcoded brightness conditional
  color: theme.brightness == Brightness.dark ? Color(0xFF1A1A2E) : Color(0xFFFFFFFF),
  ```
  Use `ThemeData.brightness`-aware token registration at the app level instead.
- Do NOT substitute a token color for a spec color because they look visually similar.
  Token values may diverge from the spec color in future theme updates.

---

## Token scope boundary

Token rules govern styling **inside library widget implementations**.
At the app layer, tokens are reference values and sensible defaults — not constraints.

| Context | Rule |
|---|---|
| Inside a library primitive or pattern | Use tokens. Raw values without documentation are a bug. |
| App screen layout matching a design spec | Spec wins. Use tokens only when they match the spec exactly. |
| App screen with no design spec provided | Use tokens as sensible starting defaults. |
| `example/` catalog screens | Tokens preferred; spec overrides allowed when demonstrating a specific variant. |

Never force app-layer layout to conform to library tokens at the cost of design accuracy.

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
- Inline `brightness`-conditional hardcoded colors — use theme registration instead
- Substituting a token color for a design-spec color because they look similar

---

## Not debt (these are intentional and correct)

- Safe plain-string fallback as the last resort
- Direct Material semantic usage when it is the correct source
- Small local layout values when no shared token exists
- `AppThemeTokens.defaults(theme)` as the unregistered-consumer fallback
- `JLocalizations.fallback()` as the unregistered-delegate fallback
- `SimpleProgressOverlay` transparent card default is intentional, not a missing token fallback
- Explicit spec-value overrides at the app layer when the design differs from token defaults
