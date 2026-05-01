## Context

Quarter-screen snapping is a straightforward extension of the half-screen snapping feature. It reuses the same `MoveToRelativeArea()` helper function with different positioning parameters (0.5 width and 0.5 height instead of 1.0).

The four corner positions are calculated as:
- Top-left: (0, 0, 0.5, 0.5)
- Top-right: (0.5, 0, 0.5, 0.5)
- Bottom-left: (0, 0.5, 0.5, 0.5)
- Bottom-right: (0.5, 0.5, 0.5, 0.5)

## Goals / Non-Goals

**Goals:**
- Snap windows to all four corners using numpad corner keys (7, 9, 1, 3)
- Automatically restore maximized windows before snapping
- Support multi-monitor setups via existing monitor detection
- Maintain consistency with half-screen snapping behavior

**Non-Goals:**
- Custom quarter positions or user-configurable layouts
- Animations or transitions
- Support for AutoHotkey v1

## Decisions

**Decision 1: Reuse MoveToRelativeArea() helper**
- **Rationale**: The function already handles all positioning logic. Quarter snaps are just different parameter values.
- **Alternative considered**: Implement separate quarter-snap function. Rejected because it duplicates logic.

**Decision 2: Use numpad corner keys (7, 9, 1, 3)**
- **Rationale**: These keys are naturally positioned at the corners of the numpad, providing intuitive spatial mapping.
- **Alternative considered**: Use different keys. Rejected because the numpad layout is already familiar to users.

## Risks / Trade-offs

**Risk: Confusion with half-snap keys**
- **Mitigation**: Numpad corner keys (7, 9, 1, 3) are distinct from half-snap keys (4, 6, 8, 2, 5). Clear documentation helps.

**Trade-off: No diagonal positioning**
- **Rationale**: Quarters cover the most common use cases. Diagonal positioning is rarely needed.
