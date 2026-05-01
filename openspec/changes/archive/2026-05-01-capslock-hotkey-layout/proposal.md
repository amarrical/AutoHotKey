## Why

Not all keyboards have a numpad, particularly laptops and compact keyboards. Users with these keyboards need access to the same window management features as numpad users. A CapsLock-based layout provides an intuitive alternative that mirrors the numpad layout on the QWERTY home row.

## What Changes

- CapsLock + Q snaps window to top-left quarter
- CapsLock + W snaps window to top half
- CapsLock + E snaps window to top-right quarter
- CapsLock + A snaps window to left half
- CapsLock + S maximizes window
- CapsLock + D snaps window to right half
- CapsLock + Z snaps window to bottom-left quarter
- CapsLock + X snaps window to bottom half
- CapsLock + C snaps window to bottom-right quarter
- CapsLock + Tab snaps window to center half (orientation-aware)
- CapsLock + Space moves window to next monitor (with center-point monitor detection and maximized state preservation)

## Capabilities

### New Capabilities

- `capslock-hotkey-layout`: CapsLock-based window management hotkeys for keyboards without numpad, mirroring the numpad layout on the home row

### Modified Capabilities

<!-- No existing capabilities modified -->

## Impact

- AutoHotkey script (scripts/WindowPadPlus.ahk)
- Provides alternative to numpad-based hotkeys
- Requires AutoHotkey v2.0+
- Improves accessibility for laptop and compact keyboard users
