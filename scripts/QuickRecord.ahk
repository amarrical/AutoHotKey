#Requires AutoHotkey v2.0

SendMode("Input")
SetWorkingDir(A_ScriptDir)

; Global state - F24
mode := "Idle"
events := []
startTick := 0
stopTick := 0

; Global state - F23
mode23 := "Idle"
events23 := []
startTick23 := 0
stopTick23 := 0

; Shared state
isReplaying := false

; Key list for capture (~110 keys)
KeyList := [
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
    "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "F13", "F14", "F15", "F16", "F17", "F18", "F19", "F20", "F21", "F22", "F23", "F24",
    "LShift", "RShift", "LCtrl", "RCtrl", "LAlt", "RAlt", "LWin", "RWin",
    "Space", "Tab", "Enter", "Backspace", "Esc", "CapsLock",
    "Up", "Down", "Left", "Right",
    "Home", "End", "PgUp", "PgDn", "Insert", "Delete",
    "Numpad0", "Numpad1", "Numpad2", "Numpad3", "Numpad4", "Numpad5", "Numpad6", "Numpad7", "Numpad8", "Numpad9",
    "NumpadDot", "NumpadDiv", "NumpadMult", "NumpadSub", "NumpadAdd", "NumpadEnter",
    ";", "'", ",", ".", "/", "[", "]", "\", "=", "-", "``"
]

; Register hotkeys at startup
for key in KeyList {
    Hotkey("~*" key, RecordDown, "On")
    Hotkey("~*" key " Up", RecordUp, "On")
}

; Tray menu
A_TrayMenu.Add("Status", TrayStatus)
A_TrayMenu.Add("Clear", TrayClear)
A_TrayMenu.Add()
A_TrayMenu.Add("Exit", TrayExit)

; Load last recording at startup
LoadBuffer()

; Tray tooltip updater
SetTimer(UpdateTrayTooltip, 1000)

; Hotkeys
+F24::ToggleRecord()
F24::Replay()
^F24::ReloadBuffer24()
!F24::StripWaits24()
+F23::ToggleRecord23()
F23::Replay23()
^F23::ReloadBuffer23()
!F23::StripWaits23()

; ============================================================================
; STATE MANAGEMENT
; ============================================================================

ToggleRecord() {
    global mode, events, startTick, stopTick
    
    if (mode = "Idle") {
        mode := "Recording"
        events := []
        startTick := A_TickCount
    } else if (mode = "Recording") {
        stopTick := A_TickCount
        mode := "Idle"
        TrimLeadingArtifacts()
        TrimTailArtifacts()
        SaveBuffer()
    }
}

ToggleRecord23() {
    global mode23, events23, startTick23, stopTick23
    
    if (mode23 = "Idle") {
        mode23 := "Recording"
        events23 := []
        startTick23 := A_TickCount
    } else if (mode23 = "Recording") {
        stopTick23 := A_TickCount
        mode23 := "Idle"
        TrimLeadingArtifacts23()
        TrimTailArtifacts23()
        SaveBuffer23()
    }
}

; ============================================================================
; EVENT CAPTURE
; ============================================================================

RecordDown(name) {
    global mode, events, mode23, events23, isReplaying
    
    if (isReplaying)
        return
    
    key := StrReplace(name, "~*", "")
    
    if (mode = "Recording")
        events.Push({kind: "down", key: key, tick: A_TickCount})
    else if (mode23 = "Recording")
        events23.Push({kind: "down", key: key, tick: A_TickCount})
}

RecordUp(name) {
    global mode, events, mode23, events23, isReplaying
    
    if (isReplaying)
        return
    
    key := StrReplace(name, "~*", "")
    key := StrReplace(key, " Up", "")
    
    if (mode = "Recording")
        events.Push({kind: "up", key: key, tick: A_TickCount})
    else if (mode23 = "Recording")
        events23.Push({kind: "up", key: key, tick: A_TickCount})
}

TrimLeadingArtifacts() {
    global events
    
    if (events.Length = 0)
        return
    
    if (events[1].kind = "up" && events[1].key = "F24")
        events.RemoveAt(1)
    
    if (events.Length > 0 && events[1].kind = "up" && (events[1].key = "LShift" || events[1].key = "RShift"))
        events.RemoveAt(1)
}

TrimTailArtifacts() {
    global events
    
    if (events.Length = 0)
        return
    
    if (events[events.Length].kind = "down" && (events[events.Length].key = "LShift" || events[events.Length].key = "RShift"))
        events.Pop()
}

TrimLeadingArtifacts23() {
    global events23
    
    if (events23.Length = 0)
        return
    
    if (events23[1].kind = "up" && events23[1].key = "F23")
        events23.RemoveAt(1)
    
    if (events23.Length > 0 && events23[1].kind = "up" && (events23[1].key = "LShift" || events23[1].key = "RShift"))
        events23.RemoveAt(1)
}

