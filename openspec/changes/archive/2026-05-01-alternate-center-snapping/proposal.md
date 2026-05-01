## Why

The current center snap (Numpad0+5 / CapsLock+Tab for halves, NumpadDot+5 for thirds) is orientation-aware: on landscape monitors it centers horizontally (column), on portrait it centers vertically (row). Users sometimes want the perpendicular center snap on their monitor — e.g., a horizontal center band on a landscape monitor — without rotating their monitor. Adding Shift as a modifier for the center key provides this efficiently, consistent with how Shift already adds absolute-mode to all other snap positions.

## What Changes

- Add Shift+Numpad0+5 hotkey for alternate center half snap (perpendicular to normal)
- Add Shift+CapsLock+Tab hotkey for the same alternate center half
- Update Shift+NumpadDot+5 hotkeys (NumpadDel/NumpadDot + NumpadClear) to use alternate center third instead of normal center third

## Capabilities

### New Capabilities
- `alternate-center-snapping`: Snap windows to the orientation-perpendicular center position using Shift as a modifier on the center key (5 / Tab), producing the opposite axis center from the default

### Modified Capabilities
<!-- No existing spec-level requirements are changing -->

## Impact

- **Code**: New `MoveToAlternateCenterHalf()` and `MoveToAlternateCenterThird()` functions; modifications to `Numpad0 & Numpad5`, `CapsLock & Tab` handlers to detect Shift; update `NumpadDel & NumpadClear` and `NumpadDot & NumpadClear` in the existing `#HotIf` block
- **APIs**: Two new helper functions mirroring the existing center snap functions with swapped orientation logic
- **User Experience**: Shift+5 / Shift+Tab now consistently means "alternate center" across all snap systems (halves and thirds)
- **Backwards Compatibility**: Fully backwards compatible — existing center snaps unchanged when Shift is not held
