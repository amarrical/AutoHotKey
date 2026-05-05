## Context

QuickRecord is a sibling script to `WindowPadPlus.ahk`, running as a standalone AutoHotkey v2 process. It must:
- Register pass-through hotkeys for ~110 keys without blocking normal typing
- Maintain a lightweight in-memory event buffer during recording
- Replay events with precise timing and modifier semantics
- Survive script reloads (persistence handled in a separate change)
- Expand to multiple recording slots in the future

AutoHotkey v2 provides the necessary primitives: per-key hotkeys (`~*Key::`), tick-count timing (`A_TickCount`), dynamic hotkey toggling (`Hotkey()`), and event-level send (`SendEvent`).

## Goals / Non-Goals

**Goals:**
- Provide a simple, keyboard-driven interface for recording and replaying macros
- Preserve inter-key timing and modifier semantics during playback
- Prevent re-entrancy (don't record playback events)
- Support future expansion to multiple named recordings
- Minimize dependencies and keep the script self-contained

**Non-Goals:**
- Mouse capture, media keys, dead keys, or compose sequences
- GUI editor for recorded macros
- Loop/repeat playback or conditional logic
- Import/export to `.ahk` snippets or other formats

## Decisions

### 1. **State Machine: Three States (Idle, Recording, Replaying)**

**Decision:** Use a simple three-state machine:
- `Idle`: No recording or replay in progress
- `Recording`: Capturing keyboard events
- `Replaying`: Playing back events (hotkeys disabled)

**Rationale:** Clear separation of concerns. Prevents accidental recording during replay. Simplifies tray state display.

**Alternatives Considered:**
- Single `isRecording` boolean: Less explicit about replay state; harder to prevent re-entrancy
- Four states (Idle, Recording, Replaying, Paused): Paused adds complexity not needed in phase 1

### 2. **Dynamic Hotkey Toggle for Re-entrancy (not #HotIf)**

**Decision:** During replay, explicitly disable recording hotkeys via `Hotkey(name, , "Off")` and re-enable after.

**Rationale:** Explicit state management is clearer than conditional guards. Ensures recording hotkeys are completely inactive during replay, preventing any chance of recording playback events.

**Alternatives Considered:**
- `#HotIf !isReplaying` guards: Cleaner syntax, but every hotkey check adds overhead. Dynamic toggle is more direct.

### 3. **Event Buffer: In-Memory Array of {kind, key, tick}**

**Decision:** Store events as objects with `kind` (down/up), `key` (string), and `tick` (A_TickCount). Compute deltas during save/replay.

**Rationale:** Absolute ticks are easier to work with during capture. Deltas are computed on-the-fly for persistence and replay, making the file format portable.

**Alternatives Considered:**
- Store deltas in memory: Requires tracking previous tick during capture; more complex.
- Store absolute ticks in file: File is session-specific and not portable across reloads.

### 4. **Tail-Trim Heuristic for Toggle Artifacts (TBD)**

**Decision:** After recording stops, remove trailing `Shift+F24` and modifier release events within a threshold (exact value TBD during prototyping).

**Rationale:** Users expect the toggle hotkey itself to not appear in the recording. A time-based heuristic handles most cases without complex key-sequence parsing.

**Alternatives Considered:**
- Always remove last two events (Shift down, F24 down, F24 up, Shift up): Too rigid; doesn't account for user's actual key timing.
- Manual editing: Shifts burden to user; not user-friendly.

**Open Question:** Exact threshold (50ms? 100ms?) to be determined during testing.

### 5. **Pass-Through Hotkeys (~*Key) for Non-Blocking Capture**

**Decision:** Use `~*Key::` and `~*Key Up::` syntax to capture events without blocking them.

**Rationale:** AHK's pass-through prefix (`~`) allows capture without interfering with normal typing. The `*` wildcard ensures modifiers don't prevent the hotkey from firing.

**Alternatives Considered:**
- Blocking hotkeys (`Key::`): Would require explicit `Send` to pass through; more complex and error-prone.

### 6. **Clamped Delays During Replay (5000 ms max)**

**Decision:** Compute inter-event delays from delta times, but cap each delay at 5000 ms.

**Rationale:** Prevents long pauses (e.g., user paused for 30 seconds during recording) from stalling replay. 5000 ms is a reasonable threshold for "user took a break."

**Alternatives Considered:**
- No clamping: Could cause very long delays, frustrating users.
- Shorter cap (1000 ms): Too aggressive; might skip intentional pauses.

### 7. **Key List: ~110 Keys (Hardcoded Array)**

**Decision:** Define a fixed `KeyList` array at startup with common keys: A–Z, 0–9, F1–F24, modifiers, navigation, numpad, punctuation.

**Rationale:** Covers 95% of macro use cases. Hardcoding avoids dynamic lookup overhead. Future expansion can add more keys or make it configurable.

**Alternatives Considered:**
- Capture all keys: No script-level "record everything" hook in AHK; would require low-level hooks (out of scope).
- User-configurable list: Adds complexity; hardcoded list is sufficient for phase 1.

## Risks / Trade-offs

| Risk | Mitigation |
|------|-----------|
| **Tail-trim threshold is wrong** | Prototyping will reveal the right value. Can adjust after initial testing. |
| **Modifier state leaks between recordings** | Always clear buffer on toggle-to-record; ensures clean state. |
| **Replay blocks user input** | Intentional; prevents accidental interference. Users can press Escape to interrupt (future enhancement). |
| **No visual feedback during long replay** | Tray tooltip updates during replay show progress. Sufficient for phase 1. |
| **Key list is incomplete** | Out-of-scope keys are silently ignored. Users can request additions in future. |

## Migration Plan

1. Create `scripts/QuickRecord.ahk` with full implementation
2. Test hotkey registration, state transitions, and basic record/replay
3. Validate tail-trim heuristic and adjust threshold if needed
4. Document in `docs/QuickRecord.md` (separate change)
5. No migration needed for existing users; script is new

## Open Questions

- **Tail-trim threshold:** Exact millisecond value (50ms? 100ms?) TBD during prototyping
- **Escape to interrupt replay:** Should pressing Escape stop an ongoing replay? (Deferred to future enhancement)
- **Tray menu layout:** Status, Clear, Exit — or additional options? (Finalize during implementation)
