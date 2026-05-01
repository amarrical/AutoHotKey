## ADDED Requirements

### Requirement: Shift+Numpad0+Direction snaps to absolute monitor position
The system SHALL snap the active window to a fixed position on the monitor when Shift is held with Numpad0 and a direction key, regardless of the window's current position or size.

#### Scenario: Shift+Numpad0+Numpad6 snaps to right half
- **WHEN** user presses Shift+Numpad0+Numpad6
- **THEN** active window is positioned to the right half of the monitor (50% width, 100% height, right-aligned)

#### Scenario: Shift+Numpad0+Numpad4 snaps to left half
- **WHEN** user presses Shift+Numpad0+Numpad4
- **THEN** active window is positioned to the left half of the monitor (50% width, 100% height, left-aligned)

#### Scenario: Shift+Numpad0+Numpad8 snaps to top half
- **WHEN** user presses Shift+Numpad0+Numpad8
- **THEN** active window is positioned to the top half of the monitor (100% width, 50% height, top-aligned)

#### Scenario: Shift+Numpad0+Numpad2 snaps to bottom half
- **WHEN** user presses Shift+Numpad0+Numpad2
- **THEN** active window is positioned to the bottom half of the monitor (100% width, 50% height, bottom-aligned)

#### Scenario: Shift+Numpad0+Numpad7 snaps to top-left quarter
- **WHEN** user presses Shift+Numpad0+Numpad7
- **THEN** active window is positioned to the top-left quarter of the monitor (50% width, 50% height)

#### Scenario: Shift+Numpad0+Numpad9 snaps to top-right quarter
- **WHEN** user presses Shift+Numpad0+Numpad9
- **THEN** active window is positioned to the top-right quarter of the monitor (50% width, 50% height)

#### Scenario: Shift+Numpad0+Numpad1 snaps to bottom-left quarter
- **WHEN** user presses Shift+Numpad0+Numpad1
- **THEN** active window is positioned to the bottom-left quarter of the monitor (50% width, 50% height)

#### Scenario: Shift+Numpad0+Numpad3 snaps to bottom-right quarter
- **WHEN** user presses Shift+Numpad0+Numpad3
- **THEN** active window is positioned to the bottom-right quarter of the monitor (50% width, 50% height)

### Requirement: Shift+CapsLock+Direction snaps to absolute monitor position
The system SHALL snap the active window to a fixed position on the monitor when Shift is held with CapsLock and a direction key, providing the same absolute positioning as Numpad0+Shift for keyboards without numpad.

#### Scenario: Shift+CapsLock+D snaps to right half
- **WHEN** user presses Shift+CapsLock+D
- **THEN** active window is positioned to the right half of the monitor

#### Scenario: Shift+CapsLock+A snaps to left half
- **WHEN** user presses Shift+CapsLock+A
- **THEN** active window is positioned to the left half of the monitor

#### Scenario: Shift+CapsLock+W snaps to top half
- **WHEN** user presses Shift+CapsLock+W
- **THEN** active window is positioned to the top half of the monitor

#### Scenario: Shift+CapsLock+S snaps to bottom half
- **WHEN** user presses Shift+CapsLock+S
- **THEN** active window is positioned to the bottom half of the monitor

#### Scenario: Shift+CapsLock+Q snaps to top-left quarter
- **WHEN** user presses Shift+CapsLock+Q
- **THEN** active window is positioned to the top-left quarter of the monitor

#### Scenario: Shift+CapsLock+E snaps to top-right quarter
- **WHEN** user presses Shift+CapsLock+E
- **THEN** active window is positioned to the top-right quarter of the monitor

#### Scenario: Shift+CapsLock+Z snaps to bottom-left quarter
- **WHEN** user presses Shift+CapsLock+Z
- **THEN** active window is positioned to the bottom-left quarter of the monitor

#### Scenario: Shift+CapsLock+C snaps to bottom-right quarter
- **WHEN** user presses Shift+CapsLock+C
- **THEN** active window is positioned to the bottom-right quarter of the monitor

### Requirement: Absolute snapping restores maximized windows
The system SHALL restore a maximized window to normal state before applying absolute snap positioning, ensuring the window can be positioned to the target area.

#### Scenario: Shift+Numpad0+Numpad6 restores and snaps maximized window
- **WHEN** user presses Shift+Numpad0+Numpad6 on a maximized window
- **THEN** window is restored from maximized state and positioned to the right half of the monitor

### Requirement: Absolute snapping uses correct monitor for multi-monitor setups
The system SHALL detect which monitor contains the active window and snap to the absolute position on that monitor, not a different monitor.

#### Scenario: Shift+Numpad0+Numpad6 snaps on correct monitor in multi-monitor setup
- **WHEN** user has multiple monitors and presses Shift+Numpad0+Numpad6 on a window in monitor 2
- **THEN** window is snapped to the right half of monitor 2, not monitor 1

### Requirement: Absolute snapping does not interfere with relative snapping
The system SHALL preserve existing relative snapping behavior when Shift is not held, maintaining backwards compatibility.

#### Scenario: Numpad0+Numpad6 (without Shift) still uses relative snapping
- **WHEN** user presses Numpad0+Numpad6 without holding Shift
- **THEN** window snaps to the right half of its current area (relative positioning)
