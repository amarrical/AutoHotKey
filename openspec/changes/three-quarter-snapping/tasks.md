## 1. Implement Ctrl+Numpad0 3/4 Hotkeys

- [x] 1.1 Add new `#HotIf GetKeyState("Ctrl", "P")` block with `Numpad0 & Numpad4::MoveToAbsoluteArea(0, 0, 0.75, 1)` for left 3/4
- [x] 1.2 Add `Numpad0 & Numpad6::MoveToAbsoluteArea(0.25, 0, 0.75, 1)` for right 3/4
- [x] 1.3 Add `Numpad0 & Numpad8::MoveToAbsoluteArea(0, 0, 1, 0.75)` for top 3/4
- [x] 1.4 Add `Numpad0 & Numpad2::MoveToAbsoluteArea(0, 0.25, 1, 0.75)` for bottom 3/4
- [x] 1.5 Close the `#HotIf` block

## 2. Implement Ctrl+CapsLock 3/4 Hotkeys

- [x] 2.1 Convert `CapsLock & a` from single-line to block handler with Ctrl check calling `MoveToAbsoluteArea(0, 0, 0.75, 1)` for left 3/4
- [x] 2.2 Convert `CapsLock & d` to block handler with Ctrl check calling `MoveToAbsoluteArea(0.25, 0, 0.75, 1)` for right 3/4
- [x] 2.3 Convert `CapsLock & w` to block handler with Ctrl check calling `MoveToAbsoluteArea(0, 0, 1, 0.75)` for top 3/4
- [x] 2.4 Convert `CapsLock & x` from single-line to block handler with Ctrl check calling `MoveToAbsoluteArea(0, 0.25, 1, 0.75)` for bottom 3/4

## 3. Implement Ctrl+NumpadDot 2/3 Hotkeys

- [x] 3.1 Add `NumpadDot & Numpad4::MoveToAbsoluteArea(0, 0, 0.666667, 1)` inside the same `#HotIf GetKeyState("Ctrl", "P")` block for left 2/3
- [x] 3.2 Add `NumpadDot & Numpad6::MoveToAbsoluteArea(0.333333, 0, 0.666667, 1)` for right 2/3
- [x] 3.3 Add `NumpadDot & Numpad8::MoveToAbsoluteArea(0, 0, 1, 0.666667)` for top 2/3
- [x] 3.4 Add `NumpadDot & Numpad2::MoveToAbsoluteArea(0, 0.333333, 1, 0.666667)` for bottom 2/3

## 4. Testing and Verification

- [x] 4.1 Test all Ctrl+Numpad0 3/4 hotkeys (left, right, top, bottom)
- [x] 4.2 Test all Ctrl+CapsLock 3/4 hotkeys (a, d, w, x)
- [x] 4.3 Test all Ctrl+NumpadDot 2/3 hotkeys (4, 6, 8, 2)
- [x] 4.4 Test with maximized windows (verify restore behavior)
- [x] 4.5 Test multi-monitor scenarios to verify correct monitor detection
- [x] 4.6 Verify existing relative snapping (Numpad0/CapsLock without Ctrl) still works
- [x] 4.7 Verify existing NumpadDot relative third snapping still works
