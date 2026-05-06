## MODIFIED Requirements

### Requirement: Recording Persistence
The system SHALL persist recording buffers to disk in a human-readable format and load them at startup.

#### Scenario: Save F24 recording
- **WHEN** user stops recording with Shift+F24
- **THEN** the system saves the F24 buffer to QuickRecord.last.txt in tab-separated format (kind, key, delta)

#### Scenario: Save F23 recording
- **WHEN** user stops recording with Shift+F23
- **THEN** the system saves the F23 buffer to QuickRecord.last.f23.txt in tab-separated format (kind, key, delta)

#### Scenario: Load both buffers at startup
- **WHEN** the script starts
- **THEN** the system loads QuickRecord.last.txt into the F24 buffer and QuickRecord.last.f23.txt into the F23 buffer (if either file exists)

#### Scenario: Handle missing persistence files
- **WHEN** the script starts and one or both persistence files do not exist
- **THEN** the system initializes the corresponding buffer as empty and continues normally

#### Scenario: Delete all recordings
- **WHEN** user clears the recording via tray menu
- **THEN** the system deletes both QuickRecord.last.txt and QuickRecord.last.f23.txt if they exist
