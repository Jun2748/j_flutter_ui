# API Design Rules (Widgets)

These rules exist to keep `j_flutter_ui` plug-and-play across many apps.

## Public API hygiene
- Anything exported by `lib/j_flutter_ui.dart` is public API.
- Prefer additive changes over breaking changes.
- Avoid renames/moves unless part of a deliberate migration with notes.

## Naming (avoid Flutter SDK collisions)
- Do **not** export symbols whose names collide with common Flutter SDK/Material types.
  - Example: Material already exports `SimpleDialog`, so `j_flutter_ui` must not export a type with that name.
- Prefer names that reflect the underlying Material primitive:
  - Example: a wrapper around `AlertDialog` should be named like `SimpleAlertDialog` (not `SimpleDialog`).

## Export policy (library boundary)
- Consumers should import **only** `package:j_flutter_ui/j_flutter_ui.dart`.
- Treat all exports from `lib/j_flutter_ui.dart` as **stable, semver-governed API**.
- When adding new APIs:
  - Prefer exporting a small number of high-signal primitives/patterns.
  - Do not export internal helpers just because they exist under `src/`.
- When refactoring internals:
  - Do not rename/move/remove exported symbols without a **migration plan**.
  - Prefer deprecate → migrate → remove, with notes in `MIGRATION_NOTES.md` (create only when needed).
- Avoid “public-by-accident” APIs:
  - if a file/class is intended to be internal, keep it unexported (or explicitly document why it’s exported).

## Constructor design
- Prefer **named constructors** for clearly distinct variants (e.g. `primary/secondary/outline/text`) over boolean flags.
- Avoid “boolean soup”. If you see 3+ booleans controlling visual variants, it’s a smell.
- Prefer nullable callbacks to represent “enabled/disabled” (`onPressed == null`).
- Avoid requiring styling parameters; provide sensible defaults from theme/tokens.

## Styling parameters (keep override paths predictable)
When you expose styling knobs:
- expose the *semantic* knob (e.g., `backgroundColor`) not 10 micro-parameters
- ensure the widget still reads the host theme/tokens when the knob is null
- do not create a second, parallel theming system via custom classes
- for text inputs, prefer `prefixIcon` / `suffixIcon` for icons, flags, or interactive controls; reserve `prefix` / `suffix` for inline affix content

## Text parameters
- Prefer accepting `Widget` slots for complex content (`title`, `subtitle`, `leading`, `trailing`) in pattern widgets.
- For primitives that accept strings:
  - allow `null` and treat it as empty
  - never hide truncation defaults: specify `maxLines`/`overflow` where needed

## Behavioral parameters
- For async actions, make loading state explicit (`loading`) and ensure interaction is disabled consistently.
- Avoid implicit side-effects (don’t auto-navigate, don’t read global singletons).
- If multiple reset paths exist, keep their semantics explicit and intentionally different (for example blank-form reset vs restore-initial-values).

## Extensibility
- Prefer composition slots (`header`, `footer`, `content`) over subclassing.
- Do not couple widgets to app routing, app state management, or app domain models.
