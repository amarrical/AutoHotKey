# QuickRecord Feature Plan

A keyboard-macro quick-record/playback utility, triggered by `Shift+F24` (toggle record) and `F24` (replay last recording). Built in AutoHotkey v2 as a sibling script to `WindowPadPlus.ahk`.

This plan is structured so each section maps to an **OpenSpec change proposal** (one capability per change) with concrete tasks. Capability names use kebab-case, suitable for `openspec/specs/<capability>/spec.md`.

---

## Feasibility Summary

- **Possible in AHK v2.** AHK provides per-key hotkeys (`~*Key::` / `~*Key Up::`), tick-count timing, context-aware hotkey toggling, and event-level send (`SendEvent {Key Down}` / `{Key Up}`).
- **Limitation:** there is no script-level "record everything" hook; capture is limited to a registered key list (~110 keys covers practical use). Media keys, mouse, and dead keys are out of scope.
- **Multiple recordings:** Support multiple named recording files (e.g., `QuickRecord.macro1.txt`, `QuickRecord.macro2.txt`) for future hotkey expansion.
- **Shareable format:** Recording files use relative paths and delta-based timing for portability across machines and sessions.

---

## Target File Layout

- `scripts/QuickRecord.ahk` — new standalone script.
- `scripts/QuickRecord.last.txt` — persisted last recording (created at runtime).
- `docs/QuickRecord.md` — user documentation.
- `openspec/specs/quick-record-*/` — one folder per capability below.

---

## Capability 1 — `quick-record-toggle`

**Purpose:** Provide a global toggle hotkey that starts and stops macro recording.

### Requirements

#### Requirement: Shift+F24 toggles recording state
The system SHALL toggle between Idle and Recording states each time `Shift+F24` is pressed.

- **Scenario: Idle → Recording**
  - **WHEN** the script is Idle and the user presses `Shift+F24`
  - **THEN** the script enters Recording state, clears the previous in-memory event buffer, and records a start tick.

- **Scenario: Recording → Idle**
  - **WHEN** the script is Recording and the user presses `Shift+F24`
  - **THEN** the script exits Recording state and finalizes the event buffer.

#### Requirement: Toggle artifacts are excluded
The system SHALL NOT include the `Shift+F24` keystrokes themselves (down or up) in the recorded event buffer.

- **Scenario: trailing modifier release is dropped**
  - **WHEN** recording stops via `Shift+F24`
  - **THEN** any `LShift`/`RShift`/`F24` up-events captured near the toggle are removed from the tail of the buffer. (Exact threshold TBD during prototyping.)

#### Requirement: Visual state indication
The system SHALL communicate current state via tray icon and tooltip.

- **Scenario: Recording shows red tray state**
  - **WHEN** the script is Recording
  - **THEN** the tray tooltip reads `QuickRecord — Recording (Nm Ns)` and updates at least once per second.

### Tasks
1. Scaffold `scripts/QuickRecord.ahk` with `#Requires AutoHotkey v2.0`, globals (`mode`, `events`, `startTick`), tray menu (Status / Clear / Exit).
2. Bind `+F24::ToggleRecord()`.
3. Implement state transitions and tooltip updater (`SetTimer`).
4. Implement tail-trim logic for toggle artifacts.

---

## Capability 2 — `quick-record-keyboard-capture`

**Purpose:** Capture keyboard events with timing while recording, without blocking normal typing.

### Requirements

#### Requirement: Pass-through capture for a defined key set
The system SHALL register pass-through hotkeys (`~*Key` / `~*Key Up`) for a fixed key list and append `(kind, key, tick)` events to the buffer while Recording.

- **Scenario: letter key recorded as down then up**
  - **WHEN** Recording is active and the user presses and releases `a`
  - **THEN** the buffer contains `{down, "a", t1}` followed by `{up, "a", t2}` with `t2 >= t1`, and the keystroke still reaches the focused application.

- **Scenario: held modifier with letter**
  - **WHEN** the user presses `LShift` down, presses and releases `a`, then releases `LShift`
  - **THEN** the buffer contains, in order: `LShift down`, `a down`, `a up`, `LShift up`.

#### Requirement: Defined key coverage
The system SHALL cover at minimum: `A`–`Z`, `0`–`9`, `F1`–`F24`, `LShift`/`RShift`/`LCtrl`/`RCtrl`/`LAlt`/`RAlt`/`LWin`/`RWin`, `Space`/`Tab`/`Enter`/`Backspace`/`Esc`/`CapsLock`, arrow keys, `Home`/`End`/`PgUp`/`PgDn`/`Insert`/`Delete`, all numpad keys, and the punctuation keys ``;'`,./[]\=-``.

- **Scenario: unsupported key is silently ignored**
  - **WHEN** Recording and the user presses a media key not in the list
  - **THEN** no event is appended and no error is shown.

#### Requirement: No capture when not recording
The system SHALL only append events while in Recording state.

- **Scenario: Idle keystrokes ignored**
  - **WHEN** the script is Idle and the user types
  - **THEN** the event buffer is unchanged.

### Tasks
1. Define `KeyList` constant array.
2. Loop-register `Hotkey("~*" k, RecordDown, "Off")` and `Hotkey("~*" k " Up", RecordUp, "Off")` at startup.
3. In `ToggleRecord`, enable/disable the registered hotkeys via `Hotkey(name, , "On"|"Off")`.
4. Implement `RecordDown(name)` / `RecordUp(name)` — strip `~*` prefix and ` Up` suffix, append event with `A_TickCount`.

