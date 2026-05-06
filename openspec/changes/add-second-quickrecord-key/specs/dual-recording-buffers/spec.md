## ADDED Requirements

### Requirement: F23 Recording Toggle
The system SHALL support Shift+F23 as a hotkey to toggle recording for a second independent buffer.

#### Scenario: Start recording with Shift+F23
- **WHEN** user presses Shift+F23 while in Idle mode
- **THEN** the system enters Recording mode for F23 buffer, clears the F23 events array, and records all subsequent key events

#### Scenario: Stop recording with Shift+F23
- **WHEN** user presses Shift+F23 while in Recording mode for F23 buffer
- **THEN** the system exits Recording mode, trims artifacts, and saves the F23 buffer to disk

### Requirement: F23 Replay
The system SHALL support F23 as a hotkey to replay the recorded sequence from the F23 buffer.

#### Scenario: Replay F23 recording
- **WHEN** user presses F23 while in Idle mode and a recording exists in the F23 buffer
- **THEN** the system replays all events from the F23 buffer with proper timing

#### Scenario: Replay with empty F23 buffer
- **WHEN** user presses F23 while in Idle mode and the F23 buffer is empty
- **THEN** the system displays a notification that no recording is available

### Requirement: Independent F23 and F24 Buffers
The system SHALL maintain two completely independent recording buffers for F23 and F24.

#### Scenario: Record F23 while F24 has recording
- **WHEN** user has a recording in the F24 buffer and records a new sequence with F23
- **THEN** the F23 buffer is populated independently without affecting the F24 buffer

#### Scenario: Replay F23 without affecting F24
- **WHEN** user replays the F23 buffer
- **THEN** the F24 buffer remains unchanged and available for replay

### Requirement: F23 Buffer Persistence
The system SHALL persist the F23 recording buffer to a separate file from F24.

#### Scenario: Save F23 recording
- **WHEN** user stops recording with Shift+F23
- **THEN** the system saves the F23 buffer to QuickRecord.last.f23.txt in tab-separated format

#### Scenario: Load F23 recording at startup
- **WHEN** the script starts and QuickRecord.last.f23.txt exists
- **THEN** the system loads the F23 buffer from the file and makes it available for replay

#### Scenario: Clear F23 recording
- **WHEN** user clears the recording (via tray menu or equivalent)
- **THEN** both F23 and F24 buffers are cleared, and both persistence files are deleted
