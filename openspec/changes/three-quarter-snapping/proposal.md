## Why

WindowPad currently snaps windows to halves (Numpad0), thirds (NumpadDot), and quarters (Numpad0 diagonals). There is no way to fill most of a monitor while keeping a small visible strip on one side — a common use case for reference windows alongside a primary workspace. Adding Ctrl as a modifier for large-area snapping fills this gap consistently across all existing chord systems.

## What Changes

- Add Ctrl+Numpad0+direction (2/4/6/8) for absolute 3/4 monitor snapping (left, right, top, bottom)
- Add Ctrl+CapsLock+direction (a/d/w/x) for the same 3/4 snapping on non-numpad keyboards
- Add Ctrl+NumpadDot+direction (2/4/6/8) for absolute 2/3 monitor snapping (left, right, top, bottom)
- All positions are absolute (monitor-relative), consistent with Shift-based absolute snapping
- Existing hotkeys without Ctrl are unchanged

## Capabilities

### New Capabilities
- `ctrl-large-area-snapping`: Snap windows to 3/4 or 2/3 of the monitor using Ctrl as a modifier chord, providing larger-than-half snap areas with directional control

### Modified Capabilities
<!-- No existing spec-level requirements are changing -->

## Impact

- **Code**: New `#HotIf GetKeyState("Ctrl", "P")` block in `WindowPadPlus.ahk` with `Numpad0 & Numpad#` hotkeys for 3/4 snapping; Ctrl check added to `CapsLock & a/d/w/x` handlers; new `#HotIf` entries for `NumpadDot & Numpad#` 2/3 snapping; reuses existing `MoveToAbsoluteArea()`
- **APIs**: No new functions — all positions expressible as normalized coordinates via existing `MoveToAbsoluteArea()`
- **User Experience**: Ctrl is a new, consistent modifier meaning "large area" — 3/4 for halves-system (Numpad0/CapsLock), 2/3 for thirds-system (NumpadDot)
- **Backwards Compatibility**: Fully backwards compatible — no existing hotkeys modified