TrimTailArtifacts23() {
    global events23
    
    if (events23.Length = 0)
        return
    
    if (events23[events23.Length].kind = "down" && (events23[events23.Length].key = "LShift" || events23[events23.Length].key = "RShift"))
        events23.Pop()
}

; ============================================================================
; PLAYBACK
; ============================================================================

Replay() {
    global mode, events, isReplaying, KeyList
    
    if (mode != "Idle" || isReplaying)
        return
    
    if (events.Length = 0) {
        TrayTip("QuickRecord", "No recording available", 2)
        return
    }
    
    isReplaying := true
    
    try {
        prevTick := events[1].tick
        
        for event in events {
            delta := event.tick - prevTick
            delta := Min(delta, 5000)
            
            if (delta > 0)
                Sleep(delta)
            
            if (event.kind = "down")
                SendEvent("{" event.key " Down}")
            else
                SendEvent("{" event.key " Up}")
            
            prevTick := event.tick
        }
    } finally {
        isReplaying := false
    }
}

Replay23() {
    global mode23, events23, isReplaying, KeyList
    
    if (mode23 != "Idle" || isReplaying)
        return
    
    if (events23.Length = 0) {
        TrayTip("QuickRecord", "No recording available", 2)
        return
    }
    
    isReplaying := true
    
    try {
        prevTick := events23[1].tick
        
        for event in events23 {
            delta := event.tick - prevTick
            delta := Min(delta, 5000)
            
            if (delta > 0)
                Sleep(delta)
            
            if (event.kind = "down")
                SendEvent("{" event.key " Down}")
            else
                SendEvent("{" event.key " Up}")
            
            prevTick := event.tick
        }
    } finally {
        isReplaying := false
    }
}

; ============================================================================
; PERSISTENCE
; ============================================================================

SaveBuffer() {
    global events, startTick
    
    filePath := A_ScriptDir "\QR.F24.txt"
    
    if (events.Length = 0) {
        if (FileExist(filePath))
            FileDelete(filePath)
        return
    }
    
    content := ""
    prevTick := events[1].tick
    
    for event in events {
        delta := event.tick - prevTick
        content .= event.kind "`t" event.key "`t" delta "`n"
        prevTick := event.tick
    }
    
    try {
        if (FileExist(filePath))
            FileDelete(filePath)
        FileAppend(content, filePath)
    } catch as err {
        TrayTip("QuickRecord", "Error saving recording: " err.Message, 2)
    }
}

SaveBuffer23() {
    global events23, startTick23
    
    filePath := A_ScriptDir "\QR.F23.txt"
    
    if (events23.Length = 0) {
        if (FileExist(filePath))
            FileDelete(filePath)
        return
    }
    
    content := ""
    prevTick := events23[1].tick
    
    for event in events23 {
        delta := event.tick - prevTick
        content .= event.kind "`t" event.key "`t" delta "`n"
        prevTick := event.tick
    }
    
    try {
        if (FileExist(filePath))
            FileDelete(filePath)
        FileAppend(content, filePath)
    } catch as err {
        TrayTip("QuickRecord", "Error saving recording: " err.Message, 2)
    }
}

LoadBuffer() {
    LoadBufferFromFile24()
    LoadBufferFromFile23()
}

LoadBufferFromFile24() {
    global events, startTick
    
    filePath := A_ScriptDir "\QR.F24.txt"
    
    if (!FileExist(filePath))
        return
    
    try {
        content := FileRead(filePath)
        lines := StrSplit(content, "`n")
        events := []
        currentTick := A_TickCount
        
        for line in lines {
            if (line = "")
                continue
            
            parts := StrSplit(line, "`t")
            if (parts.Length < 3) {
                TrayTip("QuickRecord", "Warning: Corrupt recording file, starting fresh", 3)
                events := []
                return
            }
            
            kind := parts[1]
            key := parts[2]
            delta := Integer(parts[3])
            
            if (kind != "down" && kind != "up") {
                TrayTip("QuickRecord", "Warning: Corrupt recording file, starting fresh", 3)
                events := []
                return
            }
            
            currentTick += delta
            events.Push({kind: kind, key: key, tick: currentTick})
        }
    } catch as err {
        TrayTip("QuickRecord", "Error loading recording: " err.Message, 3)
        events := []
    }
}

LoadBufferFromFile23() {
    global events23, startTick23
    
    filePath := A_ScriptDir "\QR.F23.txt"
    
    if (!FileExist(filePath))
        return
    
    try {
        content := FileRead(filePath)
        lines := StrSplit(content, "`n")
        events23 := []
        currentTick := A_TickCount
        
        for line in lines {
            if (line = "")
                continue
            
            parts := StrSplit(line, "`t")
            if (parts.Length < 3) {
                TrayTip("QuickRecord", "Warning: Corrupt F23 recording file, starting fresh", 3)
                events23 := []
                return
            }
            
            kind := parts[1]
            key := parts[2]
            delta := Integer(parts[3])
            
            if (kind != "down" && kind != "up") {
                TrayTip("QuickRecord", "Warning: Corrupt F23 recording file, starting fresh", 3)
                events23 := []
                return
            }
            
            currentTick += delta
            events23.Push({kind: kind, key: key, tick: currentTick})
        }
    } catch as err {
        TrayTip("QuickRecord", "Error loading F23 recording: " err.Message, 3)
        events23 := []
    }
}

