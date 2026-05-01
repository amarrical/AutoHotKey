## Context

The CapsLock layout provides a complete alternative to the numpad layout for users without a numpad. The key mapping mirrors the numpad spatially on the QWERTY home row:

- Top row (Q/W/E) maps to numpad top row (7/8/9)
- Middle row (A/S/D) maps to numpad middle row (4/5/6)
- Bottom row (Z/X/C) maps to numpad bottom row (1/2/3)
- Tab and Space provide center-half and next-monitor functions

The implementation reuses the same window snapping logic as the numpad hotkeys, just with different key bindings. CapsLock+Space uses center-point monitor detection (improvement over the numpad variant which uses upper-left corner).

## Goals / Non-Goals

**Goals:**
- Provide complete numpad functionality on keyboards without numpad
- Use intuitive spatial mapping on home row keys
- Reuse existing window snapping logic
- Support multi-monitor setups with center-point detection for CapsLock+Space
- Preserve maximized state when moving between monitors

**Non-Goals:**
- Remap CapsLock itself (it still functions as CapsLock when used alone)
- Custom key layouts or user-configurable bindings
- Support for AutoHotkey v1

## Decisions

**Decision 1: Use home row keys (QWERTY) for spatial mapping**
- **Rationale**: Home row is where users' hands naturally rest. Spatial layout (top/middle/bottom rows) mirrors numpad layout.
- **Alternative considered**: Use different key layout. Rejected because home row is most ergonomic.

**Decision 2: Reuse window snapping functions**
- **Rationale**: CapsLock hotkeys call the same MoveToRelativeArea() and other helpers as numpad hotkeys. No code duplication.
- **Alternative considered**: Implement separate CapsLock-specific functions. Rejected because it duplicates logic.

**Decision 3: Use center-point monitor detection for CapsLock+Space**
- **Rationale**: Center-point detection is more reliable than upper-left corner for multi-monitor setups. This is an improvement over the numpad variant.
- **Alternative considered**: Use upper-left corner like numpad. Rejected because center-point is more accurate.

**Decision 4: Tab for center-half, Space for next-monitor**
- **Rationale**: Tab is near the home row and provides a natural "center" key. Space is the largest key and easy to find for the next-monitor function.
- **Alternative considered**: Use different keys. Rejected because Tab and Space are ergonomic and memorable.

## Risks / Trade-offs

**Risk: CapsLock remapping conflicts**
- **Mitigation**: CapsLock is only used as a modifier, not remapped. Users can still use CapsLock normally when pressed alone.

**Risk: Key conflict with text input**
- **Mitigation**: Hotkeys only activate when CapsLock is held. Normal typing is unaffected.

**Trade-off: Different monitor detection between numpad and CapsLock variants**
- **Rationale**: CapsLock+Space uses center-point detection (better), numpad uses upper-left (simpler). This inconsistency is acceptable given the improvement.
