## Why

Currently, QuickRecord replays recorded macros from memory, requiring a script restart to pick up edits made to the recording file. Adding a reload-from-file feature allows users to edit the recording file and have changes take effect immediately on the next replay, enabling iterative macro refinement without restarting the script.

## What Changes

- Add Ctrl+F24 hotkey to reload the F24 recording from QuickRecord.last.txt without replaying it
- Add Ctrl+F23 hotkey to reload the F23 recording from QuickRecord.last.f23.txt without replaying it
- Modify the replay behavior to use the reloaded buffer instead of the in-memory buffer
- Preserve the ability to record and replay independently

## Capabilities

### New Capabilities

- `reload-macro-from-file`: Ability to reload a recording from disk (Ctrl+F24 or Ctrl+F23) without triggering replay, allowing users to edit recording files and have changes take effect on the next replay

### Modified Capabilities

- `recording-playback`: Extend to support reloading from file before replay

## Impact

- **Code**: QuickRecord.ahk will be modified to add reload hotkeys and update the replay logic
- **Files**: No new files created; existing recording files (QuickRecord.last.txt and QuickRecord.last.f23.txt) are read on demand
- **User Experience**: Users can now edit recording files directly and reload them without restarting the script
