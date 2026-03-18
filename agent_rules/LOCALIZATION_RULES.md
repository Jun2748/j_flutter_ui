# Localization Rules

## Ownership
- **Host app owns product/business copy.** Do not hardcode app-specific strings inside reusable widgets.
- **Library may own only** generic reusable copy and demo/catalog copy.

Examples of acceptable library-owned copy:
- generic buttons like “Okay”, “Cancel”
- generic validation messages
- generic states like “Something went wrong”
- demo-only labels shown in `example/`

## Resolution order (required)
When the library provides default copy, resolve in this order:
1. **Caller override** (explicit widget parameter like `confirmText`, `hintText`, `retryLabel`)
2. **Host app override bridge** (`AppLocalizationBridge`)
3. **Library localization JSON** (`assets/localization/<lang>.json`)
4. **Key fallback** (the localization key itself, as a diagnostic)
5. **Safe plain-string fallback** (English, short, generic)

## API usage
- Use `Intl.text(key, context: context, args: ...)` when a `BuildContext` is available.
- Context-less calls to `Intl.text(key)` are allowed for utilities (e.g., validators) but should accept that the first call may return the key until the fallback localization loads.

## Keys and JSON
- Keys should be registered in `lib/src/ui/localization/l.dart` (class `L`).
- Library translations live in `assets/localization/<lang>.json` and should match keys in `L`.
- **Do not concatenate translated fragments** to form a sentence.
  - Use a single key with placeholders instead (e.g. `{field}`, `{length}`).

## Interpolation rules
- Placeholders use `{name}` and are resolved by passing `args: {'name': '...'}`.
- Always provide safe fallbacks for placeholder-based messages (tests should cover them).

## Testing expectations
Add/keep tests for:
- placeholder interpolation correctness
- safe fallback behavior when localization is missing
- widgets with default copy (dialogs, states, validation messages)

