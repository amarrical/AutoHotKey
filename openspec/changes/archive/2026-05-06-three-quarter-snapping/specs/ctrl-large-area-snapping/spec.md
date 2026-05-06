## ADDED Requirements

### Requirement: Ctrl+Numpad0+direction snaps to absolute 3/4 monitor area
The system SHALL snap the active window to a 3/4 area of the monitor when Ctrl is held with Numpad0 and a cardinal direction key (2/4/6/8), positioning the window flush with the corresponding edge.

#### Scenario: Ctrl+Numpad0+Numpad4 snaps to left 3/4
- **WHEN** user presses Ctrl+Numpad0+Numpad4
- **THEN** active window fills the left 75% of the monitor (full height, anchored to left edge)

#### Scenario: Ctrl+Numpad0+Numpad6 snaps to right 3/4
- **WHEN** user presses Ctrl+Numpad0+Numpad6
- **THEN** active window fills the right 75% of the monitor (full height, anchored to right edge)

#### Scenario: Ctrl+Numpad0+Numpad8 snaps to top 3/4
- **WHEN** user presses Ctrl+Numpad0+Numpad8
- **THEN** active window fills the top 75% of the monitor (full width, anchored to top edge)

#### Scenario: Ctrl+Numpad0+Numpad2 snaps to bottom 3/4
- **WHEN** user presses Ctrl+Numpad0+Numpad2
- **THEN** active window fills the bottom 75% of the monitor (full width, anchored to bottom edge)

### Requirement: Ctrl+CapsLock+direction snaps to absolute 3/4 monitor area
The system SHALL snap the active window to a 3/4 area of the monitor when Ctrl is held with CapsLock and a cardinal direction key (a/d/w/x), providing the same 3/4 snapping for keyboards without numpad.

#### Scenario: Ctrl+CapsLock+A snaps to left 3/4
- **WHEN** user presses Ctrl+CapsLock+A
- **THEN** active window fills the left 75% of the monitor (full height, anchored to left edge)

#### Scenario: Ctrl+CapsLock+D snaps to right 3/4
- **WHEN** user presses Ctrl+CapsLock+D
- **THEN** active window fills the right 75% of the monitor (full height, anchored to right edge)

#### Scenario: Ctrl+CapsLock+W snaps to top 3/4
- **WHEN** user presses Ctrl+CapsLock+W
- **THEN** active window fills the top 75% of the monitor (full width, anchored to top edge)

#### Scenario: Ctrl+CapsLock+X snaps to bottom 3/4
- **WHEN** user presses Ctrl+CapsLock+X
- **THEN** active window fills the bottom 75% of the monitor (full width, anchored to bottom edge)

### Requirement: Ctrl+NumpadDot+direction snaps to absolute 2/3 monitor area
The system SHALL snap the active window to a 2/3 area of the monitor when Ctrl is held with NumpadDot and a cardinal direction key (2/4/6/8), positioning the window flush with the corresponding edge.

#### Scenario: Ctrl+NumpadDot+Numpad4 snaps to left 2/3
- **WHEN** user presses Ctrl+NumpadDot+Numpad4
- **THEN** active window fills the left 66.7% of the monitor (full height, anchored to left edge)

#### Scenario: Ctrl+NumpadDot+Numpad6 snaps to right 2/3
- **WHEN** user presses Ctrl+NumpadDot+Numpad6
- **THEN** active window fills the right 66.7% of the monitor (full height, anchored to right edge)

#### Scenario: Ctrl+NumpadDot+Numpad8 snaps to top 2/3
- **WHEN** user presses Ctrl+NumpadDot+Numpad8
- **THEN** active window fills the top 66.7% of the monitor (full width, anchored to top edge)

#### Scenario: Ctrl+NumpadDot+Numpad2 snaps to bottom 2/3
- **WHEN** user presses Ctrl+NumpadDot+Numpad2
- **THEN** active window fills the bottom 66.7% of the monitor (full width, anchored to bottom edge)

### Requirement: Large area snapping restores maximized windows
The system SHALL restore a maximized window before applying 3/4 or 2/3 snap positioning.

#### Scenario: Ctrl+Numpad0+Numpad4 on maximized window
- **WHEN** user presses Ctrl+Numpad0+Numpad4 on a maximized window
- **THEN** window is restored from maximized state and positioned to the left 3/4 of the monitor

### Requirement: Large area snapping uses correct monitor in multi-monitor setups
The system SHALL detect which monitor contains the active window and snap to the 3/4 or 2/3 area on that monitor.

#### Scenario: Ctrl+Numpad0+Numpad6 snaps on correct monitor
- **WHEN** user has multiple monitors and presses Ctrl+Numpad0+Numpad6 on a window in monitor 2
- **THEN** window is snapped to the right 3/4 of monitor 2, not monitor 1

### Requirement: Large area snapping does not interfere with existing snapping
The system SHALL preserve all existing snap behaviors when Ctrl is not held.

#### Scenario: Numpad0+Numpad4 without Ctrl still uses relative half snapping
- **WHEN** user presses Numpad0+Numpad4 without holding Ctrl
- **THEN** window snaps to the left half using relative positioning (unchanged behavior)
