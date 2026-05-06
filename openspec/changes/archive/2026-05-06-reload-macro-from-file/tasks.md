## 1. Extract Reload Logic

- [x] 1.1 Create `LoadBufferFromFile24()` helper function to load F24 buffer from QuickRecord.last.F24.txt
- [x] 1.2 Create `LoadBufferFromFile23()` helper function to load F23 buffer from QuickRecord.last.f23.txt
- [x] 1.3 Refactor `LoadBuffer()` to use the new helper functions

## 2. Implement Reload Hotkeys

- [x] 2.1 Create `ReloadBuffer24()` function that calls `LoadBufferFromFile24()` and displays a notification
- [x] 2.2 Create `ReloadBuffer23()` function that calls `LoadBufferFromFile23()` and displays a notification
- [x] 2.3 Register Ctrl+F24 hotkey to call `ReloadBuffer24()`
- [x] 2.4 Register Ctrl+F23 hotkey to call `ReloadBuffer23()`

## 3. Error Handling

- [x] 3.1 Add error handling to `ReloadBuffer24()` for file read errors and corrupt data
- [x] 3.2 Add error handling to `ReloadBuffer23()` for file read errors and corrupt data
- [x] 3.3 Display appropriate tray notifications for success and error cases

## 4. Testing

- [x] 4.1 Test Ctrl+F24 to reload F24 buffer from file
- [x] 4.2 Test Ctrl+F23 to reload F23 buffer from file
- [x] 4.3 Test that reload does not trigger replay
- [x] 4.4 Test that reloaded buffer is used on next F24/F23 replay
- [x] 4.5 Test reload with missing file (should display notification)
- [x] 4.6 Test reload with corrupt file (should display warning and leave buffer unchanged)
- [x] 4.7 Test reload during recording (should be ignored)
- [x] 4.8 Test that F24 and F23 reloads are independent
