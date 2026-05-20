## Why

WindowPadPlus users with multi-monitor setups need a quick, intuitive way to move windows between monitors. Currently, moving windows to specific monitors requires multiple steps or complex key combinations. Adding numpad 0 as a modifier with normal number keys 1-9 provides a direct, memorable shortcut that maps naturally to monitor positions.

## What Changes

- Add numpad 0 + normal number keys 1-9 keybinding support to move the active window to a specific monitor
- Numpad 0 acts as a modifier key; when held with number keys 1-9, the window moves to that monitor number
- Gracefully handle cases where fewer than 9 monitors are connected (no action for non-existent monitors)
- Integrate with existing WindowPadPlus hotkey system

## Capabilities

### New Capabilities

- `numpad-monitor-navigation`: Allows users to press numpad 0 + number keys 1-9 to move the active window to monitors 1-9 directly

### Modified Capabilities

- `hotkey-system`: The existing hotkey system will be extended to support numpad modifier + number key combinations for monitor navigation

## Impact

- **Code**: QuickRecord.ahk hotkey handler, monitor detection and window movement logic
- **APIs**: No external API changes; internal hotkey registration and window movement functions
- **Dependencies**: Existing AutoHotkey monitor detection and window positioning capabilities
- **User Experience**: New keyboard shortcut available in all window management contexts
