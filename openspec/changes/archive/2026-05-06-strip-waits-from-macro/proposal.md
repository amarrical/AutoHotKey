## Why

Recorded macros often contain timing delays between key presses that are necessary for the original recording but may not be needed for faster playback. Adding a quick way to strip all waits from a macro allows users to execute the same sequence of actions at maximum speed without manual file editing or script restart.

## What Changes

- Add Alt+F24 hotkey to strip all wait times from the F24 macro and rewrite the storage file
- Add Alt+F23 hotkey to strip all wait times from the F23 macro and rewrite the storage file
- Preserve the key sequence while removing all timing delays (setting delta to 0)
- Display confirmation notification after stripping waits

## Capabilities

### New Capabilities

- `strip-waits`: Ability to remove all timing delays from a recorded macro (Alt+F24 or Alt+F23) and persist the modified macro to disk

### Modified Capabilities

- `recording-persistence`: Extend to support in-place modification of recording files

## Impact

- **Code**: QuickRecord.ahk will be modified to add strip-waits hotkeys and implement wait-stripping logic
- **Files**: Existing recording files (QuickRecord.last.F24.txt and QuickRecord.last.f23.txt) will be modified in-place when strip-waits is invoked
- **User Experience**: Users can quickly execute macros at maximum speed by pressing Alt+F24 or Alt+F23 to remove all delays
