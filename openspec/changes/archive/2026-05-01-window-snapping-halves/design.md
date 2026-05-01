## Context

Window snapping requires knowledge of the monitor's dimensions and the window's current position. AutoHotkey v2 provides APIs to query monitor information and move windows. The challenge is handling both maximized and restored windows, and calculating positions relative to the active monitor (important for multi-monitor setups).

The `MoveToRelativeArea()` helper function abstracts position calculation, allowing all snap hotkeys to use consistent logic. The center-half snap requires orientation detection to choose between horizontal and vertical centering.

## Goals / Non-Goals

**Goals:**
- Snap windows to left, right, top, bottom halves using relative positioning
- Snap window to center half with orientation awareness (landscape vs portrait)
- Automatically restore maximized windows before snapping
- Support multi-monitor setups by detecting the active monitor
- Use consistent relative positioning logic across all snap operations

**Non-Goals:**
- Custom snap positions or user-configurable layouts
- Animations or transitions
- Persistence of snap state across reboots
- Support for AutoHotkey v1

## Decisions

**Decision 1: Use relative positioning (0-1 scale)**
- **Rationale**: Relative positioning (e.g., 0.5 width, 0 Y offset) works across monitors of different sizes. Absolute pixel positions would fail on multi-monitor setups.
- **Alternative considered**: Absolute pixel positioning. Rejected because it doesn't scale across monitors.

**Decision 2: Detect active monitor via window center point**
- **Rationale**: Using the window's center point is more reliable than the upper-left corner, especially for windows spanning multiple monitors.
- **Alternative considered**: Use window's upper-left corner. Rejected because it can misidentify the monitor for partially-off-screen windows.

**Decision 3: Restore maximized windows before snapping**
- **Rationale**: A maximized window's reported position is the full monitor dimensions. Snapping a maximized window without restoring it first would result in incorrect positioning.
- **Alternative considered**: Calculate snap position based on maximized state. Rejected because it's more complex and error-prone.

**Decision 4: Orientation-aware center-half snap**
- **Rationale**: On landscape monitors, users expect a vertical column in the center. On portrait monitors, a horizontal row. This maximizes usable space.
- **Alternative considered**: Always use a fixed 50% width center snap. Rejected because it wastes space on portrait displays.

## Risks / Trade-offs

**Risk: Window position calculation complexity**
- **Mitigation**: Encapsulate logic in `MoveToRelativeArea()` helper function. Test thoroughly on multi-monitor setups.

**Risk: Maximized window detection**
- **Mitigation**: Use `WinGetMinMax()` which returns 1 for maximized, 0 for restored. This is reliable in AutoHotkey v2.

**Trade-off: Snap happens on key release, not press**
- **Rationale**: Necessary to detect whether a chord was activated. The delay is imperceptible to users.

**Trade-off: No animation**
- **Rationale**: Keeps implementation simple and responsive. Users can add animations via AutoHotkey if desired.
