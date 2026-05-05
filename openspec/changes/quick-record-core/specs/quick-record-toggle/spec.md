## ADDED Requirements

### Requirement: Shift+F24 toggles recording state
The system SHALL toggle between Idle and Recording states each time `Shift+F24` is pressed.

#### Scenario: Idle → Recording
- **WHEN** the script is Idle and the user presses `Shift+F24`
- **THEN** the script enters Recording state, clears the previous in-memory event buffer, and records a start tick

#### Scenario: Recording → Idle
- **WHEN** the script is Recording and the user presses `Shift+F24`
- **THEN** the script exits Recording state and finalizes the event buffer

### Requirement: Toggle artifacts are excluded
The system SHALL NOT include the `Shift+F24` keystrokes themselves (down or up) in the recorded event buffer.

#### Scenario: Trailing modifier release is dropped
- **WHEN** recording stops via `Shift+F24`
- **THEN** any `LShift`/`RShift`/`F24` up-events captured near the toggle are removed from the tail of the buffer

### Requirement: Visual state indication
The system SHALL communicate current state via tray icon and tooltip.

#### Scenario: Recording shows tray state
- **WHEN** the script is Recording
- **THEN** the tray tooltip reads `QuickRecord — Recording (Nm Ns)` (showing number of events and seconds elapsed) and updates at least once per second

#### Scenario: Idle shows tray state
- **WHEN** the script is Idle
- **THEN** the tray tooltip reads `QuickRecord — Idle`
