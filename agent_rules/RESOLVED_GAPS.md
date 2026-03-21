# Resolved Gaps (Historical Record)

> This file is HISTORICAL RECORD only.
> Do NOT treat entries here as active rules or pending tasks.
> Do NOT use this file as input for automated code changes.
> For active rules, see `AGENTS.md`.

---

## Validated and implemented (as of 2026-03)

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

---

## If a gap is reintroduced

Add a new entry to `AGENTS.md` under a `## Known gaps` section (create if absent). Do NOT add it here — this file is append-only historical record.
