## Why

Numpad modifier keys (Numpad0 and NumpadDot) are used as chord modifiers for window snapping hotkeys, but they should also send their original character (0 and .) when pressed and released alone without triggering any chord. This provides a seamless user experience where the modifier keys remain functional for typing.

## What Changes

- Numpad0 (and its NumpadIns alias) sends `0` when pressed and released alone, without blocking chord activation
- NumpadDot (and its NumpadDel alias) sends `.` when pressed and released alone, without blocking chord activation
- Uses AutoHotkey v2 KeyUp event with A_PriorKey check to detect solo presses
- SendMode Input ensures reliable key delivery

## Capabilities

### New Capabilities

- `transparent-modifier-keys`: Numpad modifier keys that pass through their original character when pressed alone, while still functioning as chord modifiers for window management hotkeys

### Modified Capabilities

<!-- No existing capabilities modified -->

## Impact

- AutoHotkey script (scripts/WindowPadPlus.ahk)
- Affects user experience on keyboards with numpad
- Requires AutoHotkey v2.0+
