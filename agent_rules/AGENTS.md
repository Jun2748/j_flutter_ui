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
  - Examples: `SimpleText`, `SimpleButton`, `SimpleIconButton`, `SimpleCard`, `SimpleTextField`, `SimpleListItem`.
- **Patterns**: compose primitives; do not rebuild styling logic from scratch.
  - Examples: `SimpleMenuTile`, `SimpleMenuSection`, `SimpleMenuPage`, `SimpleBottomNavBar`, `SimpleFormBuilder`, `SimpleVerticalRail`.

## Active indicator pattern (navigation)
`SimpleVerticalRail` provides color-change only (active: `colorScheme.onSurface`, inactive: `tokens.mutedText`). It intentionally has no built-in position indicator (dot, bar, etc.). App-specific indicators must be implemented as `Stack` overlays on top of the widget. Do not add indicator logic into the library widget itself.

## Theming contract (what downstream apps rely on)
Use Flutter-native theming only.

### Resolution order (default)
Every visual value should resolve in this order:
`explicit widget parameter -> Material semantic theme source when semantically correct -> AppThemeTokens (ThemeExtension) -> final fallback constants`

Rationale: downstream apps often customize library-owned styling via `AppThemeTokens`, while standard Material surfaces/components should still respect their matching Material theme APIs (for example `AppBarTheme` for app bars).

### Use Material semantics when
- The value is a standard Material semantic pairing.
- Examples: `theme.colorScheme.error`, `theme.colorScheme.onSurface`, `theme.textTheme`, `theme.appBarTheme`, `theme.iconTheme`.
- For compact icon-action primitives, prefer `theme.iconButtonTheme.style` before token fallback.
- `AppBarEx` should prefer `theme.appBarTheme.backgroundColor` / `foregroundColor` before token fallback.

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
- When a `BuildContext` is available, pass it into localization-backed validation/message helpers so the app override bridge participates.

## Forms (core infrastructure)
- Keep separation between builder/controller/validation/utilities.
- Preserve app-level override capability for backend errors.
- Avoid making the form layer “too smart” (no hidden flows).
- `SimpleFormBuilderState.reset()` is the blank-form reset: it clears configured field values to `null` and clears errors.
- `SimpleFormController.resetToInitialValues()` remains the restore-initial-values path.

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

## Known gaps (confirmed by validation screen builds)

These are real reusable primitives/behaviors missing from the library. They have been confirmed by two or more validation screens that had to work around them. Fix them here when prioritized — do **not** let the workarounds drift into a permanent app-layer pattern.

### `SimpleGrid` — missing 2-column (and n-column) layout primitive
**Confirmed by:** `zus_menu_page.dart`, `zus_menu_page_v2.dart`
Both screens hand-roll `Row` pairs inside `VStack` to produce a 2-column product grid. The pattern is identical in both files and will appear in any future product/catalog screen.

Proposed API:
```dart
SimpleGrid({
  required int columnCount,
  required double gap,
  required List<Widget> children,
})
```

Classification: **real reusable gap**.

---

### `SimpleVerticalRail` — no `selectedItemColor` parameter
**Confirmed by:** `zus_menu_page.dart`, `zus_menu_page_v2.dart`, `tea_pickup_v2_page.dart`
All three screens work around the missing parameter by wrapping the rail in a `Theme` that mutates `colorScheme.onSurface` to the desired active color. This is a repeated, non-obvious workaround.

Proposed fix: add `selectedItemColor` and `unselectedItemColor` optional parameters to `SimpleVerticalRail`, resolving to current defaults if not set.

Classification: **real reusable gap**.

---

### `SimpleCard` — no flush / edge-to-edge variant
**Confirmed by:** `zus_menu_page.dart`, `zus_menu_page_v2.dart`
`SimpleCard`'s default `margin: JInsets.all16` and `radius: 16dp` prevent use as a full-bleed hero banner surface. Both screens fall back to raw `DecoratedBox` to achieve flush-to-edge treatment.

Proposed fix: support `margin: EdgeInsets.zero` without layout side-effects, or add a `.banner` / `.flush` named constructor that removes margin and radius.

Classification: **real reusable gap**.
