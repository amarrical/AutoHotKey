## 1. State Management

- [ ] 1.1 Add global state variables for F23 buffer: `events23`, `mode23`, `startTick23`, `stopTick23`
- [ ] 1.2 Update `LoadBuffer()` to load both F24 and F23 buffers from their respective files

## 2. Recording Hotkeys

- [ ] 2.1 Create `ToggleRecord23()` function to toggle recording for F23 buffer
- [ ] 2.2 Register Shift+F23 hotkey to call `ToggleRecord23()`
- [ ] 2.3 Update `RecordDown()` to check both `mode` and `mode23` and append to correct buffer
- [ ] 2.4 Update `RecordUp()` to check both `mode` and `mode23` and append to correct buffer

## 3. Replay Hotkeys

- [ ] 3.1 Create `Replay23()` function to replay the F23 buffer
- [ ] 3.2 Register F23 hotkey to call `Replay23()`

## 4. Persistence

- [ ] 4.1 Create `SaveBuffer23()` function to save F23 buffer to QuickRecord.last.f23.txt
- [ ] 4.2 Update `SaveBuffer()` to be `SaveBuffer24()` for clarity (optional refactor)
- [ ] 4.3 Update `ToggleRecord23()` to call `SaveBuffer23()` when stopping recording
- [ ] 4.4 Update `LoadBuffer()` to load F23 buffer from QuickRecord.last.f23.txt

## 5. Utility Functions

- [ ] 5.1 Update `ClearRecording()` to delete both QuickRecord.last.txt and QuickRecord.last.f23.txt
- [ ] 5.2 Update `UpdateTrayTooltip()` to display status for both F24 and F23 buffers (or keep F24 only)
- [ ] 5.3 Update `TrayStatus()` to show event counts for both buffers

## 6. Testing

- [ ] 6.1 Test Shift+F23 to start/stop recording F23 buffer
- [ ] 6.2 Test F23 to replay F23 buffer
- [ ] 6.3 Test that F24 recording/replay still works independently
- [ ] 6.4 Test that F23 buffer persists across script restart
- [ ] 6.5 Test that clearing recording deletes both persistence files
- [ ] 6.6 Test replay timing and event accuracy for F23 buffer
