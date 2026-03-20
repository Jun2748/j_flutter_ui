# Localization Rules

> Apply these rules whenever adding or modifying any user-visible string in the library.

---

## Ownership boundary

- **Host app owns** all product/business copy. Do NOT hardcode app-specific strings inside reusable widgets.
- **Library owns only** generic reusable copy and demo/catalog copy.

Acceptable library-owned copy examples:
- Generic actions: "Okay", "Cancel", "Retry", "Close"
- Generic validation messages: "This field is required", "Invalid format"
- Generic states: "Something went wrong", "No results found"
- Demo-only labels shown in `example/`

---

## Resolution order (STRICT — apply in this exact sequence)

```
1. Caller override       — explicit widget parameter (e.g. confirmText, hintText, retryLabel)
2. AppLocalizationBridge — host app runtime override
3. Library JSON          — assets/localization/<lang>.json
4. Key fallback          — returns the key string (diagnostic only, never shown to real users)
5. Plain-string fallback — short English string, prevents runtime errors
```

**Rules:**
- Every widget that renders library-owned copy MUST expose a nullable string parameter for each user-visible string.
- When the parameter is non-null, use it as-is — bypass localization lookup entirely.
- The plain-string fallback (step 5) must be short enough to render without overflow in the default layout.
- The plain-string fallback is a crash-prevention safety net, NOT a translation substitute.

---

## API usage

- When `BuildContext` is available: use `Intl.text(key, context: context, args: {...})`.
- When `BuildContext` is unavailable (e.g. pure validators): use `Intl.text(key)` — acceptable, but the first call may return the key until the fallback localization loads.
- Validation and message helpers MUST accept an optional `BuildContext` and pass it through when called from widgets so `AppLocalizationBridge` participates.

---

## Keys and JSON

- Register all keys in `lib/src/ui/localization/l.dart` (class `L`).
- Library translations live in `assets/localization/<lang>.json` and MUST match keys in `L`.
- Every key in `L` MUST have a corresponding entry in every supported locale JSON file.
- Missing keys in any locale JSON file are a bug, not acceptable drift.

---

## Interpolation rules

- Use `{name}` placeholder syntax. Resolve via `args: {'name': '...'}`.
- Do NOT concatenate translated fragments to form a sentence. Use a single key with placeholders.
  - WRONG: `translate('hello') + ' ' + translate('world')`
  - CORRECT: single key `'hello_world'` with appropriate placeholders if needed
- Always provide safe fallbacks for placeholder-based messages.

---

## Delegate registration (consumer responsibility)

Consumers must register the delegate in `MaterialApp`:

```dart
MaterialApp(
  localizationsDelegates: [
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,
)
```

`JLocalizations.fallback()` returns a plain-English instance so library widgets NEVER throw when the delegate is absent.

---

## Test requirements

Every widget or utility with library-owned copy must have tests covering:
- Placeholder interpolation correctness
- Safe fallback behavior when localization is missing
- `AppLocalizationBridge` override behavior
- Key-coverage: every key in `L` has a corresponding entry in locale JSON (automated sync check preferred)
