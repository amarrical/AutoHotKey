## Why

WindowPad currently snaps windows relative to their current position on the monitor. Users need a way to snap windows to absolute monitor positions regardless of where the window currently is. This enables faster, more predictable window management workflows where the same key combination always produces the same result.

## What Changes

- Add Shift as a new modifier chord for window snapping
- When Shift is held, snapping operations target the absolute monitor position instead of relative window position
- Shift + directional keys will snap to fixed monitor regions (e.g., Shift + 0 + 6 snaps to right half regardless of current window location)
- Existing relative snapping behavior remains unchanged when Shift is not held

## Capabilities

### New Capabilities
- `shift-modifier-snapping`: Snap windows to absolute monitor positions using Shift as a modifier chord, enabling consistent positioning regardless of current window location

### Modified Capabilities
<!-- No existing capabilities are being modified at the requirement level -->

## Impact

- **Code**: Modifier handling in hotkey processing, snap position calculation logic
- **APIs**: Window snapping functions will need to support absolute vs relative positioning modes
- **User Experience**: New keyboard chord pattern (Shift + direction) for absolute snapping
- **Backwards Compatibility**: Fully backwards compatible - existing snapping behavior unchanged
