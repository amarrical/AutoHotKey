## Context

Multi-monitor window management requires detecting the current monitor, calculating relative position/size, and applying those proportions to the destination monitor. The maximize operation is straightforward (WinMaximize), but the move-to-next-monitor operation is more complex.

The implementation detects the current monitor by finding which monitor contains the window's upper-left corner, then wraps to the first monitor if already on the last. Relative position and size are calculated as percentages of the source monitor's dimensions, then applied to the destination monitor.

## Goals / Non-Goals

**Goals:**
- Maximize the active window with a single hotkey
- Move window to the next monitor with proportional positioning
- Wrap around from the last monitor to the first
- Preserve maximized state when moving between monitors
- Support multi-monitor setups with different monitor sizes

**Non-Goals:**
- Custom monitor selection or user-configurable monitor order
- Animations or transitions
- Support for AutoHotkey v1

## Decisions

**Decision 1: Use window's upper-left corner for monitor detection**
- **Rationale**: Simple and deterministic. Works for most window positions.
- **Alternative considered**: Use window center point. Rejected because upper-left is more predictable for window movement.

**Decision 2: Calculate relative position as percentages**
- **Rationale**: Percentages scale across monitors of different sizes. A window at 25% on a 1920px monitor maps to 25% on a 1440px monitor.
- **Alternative considered**: Preserve absolute pixel positions. Rejected because it doesn't scale across different monitor sizes.

**Decision 3: Re-maximize window if it was maximized before move**
- **Rationale**: Users expect maximized state to be preserved. Checking before move and re-maximizing after ensures this.
- **Alternative considered**: Always restore before moving. Rejected because it changes user's intended state.

**Decision 4: Wrap around to first monitor**
- **Rationale**: Intuitive circular navigation. Users expect pressing next on the last monitor to go to the first.
- **Alternative considered**: Stop at last monitor. Rejected because it's less intuitive.

## Risks / Trade-offs

**Risk: Monitor detection edge cases**
- **Mitigation**: Upper-left corner detection is reliable for typical window positions. Document limitation for edge cases.

**Trade-off: No animation**
- **Rationale**: Keeps implementation simple. Users see instant window movement.

**Trade-off: Relative positioning may not preserve exact pixel dimensions**
- **Rationale**: Necessary for scaling across different monitor sizes. Users can manually adjust if needed.
