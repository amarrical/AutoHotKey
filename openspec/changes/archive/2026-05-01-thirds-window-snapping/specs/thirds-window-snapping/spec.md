## ADDED Requirements

### Requirement: Snap window to left third

The system SHALL snap the active window to the left third of the monitor when NumpadDot + Numpad4 is pressed.

#### Scenario: Snap restored window to left third
- **WHEN** user presses NumpadDot + Numpad4 with a restored window
- **THEN** window moves to left third (0% X, 0% Y, 33.33% width, 100% height) of the active monitor

#### Scenario: Snap maximized window to left third
- **WHEN** user presses NumpadDot + Numpad4 with a maximized window
- **THEN** window is restored and moved to left third of the active monitor

### Requirement: Snap window to right third

The system SHALL snap the active window to the right third of the monitor when NumpadDot + Numpad6 is pressed.

#### Scenario: Snap restored window to right third
- **WHEN** user presses NumpadDot + Numpad6 with a restored window
- **THEN** window moves to right third (66.67% X, 0% Y, 33.33% width, 100% height) of the active monitor

#### Scenario: Snap maximized window to right third
- **WHEN** user presses NumpadDot + Numpad6 with a maximized window
- **THEN** window is restored and moved to right third of the active monitor

### Requirement: Snap window to top third

The system SHALL snap the active window to the top third of the monitor when NumpadDot + Numpad8 is pressed.

#### Scenario: Snap restored window to top third
- **WHEN** user presses NumpadDot + Numpad8 with a restored window
- **THEN** window moves to top third (0% X, 0% Y, 100% width, 33.33% height) of the active monitor

#### Scenario: Snap maximized window to top third
- **WHEN** user presses NumpadDot + Numpad8 with a maximized window
- **THEN** window is restored and moved to top third of the active monitor

### Requirement: Snap window to bottom third

The system SHALL snap the active window to the bottom third of the monitor when NumpadDot + Numpad2 is pressed.

#### Scenario: Snap restored window to bottom third
- **WHEN** user presses NumpadDot + Numpad2 with a restored window
- **THEN** window moves to bottom third (0% X, 66.67% Y, 100% width, 33.33% height) of the active monitor

#### Scenario: Snap maximized window to bottom third
- **WHEN** user presses NumpadDot + Numpad2 with a maximized window
- **THEN** window is restored and moved to bottom third of the active monitor

### Requirement: Snap window to center third with orientation awareness

The system SHALL snap the active window to the center third of the monitor when NumpadDot + Numpad5 is pressed, with positioning that adapts to monitor orientation.

#### Scenario: Snap to center third on landscape monitor
- **WHEN** user presses NumpadDot + Numpad5 on a landscape monitor (width >= height)
- **THEN** window moves to center column (33.33% X, 0% Y, 33.33% width, 100% height)

#### Scenario: Snap to center third on portrait monitor
- **WHEN** user presses NumpadDot + Numpad5 on a portrait monitor (height > width)
- **THEN** window moves to center row (0% X, 33.33% Y, 100% width, 33.33% height)

#### Scenario: Snap maximized window to center third
- **WHEN** user presses NumpadDot + Numpad5 with a maximized window
- **THEN** window is restored and moved to center third with orientation awareness

### Requirement: Position calculation relative to active monitor

The system SHALL calculate window positions relative to the monitor containing the window's area.

#### Scenario: Multi-monitor setup with window on secondary monitor
- **WHEN** user snaps a window on a secondary monitor
- **THEN** window is positioned relative to that secondary monitor's dimensions, not the primary monitor

#### Scenario: Window spanning multiple monitors
- **WHEN** user snaps a window whose area spans multiple monitors
- **THEN** window is positioned relative to the monitor containing the window's area
