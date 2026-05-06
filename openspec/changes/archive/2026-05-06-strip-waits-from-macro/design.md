## Context

QuickRecord stores recordings as tab-separated values with timing deltas between key events. When a user wants to execute a macro at maximum speed, they must manually edit the file or re-record without delays. The strip-waits feature provides a quick hotkey to remove all timing delays from the current buffer and rewrite the file.

## Goals / Non-Goals

**Goals:**
- Support Alt+F24 to strip all waits from F24 macro and rewrite QuickRecord.last.F24.txt
- Support Alt+F23 to strip all waits from F23 macro and rewrite QuickRecord.last.f23.txt
- Preserve the key sequence (kind and key values) while setting all deltas to 0
- Display confirmation notification after stripping
- Only allow stripping when not recording

**Non-Goals:**
- Modify the recording or replay behavior
- Change the file format
- Support partial wait removal (e.g., remove only waits > 100ms)
- Add undo functionality

## Decisions

**Decision 1: Separate Strip Functions**
- Create `StripWaits24()` and `StripWaits23()` functions that operate on the in-memory buffers
- Alternative: Create a parameterized `StripWaits(bufferNum)` function. Rejected because it adds indirection.
- Rationale: Explicit and clear, consistent with existing dual-buffer design.

**Decision 2: Modify In-Memory Buffer and Rewrite File**
- Strip waits by iterating through the buffer, setting all deltas to 0, then rewrite the file
- Alternative: Read file, strip, rewrite without modifying buffer. Rejected because it's less efficient and doesn't update the in-memory buffer.
- Rationale: Keeps buffer and file in sync, allows immediate replay of stripped version.

**Decision 3: Strip During Idle Only**
- Strip operations are only allowed when the corresponding mode is "Idle" (not recording)
- Rationale: Prevents conflicts with active recording and keeps state management simple.

**Decision 4: Confirmation Notification**
- Display a tray notification showing how many events were stripped
- Rationale: Provides user feedback and confirms the operation succeeded.

## Risks / Trade-offs

**Risk: Accidental Stripping**
- User might press Alt+F24 by accident and lose timing information
- Mitigation: Display clear confirmation notification; if needed in future, could add a confirmation dialog

**Risk: No Undo**
- Once waits are stripped, the original timing is lost unless the user has a backup
- Mitigation: Document this behavior; user can reload from file if they haven't saved yet

**Trade-off: Simplicity vs Flexibility**
- This implementation only strips all waits; doesn't support partial stripping
- Rationale: Simpler to implement and covers the primary use case; partial stripping can be added later if needed
