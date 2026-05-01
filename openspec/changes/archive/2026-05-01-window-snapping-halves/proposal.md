## Why

Window management is a critical part of productivity. Users need quick keyboard shortcuts to snap windows to halves of the monitor for side-by-side work. The center-half snap should intelligently adapt to monitor orientation, maximizing usable screen space on both landscape and portrait displays.

## What Changes

- Numpad0 + Numpad4 snaps active window to left half of monitor
- Numpad0 + Numpad6 snaps active window to right half of monitor
- Numpad0 + Numpad8 snaps active window to top half of monitor
- Numpad0 + Numpad2 snaps active window to bottom half of monitor
- Numpad0 + Numpad5 snaps active window to center half with orientation awareness (landscape: 50% width centered; portrait: 50% height centered)
- Maximized windows are automatically restored before snapping
- Window position and size are calculated relative to the active monitor

## Capabilities

### New Capabilities

- `window-snapping-halves`: Snap active window to left, right, top, bottom, or center halves of the monitor with orientation-aware center positioning

### Modified Capabilities

<!-- No existing capabilities modified -->

## Impact

- AutoHotkey script (scripts/WindowPadPlus.ahk)
- Requires monitor detection and window positioning APIs
- Requires AutoHotkey v2.0+
