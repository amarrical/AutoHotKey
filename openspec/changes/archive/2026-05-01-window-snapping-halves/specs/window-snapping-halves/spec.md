## ADDED Requirements

### Requirement: Snap window to left half

The system SHALL snap the active window to the left half of the monitor when Numpad0 + Numpad4 is pressed.

#### Scenario: Snap restored window to left half
- **WHEN** user presses Numpad0 + Numpad4 with a restored window
- **THEN** window moves to left half (0% X, 0% Y, 50% width, 100% height) of the active monitor

#### Scenario: Snap maximized window to left half
- **WHEN** user presses Numpad0 + Numpad4 with a maximized window
- **THEN** window is restored and moved to left half of the active monitor

### Requirement: Snap window to right half

The system SHALL snap the active window to the right half of the monitor when Numpad0 + Numpad6 is pressed.

#### Scenario: Snap restored window to right half
- **WHEN** user presses Numpad0 + Numpad6 with a restored window
- **THEN** window moves to right half (50% X, 0% Y, 50% width, 100% height) of the active monitor

#### Scenario: Snap maximized window to right half
- **WHEN** user presses Numpad0 + Numpad6 with a maximized window
- **THEN** window is restored and moved to right half of the active monitor

### Requirement: Snap window to top half

The system SHALL snap the active window to the top half of the monitor when Numpad0 + Numpad8 is pressed.

#### Scenario: Snap restored window to top half
- **WHEN** user presses Numpad0 + Numpad8 with a restored window
- **THEN** window moves to top half (0% X, 0% Y, 100% width, 50% height) of the active monitor

#### Scenario: Snap maximized window to top half
- **WHEN** user presses Numpad0 + Numpad8 with a maximized window
- **THEN** window is restored and moved to top half of the active monitor

### Requirement: Snap window to bottom half

The system SHALL snap the active window to the bottom half of the monitor when Numpad0 + Numpad2 is pressed.

#### Scenario: Snap restored window to bottom half
- **WHEN** user presses Numpad0 + Numpad2 with a restored window
- **THEN** window moves to bottom half (0% X, 50% Y, 100% width, 50% height) of the active monitor

#### Scenario: Snap maximized window to bottom half
- **WHEN** user presses Numpad0 + Numpad2 with a maximized window
- **THEN** window is restored and moved to bottom half of the active monitor

### Requirement: Snap window to center half with orientation awareness

The system SHALL snap the active window to the center half of the monitor when Numpad0 + Numpad5 is pressed, with positioning that adapts to monitor orientation.

#### Scenario: Snap to center half on landscape monitor
- **WHEN** user presses Numpad0 + Numpad5 on a landscape monitor (width >= height)
- **THEN** window moves to center column (25% X, 0% Y, 50% width, 100% height)

#### Scenario: Snap to center half on portrait monitor
- **WHEN** user presses Numpad0 + Numpad5 on a portrait monitor (height > width)
- **THEN** window moves to center row (0% X, 25% Y, 100% width, 50% height)

#### Scenario: Snap maximized window to center half
- **WHEN** user presses Numpad0 + Numpad5 with a maximized window
- **THEN** window is restored and moved to center half with orientation awareness

### Requirement: Position calculation relative to active monitor

The system SHALL calculate window positions relative to the monitor containing the window's center point.

#### Scenario: Multi-monitor setup with window on secondary monitor
- **WHEN** user snaps a window on a secondary monitor
- **THEN** window is positioned relative to that secondary monitor's dimensions, not the primary monitor

#### Scenario: Window spanning multiple monitors
- **WHEN** user snaps a window whose center point is on a specific monitor
- **THEN** window is positioned relative to that monitor
