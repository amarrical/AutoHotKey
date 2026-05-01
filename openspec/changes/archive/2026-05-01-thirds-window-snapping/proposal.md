## Why

Three-column and three-row layouts are common in productivity workflows. Users need quick shortcuts to snap windows to thirds of the monitor for comparing multiple documents side-by-side. The center-third snap should intelligently adapt to monitor orientation, maximizing usable screen space on both landscape and portrait displays.

## What Changes

- NumpadDot + Numpad4 snaps active window to left third of monitor (0–33%)
- NumpadDot + Numpad6 snaps active window to right third of monitor (66–100%)
- NumpadDot + Numpad8 snaps active window to top third of monitor (0–33%)
- NumpadDot + Numpad2 snaps active window to bottom third of monitor (66–100%)
- NumpadDot + Numpad5 snaps active window to center third with orientation awareness (landscape: 33–66% width full height; portrait: 33–66% height full width)
- Maximized windows are automatically restored before snapping
- Window position and size are calculated relative to the active monitor

## Capabilities

### New Capabilities

- `thirds-window-snapping`: Snap active window to left, right, top, bottom, or center thirds of the monitor with orientation-aware center positioning

### Modified Capabilities

<!-- No existing capabilities modified -->

## Impact

- AutoHotkey script (scripts/WindowPadPlus.ahk)
- Requires monitor detection and window positioning APIs
- Requires AutoHotkey v2.0+
