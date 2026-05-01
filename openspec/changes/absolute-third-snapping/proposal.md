## Why

WindowPad already supports absolute half/quarter snapping via Shift+Numpad0, and relative third snapping via NumpadDot. Users need a consistent absolute third snapping mode so that Shift+NumpadDot always snaps to a fixed third of the monitor regardless of where the window currently is, matching the predictable behavior of Shift+Numpad0.

## What Changes

- Add Shift as a modifier chord for NumpadDot-based third snapping
- When Shift is held, third snapping targets absolute monitor positions instead of relative window positions
- Shift+NumpadDot+direction snaps to fixed monitor thirds (left, center, right, top, bottom)
- Existing relative third snapping behavior (NumpadDot without Shift) remains unchanged

## Capabilities

### New Capabilities
- `shift-third-snapping`: Snap windows to absolute monitor third positions using Shift+NumpadDot as a modifier chord, enabling consistent one-third positioning regardless of current window location

### Modified Capabilities
<!-- No existing capabilities are being modified at the requirement level -->

## Impact

- **Code**: New hotkey definitions in `WindowPadPlus.ahk` using `#HotIf GetKeyState("Shift", "P")` with `NumpadDel`/`NumpadDot` as prefix modifier and shifted numpad navigation keys
- **APIs**: New `MoveToAbsoluteArea()` calls reusing the existing function from the non-relative-snapping feature
- **User Experience**: New keyboard chord pattern (Shift+NumpadDot+direction) for absolute third snapping, parallel to existing Shift+Numpad0 absolute half/quarter snapping
- **Backwards Compatibility**: Fully backwards compatible — existing NumpadDot relative third snapping unchanged
