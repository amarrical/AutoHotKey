## Context

Thirds snapping is similar to halves and quarters snapping, but uses 1/3 proportions instead of 1/2 or 1/1. The implementation uses a dedicated `MoveToThird()` helper function that calculates positions based on 1/3 increments.

The center-third snap requires orientation detection to choose between horizontal (landscape) and vertical (portrait) centering. Left and right thirds use 0–33% and 66–100% respectively, leaving a gap in the middle. Top and bottom thirds follow the same pattern.

## Goals / Non-Goals

**Goals:**
- Snap windows to left, right, top, bottom thirds using NumpadDot modifier
- Snap window to center third with orientation awareness (landscape vs portrait)
- Automatically restore maximized windows before snapping
- Support multi-monitor setups by detecting the active monitor
- Use consistent relative positioning logic across all snap operations

**Non-Goals:**
- Custom snap positions or user-configurable layouts
- Animations or transitions
- Persistence of snap state across reboots
- Support for AutoHotkey v1

## Decisions

**Decision 1: Use 1/3 proportions for thirds snapping**
- **Rationale**: 1/3 (0.333333) is the natural proportion for thirds. Left third is 0–33%, right third is 66–100%, center third is 33–66%.
- **Alternative considered**: Use different proportions. Rejected because 1/3 is mathematically correct and intuitive.

**Decision 2: Implement MoveToThird() helper function**
- **Rationale**: Similar to MoveToRelativeArea(), but with 1/3 proportions. Keeps logic encapsulated and reusable.
- **Alternative considered**: Reuse MoveToRelativeArea() with different parameters. Rejected because MoveToThird() is clearer and more maintainable.

**Decision 3: Orientation-aware center-third snap**
- **Rationale**: On landscape monitors, users expect a vertical column in the center. On portrait monitors, a horizontal row. This maximizes usable space.
- **Alternative considered**: Always use a fixed 33% width center snap. Rejected because it wastes space on portrait displays.

**Decision 4: Use NumpadDot as the modifier key**
- **Rationale**: NumpadDot is already used as a transparent modifier (sends "." when pressed alone). Using it for thirds snapping provides a logical grouping.
- **Alternative considered**: Use a different modifier. Rejected because NumpadDot is already established for this purpose.

## Risks / Trade-offs

**Risk: Window position calculation complexity**
- **Mitigation**: Encapsulate logic in `MoveToThird()` helper function. Test thoroughly on multi-monitor setups.

**Risk: Thirds positioning may leave gaps**
- **Mitigation**: Left third (0–33%) and right third (66–100%) intentionally leave a gap in the middle. This is by design to allow center-third positioning.

**Trade-off: Snap happens on key release, not press**
- **Rationale**: Necessary to detect whether a chord was activated. The delay is imperceptible to users.

**Trade-off: No animation**
- **Rationale**: Keeps implementation simple and responsive. Users can add animations via AutoHotkey if desired.
