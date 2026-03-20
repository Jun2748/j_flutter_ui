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
| Edge-to-edge / full-bleed card variant was missing | `SimpleCard.flush` added (no external margin, no corner radius) |
| Common search bars required route-scoped input theme overrides | `SimpleSearchField` now supports `quiet` pill-like variant |
| Promo/announcement overlays had no reusable primitive | `SimpleFloatingBanner` added (dimmed backdrop, optional close, `media` + `child` slots) |
| Horizontal single-select chip bar required app-layer glue | `SimpleChipBar` added |

---

## If a gap is reintroduced

Add a new entry to `AGENTS.md` under a `## Known gaps` section (create if absent). Do NOT add it here — this file is append-only historical record.
