## ADDED Requirements

### Requirement: Numpad 0 + 1-9 hotkey registration
The system SHALL register hotkey combinations using numpad 0 as a modifier key with normal number keys 1 through 9 to enable direct window-to-monitor navigation.

#### Scenario: Hotkeys are registered on startup
- **WHEN** WindowPadPlus starts
- **THEN** numpad 0 + 1 through numpad 0 + 9 hotkeys are registered and active

#### Scenario: Hotkey handler is assigned
- **WHEN** a numpad 0 + number hotkey is registered
- **THEN** each hotkey is bound to a handler function that moves the active window to the specified monitor

### Requirement: Monitor count detection
The system SHALL detect the number of connected monitors at the time a hotkey is triggered.

#### Scenario: System queries monitor count dynamically
- **WHEN** user presses numpad 0 + 1-9
- **THEN** the system queries the current number of connected monitors

#### Scenario: Monitor count reflects current hardware state
- **WHEN** monitors are connected or disconnected after startup
- **THEN** the next hotkey press detects the updated monitor count without requiring a restart

### Requirement: Window movement to target monitor
The system SHALL move the active window to the specified monitor when a valid numpad hotkey is pressed.

#### Scenario: Valid monitor target
- **WHEN** user presses numpad 0 + 3 and 3 or more monitors are connected
- **THEN** the active window moves to monitor 3 and remains in focus

#### Scenario: Window state is preserved
- **WHEN** a window is moved to a different monitor
- **THEN** the window's size, maximized/minimized state, and z-order are preserved

#### Scenario: Window position is adjusted for target monitor
- **WHEN** a window is moved to a monitor with different resolution or DPI
- **THEN** the window is positioned within the valid bounds of the target monitor

### Requirement: Invalid monitor handling
The system SHALL gracefully handle attempts to move windows to non-existent monitors.

#### Scenario: Hotkey pressed for non-existent monitor
- **WHEN** user presses numpad 0 + 7 but only 3 monitors are connected
- **THEN** no action is taken (window remains on current monitor)

#### Scenario: No error or notification is shown
- **WHEN** an invalid monitor number is targeted
- **THEN** the system performs no action silently without displaying errors or warnings

### Requirement: Integration with existing hotkey system
The system SHALL register numpad monitor navigation hotkeys alongside existing WindowPadPlus hotkeys without conflicts.

#### Scenario: Hotkeys coexist with other window management hotkeys
- **WHEN** WindowPadPlus initializes all hotkeys
- **THEN** numpad 0 + 1-9 hotkeys are registered without disabling or conflicting with other hotkeys

#### Scenario: Hotkey registration follows existing patterns
- **WHEN** numpad hotkeys are registered
- **THEN** they use the same registration mechanism as other WindowPadPlus hotkeys in QuickRecord.ahk
