# OpenSpec Backfill Guide

This document captures the already-implemented features in `scripts/WindowPadPlus.ahk` and provides the exact commands to backfill them into OpenSpec as archived changes.

## Feature Inventory

| Feature Group | Change Name | Hotkeys Covered |
|---|---|---|
| Transparent modifier keys | `transparent-modifier-keys` | `Numpad0` passthrough, `NumpadDot` passthrough |
| Half-screen window snapping | `window-snapping-halves` | `Numpad0+4/6/8/2/5` |
| Quarter-screen window snapping | `window-snapping-quarters` | `Numpad0+7/9/1/3` |
| Maximize and next monitor | `window-maximize-and-next-monitor` | `Numpad0+NumpadAdd`, `Numpad0+NumpadEnter` |
| CapsLock hotkey layout | `capslock-hotkey-layout` | `CapsLock+Q/W/E/A/S/D/Z/X/C/Tab/Space` |
| Thirds window snapping | `thirds-window-snapping` | `NumpadDot+4/5/6/8/2` |

---

## Backfill Instructions

Run each block in sequence. Each change follows the same three-step pattern:
1. **Propose** — generates `proposal.md`, `design.md`, `tasks.md`
2. **Mark tasks done** — all tasks are already implemented; mark all `- [ ]` as `- [x]` in `tasks.md`
3. **Archive** — moves the change to the archive

---

### 1. Transparent Modifier Keys

**What it is:** `Numpad0` and `NumpadDot` act as chord modifiers while still sending their character (`0` and `.`) when pressed and released alone. Also handles the `NumpadIns` and `NumpadDel` aliases for numlock-off state.

**Step 1 — Propose:**
```
/opsx-propose transparent-modifier-keys

Backfill: Already implemented in scripts/WindowPadPlus.ahk.
Numpad0 (and NumpadIns alias) and NumpadDot (and NumpadDel alias) are used as chord
modifier keys. When pressed alone (no chord fired), they fall through and send their
original character using the KeyUp event and A_PriorKey check. AHK v2, SendMode Input.
```

**Step 2 — Mark tasks done:** Open `openspec/changes/transparent-modifier-keys/tasks.md` and mark all tasks `- [x]`.

**Step 3 — Archive:**
```
/opsx-archive transparent-modifier-keys
```

---

### 2. Half-Screen Window Snapping (Numpad)

**What it is:** `Numpad0` chord snaps the active window to halves of the monitor. The center-half (`Numpad0+5`) is orientation-aware: landscape monitors use half-width centered, portrait monitors use half-height centered. Maximized windows are restored before moving.

**Step 1 — Propose:**
```
/opsx-propose window-snapping-halves

Backfill: Already implemented in scripts/WindowPadPlus.ahk.
Numpad0 modifier chords: Numpad4=left half, Numpad6=right half, Numpad8=top half,
Numpad2=bottom half, Numpad5=center half (landscape: 50% width centered; portrait:
50% height centered). MoveToRelativeArea() calculates position relative to the
window's current monitor. Maximized windows auto-restore before snapping. AHK v2.
```

**Step 2 — Mark tasks done:** Open `openspec/changes/window-snapping-halves/tasks.md` and mark all tasks `- [x]`.

**Step 3 — Archive:**
```
/opsx-archive window-snapping-halves
```

---

### 3. Quarter-Screen Window Snapping (Numpad)

**What it is:** `Numpad0` chord snaps the active window to corner quarters of the monitor using the numpad corner keys.

**Step 1 — Propose:**
```
/opsx-propose window-snapping-quarters

Backfill: Already implemented in scripts/WindowPadPlus.ahk.
Numpad0 modifier chords: Numpad7=top-left quarter, Numpad9=top-right quarter,
Numpad1=bottom-left quarter, Numpad3=bottom-right quarter. Uses MoveToRelativeArea()
shared with halves snapping. AHK v2.
```

