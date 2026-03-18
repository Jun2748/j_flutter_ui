# API Design Rules (Widgets)

These rules exist to keep `j_flutter_ui` plug-and-play across many apps.

## Public API hygiene
- Anything exported by `lib/j_flutter_ui.dart` is public API.
- Prefer additive changes over breaking changes.
- Avoid renames/moves unless part of a deliberate migration with notes.

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

## Text parameters
- Prefer accepting `Widget` slots for complex content (`title`, `subtitle`, `leading`, `trailing`) in pattern widgets.
- For primitives that accept strings:
  - allow `null` and treat it as empty
  - never hide truncation defaults: specify `maxLines`/`overflow` where needed

## Behavioral parameters
- For async actions, make loading state explicit (`loading`) and ensure interaction is disabled consistently.
- Avoid implicit side-effects (don’t auto-navigate, don’t read global singletons).

## Extensibility
- Prefer composition slots (`header`, `footer`, `content`) over subclassing.
- Do not couple widgets to app routing, app state management, or app domain models.

