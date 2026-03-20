# j_flutter_ui Example

This is the demo catalog and QA surface for `j_flutter_ui`.

Use it to validate reusable widget behavior, theming, and public API changes before relying on them downstream.

When a widget wraps a standard Material component, use the catalog together with host `ThemeData` overrides to verify the expected resolution order:
- explicit widget parameter
- matching Material component theme
- `AppThemeTokens`
- final fallback constants

Notable navigation demos:
- `Vertical Rail` shows the default rail plus the reusable `selectedItemBackgroundColor` selected-state highlight.
- `Bottom Nav Bar` shows the reusable `activeIconBackgroundColor` circle treatment for the active icon.
