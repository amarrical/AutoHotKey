## MODIFIED Requirements

### Requirement: Recording Playback
The system SHALL replay recorded key events with proper timing from the in-memory buffer.

#### Scenario: Replay F24 recording
- **WHEN** user presses F24 while in Idle mode and a recording exists in the F24 buffer
- **THEN** the system replays all events from the F24 buffer with proper timing

#### Scenario: Replay F23 recording
- **WHEN** user presses F23 while in Idle mode and a recording exists in the F23 buffer
- **THEN** the system replays all events from the F23 buffer with proper timing

#### Scenario: Replay with empty buffer
- **WHEN** user presses F24 or F23 while in Idle mode and the corresponding buffer is empty
- **THEN** the system displays a notification that no recording is available

#### Scenario: Replay uses reloaded buffer
- **WHEN** user presses Ctrl+F24 to reload the F24 buffer from file and then presses F24 to replay
- **THEN** the system replays the newly loaded events from the file, not the old in-memory buffer
