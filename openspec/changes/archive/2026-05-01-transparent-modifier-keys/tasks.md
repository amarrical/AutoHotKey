## 1. Implement Numpad0 passthrough

- [x] 1.1 Add Numpad0 Up hotkey handler that checks A_PriorKey and sends "0"
- [x] 1.2 Add NumpadIns Up hotkey handler (alias for Numpad0 with numlock off)
- [x] 1.3 Test Numpad0 sends "0" when pressed alone
- [x] 1.4 Test Numpad0 chord hotkeys still work (e.g., Numpad0 & NumpadAdd)

## 2. Implement NumpadDot passthrough

- [x] 2.1 Add NumpadDot Up hotkey handler that checks A_PriorKey and sends "."
- [x] 2.2 Add NumpadDel Up hotkey handler (alias for NumpadDot with numlock off)
- [x] 2.3 Test NumpadDot sends "." when pressed alone
- [x] 2.4 Test NumpadDot chord hotkeys still work (e.g., NumpadDot & Numpad5)

## 3. Validation

- [x] 3.1 Verify no conflicts with existing window snapping hotkeys
- [x] 3.2 Test on keyboard with numlock on
- [x] 3.3 Test on keyboard with numlock off
- [x] 3.4 Verify SendMode Input is set correctly
