## Why

QuickRecord is a powerful macro recording and playback tool, but it currently lacks user-facing documentation. New users cannot easily understand how to use the hotkeys, what the different modifiers do, or how the dual-buffer system works. Creating comprehensive documentation will reduce the learning curve and help users discover features like reload-from-file and strip-waits.

## What Changes

- Create QuickRecord.md in the docs/ directory with complete user documentation
- Document all hotkeys and their modifiers (Shift, Ctrl, Alt)
- Explain the dual-buffer system (F24 and F23)
- Provide usage examples and workflows
- Document the file format and persistence behavior
- Include troubleshooting and FAQ sections
- Match the style and structure of existing WindowPadPlus.md documentation

## Capabilities

### New Capabilities

- `quickrecord-documentation`: Comprehensive user guide for QuickRecord including hotkey reference, concepts, workflows, and troubleshooting

### Modified Capabilities

(None)

## Impact

- **Code**: No code changes
- **Files**: New file `docs/QuickRecord.md` created
- **User Experience**: Users can now easily learn and reference QuickRecord features without reading source code
