# Architecture Rules

> Structural rules for `j_flutter_ui`. Apply when adding files, layers, or infrastructure.
> For theming rules, see `THEMING_RULEBOOK.md`. For API rules, see `API_DESIGN_RULES.md`.

---

## Source layout (enforced)

```
lib/
  j_flutter_ui.dart              ← ONLY supported consumer import
  src/ui/
    constants/                   ← country/currency codes, static constants
    localization/                ← JSON localization + AppLocalizationBridge
    resources/                   ← tokens, theme infrastructure, asset helpers
    utils/                       ← small stateless reusable utilities
    widgets/
      primitives/                ← single-responsibility Material wrappers
      patterns/                  ← compositions of primitives
example/                         ← catalog app — must remain runnable
assets/                          ← svg/png/jpg + localization JSON
test/                            ← regression tests
```

**Rules:**
- Do NOT place app-specific logic in any `src/` path.
- Do NOT import from `src/` in consumer apps. Public API is `lib/j_flutter_ui.dart` only.
- Do NOT place pattern logic inside primitives.
- `example/` must remain runnable at all times. A broken catalog is a blocking issue.

---

## Widget layer rules

### Primitives (`widgets/primitives/`)
- Single responsibility only.
- Thin wrapper over one Material semantic widget.
- Do NOT compose other library primitives inside a primitive.
- Do NOT implement app-specific logic, routing, or state.

### Patterns (`widgets/patterns/`)
- Must compose primitives. Do NOT re-implement styling logic that already exists in a primitive.
- If styling logic appears in 3+ widgets, centralize it in `resources/` as a shared helper.
- Do NOT place app domain logic, navigation, or state management inside a pattern.

---

## Resource layer rules (`resources/`)

### Tokens
Use the correct token class for each value type:

| Value type | Token class |
|---|---|
| Fixed gaps (SizedBox) | `JGaps` |
| Padding / insets | `JInsets` |
| Dimensions / radii | `JDimens` |
| Heights | `JHeights` |
| Icon sizes | `JIconSizes` |
| Font sizes | `JFontSizes` |
| Line heights | `JLineHeights` |
| Typography presets | `JTextStyles` |

- Do NOT use raw numbers for any of the above. Raw numbers in widget code are a bug.
- Add a new token only if the value is reused across multiple widgets or is part of a system scale.

### Shared styling helpers
- `JInputDecorations` → all `InputDecoration` construction for inputs. Do NOT duplicate input decoration logic inline.
- `JTints` → all tinted surface/border recipes for feedback components (badge/banner/snackbar/chip). Do NOT duplicate tint recipes inline.
- Both helpers must follow the standard resolution order: Material semantics → `AppThemeTokens` → fallback constants.
- Do NOT hardcode color constants directly inside helpers.

---

## Theming infrastructure

- `JAppTheme` provides `lightTheme` and `darkTheme` as ready-to-use `ThemeData` instances.
- `AppThemeTokens` is a `ThemeExtension<AppThemeTokens>` for library-owned semantic tokens.
- Access tokens only via: `Theme.of(context).appThemeTokens`
- `AppThemeTokens.defaults(ThemeData)` provides a safe zero-config fallback for consumers who do not register a custom token set.
- If no `AppThemeTokens` is registered, `theme.appThemeTokens` must return `AppThemeTokens.defaults(theme)` silently. Library widgets must NEVER throw due to missing token registration.

---

## Localization infrastructure

- Library JSON lives in `assets/localization/<lang>.json`.
- Keys are registered in `lib/src/ui/localization/l.dart` (class `L`).
- `AppLocalizationBridge` allows host apps to override any library key at runtime.
- `JLocalizations.fallback()` returns a plain-English instance. Widgets must NEVER throw when the delegate is absent.
- Resolution order: caller override → `AppLocalizationBridge` → library JSON → key fallback → plain-string fallback.

---

## Form infrastructure

Four distinct layers — do NOT merge:

| Layer | Responsibility |
|---|---|
| `SimpleFormBuilder` | Renders form fields from configuration |
| `SimpleFormController` | Manages field values and initial state |
| `SimpleFormValidator` / `SimpleCrossFieldValidator` | Validation logic only |
| utilities | Shared helpers, no rendering or state |

### Reset semantics (do NOT unify)
- `SimpleFormBuilderState.reset()` → blank-form reset: field values → `null`, text controllers → empty, errors cleared.
- `SimpleFormController.resetToInitialValues()` → restores original controller values.
- `SimpleFormController.reset()` → controller-only clear.

---

## Navigation patterns

### SimpleVerticalRail
- Compact left-edge icon-label rail.
- Active state: color-change. Optional selected background via `selectedItemBackgroundColor`.
- Do NOT add built-in position indicators (dot, bar). These are app-layer `Stack` composition.
- Per-item badges: use `badgeLabel` on `SimpleVerticalRailItem`.

### SimpleBottomNavBar
- Respects `BottomNavigationBarThemeData` before token fallback.
- Optional active icon circle: `activeIconBackgroundColor`.
- Do NOT turn into a custom item-renderer API.

### SimpleTabs
- Respects `TabBarThemeData` before token fallback.

---

## Overlay patterns

### SimpleBottomSheet
- Respects `BottomSheetThemeData` before token fallback.

### SimpleFloatingBanner
- Composition-first: `media` slot for images, `child` slot for content.
- Do NOT bake in campaign-specific layouts, prices, or brand structure.
- Respects `DialogTheme` and `IconButtonTheme` before token fallback.

---

## Test requirements

- Every risky theming fallback must have a regression test.
- Every null-safety path must have a regression test.
- Every widget with library-owned copy must have a localization override test.
- `example/` catalog must remain runnable — treat a broken catalog as a blocking bug.
