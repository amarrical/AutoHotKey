## 1. Hotkey Registration

- [x] 1.1 Add hotkey registration function for numpad 0 + normal number keys 1-9 combinations in QuickRecord.ahk
- [x] 1.2 Register all 9 hotkey combinations (KP0 & 1 through KP0 & 9) at script startup
- [x] 1.3 Verify hotkeys are registered without conflicts with existing hotkeys

## 2. Monitor Detection

- [x] 2.1 Implement function to get the current number of connected monitors using AutoHotkey API
- [x] 2.2 Test monitor detection with 1, 2, 3, and 4 monitor configurations
- [x] 2.3 Verify monitor count updates correctly when monitors are connected/disconnected

## 3. Window Movement

- [x] 3.1 Implement function to move active window to a specified monitor number
- [x] 3.2 Handle edge cases: window already on target monitor, monitor doesn't exist
- [x] 3.3 Ensure window state (size, maximized/minimized) is preserved during move
- [x] 3.4 Test window positioning with different monitor resolutions and DPI settings

## 4. Hotkey Handler

- [x] 4.1 Create hotkey handler function that receives the target monitor number
- [x] 4.2 Integrate handler with monitor detection (validate target monitor exists)
- [x] 4.3 Integrate handler with window movement function
- [x] 4.4 Ensure handler executes silently without notifications for invalid monitors

## 5. Integration & Testing

- [x] 5.1 Integrate numpad hotkey registration into main script initialization
- [x] 5.2 Test all 9 hotkey combinations with active windows
- [x] 5.3 Test behavior when fewer than 9 monitors are connected
- [x] 5.4 Test with various window types (normal, maximized, minimized)
- [x] 5.5 Verify no conflicts with existing WindowPadPlus hotkeys

## 6. Documentation

- [x] 6.1 Add numpad 0 + 1-9 hotkeys to user documentation/help file
- [x] 6.2 Document the feature in release notes (N/A - no release notes file in project)
- [x] 6.3 Add code comments explaining hotkey registration and handler logic
