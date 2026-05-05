## Why

QuickRecord fills a gap in WindowPad's utility: users often need to record and replay keyboard sequences (macros) for repetitive tasks. Currently, there's no built-in way to do this without external tools. A lightweight, keyboard-driven recording system integrated into the WindowPad ecosystem provides immediate value and sets the foundation for future macro expansion.

## What Changes

- Add `scripts/QuickRecord.ahk` — a new standalone AutoHotkey v2 script for recording and replaying keyboard macros
- Introduce `Shift+F24` hotkey to toggle recording on/off with visual state indication
- Introduce `F24` hotkey to replay the most recent recording
- Capture keyboard events (down/up) with inter-event timing preserved during playback
- Support ~110 common keys (A–Z, 0–9, function keys, modifiers, navigation, numpad, punctuation)
- Exclude media keys, mouse, and dead keys from scope
- Design for future expansion to multiple named recording files with separate hotkeys

## Capabilities

### New Capabilities
- `quick-record-toggle`: Toggle recording state via `Shift+F24` with visual tray indication
- `quick-record-keyboard-capture`: Capture keyboard events (down/up) with timing while recording, without blocking normal typing
- `quick-record-playback`: Replay the most recent recording, preserving inter-key timing and modifier semantics

### Modified Capabilities
<!-- No existing capabilities are modified -->

## Impact

- **Code**: New `scripts/QuickRecord.ahk` (~200–300 lines) with hotkey handlers, state machine, event buffer, and replay logic
- **APIs**: No new public APIs; internal functions for state management, event capture, and playback
- **User Experience**: Two new global hotkeys (`Shift+F24` to record, `F24` to replay) with tray tooltip feedback
- **Backwards Compatibility**: Fully backwards compatible — no changes to existing WindowPadPlus functionality