**Step 2 — Mark tasks done:** Open `openspec/changes/window-snapping-quarters/tasks.md` and mark all tasks `- [x]`.

**Step 3 — Archive:**
```
/opsx-archive window-snapping-quarters
```

---

### 4. Maximize and Move to Next Monitor (Numpad)

**What it is:** `Numpad0+NumpadAdd` maximizes the active window. `Numpad0+NumpadEnter` moves it to the next monitor (wrapping around), preserving its relative position and size. If the window was maximized before the move, it is re-maximized on the destination monitor.

**Step 1 — Propose:**
```
/opsx-propose window-maximize-and-next-monitor

Backfill: Already implemented in scripts/WindowPadPlus.ahk.
Numpad0+NumpadAdd calls WinMaximize. Numpad0+NumpadEnter moves the window to the
next monitor index (wraps at end), computing relative X/Y/W/H from the source monitor
and applying to the destination monitor dimensions. Maximized state is preserved.
Monitor detection uses the window's upper-left corner. AHK v2.
```

**Step 2 — Mark tasks done:** Open `openspec/changes/window-maximize-and-next-monitor/tasks.md` and mark all tasks `- [x]`.

**Step 3 — Archive:**
```
/opsx-archive window-maximize-and-next-monitor
```

---

### 5. CapsLock Hotkey Layout

**What it is:** A full duplicate of the numpad layout mapped to CapsLock chords, for keyboards without a numpad. Key mapping: `Q/W/E` → top-left/top/top-right, `A/S/D` → left/maximize/right, `Z/X/C` → bottom-left/bottom/bottom-right, `Tab` → center half, `Space` → move to next monitor. Uses the same monitor detection improvement (center-point based) as the CapsLock+Space variant.

**Step 1 — Propose:**
```
/opsx-propose capslock-hotkey-layout

Backfill: Already implemented in scripts/WindowPadPlus.ahk.
CapsLock modifier mirrors the numpad layout for keyboards without numpad:
CapsLock+Q=top-left quarter, W=top half, E=top-right quarter,
A=left half, S=maximize, D=right half,
Z=bottom-left quarter, X=bottom half, C=bottom-right quarter,
Tab=center half (orientation-aware), Space=move to next monitor (center-point
monitor detection, preserves maximized state). AHK v2.
```

**Step 2 — Mark tasks done:** Open `openspec/changes/capslock-hotkey-layout/tasks.md` and mark all tasks `- [x]`.

**Step 3 — Archive:**
```
/opsx-archive capslock-hotkey-layout
```

---

### 6. Thirds Window Snapping

**What it is:** `NumpadDot` chord snaps the active window to thirds of the monitor. Left/right/top/bottom thirds use `MoveToThird()` which calculates 1/3 proportions. Center third (`NumpadDot+5`) is orientation-aware: landscape uses a centered 1/3-width column, portrait uses a centered 1/3-height row.

**Step 1 — Propose:**
```
/opsx-propose thirds-window-snapping

Backfill: Already implemented in scripts/WindowPadPlus.ahk.
NumpadDot modifier chords: Numpad4=left third (0–33%), Numpad6=right third (66–100%),
Numpad8=top third (0–33%), Numpad2=bottom third (66–100%), Numpad5=center third
(orientation-aware: landscape=middle 33% width full height, portrait=middle 33%
height full width). MoveToThird() uses GetWindowArea() for relative positioning.
AHK v2.
```

**Step 2 — Mark tasks done:** Open `openspec/changes/thirds-window-snapping/tasks.md` and mark all tasks `- [x]`.

**Step 3 — Archive:**
```
/opsx-archive thirds-window-snapping
```

---

## Notes

- All proposals describe already-completed work. When the AI generates `tasks.md`, every task should be immediately marked `- [x]` before archiving.
- Archive the changes in the order listed above to keep a clean logical history.
- If OpenSpec asks for a description during propose, paste the text provided under each **Step 1** block.
