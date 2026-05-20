# WindowPadPlus

A window snapping utility for Windows, built with AutoHotkey v2. Snap any window to halves, thirds, quarters, or large-area fractions of your monitor using keyboard chords — no mouse required.

---

## Installation

### 1. Install AutoHotkey v2

1. Go to [https://www.autohotkey.com](https://www.autohotkey.com)
2. Click **Download** and choose **AutoHotkey v2** (not v1)
3. Run the installer and follow the prompts

> **Important:** This script requires AutoHotkey **v2.0**. It will not run on v1.x.

### 2. Run the Script

1. Navigate to the `scripts/` folder
2. Double-click `WindowPadPlus.ahk`
3. A green AHK icon will appear in the system tray — the script is running

### 3. Run on Startup (Optional)

To have the script start automatically with Windows:

1. Press `Win + R`, type `shell:startup`, press Enter
2. Create a shortcut to `WindowPadPlus.ahk` in the folder that opens

### 4. Reload After Edits

After modifying the script, right-click the tray icon and choose **Reload Script**.

---

## Concepts

### Chord Keys

WindowPadPlus uses **chord keys** — hold a modifier key, press a direction key while still holding it. The two chord systems are:

- **Numpad0** — hold `0` on the numpad, then press a direction key
- **NumpadDot** — hold `.` on the numpad, then press a direction key
- **CapsLock** — hold `CapsLock`, then press a letter key (for keyboards without a numpad)

Pressing `0` or `.` alone still types the character normally.

### Modifier Keys

Each chord system supports three **modifier keys** that change what kind of snap is performed:

| Modifier | Effect |
|----------|--------|
| *(none)* | **Relative** snap — snaps within the window's current area |
| **Shift** | **Absolute half/third** snap — snaps to a fixed fraction of the monitor |
| **Ctrl** | **Large area** snap — snaps to 3/4 (Numpad0) or 2/3 (NumpadDot) of the monitor |

### Relative vs Absolute Snapping

- **Relative**: The snap target is calculated from the window's current bounding area. Useful when a window is already occupying a portion of the screen — snapping further subdivides that area.
- **Absolute**: The snap target is always a fixed region of the monitor, regardless of where the window is. Predictable and consistent.

### Orientation-Aware Centering

Center snaps (`5` / `Tab`) adapt to your monitor's orientation:
- **Landscape monitor**: centers as a column (half/third width, full height)
- **Portrait monitor**: centers as a band (full width, half/third height)

Adding **Shift** to a center snap gives the **alternate** center — the perpendicular axis:
- **Landscape + Shift**: full width, half/third height (horizontal band)
- **Portrait + Shift**: half/third width, full height (vertical column)

### Maximized Windows

All snap operations automatically **restore** a maximized window before repositioning it.

### Multi-Monitor

Monitor detection uses the **window's center point** to determine which monitor it belongs to. All snaps target the window's current monitor. `0 + Enter` / `CapsLock + Space` moves the window to the next monitor, preserving its relative position and size.

---

## Numpad System

Uses **Numpad0** as the chord key. The numpad layout maps directly to snap positions:

```
┌───┬───┬───┐
│ 7 │ 8 │ 9 │   top-left │ top │ top-right
├───┼───┼───┤
│ 4 │ 5 │ 6 │   left     │center│ right
├───┼───┼───┤
│ 1 │ 2 │ 3 │   bot-left │ bot │ bot-right
└───┴───┴───┘
      0          (chord key)
```

### Numpad0 + Key — Relative Snapping

Hold `Numpad0`, then press:

| Key | Action |
|-----|--------|
| `+` | Maximize window |
| `Enter` | Move to next monitor (preserves relative size/position) |
| `1`–`9` | Move window to monitor 1–9 (preserves relative size/position) |
| `5` | Center half *(orientation-aware)* |
| `4` | Left half |
| `6` | Right half |
| `8` | Top half |
| `2` | Bottom half |
| `7` | Top-left quarter |
| `9` | Top-right quarter |
| `1` | Bottom-left quarter |
| `3` | Bottom-right quarter |

### Shift + Numpad0 + Key — Absolute Half/Quarter Snapping

Hold `Shift`, hold `Numpad0`, then press a direction key. Works regardless of which of Shift or Numpad0 is pressed first.

| Key | Action |
|-----|--------|
| `5` | Alternate center half *(perpendicular axis)* |
| `4` | Left half of monitor |
| `6` | Right half of monitor |
| `8` | Top half of monitor |
| `2` | Bottom half of monitor |
| `7` | Top-left quarter of monitor |
| `9` | Top-right quarter of monitor |
| `1` | Bottom-left quarter of monitor |
| `3` | Bottom-right quarter of monitor |

### Ctrl + Numpad0 + Key — Absolute 3/4 Snapping

Hold `Ctrl`, hold `Numpad0`, then press a direction key.

| Key | Action |
|-----|--------|
| `4` | Left 3/4 of monitor |
| `6` | Right 3/4 of monitor |
| `8` | Top 3/4 of monitor |
| `2` | Bottom 3/4 of monitor |

---

## NumpadDot (Thirds) System

Uses **NumpadDot** (`.`) as the chord key for third-based snapping.

### NumpadDot + Key — Relative Third Snapping

Hold `NumpadDot`, then press:

| Key | Action |
|-----|--------|
| `+` | Maximize window |
| `5` | Center third *(orientation-aware)* |
| `4` | Left third |
| `6` | Right third |
| `8` | Top third |
| `2` | Bottom third |

### Shift + NumpadDot + Key — Absolute Third Snapping

Hold `Shift`, hold `NumpadDot`, then press a direction key. Works regardless of press order.

| Key | Action |
|-----|--------|
| `5` | Alternate center third *(perpendicular axis)* |
| `4` | Left third of monitor |
| `6` | Right third of monitor |
| `8` | Top third of monitor |
| `2` | Bottom third of monitor |

### Ctrl + NumpadDot + Key — Absolute 2/3 Snapping

Hold `Ctrl`, hold `NumpadDot`, then press a direction key.

| Key | Action |
|-----|--------|
| `4` | Left 2/3 of monitor |
| `6` | Right 2/3 of monitor |
| `8` | Top 2/3 of monitor |
| `2` | Bottom 2/3 of monitor |

---

## CapsLock System

For keyboards without a numpad. Uses **CapsLock** as the chord key. Letter keys map to the same positions as the numpad:

```
┌───┬───┬───┐
│ Q │ W │ E │   top-left │ top │ top-right
├───┼───┼───┤
│ A │ S │ D │   left  │maximize│ right
├───┼───┼───┤
│ Z │ X │ C │   bot-left │ bot │ bot-right
└───┴───┴───┘
 Tab = center     Space = next monitor
```

### CapsLock + Key — Relative Snapping

Hold `CapsLock`, then press:

| Key | Action |
|-----|--------|
| `Tab` | Center half *(orientation-aware)* |
| `Space` | Move to next monitor |
| `S` | Maximize window |
| `A` | Left half |
| `D` | Right half |
| `W` | Top half |
| `X` | Bottom half |
| `Q` | Top-left quarter |
| `E` | Top-right quarter |
| `Z` | Bottom-left quarter |
| `C` | Bottom-right quarter |

### Shift + CapsLock + Key — Absolute Half/Quarter Snapping

Hold `Shift`, hold `CapsLock`, then press a letter key.

| Key | Action |
|-----|--------|
| `Tab` | Alternate center half *(perpendicular axis)* |
| `S` | Bottom half of monitor |
| `A` | Left half of monitor |
| `D` | Right half of monitor |
| `W` | Top half of monitor |
| `Q` | Top-left quarter of monitor |
| `E` | Top-right quarter of monitor |
| `Z` | Bottom-left quarter of monitor |
| `C` | Bottom-right quarter of monitor |

### Ctrl + CapsLock + Key — Absolute 3/4 Snapping

Hold `Ctrl`, hold `CapsLock`, then press a letter key.

| Key | Action |
|-----|--------|
| `A` | Left 3/4 of monitor |
| `D` | Right 3/4 of monitor |
| `W` | Top 3/4 of monitor |
| `X` | Bottom 3/4 of monitor |

---

## Quick Reference

| Chord | Modifier | System | Result |
|-------|----------|--------|--------|
| `0 + dir` | — | Numpad0 | Relative half/quarter |
| `0 + 1–9` | — | Numpad0 | Move to monitor 1–9 |
| `0 + 5` | — | Numpad0 | Center half (orientation-aware) |
| `0 + Enter` | — | Numpad0 | Next monitor |
| `0 + +` | — | Numpad0 | Maximize |
| `Shift + 0 + dir` | Shift | Numpad0 | Absolute half/quarter |
| `Shift + 0 + 5` | Shift | Numpad0 | Alternate center half |
| `Ctrl + 0 + dir` | Ctrl | Numpad0 | Absolute 3/4 |
| `. + dir` | — | NumpadDot | Relative third |
| `. + 5` | — | NumpadDot | Center third (orientation-aware) |
| `. + +` | — | NumpadDot | Maximize |
| `Shift + . + dir` | Shift | NumpadDot | Absolute third |
| `Shift + . + 5` | Shift | NumpadDot | Alternate center third |
| `Ctrl + . + dir` | Ctrl | NumpadDot | Absolute 2/3 |
| `CapsLock + key` | — | CapsLock | Relative half/quarter |
| `Shift + CapsLock + key` | Shift | CapsLock | Absolute half/quarter |
| `Ctrl + CapsLock + key` | Ctrl | CapsLock | Absolute 3/4 |
