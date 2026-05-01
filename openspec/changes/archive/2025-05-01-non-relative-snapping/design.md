## Context

WindowPad currently uses a relative positioning model where snapping operations calculate positions based on the window's current area (either its bounds or the full monitor if maximized). The `MoveToRelativeArea()` function takes normalized coordinates (0-1) and applies them relative to the current window area.

The system has two hotkey schemes:
1. **Numpad0-based**: Numpad0 as modifier with numpad keys (4, 6, 8, 2, 7, 9, 1, 3, 5, etc.)
2. **CapsLock-based**: CapsLock as modifier with QWERTY keys (alternative for keyboards without numpad)

## Goals / Non-Goals

**Goals:**
- Add Shift as a new modifier chord that enables absolute monitor positioning
- When Shift is held with direction keys, snap to fixed monitor regions regardless of current window position
- Support both Numpad0+Shift and CapsLock+Shift combinations
- Maintain full backwards compatibility with existing relative snapping

**Non-Goals:**
- Changing existing relative snapping behavior
- Modifying monitor detection or multi-monitor logic
- Adding new snap positions or layouts beyond what Shift enables

## Decisions

**Decision 1: Dual-modifier approach (Shift + Numpad0/CapsLock)**
- **Rationale**: Shift is a standard modifier that doesn't conflict with existing hotkeys. Using Shift+Numpad0+Direction or Shift+CapsLock+Direction creates a clear distinction from relative snapping.
- **Alternative Considered**: Single modifier (Shift+Direction alone) - rejected because it would require remapping existing hotkeys and could conflict with other applications.

**Decision 2: Create `MoveToAbsoluteArea()` function**
- **Rationale**: Mirror the existing `MoveToRelativeArea()` pattern. This function will take normalized coordinates and apply them to the monitor bounds directly, not the window's current area.
- **Implementation**: Extract monitor bounds, calculate absolute position, and move window. No relative area calculation needed.

**Decision 3: Hotkey syntax using nested modifiers**
- **Rationale**: AutoHotkey v2.0 supports chained modifiers. Use `Shift & Numpad0 & Numpad6` syntax for Shift+Numpad0+Direction combinations.
- **Alternative Considered**: Separate Shift detection in hotkey handlers - rejected as more complex and error-prone.

**Decision 4: Reuse monitor detection logic**
- **Rationale**: Leverage existing `GetWindowMonitor()` to find the correct monitor for the active window, then snap to absolute positions on that monitor.

## Risks / Trade-offs

**Risk: Hotkey collision with system or application shortcuts**
- **Mitigation**: Shift+Numpad combinations are rarely used system-wide. Test with common applications to verify no conflicts.

**Risk: User confusion between relative and absolute snapping**
- **Mitigation**: Clear documentation and consistent behavior. Shift modifier provides visual/tactile distinction.

**Risk: Maximized window handling**
- **Mitigation**: `RestoreIfMaximized()` is called before moving, ensuring consistent behavior. Absolute snapping will restore then position.

**Trade-off: Code duplication vs. abstraction**
- **Mitigation**: Keep functions simple and parallel. Duplication is acceptable here as the two modes (relative vs absolute) have fundamentally different calculation logic.
