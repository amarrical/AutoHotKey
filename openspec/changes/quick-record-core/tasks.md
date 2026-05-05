## 1. Setup & Scaffolding

- [ ] 1.1 Create `scripts/QuickRecord.ahk` with `#Requires AutoHotkey v2.0` header
- [ ] 1.2 Define global variables: `mode` (Idle/Recording/Replaying), `events` (array), `startTick`, `isReplaying`
- [ ] 1.3 Create tray menu with Status, Clear, and Exit options
- [ ] 1.4 Set up `SetTimer` for tray tooltip updates (at least once per second)

## 2. Hotkey Registration & State Machine

- [ ] 2.1 Define `KeyList` constant array with ~110 keys (A–Z, 0–9, F1–F24, modifiers, navigation, numpad, punctuation)
- [ ] 2.2 Loop-register `Hotkey("~*" k, RecordDown, "Off")` and `Hotkey("~*" k " Up", RecordUp, "Off")` at startup
- [ ] 2.3 Bind `+F24::ToggleRecord()` for toggle hotkey
- [ ] 2.4 Implement `ToggleRecord()` function with Idle ↔ Recording transitions
- [ ] 2.5 In `ToggleRecord`, enable/disable recording hotkeys via `Hotkey(name, , "On"|"Off")`

## 3. Event Capture

- [ ] 3.1 Implement `RecordDown(name)` function: strip `~*` prefix, append `{down, key, A_TickCount}` to events array
- [ ] 3.2 Implement `RecordUp(name)` function: strip `~*` and ` Up` suffix, append `{up, key, A_TickCount}` to events array
- [ ] 3.3 Add guard in both functions: only append if `mode = "Recording"`
- [ ] 3.4 Implement tail-trim logic: after recording stops, remove trailing `Shift+F24` and modifier release events within threshold

## 4. Playback

- [ ] 4.1 Bind `F24::Replay()` hotkey
- [ ] 4.2 Implement `Replay()` function with `isReplaying` flag and `try`/`finally` block to clear flag
- [ ] 4.3 In `Replay()`, disable recording hotkeys at start via `Hotkey(name, , "Off")` and re-enable at end
- [ ] 4.4 Iterate through events: compute delta from previous tick, `Sleep` (clamped to 5000 ms), `SendEvent {Key Down}` or `{Key Up}`
- [ ] 4.5 Add empty-buffer guard: show `TrayTip` with "No recording available" if buffer is empty
- [ ] 4.6 Ensure `F24` and `Shift+F24` presses during replay are ignored (hotkeys disabled)

## 5. Tray State & Feedback

- [ ] 5.1 Implement tray tooltip updater: show `QuickRecord — Idle` or `QuickRecord — Recording (Nm Ns)` based on mode
- [ ] 5.2 Update tooltip at least once per second via `SetTimer`
- [ ] 5.3 Add tray menu item "Clear last recording" that empties events array
- [ ] 5.4 Test tray balloon notifications for empty buffer and other feedback

## 6. Testing & Validation

- [ ] 6.1 Test toggle hotkey: Idle → Recording → Idle state transitions
- [ ] 6.2 Test keyboard capture: verify down/up events are recorded with correct timing
- [ ] 6.3 Test modifier combinations: Shift+A, Ctrl+C, etc. record and replay correctly
- [ ] 6.4 Test playback: replay recorded typing into a text editor and verify output
- [ ] 6.5 Test re-entrancy: pressing F24 during replay does not start a second replay
- [ ] 6.6 Test empty buffer: F24 with no recording shows tray balloon
- [ ] 6.7 Test tail-trim: verify toggle hotkey is not included in recording
- [ ] 6.8 Test clamped delays: verify long pauses (>5000 ms) are clamped during replay
- [ ] 6.9 Verify script runs without errors and hotkeys are responsive
