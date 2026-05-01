## ADDED Requirements

### Requirement: Numpad0 sends zero when pressed alone

The system SHALL send the character `0` when Numpad0 is pressed and released without triggering any chord hotkey.

#### Scenario: Numpad0 pressed alone in text field
- **WHEN** user presses and releases Numpad0 without holding any other key
- **THEN** the character `0` is sent to the active application

#### Scenario: Numpad0 used as chord modifier
- **WHEN** user presses Numpad0 and holds it while pressing another key (e.g., NumpadAdd)
- **THEN** the chord hotkey is triggered and `0` is NOT sent

### Requirement: NumpadIns sends zero when pressed alone

The system SHALL send the character `0` when NumpadIns (Numpad0 with numlock off) is pressed and released without triggering any chord hotkey.

#### Scenario: NumpadIns pressed alone with numlock off
- **WHEN** user presses and releases NumpadIns (numlock off) without holding any other key
- **THEN** the character `0` is sent to the active application

#### Scenario: NumpadIns used as chord modifier
- **WHEN** user presses NumpadIns and holds it while pressing another key
- **THEN** the chord hotkey is triggered and `0` is NOT sent

### Requirement: NumpadDot sends period when pressed alone

The system SHALL send the character `.` when NumpadDot is pressed and released without triggering any chord hotkey.

#### Scenario: NumpadDot pressed alone in text field
- **WHEN** user presses and releases NumpadDot without holding any other key
- **THEN** the character `.` is sent to the active application

#### Scenario: NumpadDot used as chord modifier
- **WHEN** user presses NumpadDot and holds it while pressing another key (e.g., Numpad5)
- **THEN** the chord hotkey is triggered and `.` is NOT sent

### Requirement: NumpadDel sends period when pressed alone

The system SHALL send the character `.` when NumpadDel (NumpadDot with numlock off) is pressed and released without triggering any chord hotkey.

#### Scenario: NumpadDel pressed alone with numlock off
- **WHEN** user presses and releases NumpadDel (numlock off) without holding any other key
- **THEN** the character `.` is sent to the active application

#### Scenario: NumpadDel used as chord modifier
- **WHEN** user presses NumpadDel and holds it while pressing another key
- **THEN** the chord hotkey is triggered and `.` is NOT sent
