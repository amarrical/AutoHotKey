## 1. Implement Strip Waits Functions

- [x] 1.1 Create `StripWaits24()` function that sets all deltas to 0 in F24 buffer and rewrites QuickRecord.last.F24.txt
- [x] 1.2 Create `StripWaits23()` function that sets all deltas to 0 in F23 buffer and rewrites QuickRecord.last.f23.txt
- [x] 1.3 Add validation to check if buffer is empty before stripping

## 2. Register Hotkeys

- [x] 2.1 Register Alt+F24 hotkey to call `StripWaits24()`
- [x] 2.2 Register Alt+F23 hotkey to call `StripWaits23()`

## 3. Error Handling and Notifications

- [x] 3.1 Add check to prevent stripping during recording (display notification if attempted)
- [x] 3.2 Display confirmation notification showing number of events stripped for F24
- [x] 3.3 Display confirmation notification showing number of events stripped for F23
- [x] 3.4 Display notification if user tries to strip empty buffer

## 4. Testing

- [x] 4.1 Test Alt+F24 to strip waits from F24 macro
- [x] 4.2 Test Alt+F23 to strip waits from F23 macro
- [x] 4.3 Test that key sequence is preserved (only deltas change)
- [x] 4.4 Test that stripped macro persists across script restart
- [x] 4.5 Test stripping empty buffer (should display notification)
- [x] 4.6 Test stripping during recording (should be blocked)
- [x] 4.7 Test that F24 and F23 strips are independent
- [x] 4.8 Test that stripped macro replays at maximum speed (no delays)
