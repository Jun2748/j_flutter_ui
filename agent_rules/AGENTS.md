# j_flutter_ui — Agent & Maintainer Rules

> Read this file before changing any code.
> This file contains RULES ONLY. For historical gap tracking, see `RESOLVED_GAPS.md`. For audit history, see `REPO_AUDIT_SUMMARY.md`.

---

## Library contract (non-negotiables)

- `j_flutter_ui` must remain **app-agnostic**, **themeable**, **localization-safe**, and **stable** across multiple downstream apps.
- Do NOT fix library issues by changing consumer app code.
- Do NOT add app routing, app state management, or app domain models inside any library widget.
- Do NOT hardcode app/business copy in reusable widgets.
- Do NOT introduce a parallel theme system. Use Flutter-native `ThemeData` + `ThemeExtension` only.
- Do NOT use `!` force-unwrap unless the null guarantee is obvious, local, and documented inline.
- Do NOT make breaking changes to public API without a migration plan in `MIGRATION_NOTES.md`.
- Do NOT refactor unrelated code in the same diff (no drive-by refactors).

---

## Repo map

| Path | Purpose |
|---|---|
| `lib/j_flutter_ui.dart` | Public entrypoint. Everything exported here is public API. |
| `lib/src/ui/resources/` | Tokens (`JDimens`, `JInsets`, `JTextStyles`), `JAppTheme`, `AppThemeTokens`. |
| `lib/src/ui/widgets/` | Primitives and patterns. |
| `lib/src/ui/localization/` | Library JSON localization + `AppLocalizationBridge`. |
| `example/` | Demo catalog and QA surface. Must remain runnable at all times. |
| `test/` | Regression suite. Must pass before any merge. |

---

## Widget layering

### Primitives
- Single responsibility. Thin wrappers around Material semantics.
- Do NOT compose other library primitives inside a primitive.
- Examples: `SimpleText`, `SimpleButton`, `SimpleIconButton`, `SimpleCard`, `SimpleTextField`, `SimpleListItem`.

### Patterns
- Compose primitives. Do NOT rebuild styling logic from scratch inside a pattern.
- Examples: `SimpleMenuTile`, `SimpleMenuSection`, `SimpleMenuPage`, `SimpleBottomNavBar`, `SimpleFormBuilder`, `SimpleVerticalRail`, `SimpleFloatingBanner`.

---

## Pre-edit checklist (run before every change)

1. Is the symbol you are touching exported from `lib/j_flutter_ui.dart`? If yes → treat as public API, breaking changes require migration plan.
2. Does an existing primitive or pattern already cover the need? If yes → compose it, do not add a new widget.
3. Are all visual values resolved in the correct order? (See theming rules below.)
4. For thin Material wrappers → does the matching component theme still participate before token fallback?
5. Does behavior change? If yes → add or update tests, especially for fallbacks and null cases.

---

## Theming rules

### Resolution order (STRICT — apply in this exact sequence)
```
explicit widget parameter
  → Material component theme (when semantically correct)
  → AppThemeTokens (ThemeExtension)
  → final fallback constants (last resort only)
```

### When to use Material semantics
Use Material semantics when the value is a standard Material semantic pairing:
- `theme.colorScheme.error`, `theme.colorScheme.onSurface`, `theme.textTheme`, `theme.appBarTheme`, `theme.iconTheme`
- Matching component themes for thin wrappers:

| Widget | Prefer before token fallback |
|---|---|
| `AppBarEx` | `theme.appBarTheme.backgroundColor` / `foregroundColor` |
| `SimpleBottomNavBar` | `theme.bottomNavigationBarTheme` |
| `SimpleTabs` | `theme.tabBarTheme` |
| `SimpleCheckbox` | `theme.checkboxTheme` |
| `SimpleSwitch` | `theme.switchTheme` |
| `SimpleAlertDialog` | `theme.dialogTheme` |
| `SimpleBottomSheet` | `theme.bottomSheetTheme` |
| `SimpleLoadingView` | `theme.progressIndicatorTheme` |
| compact icon-action primitives | `theme.iconButtonTheme.style` |

### When to use AppThemeTokens
Use `AppThemeTokens` when the library owns the semantic styling:
- `cardBackground`, `cardBorderColor`
- `inputBackground`, `inputBorderColor`
- `dividerColor`, `mutedText`
- `primary`, `secondary`

Read tokens only via the canonical accessor:
```dart
final AppThemeTokens tokens = Theme.of(context).appThemeTokens;
```

Do NOT access `AppThemeTokens` via any other path.

