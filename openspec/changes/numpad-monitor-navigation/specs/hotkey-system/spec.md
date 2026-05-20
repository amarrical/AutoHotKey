## ADDED Requirements

### Requirement: Numpad modifier key support
The system SHALL support using numpad keys as modifier keys in hotkey combinations for window management operations.

#### Scenario: Numpad 0 acts as a modifier
- **WHEN** numpad 0 is pressed in combination with other numpad keys
- **THEN** the combination is recognized as a valid hotkey trigger

#### Scenario: Numpad modifier combinations are distinct
- **WHEN** numpad 0 + numpad 1 is pressed
- **THEN** it is treated as a different hotkey than numpad 1 alone or numpad 0 alone

### Requirement: Hotkey handler execution
The system SHALL execute the appropriate handler function when a registered hotkey combination is triggered.

#### Scenario: Handler is called on hotkey press
- **WHEN** a registered hotkey combination is pressed
- **THEN** the associated handler function is invoked immediately

#### Scenario: Handler receives correct context
- **WHEN** a hotkey handler executes
- **THEN** it has access to information about the active window and system state
