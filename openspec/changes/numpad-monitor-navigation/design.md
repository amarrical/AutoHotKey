## Context

WindowPadPlus is built on AutoHotkey and already has a mature hotkey system for window management. The codebase includes monitor detection capabilities and window positioning functions. Users with multiple monitors need a faster way to move windows between monitors without navigating menus or using complex key combinations.

Since numpad 1-9 are already in use for other WindowPadPlus functionality, the numpad 0 + normal number keys 1-9 approach provides an intuitive monitor navigation shortcut that maps naturally to monitor positions (e.g., numpad 0 + 1 = monitor 1, numpad 0 + 9 = monitor 9).

## Goals / Non-Goals

**Goals:**
- Implement numpad 0 + normal number keys 1-9 hotkey bindings for direct monitor navigation
- Detect the number of connected monitors and only activate valid monitor targets
- Move the active window to the specified monitor while preserving window state
- Integrate seamlessly with existing WindowPadPlus hotkey registration system
- Provide clear feedback when an invalid monitor is targeted (e.g., numpad 0 + 5 when only 3 monitors exist)

**Non-Goals:**
- Change existing monitor detection logic or window positioning algorithms
- Modify the hotkey configuration file format or user settings system
- Add GUI configuration for this feature (use code defaults)
- Support numpad 0 + numpad keys (only normal number row keys 1-9)

## Decisions

**Decision 1: Numpad 0 as modifier with normal number keys**
- **Choice**: Use numpad 0 (KP0 in AutoHotkey) as the modifier with normal number keys 1-9, not numpad 1-9
- **Rationale**: Numpad 1-9 are already used in WindowPadPlus for other functionality. Using normal number keys 1-9 with numpad 0 as a modifier avoids conflicts. Numpad 0 is rarely used, making it a safe modifier choice.
- **Alternative Considered**: Using Ctrl+1-9 or Shift+1-9 would conflict with existing shortcuts; numpad 1-9 are already in use

**Decision 2: Monitor detection at hotkey trigger time**
- **Choice**: Query the number of monitors when the hotkey fires, not at startup
- **Rationale**: Handles dynamic monitor connections/disconnections gracefully. Users can plug/unplug monitors without restarting the script. This is especially important since numpad 0 + 1-9 will be frequently used.
- **Alternative Considered**: Cache monitor count at startup (simpler but breaks if monitors change)

**Decision 3: Silent no-op for invalid monitors**
- **Choice**: If user presses numpad 0 + 7 but only 3 monitors exist, do nothing
- **Rationale**: Keeps the feature simple and non-intrusive. Users will quickly learn valid ranges. Avoids notification spam. Silent operation is consistent with other WindowPadPlus hotkeys.
- **Alternative Considered**: Show a tooltip warning (adds complexity and can be annoying)

**Decision 4: Integrate into QuickRecord.ahk hotkey handler**
- **Choice**: Add hotkey registration in the existing QuickRecord.ahk file alongside other window management hotkeys
- **Rationale**: Maintains consistency with current architecture. All window hotkeys are in one place, making maintenance easier.
- **Alternative Considered**: Create a separate module (adds unnecessary complexity for this feature)

## Risks / Trade-offs

**Risk: Numpad 0 key detection reliability**
- Some keyboards or configurations may not properly distinguish numpad 0 from other keys
- **Mitigation**: Test on multiple keyboard types; document any known compatibility issues

**Risk: Window state preservation**
- Moving a window between monitors might cause display issues if the target monitor has different DPI or resolution
- **Mitigation**: Use AutoHotkey's built-in window positioning (WinMove) which handles DPI scaling; test with mixed-DPI setups

**Risk: Hotkey conflicts with user scripts**
- If a user has custom AutoHotkey scripts, numpad 0 + 1-9 might conflict
- **Mitigation**: Document the hotkeys clearly; provide easy way to disable in user config

**Trade-off: No visual feedback**
- Chosen silent operation over tooltips to keep it lightweight
- **Impact**: Users must verify the window moved by looking at the screen

## Migration Plan

1. Add hotkey registration code to QuickRecord.ahk
2. Implement helper function to get active monitor count
3. Implement helper function to move window to specific monitor
4. Register numpad 0 + 1-9 hotkeys with appropriate handlers
5. Test with 1, 2, 3, and 4 monitor configurations
6. Update user documentation with new hotkey list
7. Deploy as part of next WindowPadPlus release

## Open Questions

- Should we show a brief tooltip when a window is successfully moved? (Currently: no, keep silent)
- Should numpad 0 + 0 have special behavior (e.g., move to primary monitor)? (Currently: no special behavior)
- Should we support moving to monitor by name/position (e.g., "leftmost") in addition to numbers? (Currently: numbers only)
