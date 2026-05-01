## Why

Quarter-screen snapping enables efficient window management for four-way layouts. Users can quickly position windows in any corner of the monitor, useful for comparing multiple documents or monitoring multiple data sources simultaneously.

## What Changes

- Numpad0 + Numpad7 snaps active window to top-left quarter of monitor
- Numpad0 + Numpad9 snaps active window to top-right quarter of monitor
- Numpad0 + Numpad1 snaps active window to bottom-left quarter of monitor
- Numpad0 + Numpad3 snaps active window to bottom-right quarter of monitor
- Maximized windows are automatically restored before snapping
- Window position and size are calculated relative to the active monitor

## Capabilities

### New Capabilities

- `window-snapping-quarters`: Snap active window to any corner quarter of the monitor using numpad corner keys

### Modified Capabilities

<!-- No existing capabilities modified -->

## Impact

- AutoHotkey script (scripts/WindowPadPlus.ahk)
- Reuses existing monitor detection and window positioning infrastructure
- Requires AutoHotkey v2.0+