---

## Capability 3 — `quick-record-playback`

**Purpose:** Replay the most recent recording, preserving inter-key timing.

### Requirements

#### Requirement: F24 replays the last recording
The system SHALL replay all buffered events when `F24` is pressed and the script is Idle.

- **Scenario: replay reproduces typing**
  - **WHEN** the user has recorded typing `hello` and then presses `F24` with a text editor focused
  - **THEN** `hello` is typed into the editor.

- **Scenario: replay preserves modifier semantics**
  - **WHEN** the user recorded `Ctrl+C` and presses `F24` with a selection in a text editor
  - **THEN** the selection is copied to the clipboard.

#### Requirement: Inter-event delays preserved
The system SHALL `Sleep` the delta in milliseconds between consecutive captured events before sending each event, clamped to a maximum of 5000 ms per gap.

- **Scenario: long pause is clamped**
  - **WHEN** the gap between two recorded events is 30 seconds
  - **THEN** replay waits 5 seconds, then continues.

#### Requirement: Event-level send
The system SHALL send each event using `SendEvent` with `{Key Down}` or `{Key Up}` rather than translated text input.

- **Scenario: held modifier replays as held**
  - **WHEN** the recording contains `LShift down`, `a down`, `a up`, `LShift up`
  - **THEN** replay sends them as discrete down/up events in that order.

#### Requirement: Replay is re-entrancy safe
The system SHALL ignore `F24` and `Shift+F24` presses while a replay is in progress.

- **Scenario: F24 during replay is no-op**
  - **WHEN** the user presses `F24` while replay is running
  - **THEN** the second replay is not started and the first continues uninterrupted.

- **Implementation note:** Use dynamic hotkey toggle (disable recording hotkeys during replay) rather than `#HotIf` guards for first pass.

#### Requirement: Empty buffer guard
The system SHALL show a tray balloon `No recording available` and not attempt playback when the buffer is empty.

### Tasks
1. Bind `F24::Replay()`.
2. Implement `Replay()` with `isReplaying` flag, `try`/`finally` to clear flag.
3. Wrap recording hotkeys in `#HotIf !isReplaying` (or toggle them off explicitly during replay) so playback isn't recorded.
4. Iterate events: compute delta from previous tick, `Sleep` (clamped), `SendEvent`.
5. Empty-buffer guard with `TrayTip`.

---

## Capability 4 — `quick-record-persistence`

**Purpose:** Survive script reload by saving the last recording to disk.

### Requirements

#### Requirement: Persist on stop
The system SHALL write the event buffer to `scripts/QuickRecord.last.txt` immediately after recording stops.

- **Scenario: stop writes file**
  - **WHEN** recording transitions Recording → Idle
  - **THEN** `QuickRecord.last.txt` exists and contains all buffered events in a parseable format.

#### Requirement: Load on start
The system SHALL load `QuickRecord.last.txt` into the in-memory buffer at script startup if the file exists and parses successfully.

- **Scenario: replay after reload**
  - **WHEN** the user records, reloads the script, then presses `F24`
  - **THEN** the recording from before the reload is replayed.

#### Requirement: Format is line-based and human-readable
The system SHALL use one event per line, format `<kind>\t<key>\t<delta>`, where `kind` is `down` or `up` and `delta` is the milliseconds since the previous event (or 0 for the first event).

- **Scenario: zero-delay events**
  - **WHEN** the user wants faster playback, they may manually edit the file and set `delta` to `0` for rapid-fire events.
  - **THEN** replay respects the zero delay and sends events back-to-back.

- **Scenario: corrupt file ignored gracefully**
  - **WHEN** the file contains an unparseable line
  - **THEN** the script logs a tray warning, starts with an empty buffer, and continues running.

### Tasks
1. Implement `SaveBuffer()` called at end of `ToggleRecord` stop branch.
2. Implement `LoadBuffer()` called once at startup, after key registration.
3. Add tray menu item `Clear last recording` that empties the buffer and deletes the file.

---

## Capability 5 — `quick-record-documentation`

**Purpose:** Document usage, key coverage, and limitations.

### Requirements

#### Requirement: User documentation exists
The system SHALL provide `docs/QuickRecord.md` covering install, hotkeys, key-coverage list, persistence path, limitations (no mouse, clamped delays), and troubleshooting.

#### Requirement: Cross-link from main doc
The system SHALL add a link to `docs/QuickRecord.md` from `docs/WindowPadPlus.md` under a new "Companion Scripts" section.

### Tasks
1. Author `docs/QuickRecord.md`.
2. Edit `docs/WindowPadPlus.md` to add the Companion Scripts section + link.

---

## Suggested OpenSpec Change Proposal Order

Run `/opsx-propose` once per capability, in this order (each builds on the previous):

1. `quick-record-core` (combines toggle, keyboard-capture, playback)
2. `quick-record-persistence`
3. `quick-record-documentation`

Capabilities 1–3 are merged into a single core change. 2 and 3 are independently shippable enhancements.

---

## In Scope (Future Expansion)

- Multiple named recording files (e.g., `QuickRecord.macro1.txt`, `QuickRecord.macro2.txt`) with separate hotkeys for each.

## Out of Scope (Future)

- Mouse movement / click capture.
- Media keys, mouse wheel, dead keys / compose sequences.
- Editing a recording (insert/delete events) — defer to Pulover's Macro Creator.
- Loop / repeat-N-times playback.
- Record-from-clipboard or import/export of `.ahk` snippets.
