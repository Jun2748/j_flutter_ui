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
  - Examples: `SimpleMenuTile`, `SimpleMenuSection`, `SimpleMenuPage`, `SimpleBottomNavBar`, `SimpleFormBuilder`, `SimpleVerticalRail`, `SimpleFloatingBanner`.

## Active indicator pattern (navigation)
`SimpleVerticalRail` defaults to color-change active state and now also supports an optional selected background via `selectedItemBackgroundColor`. Defaults are active: `colorScheme.onSurface`, inactive: `tokens.mutedText`, but you can override the active/inactive colors via `selectedItemColor` / `unselectedItemColor`. It intentionally has no built-in position indicator (dot, bar, etc.). App-specific indicators must be implemented as `Stack` overlays on top of the widget. Do not add indicator logic into the library widget itself.

`SimpleBottomNavBar` supports the standard active-color treatment and an optional active icon circle treatment via `activeIconBackgroundColor`. Do not expand it into a custom item-renderer API for app-specific navigation chrome.

## Theming contract (what downstream apps rely on)
Use Flutter-native theming only.

### Resolution order (default)
Every visual value should resolve in this order:
`explicit widget parameter -> Material semantic theme source when semantically correct -> AppThemeTokens (ThemeExtension) -> final fallback constants`

Rationale: downstream apps often customize library-owned styling via `AppThemeTokens`, while standard Material surfaces/components should still respect their matching Material theme APIs (for example `AppBarTheme` for app bars).

### Use Material semantics when
- The value is a standard Material semantic pairing.
- Examples: `theme.colorScheme.error`, `theme.colorScheme.onSurface`, `theme.textTheme`, `theme.appBarTheme`, `theme.iconTheme`.
- Also prefer matching component themes when the widget is a thin wrapper over a Material control: `theme.bottomNavigationBarTheme`, `theme.tabBarTheme`, `theme.checkboxTheme`, `theme.switchTheme`, `theme.dialogTheme`, `theme.bottomSheetTheme`, `theme.progressIndicatorTheme`.
- For compact icon-action primitives, prefer `theme.iconButtonTheme.style` before token fallback.
- `AppBarEx` should prefer `theme.appBarTheme.backgroundColor` / `foregroundColor` before token fallback.
- `SimpleBottomNavBar`, `SimpleTabs`, `SimpleCheckbox`, `SimpleSwitch`, `SimpleAlertDialog`, `SimpleBottomSheet`, and `SimpleLoadingView` should all respect their matching Material component theme before token fallback.

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

## Reusable gaps now covered
- `SimpleVerticalRail` includes `selectedItemBackgroundColor` for reusable selected-state background highlights without app-layer overlays.
- `SimpleBottomNavBar` includes `activeIconBackgroundColor` for reusable active icon circle treatments without custom item rendering.
- `SimpleSearchField` includes a first-class `quiet` variant for soft-background / pill-like search bars. Keep it semantic and app-agnostic; do not turn it into a branded search template.
- `SimpleFloatingBanner` is the reusable centered promo/announcement overlay primitive. Keep it composition-first (`media`, `child`) and avoid baking in campaign-specific text, badges, prices, or brand layouts.

## Review workflow (what to do before you edit)
- Identify whether you’re touching **public API** (exported via `j_flutter_ui.dart`).
- Check for existing primitives/patterns before adding new ones.
- Ensure theming and tokens are resolved predictably.
- For thin wrappers over Material components, verify the matching component theme still participates before token fallback.
- Add/adjust tests when behavior changes (especially fallbacks and null cases).

## Labels for partial migrations (use consistently in PRs)
- `fully migrated`
- `partially migrated`
- `acceptable fallback`
- `intentional Material semantic usage`

## Resolved gaps (validated)

Previously confirmed validation gaps are now implemented in the library:

- `SimpleGrid` now provides a fixed n-column layout helper for catalog/product grids.
- `SimpleVerticalRail` supports `selectedItemColor` / `unselectedItemColor` so active-color customization no longer needs theme workarounds.
- `SimpleVerticalRail` supports `selectedItemBackgroundColor` so reusable selected-state highlights no longer need app-layer overlays.
- `SimpleBottomNavBar` supports `activeIconBackgroundColor` so reusable active icon circle treatments no longer need custom wrappers.
- `SimpleCard.flush` provides an edge-to-edge / full-bleed variant (no external margin, no corner radius) for hero banners.
- `SimpleSearchField` provides a `quiet` pill-like variant so common search bars do not need route-scoped input theme overrides.
- `SimpleFloatingBanner` provides a reusable centered promo/announcement overlay with dimmed backdrop, optional close affordance, and custom content/media composition.

If a new downstream gap is reintroduced, add it back here as a fresh “Known gaps” entry.
