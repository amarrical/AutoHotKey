## Context

WindowPad has two snapping systems:
1. **Half/quarter snapping** — Numpad0 as modifier. Relative snapping via `MoveToRelativeArea()`. Absolute snapping (Shift+Numpad0) was implemented using `#HotIf GetKeyState("Shift", "P")` blocks with shifted numpad key names (`NumpadIns` + nav keys), covering both Shift-first and Numpad0-first press orders.
2. **Third snapping** — NumpadDot as modifier. `MoveToThird()` for relative (window-area based), `MoveToCenterThird()` for the center special case. Current hotkeys: `NumpadDot & Numpad4/5/6/8/2`.

The same Shift+NumLock key transformation issue applies here: when Shift is held with NumLock ON, `NumpadDot` → `NumpadDel`, and direction keys → nav keys.

## Goals / Non-Goals

**Goals:**
- Add Shift+NumpadDot+direction hotkeys for absolute third snapping to fixed monitor thirds
- Support both press orders: Shift-first (NumpadDot → NumpadDel) and NumpadDot-first
- Reuse existing `MoveToAbsoluteArea()` function for left/right/top/bottom thirds
- Implement a new `MoveToAbsoluteCenterThird()` for the center special case
- Maintain full backwards compatibility with existing relative third snapping

**Non-Goals:**
- Changing existing `NumpadDot` relative third snapping behavior
- Adding new snap positions beyond what already exists in relative thirds
- Modifying monitor detection or multi-monitor logic

## Decisions

**Decision 1: Reuse `MoveToAbsoluteArea()` for directional thirds**
- **Rationale**: Left/right/top/bottom thirds are expressible as normalized coordinates (e.g., left third = `MoveToAbsoluteArea(0, 0, 0.333333, 1)`), exactly matching the existing function signature.
- **Alternative**: New `MoveToAbsoluteThird()` wrapper — rejected as unnecessary abstraction.

**Decision 2: New `MoveToAbsoluteCenterThird()` function for center (5)**
- **Rationale**: Center third is orientation-aware (landscape = middle third column, portrait = middle third row), matching `MoveToCenterThird()` logic but targeting monitor bounds instead of window area. Cannot be expressed as simple normalized coordinates.
- **Implementation**: Mirror `MoveToCenterThird()` but use `GetWindowMonitor()` directly (which it already does — so center third is already absolute).

**Decision 3: Same `#HotIf GetKeyState("Shift", "P")` pattern as Shift+Numpad0**
- **Rationale**: Proven approach from the non-relative-snapping feature. Two hotkey groups: `NumpadDel & NavKey` (Shift pressed first) and `NumpadDot & NavKey` (NumpadDot pressed first).
- **Alternative**: Global flag variable — rejected as more complex and already proven unnecessary.

**Decision 4: No new capability for center third (reuse `MoveToCenterThird`)**
- **Rationale**: `MoveToCenterThird()` already uses `GetWindowMonitor()` for its calculations, making it inherently absolute. It does not use the window's current area. Therefore Shift+NumpadDot+5 can call `MoveToCenterThird()` directly.

## Risks / Trade-offs

**Risk: NumpadDot → NumpadDel key name assumption**
- **Mitigation**: Consistent with the Numpad0 → NumpadIns pattern. Both are the standard Windows Shift+NumLock transformations. Verified via existing `NumpadDel Up::` handler already in the script.

**Risk: `MoveToAbsoluteArea()` coordinates for thirds may have rounding differences vs `MoveToThird()`**
- **Mitigation**: Use the same constants already used in `MoveToThird()` calls (`0.333333`, `0.666667`) for consistency.
