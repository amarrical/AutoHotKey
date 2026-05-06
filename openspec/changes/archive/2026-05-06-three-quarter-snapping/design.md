## Context

WindowPad uses `MoveToAbsoluteArea(posX, posY, sizeW, sizeH)` for all absolute snapping, taking normalized coordinates (0.0–1.0). The modifier architecture uses `#HotIf` blocks to overlay new behaviors on existing key combinations without breaking them.

**3/4 snap coordinates** (absolute, monitor-relative):
| Direction | posX | posY | sizeW | sizeH |
|-----------|------|------|-------|-------|
| Left 3/4  | 0 | 0 | 0.75 | 1 |
| Right 3/4 | 0.25 | 0 | 0.75 | 1 |
| Top 3/4   | 0 | 0 | 1 | 0.75 |
| Bottom 3/4 | 0 | 0.25 | 1 | 0.75 |

**2/3 snap coordinates** (absolute, monitor-relative):
| Direction | posX | posY | sizeW | sizeH |
|-----------|------|------|-------|-------|
| Left 2/3  | 0 | 0 | 0.666667 | 1 |
| Right 2/3 | 0.333333 | 0 | 0.666667 | 1 |
| Top 2/3   | 0 | 0 | 1 | 0.666667 |
| Bottom 2/3 | 0 | 0.333333 | 1 | 0.666667 |

**Ctrl + Numpad key behavior**: Unlike Shift, Ctrl does NOT invert NumLock. With NumLock ON and Ctrl held, numpad keys retain their numpad names (`Numpad0`, `Numpad2`, `Numpad4`, `Numpad6`, `Numpad8`). No dual-prefix handling is required.

## Goals / Non-Goals

**Goals:**
- Add `#HotIf GetKeyState("Ctrl", "P")` block with `Numpad0 & Numpad4/6/8/2` for 3/4 absolute snapping
- Add `#HotIf GetKeyState("Ctrl", "P")` entries with `NumpadDot & Numpad4/6/8/2` for 2/3 absolute snapping
- Add Ctrl detection to `CapsLock & a`, `CapsLock & d`, `CapsLock & w`, `CapsLock & x` handlers
- Reuse `MoveToAbsoluteArea()` for all positions (no new functions needed)

**Non-Goals:**
- Diagonal 3/4 or 2/3 snapping (1/3/7/9 keys not included — not requested)
- Ctrl+NumpadDot+5 center variant (out of scope)
- Ctrl+Numpad0 center (5) variant (out of scope)
- 3/4 snapping via CapsLock quarter keys (q/e/z/c — not requested)

## Decisions

**Decision 1: Single `#HotIf GetKeyState("Ctrl", "P")` block covering both Numpad0 and NumpadDot hotkeys**
- **Rationale**: Ctrl does not transform numpad key names, so only one block is needed (no Ctrl-first vs Numpad0-first press order problem). Keeping all Ctrl-based hotkeys in one `#HotIf` block is clean and consistent with the existing Shift block structure.
- **Alternative**: Separate `#HotIf` blocks per chord system — rejected for unnecessary fragmentation.

**Decision 2: Ctrl check inline for CapsLock handlers**
- **Rationale**: `CapsLock & a/d/w/x` are currently single-line calls. They need to become block handlers with `if (GetKeyState("Ctrl", "P"))` for the 3/4 branch, identical to the Shift pattern used in other CapsLock handlers.
- **Alternative**: `#HotIf` block for CapsLock hotkeys — rejected because CapsLock itself is not a standard modifier key in AHK's `#HotIf` system.

**Decision 3: No new functions — reuse `MoveToAbsoluteArea()`**
- **Rationale**: All 8 positions (four 3/4 and four 2/3) are simple normalized rectangles expressible directly as `MoveToAbsoluteArea()` arguments. No orientation-awareness or special logic needed.

## Risks / Trade-offs

**Risk: Ctrl conflicts with system shortcuts in some applications**
- **Mitigation**: The chord system (Ctrl held while pressing Numpad0 then a direction) is unlikely to conflict with system shortcuts. AHK hotkeys fire before the application receives the keys.

**Risk: `CapsLock & x` currently calls `MoveToRelativeArea` directly (single-line)**
- **Mitigation**: It needs converting to a block handler to support the Ctrl branch, same as the other CapsLock direction keys. Simple refactor with no behavioral change when Ctrl is not held.
