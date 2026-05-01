## 1. Implement Shift+NumpadDot Hotkeys (Shift pressed first)

- [ ] 1.1 Add `#HotIf GetKeyState("Shift", "P")` block with `NumpadDel & NumpadLeft` hotkey for left third absolute snap
- [ ] 1.2 Add `NumpadDel & NumpadRight` hotkey for right third absolute snap
- [ ] 1.3 Add `NumpadDel & NumpadClear` (or Numpad5 equivalent) hotkey for center third absolute snap
- [ ] 1.4 Add `NumpadDel & NumpadUp` hotkey for top third absolute snap
- [ ] 1.5 Add `NumpadDel & NumpadDown` hotkey for bottom third absolute snap

## 2. Implement Shift+NumpadDot Hotkeys (NumpadDot pressed first)

- [ ] 2.1 Add `NumpadDot & NumpadLeft` hotkey for left third absolute snap (inside same `#HotIf` block)
- [ ] 2.2 Add `NumpadDot & NumpadRight` hotkey for right third absolute snap
- [ ] 2.3 Add `NumpadDot & NumpadClear` (or Numpad5 equivalent) hotkey for center third absolute snap
- [ ] 2.4 Add `NumpadDot & NumpadUp` hotkey for top third absolute snap
- [ ] 2.5 Add `NumpadDot & NumpadDown` hotkey for bottom third absolute snap

## 3. Testing and Verification

- [ ] 3.1 Test all Shift+NumpadDot hotkeys with Shift pressed first (NumpadDot → NumpadDel)
- [ ] 3.2 Test all Shift+NumpadDot hotkeys with NumpadDot pressed first
- [ ] 3.3 Test absolute third snapping with maximized windows (verify restore behavior)
- [ ] 3.4 Test multi-monitor scenarios to verify correct monitor detection
- [ ] 3.5 Verify existing relative third snapping (NumpadDot without Shift) still works
- [ ] 3.6 Verify center third is orientation-aware (landscape vs portrait monitor)
