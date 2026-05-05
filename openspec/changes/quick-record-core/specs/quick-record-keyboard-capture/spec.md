## ADDED Requirements

### Requirement: Pass-through capture for a defined key set
The system SHALL register pass-through hotkeys for a fixed key list and append `(kind, key, tick)` events to the buffer while Recording.

#### Scenario: Letter key recorded as down then up
- **WHEN** Recording is active and the user presses and releases `a`
- **THEN** the buffer contains `{down, "a", tick1}` followed by `{up, "a", tick2}` with `tick2 >= tick1`, and the keystroke still reaches the focused application

#### Scenario: Held modifier with letter
- **WHEN** the user presses `LShift` down, presses and releases `a`, then releases `LShift`
- **THEN** the buffer contains, in order: `LShift down`, `a down`, `a up`, `LShift up`

### Requirement: Defined key coverage
The system SHALL cover at minimum: `A`–`Z`, `0`–`9`, `F1`–`F24`, `LShift`/`RShift`/`LCtrl`/`RCtrl`/`LAlt`/`RAlt`/`LWin`/`RWin`, `Space`/`Tab`/`Enter`/`Backspace`/`Esc`/`CapsLock`, arrow keys, `Home`/`End`/`PgUp`/`PgDn`/`Insert`/`Delete`, all numpad keys, and the punctuation keys ``;'`,./[]\=-``.

#### Scenario: Unsupported key is silently ignored
- **WHEN** Recording and the user presses a media key not in the list
- **THEN** no event is appended and no error is shown

### Requirement: No capture when not recording
The system SHALL only append events while in Recording state.

#### Scenario: Idle keystrokes ignored
- **WHEN** the script is Idle and the user types
- **THEN** the event buffer is unchanged
