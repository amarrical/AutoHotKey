## 1. Extract Reload Logic

- [ ] 1.1 Create `LoadBufferFromFile24()` helper function to load F24 buffer from QuickRecord.last.txt
- [ ] 1.2 Create `LoadBufferFromFile23()` helper function to load F23 buffer from QuickRecord.last.f23.txt
- [ ] 1.3 Refactor `LoadBuffer()` to use the new helper functions

## 2. Implement Reload Hotkeys

- [ ] 2.1 Create `ReloadBuffer24()` function that calls `LoadBufferFromFile24()` and displays a notification
- [ ] 2.2 Create `ReloadBuffer23()` function that calls `LoadBufferFromFile23()` and displays a notification
- [ ] 2.3 Register Ctrl+F24 hotkey to call `ReloadBuffer24()`
- [ ] 2.4 Register Ctrl+F23 hotkey to call `ReloadBuffer23()`

## 3. Error Handling

- [ ] 3.1 Add error handling to `ReloadBuffer24()` for file read errors and corrupt data
- [ ] 3.2 Add error handling to `ReloadBuffer23()` for file read errors and corrupt data
- [ ] 3.3 Display appropriate tray notifications for success and error cases

## 4. Testing

- [ ] 4.1 Test Ctrl+F24 to reload F24 buffer from file
- [ ] 4.2 Test Ctrl+F23 to reload F23 buffer from file
- [ ] 4.3 Test that reload does not trigger replay
- [ ] 4.4 Test that reloaded buffer is used on next F24/F23 replay
- [ ] 4.5 Test reload with missing file (should display notification)
- [ ] 4.6 Test reload with corrupt file (should display warning and leave buffer unchanged)
- [ ] 4.7 Test reload during recording (should be ignored)
- [ ] 4.8 Test that F24 and F23 reloads are independent
