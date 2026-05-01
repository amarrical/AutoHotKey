## 1. Implement helper functions

- [x] 1.1 Implement GetWindowArea() to get window position/size or monitor dimensions if maximized
- [x] 1.2 Implement GetWindowMonitor() to detect active monitor via window center point
- [x] 1.3 Implement RestoreIfMaximized() to restore maximized windows
- [x] 1.4 Implement MoveToRelativeArea() to snap window using relative positioning

## 2. Implement half-snap hotkeys

- [x] 2.1 Add Numpad0 + Numpad4 hotkey for left half snap
- [x] 2.2 Add Numpad0 + Numpad6 hotkey for right half snap
- [x] 2.3 Add Numpad0 + Numpad8 hotkey for top half snap
- [x] 2.4 Add Numpad0 + Numpad2 hotkey for bottom half snap

## 3. Implement center-half snap with orientation awareness

- [x] 3.1 Add Numpad0 + Numpad5 hotkey with orientation detection
- [x] 3.2 Verify landscape detection (width >= height) uses centered column
- [x] 3.3 Verify portrait detection (height > width) uses centered row

## 4. Testing

- [x] 4.1 Test left/right/top/bottom snaps on single monitor
- [x] 4.2 Test center snap on landscape monitor
- [x] 4.3 Test center snap on portrait monitor
- [x] 4.4 Test snapping maximized windows
- [x] 4.5 Test multi-monitor snapping (window on secondary monitor)
- [x] 4.6 Verify no conflicts with other hotkeys
