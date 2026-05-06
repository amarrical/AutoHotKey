## 1. File I/O Functions

- [x] 1.1 Implement `SaveBuffer()` function: convert events array to delta-based format and write to `scripts/QuickRecord.last.txt`
- [x] 1.2 Implement `LoadBuffer()` function: read file, parse lines, convert deltas back to absolute ticks, populate events array
- [x] 1.3 Add error handling in `LoadBuffer()` for corrupt files (show tray warning, continue with empty buffer)

## 2. Integration

- [x] 2.1 Call `LoadBuffer()` at script startup (after hotkey registration, before main loop)
- [x] 2.2 Call `SaveBuffer()` in `ToggleRecord()` when recording stops (after trimming artifacts)
- [x] 2.3 Update tray menu "Clear last recording" to call `ClearRecording()` function

## 3. Clear Recording Function

- [x] 3.1 Implement `ClearRecording()` function: empty events array and delete `QuickRecord.last.txt`
- [x] 3.2 Add guard: only allow clear when `mode = "Idle"`
- [x] 3.3 Show tray tip confirmation when recording is cleared

## 4. Testing & Validation

- [x] 4.1 Test save: record something, stop, verify file exists and contains correct format
- [x] 4.2 Test load: record, reload script, verify buffer is populated from file
- [x] 4.3 Test replay after reload: record, reload, press F24, verify playback works
- [x] 4.4 Test manual editing: edit file to set delta to 0, replay, verify rapid-fire playback
- [x] 4.5 Test corrupt file: create malformed file, start script, verify tray warning and empty buffer
- [x] 4.6 Test clear: click "Clear last recording", verify file is deleted and buffer is empty
- [x] 4.7 Verify file location is correct (relative to script directory)
