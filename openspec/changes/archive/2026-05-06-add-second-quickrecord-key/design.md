## Context

QuickRecord currently uses a single global state for recording: one `events` array, one `mode` variable, and one persistence file. Adding F23 as a second recording key requires maintaining two independent recording buffers with separate state management and file persistence.

## Goals / Non-Goals

**Goals:**
- Support two independent recording buffers (one for F24, one for F23)
- Each buffer has its own hotkey (Shift+F24 and Shift+F23 for recording toggle, F24 and F23 for replay)
- Persistence: Each buffer saves to its own file (QuickRecord.last.txt and QuickRecord.last.f23.txt)
- Both buffers load at startup
- No interference between the two recordings

**Non-Goals:**
- Support more than two recordings (this change is specifically for F23 + F24)
- UI changes or visual indicators beyond existing tray tooltip
- Refactoring the entire recording architecture (keep changes minimal and focused)

## Decisions

**Decision 1: Dual State Variables**
- Create separate state for each recording: `events24` and `events23`, `mode24` and `mode23`
- Alternative: Use a single `recordings` object keyed by hotkey. Rejected because it adds complexity and the dual-variable approach is simpler for just two recordings.
- Rationale: Minimal code changes, clear separation of concerns, easy to understand and maintain.

**Decision 2: Separate Persistence Files**
- F24 uses `QuickRecord.last.txt` (existing)
- F23 uses `QuickRecord.last.f23.txt` (new)
- Alternative: Single file with markers for each recording. Rejected because it complicates parsing and adds unnecessary complexity.
- Rationale: Simple, independent, follows existing pattern.

**Decision 3: Duplicate Hotkey Handlers**
- Create separate `ToggleRecord24()` and `ToggleRecord23()` functions
- Create separate `Replay24()` and `Replay23()` functions
- Alternative: Single parameterized function. Rejected because it adds indirection and makes the code harder to follow.
- Rationale: Explicit and clear, minimal refactoring needed.

**Decision 4: Shared Event Capture**
- Keep `RecordDown()` and `RecordUp()` shared, but they check `mode24` and `mode23` to determine which buffer to append to
- Rationale: Event capture logic is identical; only the target buffer differs.

## Risks / Trade-offs

**Risk: Code Duplication**
- Mitigation: The duplication is intentional and minimal. If a third recording is needed in the future, refactoring to a parameterized approach would be straightforward.

**Risk: State Synchronization**
- Both recordings are independent, but `isReplaying` is global. If F24 is replaying, F23 cannot be recorded. This is acceptable for the current use case.
- Mitigation: Document this behavior; if needed, can be split into `isReplaying24` and `isReplaying23` in a future change.

**Trade-off: Simplicity vs. Extensibility**
- This design prioritizes simplicity and minimal changes over a fully generic multi-recording system.
- Rationale: The current use case is two recordings; over-engineering for future extensibility would add unnecessary complexity now.
