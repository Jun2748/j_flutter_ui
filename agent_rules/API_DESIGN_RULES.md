# API Design Rules

> These rules govern every widget and exported symbol in `j_flutter_ui`.
> Apply these rules when adding, modifying, or reviewing any public API.

---

## Public API boundary

- Everything exported from `lib/j_flutter_ui.dart` is public API governed by semver.
- Consumers import ONLY `package:j_flutter_ui/j_flutter_ui.dart`. No `src/` imports are permitted.
- Do NOT export internal helpers unless there is an explicit documented reason.
- Treat all "public-by-accident" exports as bugs to fix via planned migration, not immediate removal.

### Semver policy

| Change type | Version bump |
|---|---|
| New export (additive) | Minor |
| New named parameter with default value | Minor |
| Rename / move / remove export | Major — requires `MIGRATION_NOTES.md` entry |
| Remove or rename `AppThemeTokens` token | Major — requires `MIGRATION_NOTES.md` entry |
| Deprecate before remove | Required intermediate step |

Migration sequence for breaking changes: **deprecate → migrate → remove**, with notes in `MIGRATION_NOTES.md`.

> **Current version: 2.1.0** (read from `pubspec.yaml` — update this when bumping).

---

## Naming rules

- Do NOT export symbols whose names collide with Flutter SDK or Material types.
  - WRONG: exporting a type named `SimpleDialog` (Material already exports this).
  - CORRECT: `SimpleAlertDialog` (maps to `AlertDialog`).
- Prefer names that reflect the underlying Material primitive being wrapped.

---

## Constructor design

- Use **named constructors** for clearly distinct visual variants (e.g. `SimpleButton.primary`, `SimpleButton.outline`, `SimpleButton.text`).
- Do NOT use boolean flags to control visual variants. Three or more booleans controlling appearance is a hard stop — redesign as named constructors or an enum.
- Use `onPressed == null` to represent disabled state. Do NOT add a separate `enabled` boolean.
- Do NOT require styling parameters. All styling must have sensible defaults from theme/tokens.
- For genuinely semantic and common presentation variants (e.g. standard vs quiet search), use a small enum. Do NOT use ad-hoc route-scoped theme overrides.

---

## Styling parameters

- Expose the **semantic knob** (e.g. `backgroundColor`), not a set of micro-parameters.
- When a styling knob is `null`, the widget MUST fall back to theme/tokens correctly.
- Do NOT create a second parallel theming system via custom style classes.
- For text inputs: use `prefixIcon` / `suffixIcon` for icons, flags, or interactive affordances. Reserve `prefix` / `suffix` for simple inline affix content only.

---

## Text / content parameters

- For pattern widgets with complex content slots, prefer `Widget` parameters (`title`, `subtitle`, `leading`, `trailing`).
- For primitive widgets that accept strings:
  - Allow `null` and treat it as empty.
  - Never suppress truncation: set `maxLines` and `overflow` wherever truncation is possible.

---

## Behavioral parameters

- Async actions must expose an explicit `loading` parameter. Disable interaction consistently when `loading == true`.
- Do NOT introduce implicit side-effects (no auto-navigation, no reading global singletons).
- Multiple reset paths must have explicitly different semantics. Do NOT unify them silently. See form reset rules in `AGENTS.md`.

---

## Extensibility

- Prefer composition slots (`header`, `footer`, `content`, `media`, `child`) over subclassing.
- Do NOT couple widgets to app routing, app state management, or app domain models.
- Keep compact icon-action primitives domain-agnostic. The library provides the press target. Counts, price logic, inventory rules, and commerce flows belong in app-layer composition.
- For overlay and promo surfaces: use a composition-first widget (`media`, `child`). Do NOT bake in campaign-specific layouts, prices, or brand structure.

---

## Rejected patterns

- Boolean soup constructors (3+ booleans controlling visual variants)
- Styling via custom parallel theme classes
- Widgets that auto-navigate or read global app state
- Hard-coded business/product copy inside reusable widgets
- Named symbol collisions with Flutter SDK / Material exports
- Breaking changes without `MIGRATION_NOTES.md` entry
