## 1. Create Absolute Positioning Function

- [x] 1.1 Implement `MoveToAbsoluteArea()` function that takes normalized coordinates and snaps to absolute monitor positions
- [x] 1.2 Test `MoveToAbsoluteArea()` with various window sizes and positions to verify absolute positioning

## 2. Implement Shift+Numpad0 Hotkeys

- [x] 2.1 Add Shift+Numpad0+Numpad6 hotkey for right half absolute snap
- [x] 2.2 Add Shift+Numpad0+Numpad4 hotkey for left half absolute snap
- [x] 2.3 Add Shift+Numpad0+Numpad8 hotkey for top half absolute snap
- [x] 2.4 Add Shift+Numpad0+Numpad2 hotkey for bottom half absolute snap
- [x] 2.5 Add Shift+Numpad0+Numpad7 hotkey for top-left quarter absolute snap
- [x] 2.6 Add Shift+Numpad0+Numpad9 hotkey for top-right quarter absolute snap
- [x] 2.7 Add Shift+Numpad0+Numpad1 hotkey for bottom-left quarter absolute snap
- [x] 2.8 Add Shift+Numpad0+Numpad3 hotkey for bottom-right quarter absolute snap

## 3. Implement Shift+CapsLock Hotkeys

- [x] 3.1 Add Shift+CapsLock+D hotkey for right half absolute snap
- [x] 3.2 Add Shift+CapsLock+A hotkey for left half absolute snap
- [x] 3.3 Add Shift+CapsLock+W hotkey for top half absolute snap
- [x] 3.4 Add Shift+CapsLock+S hotkey for bottom half absolute snap
- [x] 3.5 Add Shift+CapsLock+Q hotkey for top-left quarter absolute snap
- [x] 3.6 Add Shift+CapsLock+E hotkey for top-right quarter absolute snap
- [x] 3.7 Add Shift+CapsLock+Z hotkey for bottom-left quarter absolute snap
- [x] 3.8 Add Shift+CapsLock+C hotkey for bottom-right quarter absolute snap

## 4. Testing and Verification

- [x] 4.1 Test all Shift+Numpad0 hotkeys on single monitor setup
- [x] 4.2 Test all Shift+CapsLock hotkeys on single monitor setup
- [x] 4.3 Test absolute snapping with maximized windows (verify restore behavior)
- [x] 4.4 Test multi-monitor scenarios to verify correct monitor detection
- [x] 4.5 Verify existing relative snapping (Numpad0 without Shift) still works
- [x] 4.6 Verify existing CapsLock relative snapping still works
- [x] 4.7 Test with various window sizes to ensure absolute positioning is consistent
