## Why

QuickRecord currently uses only F24 for recording and playback, limiting workflow flexibility. Adding F23 as a second recording key allows users to maintain two independent recordings simultaneously, enabling more complex automation scenarios and better organization of different recording sequences.

## What Changes

- Add F23 as a secondary quick-record hotkey (Shift+F23 to toggle recording, F23 to replay)
- Maintain two separate recording buffers: one for F24 and one for F23
- Each buffer has its own persistence file (QuickRecord.last.txt and QuickRecord.last.f23.txt)
- Both recordings are loaded at startup and can be managed independently

## Capabilities

### New Capabilities

- `dual-recording-buffers`: Ability to maintain and switch between two independent recording sequences with separate hotkeys (F23 and F24)

### Modified Capabilities

- `recording-persistence`: Extend to support multiple recording files, one per hotkey

## Impact

- **Code**: QuickRecord.ahk will be modified to support dual recording state and dual file persistence
- **Files**: New persistence file `QuickRecord.last.f23.txt` will be created alongside existing `QuickRecord.last.txt`
- **User Experience**: Users can now record two separate sequences and switch between them using different function keys
