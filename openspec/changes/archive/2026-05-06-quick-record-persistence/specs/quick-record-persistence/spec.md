## ADDED Requirements

### Requirement: Persist on stop
The system SHALL write the event buffer to `scripts/QuickRecord.last.txt` immediately after recording stops.

#### Scenario: Stop writes file
- **WHEN** recording transitions Recording → Idle
- **THEN** `QuickRecord.last.txt` exists and contains all buffered events in delta-based format

#### Scenario: File format is correct
- **WHEN** the user records `a` down, waits 50ms, `a` up, waits 100ms, `b` down, waits 45ms, `b` up
- **THEN** the file contains:
  ```
  down	a	0
  up	a	50
  down	b	100
  up	b	45
  ```

### Requirement: Load on start
The system SHALL load `QuickRecord.last.txt` into the in-memory buffer at script startup if the file exists and parses successfully.

#### Scenario: Replay after reload
- **WHEN** the user records, reloads the script, then presses `F24`
- **THEN** the recording from before the reload is replayed

#### Scenario: File does not exist
- **WHEN** the script starts and no `QuickRecord.last.txt` file exists
- **THEN** the buffer starts empty and no error is shown

### Requirement: Format is line-based and human-readable
The system SHALL use one event per line, format `<kind>\t<key>\t<delta>`, where `kind` is `down` or `up` and `delta` is the milliseconds since the previous event (or 0 for the first event).

#### Scenario: Zero-delay events
- **WHEN** the user wants faster playback, they may manually edit the file and set `delta` to `0` for rapid-fire events
- **THEN** replay respects the zero delay and sends events back-to-back

#### Scenario: Corrupt file ignored gracefully
- **WHEN** the file contains an unparseable line (e.g., missing tab, invalid key)
- **THEN** the script logs a tray warning, starts with an empty buffer, and continues running

### Requirement: Clear last recording
The system SHALL provide a tray menu item "Clear last recording" that empties the buffer and deletes the file.

#### Scenario: Clear removes file
- **WHEN** the user clicks "Clear last recording" from the tray menu
- **THEN** the buffer is emptied and `QuickRecord.last.txt` is deleted

#### Scenario: Clear only works when idle
- **WHEN** the script is Recording
- **THEN** the "Clear last recording" menu item is disabled or has no effect
