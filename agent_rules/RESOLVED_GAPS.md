# Resolved Gaps (Historical Record)

> This file is HISTORICAL RECORD only.
> Do NOT treat entries here as active rules or pending tasks.
> Do NOT use this file as input for automated code changes.
> For active rules, see `AGENTS.md`.

---

## Validated and implemented (as of 2026-03, batch 2 — F&B widget set)

| Gap | Resolution |
|---|---|
| No reusable quantity stepper for cart / product-detail screens | `SimpleQuantityStepper` added — minus/count/plus row composing `SimpleIconButton.outline` + `SimpleText.counter`, token-driven active/disabled states |
| No multi-select chip group; required `Wrap`+`FilterChip` inline at app layer | `SimpleMultiSelectChipBar<T>` added — generic `FilterChip`-in-`Wrap` primitive; respects `ChipThemeData`; max-selection limit built in; mutual-exclusion logic delegated to caller |
| No label/value summary row; required repeated inline `Row` patterns in cart/checkout screens | `SimpleSummaryRow` added — `MainAxisAlignment.spaceBetween` row composing `SimpleText.body`, token-driven colors, emphasis via weight/color overrides |
| No strikethrough pricing component; required inline `TextDecoration` at app layer | `SimpleStrikethroughPrice` added — original+current price `Row` with `Flexible` children, merged strikethrough decoration, token-driven color defaults |
| No step-progress indicator for order-tracking and multi-step checkout flows | `SimpleStepIndicator` added — horizontal dot+connector track with completed/active/incomplete states, optional icons in dots, display-only |
| No star rating display; product detail and listing cards had no standardised rating component | `SimpleRatingBar` added — full/half/empty star row with optional review count, `rating` clamped to `starCount`, display-only |
| No shimmer loading skeleton; screens had no standardised loading placeholder | `SimpleSkeletonBox` added — shimmer-animated `AnimatedBuilder` rectangle, token-derived highlight color, configurable size/radius |
| No page/carousel dot indicator; promo banners and onboarding flows had no standardised position display | `SimplePageIndicator` added — animated pill-dot `Row`, active dot stretches to pill via `AnimatedContainer`, token-driven colors |
| No voucher/promo card with dashed border; app required inline `CustomPainter` | `SimpleVoucherCard` added — dashed-border card via `_DashedBorderPainter` + `PathMetrics`, composition-first `child` slot, optional `onTap` |

---

## Validated and implemented (as of 2026-03, batch 1)

The following gaps were identified during downstream validation in `playground_flutter_app` and have been implemented in the library:

| Gap | Resolution |
|---|---|
| Fixed n-column layout for catalog/product grids | `SimpleGrid` added |
| Active-color customization required theme workarounds | `SimpleVerticalRail` now supports `selectedItemColor` / `unselectedItemColor` |
| Selected-state highlights required app-layer overlays | `SimpleVerticalRail` now supports `selectedItemBackgroundColor` |
| Per-item badges required app-layer offset computation | `SimpleVerticalRailItem` now supports `badgeLabel` |
| Strong-emphasis badge variant was missing | `SimpleBadge.filled` added (solid color + luminance-computed foreground) |
| Active icon circle treatment required custom wrappers | `SimpleBottomNavBar` now supports `activeIconBackgroundColor` |
| `SimpleBottomNavItem` had no per-item badge support | `SimpleBottomNavItem.badgeLabel` added — rendered via `SimpleBadge.filled` overlay on the icon corner |
| No sticky bottom action bar primitive for detail/checkout screens | `SimpleBottomActionBar` added — price label left, CTA button right, safe-area aware, composition-first |
| `SimpleBottomNavItem` had no per-item badge support | `SimpleBottomNavItem.badgeLabel` added — same pattern as `SimpleVerticalRailItem.badgeLabel` |
| No generic full-screen loading overlay primitive | `SimpleProgressOverlay` added — dimmed barrier + transparent background by default + indicator slot + message. Pass `cardColor` explicitly to enable card chrome. App provides branded animation via `indicator` child. |
| No compact button variant for tight spaces | `SimpleButton.small` / `SimpleButton.smallOutline` / `SimpleButton.smallText` added (32dp height, `JTextStyles.label`) |
| Edge-to-edge / full-bleed card variant was missing | `SimpleCard.flush` added (no external margin, no corner radius) |
| Common search bars required route-scoped input theme overrides | `SimpleSearchField` now supports `quiet` pill-like variant |
| Promo/announcement overlays had no reusable primitive | `SimpleFloatingBanner` added (dimmed backdrop, optional close, `media` + `child` slots) |
| Horizontal single-select chip bar required app-layer glue | `SimpleChipBar` added |
| Missing fine-grained dimension scale values | `JDimens` expanded — added `dp6`, `dp10`, `dp18`, `dp36`, `dp44`, `dp80`, `dp96`, `dp100`, `dp180`, `dp200`, `dp240`, `dp260` |
| Missing small and large gap sizes | `JGaps` expanded — added `h2`, `h6`, `h40`, `h48`, `w2`, `w6`, `w40`, `w48` |
| Missing caption and subheading font sizes | `JFontSizes` expanded — added `fs10`, `fs18`, `fs28` |
| Missing tiny and hero icon sizes | `JIconSizes` expanded — added `xxs` (8dp), `xxl` (40dp) |
| Missing inset combinations and directional padding | `JInsets` expanded — added `horizontal32`, `vertical32`, `horizontal8Vertical4`, `horizontal16Vertical8`, `horizontal24Vertical16`, `onlyTop8/16/24`, `onlyBottom8/16/24` |
| Missing component height tokens for production UI | `JHeights` expanded — added `bottomNav`, `bottomBar`, `tabBar`, `chip`, `badge`, `buttonSmall`, `productCard`, `promoBanner`, `railItem`, `searchBar` |
| Missing compact line height tokens | `JLineHeights` expanded — added `lh14`, `lh18` |

---

## If a gap is reintroduced

Add a new entry to `AGENTS.md` under a `## Known gaps` section (create if absent). Do NOT add it here — this file is append-only historical record.