### Foreground/content color rule (token-owned surfaces)
If a widget sets a background via `AppThemeTokens`, use the paired resolved foreground — do NOT assume Material `on*` colors remain correct after token overrides:
- `tokens.onCardResolved(theme)` → for card / sheet / dialog / snackbar surfaces
- `tokens.onPrimaryResolved(theme)` → for primary action surfaces
- `tokens.onSecondaryResolved(theme)` → for secondary semantic surfaces

### Allowed fallback constants
- `Colors.transparent` and structurally harmless constants are allowed.
- All other hardcoded colors are last-resort fallback only. Document why inline.

### Theme safety
- Do NOT assume `ThemeData` subfields are non-null.
- Resolve all visual values once at the top of `build`. Do NOT scatter resolution across the widget tree.

---

## Spacing & sizing rules

| Need | Use |
|---|---|
| Fixed gaps | `JGaps` |
| Padding / insets | `JInsets` |
| Dimensions / radii | `JDimens` |
| Heights | `JHeights` — includes component heights: `appBar`, `button`, `input`, `listItem`, `menuTile`, `cardMin`, `bottomNav`, `bottomBar`, `tabBar`, `chip`, `badge`, `buttonSmall`, `productCard`, `promoBanner`, `railItem`, `searchBar` |
| Icon sizes | `JIconSizes` |
| Font sizes | `JFontSizes` |
| Line heights | `JLineHeights` |

- Do NOT use magic numbers for spacing, radius, heights, border widths, icon sizes, or font sizes.
- Before using a raw number for any height, check `JHeights` first — most common component heights are already defined.
- Add a new shared token only if the value is reused across multiple widgets or is part of a system scale.

---

## Text rules

- Use `SimpleText` by default.
- Use `AppText` for library-owned text that needs localization, HTML rendering, semantics label, or auto-fit.
- Use raw `Text` only when required by Flutter/third-party APIs or when Material component text styling must be inherited.
- If truncation is possible, always set `maxLines` and `overflow` explicitly.
- Use `SimpleText.sectionLabel` for uppercase grouped-content headers in ordering flows. It carries dedicated tracking and line height; do NOT substitute `SimpleText.label` for this role.
- Use `SimpleText.counter` for quantity values only. It is compact and uses tabular figures to keep digit widths stable during stepper changes.

---

## Localization rules

### Resolution order (STRICT — apply in this exact sequence)
```
caller override (explicit widget parameter)
  → AppLocalizationBridge (host app runtime override)
  → library JSON localization (assets/localization/<lang>.json)
  → key fallback (returns the key string — diagnostic only)
  → safe plain-string fallback (short English string — prevents runtime errors)
```

- Do NOT concatenate translated fragments to form a sentence. Use a single key with placeholders.
- When a `BuildContext` is available, pass it into localization-backed helpers so `AppLocalizationBridge` participates.

---

## Navigation widget rules

### SimpleVerticalRail
- Active state: color-change by default. Optional selected background via `selectedItemBackgroundColor`.
- Override active/inactive colors via `selectedItemColor` / `unselectedItemColor`.
- Do NOT add built-in position indicators (dot, bar, line). App-specific indicators must be `Stack` overlays on top.
- Per-item badges use `badgeLabel` on `SimpleVerticalRailItem`. Do NOT compute badge offsets at the app layer.

### SimpleBottomNavBar
- Supports active icon circle treatment via `activeIconBackgroundColor`.
- Per-item badges use `badgeLabel` on `SimpleBottomNavItem`. Do NOT compute badge overlays at the app layer.
- Do NOT expand into a custom item-renderer API for app-specific navigation chrome.

---

## Overlay patterns

### SimpleProgressOverlay
- Generic full-screen dimmed overlay. Barrier + card + indicator slot + optional message.
- Host app controls visibility via conditional `Stack` rendering. Do NOT build show/hide logic into the widget.
- `indicator` slot accepts any widget. `CircularProgressIndicator` is the default; custom animation widgets are appropriate for branded apps.
- Card background is transparent by default. The indicator floats over the dimmed barrier with no card chrome.
- Pass explicit `cardColor` to enable a card surface (for example `cardColor: Colors.white` for a visible card with rounded corners).
- Border radius is only applied when `cardColor` is explicitly provided.
- `AbsorbPointer` is built in. Do NOT wrap it again at the app layer.
- Usage pattern:
```dart
if (isLoading)
  SimpleProgressOverlay(
    indicator: MyCustomAnimation(),
    message: 'Loading...',
  )
```

## Commerce & quantity control rules

### SimpleQuantityStepper
- Pattern layer. Composes `SimpleIconButton.outline` + `SimpleText.counter` in a `Row`.
- Pass `onChanged: null` to disable both buttons. Do NOT suppress the callback silently.
- `minValue` defaults to `1`. Set to `0` only when item-removal on zero is handled at the **app layer**.
- Do NOT embed cart-removal or inventory logic inside the widget. Below-min decrement behavior belongs to the caller.
- Active/disabled colors resolve via `tokens.primary` / `tokens.mutedText`. Override with `activeColor`, `disabledColor`, `disabledBorderColor`.
- Do NOT use as a generic number input — it carries clamped quantity semantics.

