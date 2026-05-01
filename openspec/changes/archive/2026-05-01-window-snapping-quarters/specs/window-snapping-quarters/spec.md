## ADDED Requirements

### Requirement: Snap window to top-left quarter

The system SHALL snap the active window to the top-left quarter of the monitor when Numpad0 + Numpad7 is pressed.

#### Scenario: Snap restored window to top-left quarter
- **WHEN** user presses Numpad0 + Numpad7 with a restored window
- **THEN** window moves to top-left quarter (0% X, 0% Y, 50% width, 50% height) of the active monitor

#### Scenario: Snap maximized window to top-left quarter
- **WHEN** user presses Numpad0 + Numpad7 with a maximized window
- **THEN** window is restored and moved to top-left quarter of the active monitor

### Requirement: Snap window to top-right quarter

The system SHALL snap the active window to the top-right quarter of the monitor when Numpad0 + Numpad9 is pressed.

#### Scenario: Snap restored window to top-right quarter
- **WHEN** user presses Numpad0 + Numpad9 with a restored window
- **THEN** window moves to top-right quarter (50% X, 0% Y, 50% width, 50% height) of the active monitor

#### Scenario: Snap maximized window to top-right quarter
- **WHEN** user presses Numpad0 + Numpad9 with a maximized window
- **THEN** window is restored and moved to top-right quarter of the active monitor

### Requirement: Snap window to bottom-left quarter

The system SHALL snap the active window to the bottom-left quarter of the monitor when Numpad0 + Numpad1 is pressed.

#### Scenario: Snap restored window to bottom-left quarter
- **WHEN** user presses Numpad0 + Numpad1 with a restored window
- **THEN** window moves to bottom-left quarter (0% X, 50% Y, 50% width, 50% height) of the active monitor

#### Scenario: Snap maximized window to bottom-left quarter
- **WHEN** user presses Numpad0 + Numpad1 with a maximized window
- **THEN** window is restored and moved to bottom-left quarter of the active monitor

### Requirement: Snap window to bottom-right quarter

The system SHALL snap the active window to the bottom-right quarter of the monitor when Numpad0 + Numpad3 is pressed.

#### Scenario: Snap restored window to bottom-right quarter
- **WHEN** user presses Numpad0 + Numpad3 with a restored window
- **THEN** window moves to bottom-right quarter (50% X, 50% Y, 50% width, 50% height) of the active monitor

#### Scenario: Snap maximized window to bottom-right quarter
- **WHEN** user presses Numpad0 + Numpad3 with a maximized window
- **THEN** window is restored and moved to bottom-right quarter of the active monitor
