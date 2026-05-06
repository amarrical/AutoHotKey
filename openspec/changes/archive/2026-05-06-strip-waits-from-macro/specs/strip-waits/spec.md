## ADDED Requirements

### Requirement: Strip Waits from F24 Macro
The system SHALL support Alt+F24 as a hotkey to remove all timing delays from the F24 macro and rewrite the storage file.

#### Scenario: Strip waits from F24 when idle
- **WHEN** user presses Alt+F24 while in Idle mode and F24 buffer contains events
- **THEN** the system sets all event deltas to 0, updates the in-memory F24 buffer, rewrites QuickRecord.last.F24.txt, and displays a confirmation notification

#### Scenario: Strip waits from empty F24 buffer
- **WHEN** user presses Alt+F24 while in Idle mode and F24 buffer is empty
- **THEN** the system displays a notification that there is no recording to strip

#### Scenario: Strip waits during F24 recording
- **WHEN** user presses Alt+F24 while recording for F24
- **THEN** the system ignores the request and displays a notification that it cannot strip while recording

### Requirement: Strip Waits from F23 Macro
The system SHALL support Alt+F23 as a hotkey to remove all timing delays from the F23 macro and rewrite the storage file.

#### Scenario: Strip waits from F23 when idle
- **WHEN** user presses Alt+F23 while in Idle mode and F23 buffer contains events
- **THEN** the system sets all event deltas to 0, updates the in-memory F23 buffer, rewrites QuickRecord.last.f23.txt, and displays a confirmation notification

#### Scenario: Strip waits from empty F23 buffer
- **WHEN** user presses Alt+F23 while in Idle mode and F23 buffer is empty
- **THEN** the system displays a notification that there is no recording to strip

#### Scenario: Strip waits during F23 recording
- **WHEN** user presses Alt+F23 while recording for F23
- **THEN** the system ignores the request and displays a notification that it cannot strip while recording

### Requirement: Preserve Key Sequence
The system SHALL preserve the key sequence (kind and key values) while removing all timing delays.

#### Scenario: Key sequence unchanged after stripping
- **WHEN** user strips waits from a macro
- **THEN** all events retain their original kind (down/up) and key values, only deltas are set to 0

### Requirement: Persist Stripped Macro
The system SHALL rewrite the storage file with the stripped macro so changes persist across script restart.

#### Scenario: Stripped macro persists
- **WHEN** user strips waits from a macro and then restarts the script
- **THEN** the reloaded macro has no timing delays (all deltas are 0)
