## ADDED Requirements

### Requirement: CapsLock quarter and half snaps

The system SHALL snap the active window to quarters and halves when CapsLock is held and a home-row key is pressed.

#### Scenario: CapsLock + Q snaps to top-left quarter
- **WHEN** user presses CapsLock + Q
- **THEN** window snaps to top-left quarter (0% X, 0% Y, 50% width, 50% height)

#### Scenario: CapsLock + W snaps to top half
- **WHEN** user presses CapsLock + W
- **THEN** window snaps to top half (0% X, 0% Y, 100% width, 50% height)

#### Scenario: CapsLock + E snaps to top-right quarter
- **WHEN** user presses CapsLock + E
- **THEN** window snaps to top-right quarter (50% X, 0% Y, 50% width, 50% height)

#### Scenario: CapsLock + A snaps to left half
- **WHEN** user presses CapsLock + A
- **THEN** window snaps to left half (0% X, 0% Y, 50% width, 100% height)

#### Scenario: CapsLock + D snaps to right half
- **WHEN** user presses CapsLock + D
- **THEN** window snaps to right half (50% X, 0% Y, 50% width, 100% height)

#### Scenario: CapsLock + Z snaps to bottom-left quarter
- **WHEN** user presses CapsLock + Z
- **THEN** window snaps to bottom-left quarter (0% X, 50% Y, 50% width, 50% height)

#### Scenario: CapsLock + X snaps to bottom half
- **WHEN** user presses CapsLock + X
- **THEN** window snaps to bottom half (0% X, 50% Y, 100% width, 50% height)

#### Scenario: CapsLock + C snaps to bottom-right quarter
- **WHEN** user presses CapsLock + C
- **THEN** window snaps to bottom-right quarter (50% X, 50% Y, 50% width, 50% height)

### Requirement: CapsLock maximize

The system SHALL maximize the active window when CapsLock + S is pressed.

#### Scenario: CapsLock + S maximizes window
- **WHEN** user presses CapsLock + S
- **THEN** window is maximized to fill the monitor

### Requirement: CapsLock center-half snap with orientation awareness

The system SHALL snap the active window to the center half when CapsLock + Tab is pressed, with positioning that adapts to monitor orientation.

#### Scenario: CapsLock + Tab on landscape monitor
- **WHEN** user presses CapsLock + Tab on a landscape monitor
- **THEN** window snaps to center column (25% X, 0% Y, 50% width, 100% height)

#### Scenario: CapsLock + Tab on portrait monitor
- **WHEN** user presses CapsLock + Tab on a portrait monitor
- **THEN** window snaps to center row (0% X, 25% Y, 100% width, 50% height)

### Requirement: CapsLock move to next monitor

The system SHALL move the active window to the next monitor when CapsLock + Space is pressed.

#### Scenario: CapsLock + Space moves window to next monitor
- **WHEN** user presses CapsLock + Space
- **THEN** window moves to the next monitor at proportionally equivalent position and size

#### Scenario: CapsLock + Space wraps from last to first monitor
- **WHEN** user presses CapsLock + Space on the last monitor
- **THEN** window moves to the first monitor at proportionally equivalent position and size

#### Scenario: CapsLock + Space preserves maximized state
- **WHEN** user presses CapsLock + Space with a maximized window
- **THEN** window moves to the next monitor and is re-maximized

#### Scenario: CapsLock + Space uses center-point monitor detection
- **WHEN** user presses CapsLock + Space with a window spanning multiple monitors
- **THEN** window's destination monitor is determined by the window's center point
