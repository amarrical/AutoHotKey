## ADDED Requirements

### Requirement: Shift+NumpadDot+Direction snaps to absolute monitor third
The system SHALL snap the active window to a fixed third of the monitor when Shift is held with NumpadDot and a direction key, regardless of the window's current position or size.

#### Scenario: Shift+NumpadDot+Numpad4 snaps to left third
- **WHEN** user presses Shift+NumpadDot+Numpad4
- **THEN** active window is positioned to the left third of the monitor (33.3% width, 100% height, left-aligned)

#### Scenario: Shift+NumpadDot+Numpad6 snaps to right third
- **WHEN** user presses Shift+NumpadDot+Numpad6
- **THEN** active window is positioned to the right third of the monitor (33.3% width, 100% height, right-aligned)

#### Scenario: Shift+NumpadDot+Numpad5 snaps to center third
- **WHEN** user presses Shift+NumpadDot+Numpad5
- **THEN** active window is positioned to the center third of the monitor (orientation-aware: middle column on landscape, middle row on portrait)

#### Scenario: Shift+NumpadDot+Numpad8 snaps to top third
- **WHEN** user presses Shift+NumpadDot+Numpad8
- **THEN** active window is positioned to the top third of the monitor (100% width, 33.3% height, top-aligned)

#### Scenario: Shift+NumpadDot+Numpad2 snaps to bottom third
- **WHEN** user presses Shift+NumpadDot+Numpad2
- **THEN** active window is positioned to the bottom third of the monitor (100% width, 33.3% height, bottom-aligned)

### Requirement: Absolute third snapping works regardless of Shift+NumpadDot press order
The system SHALL trigger absolute third snapping whether Shift is pressed before or after NumpadDot, to accommodate different user typing habits.

#### Scenario: Shift pressed first then NumpadDot then direction
- **WHEN** user presses Shift, then NumpadDot, then a direction key
- **THEN** active window snaps to the corresponding absolute monitor third

#### Scenario: NumpadDot pressed first then Shift then direction
- **WHEN** user presses NumpadDot, then Shift, then a direction key
- **THEN** active window snaps to the corresponding absolute monitor third

### Requirement: Absolute third snapping restores maximized windows
The system SHALL restore a maximized window to normal state before applying absolute third snap positioning.

#### Scenario: Shift+NumpadDot+Numpad4 restores and snaps maximized window
- **WHEN** user presses Shift+NumpadDot+Numpad4 on a maximized window
- **THEN** window is restored from maximized state and positioned to the left third of the monitor

### Requirement: Absolute third snapping uses correct monitor in multi-monitor setups
The system SHALL detect which monitor contains the active window and snap to the absolute third position on that monitor.

#### Scenario: Shift+NumpadDot+Numpad6 snaps on correct monitor
- **WHEN** user has multiple monitors and presses Shift+NumpadDot+Numpad6 on a window in monitor 2
- **THEN** window is snapped to the right third of monitor 2, not monitor 1

### Requirement: Absolute third snapping does not interfere with relative third snapping
The system SHALL preserve existing relative third snapping behavior when Shift is not held.

#### Scenario: NumpadDot+Numpad4 (without Shift) still uses relative snapping
- **WHEN** user presses NumpadDot+Numpad4 without holding Shift
- **THEN** window snaps to the left third of its current area (relative positioning)
