## ADDED Requirements

### Requirement: F24 replays the last recording
The system SHALL replay all buffered events when `F24` is pressed and the script is Idle.

#### Scenario: Replay reproduces typing
- **WHEN** the user has recorded typing `hello` and then presses `F24` with a text editor focused
- **THEN** `hello` is typed into the editor

#### Scenario: Replay preserves modifier semantics
- **WHEN** the user recorded `Ctrl+C` and presses `F24` with a selection in a text editor
- **THEN** the selection is copied to the clipboard

### Requirement: Inter-event delays preserved
The system SHALL compute the delay in milliseconds between consecutive captured events and `Sleep` that duration before sending each event, clamped to a maximum of 5000 ms per gap.

#### Scenario: Long pause is clamped
- **WHEN** the gap between two recorded events is 30 seconds
- **THEN** replay waits 5 seconds, then continues

#### Scenario: Rapid events are sent back-to-back
- **WHEN** two events have zero or minimal delay between them
- **THEN** replay sends them immediately without significant sleep

### Requirement: Event-level send
The system SHALL send each event using `SendEvent` with `{Key Down}` or `{Key Up}` rather than translated text input.

#### Scenario: Held modifier replays as held
- **WHEN** the recording contains `LShift down`, `a down`, `a up`, `LShift up`
- **THEN** replay sends them as discrete down/up events in that order

### Requirement: Replay is re-entrancy safe
The system SHALL ignore `F24` and `Shift+F24` presses while a replay is in progress.

#### Scenario: F24 during replay is no-op
- **WHEN** the user presses `F24` while replay is running
- **THEN** the second replay is not started and the first continues uninterrupted

#### Scenario: Recording hotkey disabled during replay
- **WHEN** replay is in progress
- **THEN** pressing `Shift+F24` has no effect and does not start a new recording

### Requirement: Empty buffer guard
The system SHALL show a tray balloon `No recording available` and not attempt playback when the buffer is empty.

#### Scenario: F24 with empty buffer
- **WHEN** the user presses `F24` and no recording exists
- **THEN** a tray balloon appears with the message `No recording available` and no playback occurs