### SimpleMultiSelectChipBar
- Primitive layer. Thin `FilterChip`-in-`Wrap`. Respects `ChipThemeData` before `AppThemeTokens` fallback.
- Mutual-exclusion logic (e.g. "None clears others") is the **caller's responsibility** inside `onChanged`. Do NOT add exclusive-selection logic inside the widget.
- `maxSelections: null` means no limit. When the limit is reached, non-selected chips become non-interactive (`onSelected: null`).
- `showCheckmark: false` is enforced inside the widget. Do NOT re-enable at the app layer.
- Do NOT use for single-select scenarios — use `SimpleChipBar` instead.

### SimpleSummaryRow
- Pattern layer. Composes `SimpleText.body` in a `MainAxisAlignment.spaceBetween` `Row`.
- Default colors: label and value both → `tokens.mutedText`.
- For emphasis (e.g. "Total"): pass `labelWeight: FontWeight.w700`, `valueColor: tokens.primary`, `valueWeight: FontWeight.w700`.
- The label side is `Flexible` (truncates). The value side never wraps — keep value strings short.
- Do NOT use for two-column equal-width grids. This widget is label-left / value-right only.

### SimpleStrikethroughPrice
- Pattern layer. Composes two `SimpleText.body` with token-driven color defaults.
- Defaults: original price → `tokens.mutedText` + `TextDecoration.lineThrough`, current price → `tokens.primary` + `FontWeight.w700`.
- Default constructor → `Row` with `Flexible` children + baseline alignment. Uses `mainAxisSize: MainAxisSize.max`. Do NOT revert to `MainAxisSize.min` — it overflows in tight grid cells.
- `.stacked()` constructor → `Column` with `CrossAxisAlignment.start` + `mainAxisSize: MainAxisSize.min`. Use for tight vertical product cards where horizontal space is limited.
- Gap defaults: `JDimens.dp8` for horizontal, `JDimens.dp2` for stacked.
- Pass `style` to override base text style for both prices (e.g. larger size). Strikethrough decoration is merged on top.
- Do NOT use `Column` with `CrossAxisAlignment.baseline` — baseline is a `Row`-only alignment.
- Do NOT use for non-price copy. It is a pricing component, not a generic strikethrough widget.

### SimpleVoucherCard
- Pattern layer. `CustomPainter` dashed border + `ClipRRect` + optional `InkWell`.
- Background resolves: explicit param → `theme.cardTheme.color` → `tokens.cardBackground`.
- Dashed border is drawn by `_DashedBorderPainter` via `PathMetrics`. Do NOT use `BoxDecoration.border` for dashed effects.
- Set `onTap` to make interactive. `null` renders a static, non-tappable surface.
- `child` slot accepts any content. Do NOT hardcode voucher layout inside the widget — it is composition-first.
- Do NOT mix `SimpleVoucherCard` and `SimpleCard` on the same surface. Choose one.

---

## Progress & status display rules

### SimpleStepIndicator
- Pattern layer. Custom `Row`/`Column` layout — no thin Material wrapper.
- Steps before `currentStep` are "completed", `currentStep` is "active", steps after are "incomplete".
- `currentStep` is clamped to `[0, steps.length - 1]`. Safe to pass any value.
- Connector lines are split into leading/trailing halves per cell, enabling correct color transitions.
- `icon` on `SimpleStepItem` renders only in completed and active dots.
- Do NOT add tap handlers to individual steps — this widget is display-only.
- Do NOT use as a page indicator — use `SimplePageIndicator` instead.

### SimpleRatingBar
- Primitive layer. `Row` of `Icon` widgets (full / half / empty stars via `Icons.star` / `Icons.star_half` / `Icons.star_border`).
- `rating` is clamped to `[0.0, starCount]`.
- Star thresholds (`fraction >= 1.0` full, `fraction >= 0.5` half) are intentional and not magic numbers.
- This is a **display-only** widget. Do NOT add interactive tap handling to it — implement a separate `SimpleRatingInput` at the app layer if needed.

### SimpleSkeletonBox
- Primitive layer. `StatefulWidget` with shimmer `AnimationController` + `AnimatedBuilder`.
- Default: `width: double.infinity`, `height: JDimens.dp16`, `borderRadius: JDimens.dp8`.
- `highlightColor` defaults to `baseColor` blended 50% toward `Colors.white` via `Color.lerp`.
- Animation constants are file-private named constants (`_kShimmerDuration`, `_kShimmerSweepRange`, etc.). Do NOT use raw millisecond or float literals for animation values.
- Do NOT use for interactive loading placeholders. It is display-only.

