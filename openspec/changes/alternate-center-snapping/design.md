## Context

WindowPad's center snapping is orientation-aware:

**Center half** (`Numpad0 & Numpad5`, `CapsLock & Tab`):
- Landscape (monW >= monH): half width, full height, centered horizontally → `(monW//4, monTop, monW//2, monH)`
- Portrait: full width, half height, centered vertically → `(monLeft, monH//4, monW, monH//2)`

**Center third** (`NumpadDot & Numpad5` / `MoveToCenterThird()`):
- Landscape: third width, full height, center column → `(monLeft + monW//3, monTop, monW//3, monH)`
- Portrait: full width, third height, center row → `(monLeft, monTop + monH//3, monW, monH//3)`

The "alternate" simply swaps which orientation rule applies: landscape gets the portrait behavior and vice versa. This produces the perpendicular center band.

The Shift+NumpadDot+5 hotkeys (`NumpadDel & NumpadClear` and `NumpadDot & NumpadClear`) are already defined in the `#HotIf GetKeyState("Shift", "P")` block, currently calling `MoveToCenterThird()`. These need to be updated to call the new `MoveToAlternateCenterThird()`.

## Goals / Non-Goals

**Goals:**
- Add `MoveToAlternateCenterHalf()`: snaps to the orientation-perpendicular center half
- Add `MoveToAlternateCenterThird()`: snaps to the orientation-perpendicular center third
- Wire Shift+Numpad0+5 → `MoveToAlternateCenterHalf()` (both press orders via `NumpadIns & NumpadClear` and `Numpad0 & NumpadClear` in the `#HotIf` block)
- Wire Shift+CapsLock+Tab → `MoveToAlternateCenterHalf()` (via `GetKeyState("Shift", "P")` in the existing handler)
- Update `NumpadDel & NumpadClear` and `NumpadDot & NumpadClear` to call `MoveToAlternateCenterThird()`

**Non-Goals:**
- Changing existing center snap behavior when Shift is not held
- Adding alternate snapping to non-center positions (halves/quarters/thirds are already covered by Shift+direction)

## Decisions

**Decision 1: Two new functions (`MoveToAlternateCenterHalf` / `MoveToAlternateCenterThird`)**
- **Rationale**: Mirror the existing pattern of dedicated center functions. Logic is simple inversion of the orientation condition — landscape gets portrait behavior and vice versa. Keeps hotkey handlers clean.
- **Alternative**: Inline logic in each hotkey — rejected for readability.

**Decision 2: `#HotIf` block for Shift+Numpad0+5 (both press orders)**
- **Rationale**: Consistent with the Shift+Numpad0 pattern. Add `NumpadIns & NumpadClear` (Shift first) and `Numpad0 & NumpadClear` (Numpad0 first) inside the existing `#HotIf GetKeyState("Shift", "P")` block. `Numpad5` → `NumpadClear` when Shift is held.
- **Alternative**: Inline `GetKeyState` in the existing `Numpad0 & Numpad5` handler — rejected because it would only cover the Numpad0-first press order.

**Decision 3: Update existing `NumpadDel/NumpadDot & NumpadClear` hotkeys**
- **Rationale**: These were added in the absolute-third-snapping implementation, calling `MoveToCenterThird()`. Since Shift+NumpadDot+5 should now produce the *alternate* center third, updating these to `MoveToAlternateCenterThird()` is the correct semantic.

**Decision 4: `CapsLock & Tab` uses `GetKeyState("Shift", "P")` inline**
- **Rationale**: `CapsLock & Tab` already has a block handler. Adding a Shift check at the top is the simplest approach. CapsLock+Shift key transformation does not alter `Tab` key name (unlike numpad keys), so no second press-order variant is needed.

## Risks / Trade-offs

**Risk: `NumpadClear` is the correct key name for Shift+Numpad5**
- **Mitigation**: Numpad5 with NumLock ON and Shift held → `NumpadClear` is the standard Windows mapping. Consistent with `NumpadIns`, `NumpadLeft`, etc. used throughout.

**Risk: Updating `NumpadDel/NumpadDot & NumpadClear` breaks the intended absolute-center-third behavior**
- **Mitigation**: `MoveToCenterThird()` already uses `GetWindowMonitor()` (monitor-absolute). The new `MoveToAlternateCenterThird()` does the same, just with swapped orientation. Both are absolute. The semantic shift (alternate vs. normal) is the intended design.
