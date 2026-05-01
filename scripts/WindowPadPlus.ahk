#Requires AutoHotkey v2.0

SendMode("Input")
SetWorkingDir(A_ScriptDir)

; Allow Numpad0 to type 0 when pressed alone (not as a modifier)
; Uses Key Up to only fire if no chord was activated
Numpad0 Up::
{
    if (A_PriorKey = "Numpad0")
        Send("0")
}
NumpadIns Up::
{
    if (A_PriorKey = "NumpadIns")
        Send("0")
}

; Allow NumpadDot to type . when pressed alone (not as a modifier)
NumpadDot Up::
{
    if (A_PriorKey = "NumpadDot")
        Send(".")
}
NumpadDel Up::
{
    if (A_PriorKey = "NumpadDel")
        Send(".")
}

; Get the current window's area (position and size)
; If maximized, returns the full monitor dimensions
GetWindowArea(&areaX, &areaY, &areaW, &areaH)
{
    WinGetPos(&winX, &winY, &winW, &winH, "A")
    state := WinGetMinMax("A")
    
    if (state = 1)
    {
        GetWindowMonitor(&mL, &mT, &mR, &mB)
        areaX := mL
        areaY := mT
        areaW := mR - mL
        areaH := mB - mT
    }
    else
    {
        areaX := winX
        areaY := winY
        areaW := winW
        areaH := winH
    }
}

