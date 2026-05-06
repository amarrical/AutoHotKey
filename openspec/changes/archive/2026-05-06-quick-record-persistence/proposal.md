## Why

The core recording/playback functionality is complete, but recordings only exist in memory. Without persistence, users lose their recordings when the script reloads, and there's no way to inspect what was recorded for debugging. Saving recordings to disk enables portability, debugging, and future expansion to multiple named recording slots.

## What Changes

- Add `SaveBuffer()` function to write events to `scripts/QuickRecord.last.txt` in delta-based format
- Add `LoadBuffer()` function to read and parse the file at script startup
- Use relative file paths and delta-based timing (ms since previous event) for portability across machines
- Support manual editing of recordings (users can set delta to 0 for rapid-fire playback)
- Add tray menu item "Clear last recording" to delete the file and empty the buffer
- Handle corrupt files gracefully with tray warnings

## Capabilities

### New Capabilities
- `quick-record-persistence`: Save and load recordings to disk with delta-based timing, supporting portability and manual editing

### Modified Capabilities
<!-- No existing capabilities are modified -->

## Impact

- **Code**: New `SaveBuffer()` and `LoadBuffer()` functions in `QuickRecord.ahk`; call `SaveBuffer()` when recording stops; call `LoadBuffer()` at startup
- **Files**: New `scripts/QuickRecord.last.txt` created at runtime (one recording file per session)
- **User Experience**: Recordings survive script reloads; users can manually edit `.txt` files to adjust timing
- **Backwards Compatibility**: Fully backwards compatible — existing core functionality unchanged
