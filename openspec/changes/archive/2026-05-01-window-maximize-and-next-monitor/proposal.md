## Why

Multi-monitor workflows require efficient window management across displays. Users need quick shortcuts to maximize windows and move them between monitors while preserving their relative layout. This enables seamless multi-monitor productivity without manual repositioning.

## What Changes

- Numpad0 + NumpadAdd maximizes the active window
- Numpad0 + NumpadEnter moves the active window to the next monitor (wrapping around to the first monitor after the last)
- Window position and size are preserved proportionally when moving between monitors of different sizes
- If a window was maximized before moving to the next monitor, it is re-maximized on the destination monitor
- Monitor detection uses the window's upper-left corner position

## Capabilities

### New Capabilities

- `window-maximize-and-next-monitor`: Maximize active window and move it to the next monitor while preserving relative position and maximized state

### Modified Capabilities

<!-- No existing capabilities modified -->

## Impact

- AutoHotkey script (scripts/WindowPadPlus.ahk)
- Requires multi-monitor detection and window positioning APIs
- Requires AutoHotkey v2.0+