; Get the monitor bounds for the active window
GetWindowMonitor(&monLeft, &monTop, &monRight, &monBottom)
{
    ; Use window center point for more reliable monitor detection
    WinGetPos(&wX, &wY, &wW, &wH, "A")
    centerX := wX + (wW // 2)
    centerY := wY + (wH // 2)
    mCount := MonitorGetCount()
    
    Loop mCount
    {
        MonitorGet(A_Index, &mLeft, &mTop, &mRight, &mBottom)
        if (centerX >= mLeft && centerX < mRight && centerY >= mTop && centerY < mBottom)
        {
            monLeft := mLeft
            monTop := mTop
            monRight := mRight
            monBottom := mBottom
            return
        }
    }
    
    ; Default to primary monitor
    MonitorGet(1, &mLeft, &mTop, &mRight, &mBottom)
    monLeft := mLeft
    monTop := mTop
    monRight := mRight
    monBottom := mBottom
}

; Restore window if maximized
RestoreIfMaximized()
{
    state := WinGetMinMax("A")
    if (state = 1)
        WinRestore("A")
}

; Move window to a relative position within its current area
MoveToRelativeArea(posX, posY, sizeW, sizeH)
{
    ; Get area BEFORE restoring (so maximized windows use full monitor)
    GetWindowArea(&areaX, &areaY, &areaW, &areaH)
    RestoreIfMaximized()
    
    nX := areaX + (areaW * posX)
    nY := areaY + (areaH * posY)
    nW := areaW * sizeW
    nH := areaH * sizeH
    
    WinMove(nX, nY, nW, nH, "A")
}

; Move window to an absolute position on the monitor
MoveToAbsoluteArea(posX, posY, sizeW, sizeH)
{
    RestoreIfMaximized()
    GetWindowMonitor(&monLeft, &monTop, &monRight, &monBottom)
    
    monW := monRight - monLeft
    monH := monBottom - monTop
    
    nX := monLeft + (monW * posX)
    nY := monTop + (monH * posY)
    nW := monW * sizeW
    nH := monH * sizeH
    
    WinMove(nX, nY, nW, nH, "A")
}

; Numpad0 + NumpadAdd: Maximize window
Numpad0 & NumpadAdd::WinMaximize("A")

; Numpad0 + NumpadEnter: Move to next monitor
Numpad0 & NumpadEnter::
{
    wasMaximized := WinGetMinMax("A")
    if (wasMaximized = 1)
        WinRestore("A")
    
    WinGetPos(&winX, &winY, &winW, &winH, "A")
    monCount := MonitorGetCount()
    
    ; Find current monitor
    curMon := 1
    Loop monCount
    {
        MonitorGet(A_Index, &monLeft, &monTop, &monRight, &monBottom)
        if (winX >= monLeft && winX < monRight && winY >= monTop && winY < monBottom)
        {
            curMon := A_Index
            break
        }
    }
    
    ; Get current monitor dimensions
    MonitorGet(curMon, &curMLeft, &curMTop, &curMRight, &curMBottom)
    curW := curMRight - curMLeft
    curH := curMBottom - curMTop
    
    ; Calculate relative position and size
    relX := (winX - curMLeft) / curW
    relY := (winY - curMTop) / curH
    relW := winW / curW
    relH := winH / curH
    
    ; Get next monitor (wrap around)
    nextMon := curMon + 1
    if (nextMon > monCount)
        nextMon := 1
    
    MonitorGet(nextMon, &nextMLeft, &nextMTop, &nextMRight, &nextMBottom)
    nextW := nextMRight - nextMLeft
    nextH := nextMBottom - nextMTop
    
    ; Apply relative position to next monitor
    newX := nextMLeft + (relX * nextW)
    newY := nextMTop + (relY * nextH)
    newW := relW * nextW
    newH := relH * nextH
    
    WinMove(newX, newY, newW, newH, "A")
    
    if (wasMaximized = 1)
        WinMaximize("A")
}

; Numpad0 + Numpad5: Center half (full height on landscape, full width on portrait)
Numpad0 & Numpad5::
{
    RestoreIfMaximized()
    GetWindowMonitor(&monLeft, &monTop, &monRight, &monBottom)
    
    monW := monRight - monLeft
    monH := monBottom - monTop
    
    if (monW >= monH)
    {
        ; Landscape: half width, full height, centered
        newX := monLeft + (monW // 4)
        newY := monTop
        newW := monW // 2
        newH := monH
    }
    else
    {
        ; Portrait: full width, half height, centered
        newX := monLeft
        newY := monTop + (monH // 4)
        newW := monW
        newH := monH // 2
    }
    
    WinMove(newX, newY, newW, newH, "A")
}

; Numpad0 + Numpad4: Left half
Numpad0 & Numpad4::MoveToRelativeArea(0, 0, 0.5, 1)

; Numpad0 + Numpad6: Right half
Numpad0 & Numpad6::MoveToRelativeArea(0.5, 0, 0.5, 1)

; Numpad0 + Numpad8: Top half
Numpad0 & Numpad8::MoveToRelativeArea(0, 0, 1, 0.5)

; Numpad0 + Numpad2: Bottom half
Numpad0 & Numpad2::MoveToRelativeArea(0, 0.5, 1, 0.5)

; Numpad0 + Numpad7: Top-left quarter
Numpad0 & Numpad7::MoveToRelativeArea(0, 0, 0.5, 0.5)

; Numpad0 + Numpad9: Top-right quarter
Numpad0 & Numpad9::MoveToRelativeArea(0.5, 0, 0.5, 0.5)

; Numpad0 + Numpad1: Bottom-left quarter
Numpad0 & Numpad1::MoveToRelativeArea(0, 0.5, 0.5, 0.5)

; Numpad0 + Numpad3: Bottom-right quarter
Numpad0 & Numpad3::MoveToRelativeArea(0.5, 0.5, 0.5, 0.5)

; =============================================================================
; Shift+Numpad0-based hotkeys (absolute positioning)
; When Shift is held with NumLock ON, Windows transforms the numpad keys:
;   Numpad0 -> NumpadIns, Numpad4 -> NumpadLeft, Numpad6 -> NumpadRight, etc.
; =============================================================================

#HotIf GetKeyState("Shift", "P")
; Shift pressed first: Numpad0 -> NumpadIns, direction keys -> nav keys
NumpadIns & NumpadLeft::MoveToAbsoluteArea(0, 0, 0.5, 1)
NumpadIns & NumpadRight::MoveToAbsoluteArea(0.5, 0, 0.5, 1)
NumpadIns & NumpadUp::MoveToAbsoluteArea(0, 0, 1, 0.5)
NumpadIns & NumpadDown::MoveToAbsoluteArea(0, 0.5, 1, 0.5)
NumpadIns & NumpadHome::MoveToAbsoluteArea(0, 0, 0.5, 0.5)
NumpadIns & NumpadPgUp::MoveToAbsoluteArea(0.5, 0, 0.5, 0.5)
NumpadIns & NumpadEnd::MoveToAbsoluteArea(0, 0.5, 0.5, 0.5)
NumpadIns & NumpadPgDn::MoveToAbsoluteArea(0.5, 0.5, 0.5, 0.5)
; Numpad0 pressed first: Numpad0 stays as Numpad0, direction keys -> nav keys
Numpad0 & NumpadLeft::MoveToAbsoluteArea(0, 0, 0.5, 1)
Numpad0 & NumpadRight::MoveToAbsoluteArea(0.5, 0, 0.5, 1)
Numpad0 & NumpadUp::MoveToAbsoluteArea(0, 0, 1, 0.5)
Numpad0 & NumpadDown::MoveToAbsoluteArea(0, 0.5, 1, 0.5)
Numpad0 & NumpadHome::MoveToAbsoluteArea(0, 0, 0.5, 0.5)
Numpad0 & NumpadPgUp::MoveToAbsoluteArea(0.5, 0, 0.5, 0.5)
Numpad0 & NumpadEnd::MoveToAbsoluteArea(0, 0.5, 0.5, 0.5)
Numpad0 & NumpadPgDn::MoveToAbsoluteArea(0.5, 0.5, 0.5, 0.5)
#HotIf

; =============================================================================
; CapsLock-based hotkeys (for keyboards without numpad)
; Layout: qwe=789, asd=456, zxc=123, tab=+, space=enter
; =============================================================================

; CapsLock + Tab: Center half (5)
CapsLock & Tab::
{
    RestoreIfMaximized()
    GetWindowMonitor(&monLeft, &monTop, &monRight, &monBottom)
    
    monW := monRight - monLeft
    monH := monBottom - monTop
    
    if (monW >= monH)
    {
        ; Landscape: half width, full height, centered
        newX := monLeft + (monW // 4)
        newY := monTop
        newW := monW // 2
        newH := monH
    }
    else
    {
        ; Portrait: full width, half height, centered
        newX := monLeft
        newY := monTop + (monH // 4)
        newW := monW
        newH := monH // 2
    }
    
    WinMove(newX, newY, newW, newH, "A")
}

; CapsLock + Space: Move to next monitor
CapsLock & Space::
{
    wasMaximized := WinGetMinMax("A")
    if (wasMaximized = 1)
        WinRestore("A")
    
    WinGetPos(&winX, &winY, &winW, &winH, "A")
    monCount := MonitorGetCount()
    
    ; Find current monitor using center point
    centerX := winX + (winW // 2)
    centerY := winY + (winH // 2)
    curMon := 1
    Loop monCount
    {
        MonitorGet(A_Index, &monLeft, &monTop, &monRight, &monBottom)
        if (centerX >= monLeft && centerX < monRight && centerY >= monTop && centerY < monBottom)
        {
            curMon := A_Index
            break
        }
    }
    
    ; Get current monitor dimensions
    MonitorGet(curMon, &curMLeft, &curMTop, &curMRight, &curMBottom)
    curW := curMRight - curMLeft
    curH := curMBottom - curMTop
    
    ; Calculate relative position and size
    relX := (winX - curMLeft) / curW
    relY := (winY - curMTop) / curH
    relW := winW / curW
    relH := winH / curH
    
    ; Get next monitor (wrap around)
    nextMon := curMon + 1
    if (nextMon > monCount)
        nextMon := 1
    
    MonitorGet(nextMon, &nextMLeft, &nextMTop, &nextMRight, &nextMBottom)
    nextW := nextMRight - nextMLeft
    nextH := nextMBottom - nextMTop
    
    ; Apply relative position to next monitor
    newX := nextMLeft + (relX * nextW)
    newY := nextMTop + (relY * nextH)
    newW := relW * nextW
    newH := relH * nextH
    
    WinMove(newX, newY, newW, newH, "A")
    
    if (wasMaximized = 1)
        WinMaximize("A")
}

; CapsLock + S: Maximize window (+) or Shift+CapsLock+S: Bottom half (absolute)
CapsLock & s::
{
    if (GetKeyState("Shift", "P"))
        MoveToAbsoluteArea(0, 0.5, 1, 0.5)
    else
        WinMaximize("A")
}

; CapsLock + A: Left half (4) or Shift+CapsLock+A: Left half (absolute)
CapsLock & a::
{
    if (GetKeyState("Shift", "P"))
        MoveToAbsoluteArea(0, 0, 0.5, 1)
    else
        MoveToRelativeArea(0, 0, 0.5, 1)
}

; CapsLock + D: Right half (6) or Shift+CapsLock+D: Right half (absolute)
CapsLock & d::
{
    if (GetKeyState("Shift", "P"))
        MoveToAbsoluteArea(0.5, 0, 0.5, 1)
    else
        MoveToRelativeArea(0.5, 0, 0.5, 1)
}

; CapsLock + W: Top half (8) or Shift+CapsLock+W: Top half (absolute)
CapsLock & w::
{
    if (GetKeyState("Shift", "P"))
        MoveToAbsoluteArea(0, 0, 1, 0.5)
    else
        MoveToRelativeArea(0, 0, 1, 0.5)
}

; CapsLock + X: Bottom half (2)
CapsLock & x::MoveToRelativeArea(0, 0.5, 1, 0.5)

; CapsLock + Q: Top-left quarter (7) or Shift+CapsLock+Q: Top-left quarter (absolute)
CapsLock & q::
{
    if (GetKeyState("Shift", "P"))
        MoveToAbsoluteArea(0, 0, 0.5, 0.5)
    else
        MoveToRelativeArea(0, 0, 0.5, 0.5)
}

; CapsLock + E: Top-right quarter (9) or Shift+CapsLock+E: Top-right quarter (absolute)
CapsLock & e::
{
    if (GetKeyState("Shift", "P"))
        MoveToAbsoluteArea(0.5, 0, 0.5, 0.5)
    else
        MoveToRelativeArea(0.5, 0, 0.5, 0.5)
}

; CapsLock + Z: Bottom-left quarter (1) or Shift+CapsLock+Z: Bottom-left quarter (absolute)
CapsLock & z::
{
    if (GetKeyState("Shift", "P"))
        MoveToAbsoluteArea(0, 0.5, 0.5, 0.5)
    else
        MoveToRelativeArea(0, 0.5, 0.5, 0.5)
}

; CapsLock + C: Bottom-right quarter (3) or Shift+CapsLock+C: Bottom-right quarter (absolute)
CapsLock & c::
{
    if (GetKeyState("Shift", "P"))
        MoveToAbsoluteArea(0.5, 0.5, 0.5, 0.5)
    else
        MoveToRelativeArea(0.5, 0.5, 0.5, 0.5)
}

; =============================================================================
; Thirds mode: Numpad0 + NumpadDot as chord, then 5/8/4/6/2 for thirds
; =============================================================================

; Helper function for moving to thirds
MoveToThird(posX, posY, sizeW, sizeH)
{
    GetWindowArea(&areaX, &areaY, &areaW, &areaH)
    RestoreIfMaximized()
    
    nX := areaX + (areaW * posX)
    nY := areaY + (areaH * posY)
    nW := areaW * sizeW
    nH := areaH * sizeH
    
    WinMove(nX, nY, nW, nH, "A")
}

; Center third function (for monitor)
MoveToCenterThird()
{
    RestoreIfMaximized()
    GetWindowMonitor(&monLeft, &monTop, &monRight, &monBottom)
    
    monW := monRight - monLeft
    monH := monBottom - monTop
    
    if (monW >= monH)
    {
        ; Landscape: third width, full height, centered
        newX := monLeft + (monW // 3)
        newY := monTop
        newW := monW // 3
        newH := monH
    }
    else
    {
        ; Portrait: full width, third height, centered
        newX := monLeft
        newY := monTop + (monH // 3)
        newW := monW
        newH := monH // 3
    }
    
    WinMove(newX, newY, newW, newH, "A")
}

; NumpadDot + Numpad5: Center third
NumpadDot & Numpad5::MoveToCenterThird()

; NumpadDot + Numpad4: Left third
NumpadDot & Numpad4::MoveToThird(0, 0, 0.333333, 1)

; NumpadDot + Numpad6: Right third
NumpadDot & Numpad6::MoveToThird(0.666667, 0, 0.333333, 1)

; NumpadDot + Numpad8: Top third
NumpadDot & Numpad8::MoveToThird(0, 0, 1, 0.333333)

; NumpadDot + Numpad2: Bottom third
NumpadDot & Numpad2::MoveToThird(0, 0.666667, 1, 0.333333)