## Context

Persistence builds on the core recording system. Recordings are currently stored in memory as `{kind, key, tick}` objects. To persist them, we convert to a delta-based format and write to disk. The file format is line-based and human-readable, allowing manual editing.

## Goals / Non-Goals

**Goals:**
- Survive script reloads by persisting the last recording to disk
- Use delta-based timing (ms since previous event) for portability
- Support manual editing of recordings (users can set delta to 0 for rapid playback)
- Handle corrupt files gracefully without crashing
- Provide a clear file location for users to inspect/edit

**Non-Goals:**
- Multiple named recording files (future expansion)
- Automatic backup/versioning
- Encryption or compression
- Import/export to other formats

## Decisions

### 1. **File Format: Line-Based, Tab-Separated, Delta-Based**

**Decision:** Use format `<kind>\t<key>\t<delta>` where:
- `kind` is `down` or `up`
- `key` is the key name (e.g., `a`, `LShift`)
- `delta` is milliseconds since the previous event (0 for the first event)

**Rationale:** Human-readable, easy to edit, portable across machines (deltas don't depend on absolute tick counts). Users can manually set delta to 0 for rapid-fire sequences.

**Example:**
```
down	a	0
up	a	50
down	b	100
up	b	45
```

### 2. **File Location: `scripts/QuickRecord.last.txt` (Relative Path)**

**Decision:** Save to `scripts/QuickRecord.last.txt` relative to the script directory.

**Rationale:** Relative paths make the file portable if the entire project is moved. Single file per session keeps it simple; future changes can add multiple slots.

### 3. **Load at Startup, Save on Stop**

**Decision:** Call `LoadBuffer()` once at script startup (after hotkey registration). Call `SaveBuffer()` when recording stops (in `ToggleRecord()`).

**Rationale:** Ensures last recording is always available for replay. Minimal overhead.

### 4. **Corrupt File Handling**

**Decision:** If the file exists but contains unparseable lines, log a tray warning, start with an empty buffer, and continue running.

**Rationale:** Prevents crashes from corrupted files. User is informed but not blocked.

## Risks / Trade-offs

| Risk | Mitigation |
|------|-----------|
| **File gets corrupted** | Tray warning shown; script continues with empty buffer. User can manually delete the file. |
| **Relative path doesn't work** | Use `A_ScriptDir` to ensure path is always relative to the script location. |
| **Large recordings slow down load** | Unlikely for typical use; file is text-based and small. Can optimize later if needed. |
| **User accidentally deletes file** | Tray menu has "Clear last recording" option; user can recreate by re-recording. |

## Migration Plan

1. Add `SaveBuffer()` and `LoadBuffer()` functions to `QuickRecord.ahk`
2. Call `LoadBuffer()` at startup (after hotkey registration)
3. Call `SaveBuffer()` in `ToggleRecord()` when recording stops
4. Add "Clear last recording" tray menu item
5. Test file creation, loading, and corruption handling

## Open Questions

- Should we add a "View last recording" tray menu item to open the file in the default text editor? (Deferred to future enhancement)
