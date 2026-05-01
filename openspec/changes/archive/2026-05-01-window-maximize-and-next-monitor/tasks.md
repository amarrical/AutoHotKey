## 1. Implement maximize hotkey

- [x] 1.1 Add Numpad0 + NumpadAdd hotkey that calls WinMaximize

## 2. Implement move-to-next-monitor hotkey

- [x] 2.1 Detect current monitor using window's upper-left corner position
- [x] 2.2 Calculate relative position and size as percentages of source monitor
- [x] 2.3 Determine next monitor index (with wrap-around)
- [x] 2.4 Apply relative position/size to destination monitor
- [x] 2.5 Add Numpad0 + NumpadEnter hotkey for move-to-next-monitor

## 3. Implement maximized state preservation

- [x] 3.1 Check if window is maximized before move
- [x] 3.2 Re-maximize window on destination monitor if it was maximized

## 4. Testing

- [x] 4.1 Test maximize hotkey on restored window
- [x] 4.2 Test maximize hotkey on already-maximized window
- [x] 4.3 Test move-to-next-monitor on two-monitor setup
- [x] 4.4 Test wrap-around from last to first monitor
- [x] 4.5 Test maximized state preservation when moving
- [x] 4.6 Test proportional positioning on monitors of different sizes
- [x] 4.7 Test single-monitor system (no change expected)
