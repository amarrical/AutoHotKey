## ADDED Requirements

### Requirement: Maximize active window

The system SHALL maximize the active window when Numpad0 + NumpadAdd is pressed.

#### Scenario: Maximize restored window
- **WHEN** user presses Numpad0 + NumpadAdd with a restored window
- **THEN** window is maximized to fill the monitor

#### Scenario: Maximize already-maximized window
- **WHEN** user presses Numpad0 + NumpadAdd with an already-maximized window
- **THEN** window remains maximized (no change)

### Requirement: Move window to next monitor

The system SHALL move the active window to the next monitor when Numpad0 + NumpadEnter is pressed.

#### Scenario: Move window from first to second monitor
- **WHEN** user presses Numpad0 + NumpadEnter with a window on the first monitor
- **THEN** window moves to the second monitor at proportionally equivalent position and size

#### Scenario: Move window from last to first monitor (wrap around)
- **WHEN** user presses Numpad0 + NumpadEnter with a window on the last monitor
- **THEN** window moves to the first monitor at proportionally equivalent position and size

#### Scenario: Move window on single-monitor system
- **WHEN** user presses Numpad0 + NumpadEnter on a system with only one monitor
- **THEN** window remains on the same monitor (no change)

### Requirement: Preserve relative position when moving between monitors

The system SHALL calculate window position and size as percentages of the source monitor and apply those percentages to the destination monitor.

#### Scenario: Move window between monitors of different sizes
- **WHEN** user moves a window from a 1920x1080 monitor to a 1440x900 monitor
- **THEN** window's relative position and size are preserved (e.g., 50% width on source becomes 50% width on destination)

### Requirement: Preserve maximized state when moving between monitors

The system SHALL re-maximize the window on the destination monitor if it was maximized before the move.

#### Scenario: Move maximized window to next monitor
- **WHEN** user presses Numpad0 + NumpadEnter with a maximized window
- **THEN** window moves to the next monitor and is re-maximized

#### Scenario: Move restored window to next monitor
- **WHEN** user presses Numpad0 + NumpadEnter with a restored window
- **THEN** window moves to the next monitor in restored state at proportionally equivalent position and size
