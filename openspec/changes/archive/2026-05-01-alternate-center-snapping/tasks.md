## 1. Implement Helper Functions

- [x] 1.1 Add `MoveToAlternateCenterHalf()` function: landscape → full-width half-height centered vertically; portrait → half-width full-height centered horizontally
- [x] 1.2 Add `MoveToAlternateCenterThird()` function: landscape → full-width third-height centered vertically; portrait → third-width full-height centered horizontally

## 2. Wire Shift+Numpad0+5 Hotkeys

- [x] 2.1 Add `NumpadIns & NumpadClear::MoveToAlternateCenterHalf()` inside the existing `#HotIf GetKeyState("Shift", "P")` block (covers Shift-pressed-first order)
- [x] 2.2 Add `Numpad0 & NumpadClear::MoveToAlternateCenterHalf()` inside the same `#HotIf` block (covers Numpad0-pressed-first order)

## 3. Wire Shift+CapsLock+Tab Hotkey

- [x] 3.1 Update the `CapsLock & Tab` handler to check `GetKeyState("Shift", "P")` and call `MoveToAlternateCenterHalf()` when Shift is held

## 4. Update Shift+NumpadDot+5 Hotkeys

- [x] 4.1 Update `NumpadDel & NumpadClear` in the `#HotIf` block to call `MoveToAlternateCenterThird()` instead of `MoveToCenterThird()`
- [x] 4.2 Update `NumpadDot & NumpadClear` in the `#HotIf` block to call `MoveToAlternateCenterThird()` instead of `MoveToCenterThird()`

## 5. Testing and Verification

- [x] 5.1 Test Shift+Numpad0+5 on landscape monitor (expect horizontal band)
- [x] 5.2 Test Shift+Numpad0+5 on portrait monitor (expect vertical column)
- [x] 5.3 Test both Shift+Numpad0+5 press orders (Shift-first and Numpad0-first)
- [x] 5.4 Test Shift+CapsLock+Tab on landscape and portrait monitors
- [x] 5.5 Test Shift+NumpadDot+5 (both press orders) for alternate center third
- [x] 5.6 Test with maximized window (verify restore behavior)
- [x] 5.7 Verify Numpad0+5 without Shift still uses normal orientation-aware center half
- [x] 5.8 Verify CapsLock+Tab without Shift still works as before
- [x] 5.9 Verify NumpadDot+5 without Shift still uses normal center third