### SimplePageIndicator
- Primitive layer. `Row` of `AnimatedContainer` dots.
- Active dot animates to `activeDotWidth` (pill shape). Inactive dots are circles with diameter `dotSize`.
- `currentIndex` is clamped to `[0, count - 1]`. Safe to pass any value.
- Animation duration is `_kDotAnimationDuration` (250 ms). Do NOT use raw ms literals.
- Preferred placement: inside a `Stack` positioned at the bottom of a `PageView` banner.
- Do NOT use as a stepper progress indicator — use `SimpleStepIndicator` for multi-step flows.

---

## Action bar patterns

### SimpleBottomActionBar
- Sticky bottom bar for detail and checkout screens.
- Layout: label + price on left, primary CTA button on right.
- Use in `Scaffold.bottomNavigationBar`.
- Safe area is built in. Do NOT wrap in `SafeArea` at the app layer.
- `onAction: null` disables the button. Use this during loading to prevent double-tap.
- `loading` wires through to the CTA button loading state.
- Do NOT rebuild this pattern inline in app screens. Use the library widget.

---

## Button widget rules

### SimpleButton variants

| Constructor | Height | Text style | Use for |
|---|---|---|---|
| `SimpleButton.primary` | 48dp (`JHeights.button`) | `JTextStyles.button` | Standard CTA |
| `SimpleButton.secondary` | 48dp | `JTextStyles.button` | Secondary CTA |
| `SimpleButton.outline` | 48dp | `JTextStyles.button` | Tertiary / outlined CTA |
| `SimpleButton.text` | 48dp | `JTextStyles.button` | Inline text action |
| `SimpleButton.small` | 32dp | `JTextStyles.label` | Compact primary CTA (e.g. promo banners, inline cards) |
| `SimpleButton.smallOutline` | 32dp | `JTextStyles.label` | Compact outlined CTA |
| `SimpleButton.smallText` | 32dp | `JTextStyles.label` | Compact text action |

- Do NOT use boolean flags or manual `padding` hacks to approximate the small height. Use the dedicated small constructors.
- Do NOT use `SimpleButton.small` as a replacement for `SimpleIconButton` in toolbar contexts.

---

## Form rules

- Keep strict separation: builder / controller / validation / utilities are distinct layers.
- Preserve app-level override capability for backend errors.
- Do NOT add hidden flows or implicit navigation inside the form layer.
- `SimpleFormBuilderState.reset()` → blank-form reset: clears field values to `null`, clears errors.
- `SimpleFormController.resetToInitialValues()` → restores original controller values.
- `SimpleFormController.reset()` → controller-only clear path.
- These three reset paths have intentionally different semantics. Do NOT unify them.

---

## Shared styling helpers

- Use `JInputDecorations` for all `InputDecoration` building in inputs (keeps focus/error/disabled borders consistent).
- Use `JTints` for all tinted surface/border recipes in feedback components (badge/banner/snackbar/chip).
- Helpers must follow the same resolution order as widgets: Material semantics → `AppThemeTokens` → fallback constants.
- Do NOT hardcode `JColors` or any color constant directly inside `JInputDecorations`, `JTints`, or any shared helper.

### SimpleBadge icon-corner usage

For icon-corner count/status badges (e.g. nav item overlays), use `SimpleBadge.filled` with:
- `color: tokens.primary` and `foregroundColor: tokens.onPrimaryResolved(theme)` for primary-colored indicators.
- `padding: EdgeInsets.symmetric(horizontal: JDimens.dp4, vertical: JDimens.dp2)` for compact size.
- `labelWeight: FontWeight.w700` and `labelStyle: TextStyle(height: 1.0)` for tight pill rendering.

Do NOT create private badge widgets (e.g. `_NavItemBadge`) that duplicate this logic. Use `SimpleBadge.filled` directly.

---

## Public API rules

- Consumers import only `package:j_flutter_ui/j_flutter_ui.dart`. No `src/` imports.
- Every export from `lib/j_flutter_ui.dart` is semver-governed public API.
- Adding a new export → non-breaking (minor bump).
- Renaming, moving, or removing an export → breaking change (major bump), requires `MIGRATION_NOTES.md` entry.
- Do NOT export internal helpers unless there is an explicit documented reason.
- Do NOT name exported symbols to collide with Flutter SDK / Material types (e.g. do NOT export a type named `SimpleDialog`).

---

## PR labels (use consistently)

- `fully migrated`
- `partially migrated`
- `acceptable fallback`
- `intentional Material semantic usage`
