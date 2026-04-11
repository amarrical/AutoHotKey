#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; Get the current window's area (position and size)
; If maximized, returns the full monitor dimensions
GetWindowArea(ByRef areaX, ByRef areaY, ByRef areaW, ByRef areaH)
{
    WinGetPos, winX, winY, winW, winH, A
    WinGet, state, MinMax, A
    
    if (state = 1)
    {
        GetWindowMonitor(mL, mT, mR, mB)
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
GetWindowMonitor(ByRef monLeft, ByRef monTop, ByRef monRight, ByRef monBottom)
{
    ; Use window center point for more reliable monitor detection
    WinGetPos, wX, wY, wW, wH, A
    centerX := wX + (wW // 2)
    centerY := wY + (wH // 2)
    SysGet, mCount, MonitorCount
    
    Loop, %mCount%
    {
        SysGet, m, Monitor, %A_Index%
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
    SysGet, m, Monitor, 1
    monLeft := mLeft
    monTop := mTop
    monRight := mRight
    monBottom := mBottom
}

; Restore window if maximized
RestoreIfMaximized()
{
    WinGet, state, MinMax, A
    if (state = 1)
        WinRestore, A
}

; Move window to a relative position within its current area
MoveToRelativeArea(posX, posY, sizeW, sizeH)
{
    ; Get area BEFORE restoring (so maximized windows use full monitor)
    GetWindowArea(areaX, areaY, areaW, areaH)
    RestoreIfMaximized()
    
    nX := areaX + (areaW * posX)
    nY := areaY + (areaH * posY)
    nW := areaW * sizeW
    nH := areaH * sizeH
    
    WinMove, A,, nX, nY, nW, nH
}

; Numpad0 + NumpadAdd: Maximize window
Numpad0 & NumpadAdd::
    WinMaximize, A
return

; Numpad0 + NumpadEnter: Move to next monitor
Numpad0 & NumpadEnter::
    WinGet, wasMaximized, MinMax, A
    if (wasMaximized = 1)
        WinRestore, A
    
    WinGetPos, winX, winY, winW, winH, A
    SysGet, monCount, MonitorCount
    
    ; Find current monitor
    curMon := 1
    Loop, %monCount%
    {
        SysGet, mon, Monitor, %A_Index%
        if (winX >= monLeft && winX < monRight && winY >= monTop && winY < monBottom)
        {
            curMon := A_Index
            break
        }
    }
    
    ; Get current monitor dimensions
    SysGet, curM, Monitor, %curMon%
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
    
    SysGet, nextM, Monitor, %nextMon%
    nextW := nextMRight - nextMLeft
    nextH := nextMBottom - nextMTop
    
    ; Apply relative position to next monitor
    newX := nextMLeft + (relX * nextW)
    newY := nextMTop + (relY * nextH)
    newW := relW * nextW
    newH := relH * nextH
    
    WinMove, A,, newX, newY, newW, newH
    
    if (wasMaximized = 1)
        WinMaximize, A
return

; Numpad0 + Numpad5: Center half (full height on landscape, full width on portrait)
Numpad0 & Numpad5::
    RestoreIfMaximized()
    GetWindowMonitor(monLeft, monTop, monRight, monBottom)
    
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
    
    WinMove, A,, newX, newY, newW, newH
return

; Numpad0 + Numpad4: Left half
Numpad0 & Numpad4::
    MoveToRelativeArea(0, 0, 0.5, 1)
return

; Numpad0 + Numpad6: Right half
Numpad0 & Numpad6::
    MoveToRelativeArea(0.5, 0, 0.5, 1)
return

; Numpad0 + Numpad8: Top half
Numpad0 & Numpad8::
    MoveToRelativeArea(0, 0, 1, 0.5)
return

; Numpad0 + Numpad2: Bottom half
Numpad0 & Numpad2::
    MoveToRelativeArea(0, 0.5, 1, 0.5)
return

; Numpad0 + Numpad7: Top-left quarter
Numpad0 & Numpad7::
    MoveToRelativeArea(0, 0, 0.5, 0.5)
return

; Numpad0 + Numpad9: Top-right quarter
Numpad0 & Numpad9::
    MoveToRelativeArea(0.5, 0, 0.5, 0.5)
return

; Numpad0 + Numpad1: Bottom-left quarter
Numpad0 & Numpad1::
    MoveToRelativeArea(0, 0.5, 0.5, 0.5)
return

; Numpad0 + Numpad3: Bottom-right quarter
Numpad0 & Numpad3::
    MoveToRelativeArea(0.5, 0.5, 0.5, 0.5)
return

; =============================================================================
; CapsLock-based hotkeys (for keyboards without numpad)
; Layout: qwe=789, asd=456, zxc=123, tab=+, space=enter
; =============================================================================

; CapsLock + Tab: Center half (5)
CapsLock & Tab::
    RestoreIfMaximized()
    GetWindowMonitor(monLeft, monTop, monRight, monBottom)
    
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
    
    WinMove, A,, newX, newY, newW, newH
return

; CapsLock + Space: Move to next monitor
CapsLock & Space::
    WinGet, wasMaximized, MinMax, A
    if (wasMaximized = 1)
        WinRestore, A
    
    WinGetPos, winX, winY, winW, winH, A
    SysGet, monCount, MonitorCount
    
    ; Find current monitor using center point
    centerX := winX + (winW // 2)
    centerY := winY + (winH // 2)
    curMon := 1
    Loop, %monCount%
    {
        SysGet, mon, Monitor, %A_Index%
        if (centerX >= monLeft && centerX < monRight && centerY >= monTop && centerY < monBottom)
        {
            curMon := A_Index
            break
        }
    }
    
    ; Get current monitor dimensions
    SysGet, curM, Monitor, %curMon%
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
    
    SysGet, nextM, Monitor, %nextMon%
    nextW := nextMRight - nextMLeft
    nextH := nextMBottom - nextMTop
    
    ; Apply relative position to next monitor
    newX := nextMLeft + (relX * nextW)
    newY := nextMTop + (relY * nextH)
    newW := relW * nextW
    newH := relH * nextH
    
    WinMove, A,, newX, newY, newW, newH
    
    if (wasMaximized = 1)
        WinMaximize, A
return

; CapsLock + S: Maximize window (+)
CapsLock & s::
    WinMaximize, A
return

; CapsLock + A: Left half (4)
CapsLock & a::
    MoveToRelativeArea(0, 0, 0.5, 1)
return

; CapsLock + D: Right half (6)
CapsLock & d::
    MoveToRelativeArea(0.5, 0, 0.5, 1)
return

; CapsLock + W: Top half (8)
CapsLock & w::
    MoveToRelativeArea(0, 0, 1, 0.5)
return

; CapsLock + X: Bottom half (2)
CapsLock & x::
    MoveToRelativeArea(0, 0.5, 1, 0.5)
return

; CapsLock + Q: Top-left quarter (7)
CapsLock & q::
    MoveToRelativeArea(0, 0, 0.5, 0.5)
return

; CapsLock + E: Top-right quarter (9)
CapsLock & e::
    MoveToRelativeArea(0.5, 0, 0.5, 0.5)
return

; CapsLock + Z: Bottom-left quarter (1)
CapsLock & z::
    MoveToRelativeArea(0, 0.5, 0.5, 0.5)
return

; CapsLock + C: Bottom-right quarter (3)
CapsLock & c::
    MoveToRelativeArea(0.5, 0.5, 0.5, 0.5)
return

; =============================================================================
; Thirds mode: Numpad0 + NumpadDot as chord, then 5/8/4/6/2 for thirds
; =============================================================================

; Helper function for moving to thirds
MoveToThird(posX, posY, sizeW, sizeH)
{
    GetWindowArea(areaX, areaY, areaW, areaH)
    RestoreIfMaximized()
    
    nX := areaX + (areaW * posX)
    nY := areaY + (areaH * posY)
    nW := areaW * sizeW
    nH := areaH * sizeH
    
    WinMove, A,, nX, nY, nW, nH
}

; Center third function (for monitor)
MoveToCenterThird()
{
    RestoreIfMaximized()
    GetWindowMonitor(monLeft, monTop, monRight, monBottom)
    
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
    
    WinMove, A,, newX, newY, newW, newH
}

; NumpadDot + Numpad5: Center third
NumpadDot & Numpad5::
    MoveToCenterThird()
return

; NumpadDot + Numpad4: Left third
NumpadDot & Numpad4::
    MoveToThird(0, 0, 0.333333, 1)
return

; NumpadDot + Numpad6: Right third
NumpadDot & Numpad6::
    MoveToThird(0.666667, 0, 0.333333, 1)
return

; NumpadDot + Numpad8: Top third
NumpadDot & Numpad8::
    MoveToThird(0, 0, 1, 0.333333)
return

; NumpadDot + Numpad2: Bottom third
NumpadDot & Numpad2::
    MoveToThird(0, 0.666667, 1, 0.333333)
return