ReloadBuffer24() {
    global mode
    
    if (mode != "Idle") {
        TrayTip("QuickRecord", "Cannot reload while recording", 2)
        return
    }
    
    try {
        LoadBufferFromFile24()
        TrayTip("QuickRecord", "F24 recording reloaded", 2)
    } catch as err {
        TrayTip("QuickRecord", "Error reloading F24 recording: " err.Message, 3)
    }
}

ReloadBuffer23() {
    global mode23
    
    if (mode23 != "Idle") {
        TrayTip("QuickRecord", "Cannot reload while recording", 2)
        return
    }
    
    try {
        LoadBufferFromFile23()
        TrayTip("QuickRecord", "F23 recording reloaded", 2)
    } catch as err {
        TrayTip("QuickRecord", "Error reloading F23 recording: " err.Message, 3)
    }
}

StripWaits24() {
    global mode, events
    
    if (mode != "Idle") {
        TrayTip("QuickRecord", "Cannot strip waits while recording", 2)
        return
    }
    
    if (events.Length = 0) {
        TrayTip("QuickRecord", "No F24 recording to strip", 2)
        return
    }
    
    for event in events {
        event.tick := 0
    }
    
    filePath := A_ScriptDir "\QR.F24.txt"
    content := ""
    
    for event in events {
        content .= event.kind "`t" event.key "`t0`n"
    }
    
    try {
        if (FileExist(filePath))
            FileDelete(filePath)
        FileAppend(content, filePath)
        TrayTip("QuickRecord", "F24 waits stripped (" events.Length " events)", 2)
    } catch as err {
        TrayTip("QuickRecord", "Error stripping F24 waits: " err.Message, 2)
    }
}

StripWaits23() {
    global mode23, events23
    
    if (mode23 != "Idle") {
        TrayTip("QuickRecord", "Cannot strip waits while recording", 2)
        return
    }
    
    if (events23.Length = 0) {
        TrayTip("QuickRecord", "No F23 recording to strip", 2)
        return
    }
    
    for event in events23 {
        event.tick := 0
    }
    
    filePath := A_ScriptDir "\QR.F23.txt"
    content := ""
    
    for event in events23 {
        content .= event.kind "`t" event.key "`t0`n"
    }
    
    try {
        if (FileExist(filePath))
            FileDelete(filePath)
        FileAppend(content, filePath)
        TrayTip("QuickRecord", "F23 waits stripped (" events23.Length " events)", 2)
    } catch as err {
        TrayTip("QuickRecord", "Error stripping F23 waits: " err.Message, 2)
    }
}

ClearRecording() {
    global events, mode, events23, mode23
    
    if (mode != "Idle" || mode23 != "Idle")
        return
    
    events := []
    events23 := []
    
    filePath24 := A_ScriptDir "\QR.F24.txt"
    filePath23 := A_ScriptDir "\QR.F23.txt"
    
    if (FileExist(filePath24))
        FileDelete(filePath24)
    if (FileExist(filePath23))
        FileDelete(filePath23)
    
    TrayTip("QuickRecord", "Recording cleared", 2)
}

; ============================================================================
; TRAY FEEDBACK
; ============================================================================

UpdateTrayTooltip() {
    global mode, events, startTick, mode23, events23, startTick23
    
    if (mode = "Recording") {
        elapsed := (A_TickCount - startTick) // 1000
        eventCount := events.Length
        A_IconTip := "QuickRecord - Recording F24 (" eventCount " events, " elapsed "s)"
    } else if (mode23 = "Recording") {
        elapsed := (A_TickCount - startTick23) // 1000
        eventCount := events23.Length
        A_IconTip := "QuickRecord - Recording F23 (" eventCount " events, " elapsed "s)"
    } else {
        A_IconTip := "QuickRecord - Idle"
    }
}

TrayStatus(ItemName, ItemID, MyMenu) {
    global mode, events, mode23, events23
    
    if (mode = "Idle" && mode23 = "Idle") {
        msg := "Status: Idle`nF24 events: " events.Length "`nF23 events: " events23.Length
    } else if (mode = "Recording") {
        msg := "Status: Recording F24`nRecorded events: " events.Length
    } else if (mode23 = "Recording") {
        msg := "Status: Recording F23`nRecorded events: " events23.Length
    } else {
        msg := "Status: Unknown"
    }
    
    MsgBox(msg, "QuickRecord Status")
}

TrayClear(ItemName, ItemID, MyMenu) {
    ClearRecording()
}

TrayExit(ItemName, ItemID, MyMenu) {
    ExitApp()
}
