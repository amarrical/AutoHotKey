#Requires AutoHotkey v2.0

SendMode("Input")
SetWorkingDir(A_ScriptDir)

; Global state
mode := "Idle"
events := []
startTick := 0
stopTick := 0
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

; ============================================================================
; EVENT CAPTURE
; ============================================================================

RecordDown(name) {
    global mode, events, isReplaying
    
    if (mode != "Recording" || isReplaying)
        return
    
    key := StrReplace(name, "~*", "")
    events.Push({kind: "down", key: key, tick: A_TickCount})
}

RecordUp(name) {
    global mode, events, isReplaying
    
    if (mode != "Recording" || isReplaying)
        return
    
    key := StrReplace(name, "~*", "")
    key := StrReplace(key, " Up", "")
    events.Push({kind: "up", key: key, tick: A_TickCount})
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

; ============================================================================
; PERSISTENCE
; ============================================================================

SaveBuffer() {
    global events, startTick
    
    filePath := A_ScriptDir "\QuickRecord.last.txt"
    
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

LoadBuffer() {
    global events, startTick
    
    filePath := A_ScriptDir "\QuickRecord.last.txt"
    
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

ClearRecording() {
    global events, mode
    
    if (mode != "Idle")
        return
    
    events := []
    filePath := A_ScriptDir "\QuickRecord.last.txt"
    
    if (FileExist(filePath))
        FileDelete(filePath)
    
    TrayTip("QuickRecord", "Recording cleared", 2)
}

; ============================================================================
; TRAY FEEDBACK
; ============================================================================

UpdateTrayTooltip() {
    global mode, events, startTick
    
    if (mode = "Recording") {
        elapsed := (A_TickCount - startTick) // 1000
        eventCount := events.Length
        A_IconTip := "QuickRecord - Recording (" eventCount " events, " elapsed "s)"
    } else {
        A_IconTip := "QuickRecord - Idle"
    }
}

TrayStatus(ItemName, ItemID, MyMenu) {
    global mode, events
    
    if (mode = "Idle") {
        msg := "Status: Idle`nRecorded events: " events.Length
    } else {
        msg := "Status: Recording`nRecorded events: " events.Length
    }
    
    MsgBox(msg, "QuickRecord Status")
}

TrayClear(ItemName, ItemID, MyMenu) {
    ClearRecording()
}

TrayExit(ItemName, ItemID, MyMenu) {
    ExitApp()
}
