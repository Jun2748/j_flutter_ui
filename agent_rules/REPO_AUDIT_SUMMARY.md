# Repo Audit Summary (2026-03)

> ⚠️ HISTORICAL RECORD ONLY.
> Do NOT treat this file as active rules.
> Do NOT use this file as input for automated code changes or agent instructions.
> For active rules: see `AGENTS.md`, `THEMING_RULEBOOK.md`, `API_DESIGN_RULES.md`, `ARCHITECTURE.md`, `LOCALIZATION_RULES.md`.
> For resolved gap history: see `RESOLVED_GAPS.md`.

---

## Executive summary

The repo already has the right shape for a shared UI library (tokens, primitives vs patterns, example catalog, widget tests). The biggest risks identified were:
- A large public surface exported directly from `src/` (refactors are API-sensitive)
- Theme brittleness in a few chokepoints (`!` assertions + palette map lookups)
- Rule drift in design-token usage (raw spacing/padding in a handful of core widgets)
- A parallel localization system (JSON loader + key constants) that is usable but requires discipline to keep keys/JSON/tests aligned

---

## Critical / High findings (file-specific)

### Theme crash vectors
- **Risk**: `Map` palette lookups with `!` can crash theme building if keys change.
  - **Files**: `lib/src/ui/resources/theme.dart`
- **Risk**: Token fallback resolution previously forced `!` unwraps.
  - **Files**: `lib/src/ui/resources/app_theme_tokens.dart`

### Theming precedence ambiguity (inputs)
- Inputs are effectively themed via `AppThemeTokens` today; host `InputDecorationTheme` is not the primary override path.
  - **Files**: `lib/src/ui/widgets/controls/inputs/simple_text_field.dart`, `lib/src/ui/widgets/controls/dropdown/simple_dropdown.dart`
  - **Action taken**: Precedence codified in `AGENTS.md`. Tests aligned.

### Public API size
- `lib/j_flutter_ui.dart` exports many internals. This makes maintenance harder because many "internal" refactors become breaking changes.
  - **Files**: `lib/j_flutter_ui.dart`
  - **Status**: Planned reduction via explicit public API policy. In progress.

---

## Medium / Low findings (representative)

- Repeated `alphaBlend` / `withAlpha` tinted surface recipes across feedback widgets — consistency debt, centralized in `JTints`.
- Occasional raw spacing/padding values in core infrastructure (e.g. `SimpleFormBuilder` radio option spacing) — fixed via `JDimens`.
- `AppText` had non-token default font-size bounds for auto-fit — fixed via `JFontSizes`.

---

## Changes applied in this audit (first pass)

- **Theme/token null-safety**: removed forced unwraps in token fallback resolution; removed `!` map lookups for palette colors in `JAppTheme` construction.
- **Input decoration consistency**: preserved host-provided border shape and width; kept `AppThemeTokens` as primary semantic override for input fill/border colors.
- **De-duplication**: centralized input decoration building in `JInputDecorations`; centralized tinted surface/border recipes in `JTints`.
- **Token consistency**: `SimpleFormBuilder.fieldSpacing` default → `JDimens.dp16`; radio option spacing → `JDimens`.
- **Downstream ergonomics**: renamed dialog API to avoid Flutter Material naming collisions (`SimpleAlertDialog`); added `SimpleTextField.initialValue`; extended `AppThemeTokens` with paired `on*` foregrounds and resolved helpers.
- **Typography consistency**: `AppText` auto-fit defaults → `JFontSizes` tokens.
- **Minor visual consistency**: `SimpleSwitch.trackOutlineWidth` → `JDimens.dp1`.

---

## Next refactors (planned, not yet executed — DO NOT treat as active tasks)

- Reduce public API surface: audit `lib/j_flutter_ui.dart` exports and move internal symbols out of public API via planned migration.
- Tighten localization key/JSON synchronization workflow and add a key-coverage test.
- Establish explicit versioning policy (now documented in `API_DESIGN_RULES.md`).
