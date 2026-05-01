## Context

AutoHotkey v2 hotkey system allows chord modifiers (e.g., `Numpad0 & NumpadAdd`) but by default consumes the modifier key press, preventing it from sending its original character. Users expect modifier keys to still function for typing when pressed alone.

The solution leverages AutoHotkey v2's KeyUp event and `A_PriorKey` variable to detect when a modifier key is released without having triggered any chord, then sends the original character.

## Goals / Non-Goals

**Goals:**
- Numpad0 sends `0` when pressed and released alone
- NumpadDot sends `.` when pressed and released alone
- Handle both primary keys (Numpad0, NumpadDot) and their aliases (NumpadIns, NumpadDel) for numlock-off compatibility
- Maintain full chord functionality (Numpad0 & other keys still work as modifiers)
- Use AutoHotkey v2 SendMode Input for reliable key delivery

**Non-Goals:**
- Modify behavior of other modifier keys
- Add configuration or customization options
- Support AutoHotkey v1

## Decisions

**Decision 1: Use KeyUp event with A_PriorKey check**
- **Rationale**: KeyUp fires after the key is released. `A_PriorKey` contains the key that was pressed before the current key. If `A_PriorKey` equals the current key, no chord was activated, so we send the character.
- **Alternative considered**: Using `GetKeyState()` to check if other keys are held. Rejected because it's less reliable and more complex.

**Decision 2: Handle both primary and alias keys**
- **Rationale**: NumpadIns and NumpadDel are the same physical keys as Numpad0 and NumpadDot when numlock is off. Supporting both ensures compatibility across numlock states.
- **Alternative considered**: Only support primary keys. Rejected because users with numlock off would have broken behavior.

**Decision 3: Implement as separate hotkey blocks per key**
- **Rationale**: Each key (Numpad0, NumpadIns, NumpadDot, NumpadDel) gets its own KeyUp handler. This is clear and maintainable.
- **Alternative considered**: Single handler for multiple keys. Rejected because it's less readable and harder to debug.

## Risks / Trade-offs

**Risk: Timing sensitivity**
- **Mitigation**: KeyUp event is reliable in AutoHotkey v2. The check `A_PriorKey = "Numpad0"` is deterministic.

**Risk: Interaction with other hotkeys**
- **Mitigation**: Chord hotkeys (e.g., `Numpad0 & NumpadAdd`) are processed before KeyUp, so they take precedence. No conflicts.

**Trade-off: Character sent on key release, not press**
- **Rationale**: This is necessary to detect whether a chord was activated. The delay is imperceptible to users.
