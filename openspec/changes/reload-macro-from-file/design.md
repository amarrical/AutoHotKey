## Context

QuickRecord currently loads recording buffers at startup and keeps them in memory. When a user edits the recording file directly, the changes are not reflected until the script is restarted. The proposal adds Ctrl+F24 and Ctrl+F23 hotkeys to reload from file without replaying, allowing iterative macro refinement.

## Goals / Non-Goals

**Goals:**
- Support Ctrl+F24 to reload F24 recording from QuickRecord.last.txt without replaying
- Support Ctrl+F23 to reload F23 recording from QuickRecord.last.f23.txt without replaying
- Allow users to edit recording files and have changes take effect on the next replay
- Maintain backward compatibility with existing record/replay functionality

**Non-Goals:**
- Change the recording or replay behavior
- Modify the persistence file format
- Add UI feedback beyond existing tray notifications
- Support live editing during playback

## Decisions

**Decision 1: Separate Reload Functions**
- Create `ReloadBuffer24()` and `ReloadBuffer23()` functions that call the existing `LoadBuffer()` logic for their respective buffers
- Alternative: Create a parameterized `ReloadBuffer(bufferNum)` function. Rejected because it adds indirection and the current approach is simpler.
- Rationale: Explicit and clear, minimal code changes, consistent with the dual-buffer design.

**Decision 2: Reuse LoadBuffer Logic**
- Extract the file-reading and parsing logic from `LoadBuffer()` into helper functions (`LoadBufferFromFile24()` and `LoadBufferFromFile23()`)
- Alternative: Duplicate the logic in each reload function. Rejected because it violates DRY and makes maintenance harder.
- Rationale: Reduces duplication while keeping the code clear and maintainable.

**Decision 3: No Replay on Reload**
- Reload hotkeys (Ctrl+F24, Ctrl+F23) only load the buffer from file; they do NOT trigger replay
- The user must press F24 or F23 separately to replay the reloaded buffer
- Rationale: Matches the user's requirement and provides explicit control over when replay happens.

**Decision 4: Reload During Idle Only**
- Reload operations are only allowed when `mode24` and `mode23` are both "Idle" (not recording)
- Rationale: Prevents conflicts with active recording and keeps state management simple.

## Risks / Trade-offs

**Risk: File Corruption During Edit**
- If a user edits the recording file while the script is running, the reload might fail or load partial data
- Mitigation: Add error handling in the reload functions; if parsing fails, display a notification and leave the buffer unchanged

**Risk: User Confusion About Reload vs Replay**
- Users might expect Ctrl+F24 to replay immediately, but it only reloads
- Mitigation: Add clear tray notifications when reload succeeds, and document the behavior in comments

**Trade-off: Simplicity vs Parameterization**
- Using separate functions for F24 and F23 adds some duplication but keeps the code explicit and easy to understand
- Rationale: For two buffers, this is acceptable; if more buffers are added later, refactoring to a parameterized approach would be straightforward
