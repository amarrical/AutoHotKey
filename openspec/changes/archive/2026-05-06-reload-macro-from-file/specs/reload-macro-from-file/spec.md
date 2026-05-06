## ADDED Requirements

### Requirement: Reload F24 Recording from File
The system SHALL support Ctrl+F24 as a hotkey to reload the F24 recording from QuickRecord.last.txt without triggering replay.

#### Scenario: Reload F24 when file exists
- **WHEN** user presses Ctrl+F24 while in Idle mode and QuickRecord.last.txt exists
- **THEN** the system loads the F24 buffer from QuickRecord.last.txt and displays a notification that the recording was reloaded

#### Scenario: Reload F24 when file does not exist
- **WHEN** user presses Ctrl+F24 while in Idle mode and QuickRecord.last.txt does not exist
- **THEN** the system displays a notification that no recording file was found

#### Scenario: Reload F24 during recording
- **WHEN** user presses Ctrl+F24 while recording for F24
- **THEN** the system ignores the reload request and continues recording

#### Scenario: Reload F24 with corrupt file
- **WHEN** user presses Ctrl+F24 and QuickRecord.last.txt contains invalid data
- **THEN** the system displays a warning notification and leaves the F24 buffer unchanged

### Requirement: Reload F23 Recording from File
The system SHALL support Ctrl+F23 as a hotkey to reload the F23 recording from QuickRecord.last.f23.txt without triggering replay.

#### Scenario: Reload F23 when file exists
- **WHEN** user presses Ctrl+F23 while in Idle mode and QuickRecord.last.f23.txt exists
- **THEN** the system loads the F23 buffer from QuickRecord.last.f23.txt and displays a notification that the recording was reloaded

#### Scenario: Reload F23 when file does not exist
- **WHEN** user presses Ctrl+F23 while in Idle mode and QuickRecord.last.f23.txt does not exist
- **THEN** the system displays a notification that no recording file was found

#### Scenario: Reload F23 during recording
- **WHEN** user presses Ctrl+F23 while recording for F23
- **THEN** the system ignores the reload request and continues recording

#### Scenario: Reload F23 with corrupt file
- **WHEN** user presses Ctrl+F23 and QuickRecord.last.f23.txt contains invalid data
- **THEN** the system displays a warning notification and leaves the F23 buffer unchanged

### Requirement: No Replay on Reload
The system SHALL NOT trigger replay when a reload hotkey (Ctrl+F24 or Ctrl+F23) is pressed.

#### Scenario: Reload does not replay
- **WHEN** user presses Ctrl+F24 or Ctrl+F23 to reload a recording
- **THEN** the system reloads the buffer from file but does not execute any key events

#### Scenario: User must press F24/F23 separately to replay
- **WHEN** user presses Ctrl+F24 to reload and then presses F24 to replay
- **THEN** the system first reloads the buffer, then replays the reloaded recording on the separate F24 press
