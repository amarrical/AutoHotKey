# alternate-center-snapping Specification

## Purpose
TBD - created by archiving change alternate-center-snapping. Update Purpose after archive.
## Requirements
### Requirement: Shift+Numpad0+5 snaps to alternate center half
The system SHALL snap the active window to the orientation-perpendicular center half of the monitor when Shift is held with Numpad0 and Numpad5, regardless of the window's current position or size.

#### Scenario: Shift+Numpad0+5 on landscape monitor snaps to horizontal center band
- **WHEN** user presses Shift+Numpad0+5 on a landscape monitor
- **THEN** active window is positioned to a full-width, half-height band centered vertically on the monitor

#### Scenario: Shift+Numpad0+5 on portrait monitor snaps to vertical center column
- **WHEN** user presses Shift+Numpad0+5 on a portrait monitor
- **THEN** active window is positioned to a half-width, full-height column centered horizontally on the monitor

#### Scenario: Shift+Numpad0+5 works regardless of Shift/Numpad0 press order
- **WHEN** user presses Numpad0 first then Shift then 5, OR Shift first then Numpad0 then 5
- **THEN** active window snaps to the alternate center half in both cases

### Requirement: Shift+CapsLock+Tab snaps to alternate center half
The system SHALL snap the active window to the orientation-perpendicular center half when Shift is held with CapsLock and Tab, providing the same alternate center half as Shift+Numpad0+5 for keyboards without numpad.

#### Scenario: Shift+CapsLock+Tab on landscape monitor
- **WHEN** user presses Shift+CapsLock+Tab on a landscape monitor
- **THEN** active window is positioned to a full-width, half-height band centered vertically

#### Scenario: Shift+CapsLock+Tab on portrait monitor
- **WHEN** user presses Shift+CapsLock+Tab on a portrait monitor
- **THEN** active window is positioned to a half-width, full-height column centered horizontally

### Requirement: Shift+NumpadDot+5 snaps to alternate center third
The system SHALL snap the active window to the orientation-perpendicular center third of the monitor when Shift is held with NumpadDot and Numpad5.

#### Scenario: Shift+NumpadDot+5 on landscape monitor snaps to horizontal center band
- **WHEN** user presses Shift+NumpadDot+5 on a landscape monitor
- **THEN** active window is positioned to a full-width, one-third-height band centered vertically on the monitor

#### Scenario: Shift+NumpadDot+5 on portrait monitor snaps to vertical center column
- **WHEN** user presses Shift+NumpadDot+5 on a portrait monitor
- **THEN** active window is positioned to a one-third-width, full-height column centered horizontally on the monitor

#### Scenario: Shift+NumpadDot+5 works regardless of Shift/NumpadDot press order
- **WHEN** user presses NumpadDot first then Shift then 5, OR Shift first then NumpadDot then 5
- **THEN** active window snaps to the alternate center third in both cases

### Requirement: Alternate center snapping restores maximized windows
The system SHALL restore a maximized window before applying alternate center positioning.

#### Scenario: Shift+Numpad0+5 on maximized window
- **WHEN** user presses Shift+Numpad0+5 on a maximized window
- **THEN** window is restored from maximized state and positioned to the alternate center half

### Requirement: Normal center snapping is unchanged when Shift is not held
The system SHALL preserve existing center snap behavior (Numpad0+5, CapsLock+Tab, NumpadDot+5) when Shift is not held.

#### Scenario: Numpad0+5 without Shift still uses orientation-normal center half
- **WHEN** user presses Numpad0+5 without holding Shift
- **THEN** window snaps to the normal orientation-aware center half (half-width column on landscape, half-height band on portrait)

