# Repo Audit Summary (2026-03)

This document captures the architectural audit findings and the first stabilization changes applied during the audit.

## Executive summary
The repo already has the right *shape* for a shared UI library (tokens, primitives vs patterns, example catalog, widget tests). The biggest risks are:
- a **large public surface** exported directly from `src/` (refactors are API-sensitive)
- **theme brittleness** in a few chokepoints (`!` assertions + palette map lookups)
- **rule drift** in design-token usage (raw spacing/padding in a handful of core widgets)
- a **parallel localization system** (JSON loader + key constants) that is usable but requires discipline to keep keys/JSON/tests aligned

## Critical / High findings (file-specific)

### Theme crash vectors
- **Risk**: `Map` palette lookups with `!` can crash theme building if keys change.
  - **Files**: `lib/src/ui/resources/theme.dart`
- **Risk**: token fallback resolution previously forced `!` unwraps.
  - **Files**: `lib/src/ui/resources/app_theme_tokens.dart`

### Theming precedence ambiguity (inputs)
- Inputs are effectively themed via `AppThemeTokens` today; host `InputDecorationTheme` is not the primary override path.
  - **Files**: `lib/src/ui/widgets/controls/inputs/simple_text_field.dart`, `lib/src/ui/widgets/controls/dropdown/simple_dropdown.dart`
  - **Action**: codify precedence in `AGENTS.md` and keep tests aligned with expected usage.

### Public API size
- `lib/j_flutter_ui.dart` exports many internals. This makes maintenance harder because many “internal” refactors become breaking changes.
  - **Files**: `lib/j_flutter_ui.dart`
  - **Recommendation**: introduce an explicit “public API barrel” structure over time, and reduce exports only via planned migrations.

## Medium / Low findings (representative)
- Repeated `alphaBlend` / `withAlpha` “tinted surface” recipes across feedback widgets (snackbar/banner/badge/chip). This is consistency debt.
- Occasional raw spacing/padding values in core infrastructure (e.g. `SimpleFormBuilder` radio option spacing).
- `AppText` had non-token default font-size bounds for auto-fit.

## Changes applied in this audit (first pass)
- **Theme/token null-safety**:
  - removed forced unwraps in token fallback resolution (`AppThemeTokens` / theme construction)
  - removed `!` map lookups for palette colors in `JAppTheme` construction (safe fallbacks)
- **Input decoration consistency**:
  - preserved host-provided border *shape* and width when building input borders
  - kept `AppThemeTokens` as the primary semantic override mechanism for input fill/border colors
- **De-duplication for consistency**:
  - centralized shared input decoration building in `JInputDecorations`
  - centralized tinted surface/border recipes in `JTints`
- **Token consistency**:
  - `SimpleFormBuilder.fieldSpacing` default now uses `JDimens.dp16`
  - radio option spacing uses `JDimens` (no raw `8`)
- **Typography consistency**:
  - `AppText` auto-fit defaults now use `JFontSizes` tokens
- **Minor visual consistency**:
  - `SimpleSwitch.trackOutlineWidth` now uses `JDimens.dp1`

All changes are covered by existing tests and the suite passes via `flutter test`.

## Next refactors (planned, not yet executed)
- Create a small internal utility for “tinted surface” recipes to de-duplicate feedback styling.
- Reduce duplication between `SimpleTextField` and `SimpleDropdown` decoration construction.
- Tighten localization key/JSON synchronization workflow and add a minimal key-coverage test.
- Establish a public API policy for what should/shouldn’t be exported from `j_flutter_ui.dart`.

