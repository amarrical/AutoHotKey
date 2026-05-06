# QuickRecord

A lightweight macro recording and playback tool for Windows, built with AutoHotkey v2. Record keyboard sequences and replay them instantly with customizable timing — perfect for automating repetitive tasks, testing workflows, or executing complex key sequences at maximum speed.

---

## Installation

### 1. Install AutoHotkey v2

1. Go to [https://www.autohotkey.com](https://www.autohotkey.com)
2. Click **Download** and choose **AutoHotkey v2** (not v1)
3. Run the installer and follow the prompts

> **Important:** This script requires AutoHotkey **v2.0**. It will not run on v1.x.

### 2. Run the Script

1. Navigate to the `scripts/` folder
2. Double-click `QuickRecord.ahk`
3. A green AHK icon will appear in the system tray — the script is running

### 3. Run on Startup (Optional)

To have the script start automatically with Windows:

1. Press `Win + R`, type `shell:startup`, press Enter
2. Create a shortcut to `QuickRecord.ahk` in the folder that opens

### 4. Reload After Edits

After modifying the script, right-click the tray icon and choose **Reload Script**.

---

## Concepts

### Dual-Buffer System

QuickRecord maintains **two independent recording buffers** — one for F24 and one for F23. This allows you to:

- Record two different macros simultaneously
- Switch between them without losing either recording
- Execute them independently with their own hotkeys

The buffers are **completely separate**:
- Each has its own recording state (Idle or Recording)
- Each has its own storage file
- Each can be replayed, reloaded, or stripped independently

### Recording and Playback

**Recording** captures the sequence of keys you press, along with the timing between them. When you **replay**, QuickRecord executes the same key sequence with the same timing.

### Timing and Deltas

QuickRecord stores timing as **relative deltas** — the milliseconds between each key press. This allows:
- Accurate reproduction of your original timing
- Manual editing of recordings (advanced users)
- Stripping all delays for maximum-speed execution

### Shared Replay State

Both buffers share a single **replay lock**. This means:
- Only one buffer can replay at a time
- You cannot record while either buffer is replaying
- This prevents conflicts and keeps the system simple

---

## Hotkey Reference

All hotkeys use **F24** or **F23** as the base key. Modifiers change the behavior:

| Modifier | Effect |
|----------|--------|
| *(none)* | **Replay** the recording |
| **Shift** | **Toggle recording** (start/stop) |
| **Ctrl** | **Reload from file** (pick up edits) |
| **Alt** | **Strip waits** (remove all delays) |

### Recording

| Hotkey | Action |
|--------|--------|
| `Shift + F24` | Start/stop recording for F24 buffer |
| `Shift + F23` | Start/stop recording for F23 buffer |

**How it works:**
1. Press `Shift + F24` to start recording
2. Perform your key sequence
3. Press `Shift + F24` again to stop
4. The recording is automatically saved

**Tip:** The hotkey press itself is trimmed from the recording, so you won't see the Shift key in the playback.

### Playback

| Hotkey | Action |
|--------|--------|
| `F24` | Replay the F24 buffer |
| `F23` | Replay the F23 buffer |

**How it works:**
1. Press `F24` to replay the F24 recording
2. QuickRecord executes all recorded keys with original timing
3. Cannot replay while recording or while the other buffer is replaying

### Reload from File

| Hotkey | Action |
|--------|--------|
| `Ctrl + F24` | Reload F24 buffer from disk |
| `Ctrl + F23` | Reload F23 buffer from disk |

**How it works:**
1. Edit the recording file (e.g., `QuickRecord.last.F24.txt`)
2. Press `Ctrl + F24` to reload the changes
3. Press `F24` to replay the updated recording

**Use case:** Refine timing or fix mistakes by editing the file directly without re-recording.

### Strip Waits

| Hotkey | Action |
|--------|--------|
| `Alt + F24` | Remove all delays from F24 buffer |
| `Alt + F23` | Remove all delays from F23 buffer |

**How it works:**
1. Press `Alt + F24` to strip all timing delays
2. The buffer is updated and saved immediately
3. Press `F24` to replay at maximum speed (no delays between keys)

**Use case:** Execute a macro as fast as possible, ignoring original timing.

### Tray Menu

Right-click the QuickRecord icon in the system tray for:

| Option | Action |
|--------|--------|
| **Status** | Show current state and event counts |
| **Clear** | Delete all recordings and files |
| **Exit** | Close QuickRecord |

---

## Workflows

### Workflow 1: Record a Complex Sequence

**Goal:** Record a multi-step keyboard workflow and replay it.

**Steps:**

1. **Start recording:** Press `Shift + F24`
   - The tray tooltip shows "Recording F24"
   
2. **Perform your sequence:** Type or press keys as needed
   - Example: `Alt + Tab`, `Ctrl + A`, `Ctrl + C`
   
3. **Stop recording:** Press `Shift + F24` again
   - A notification shows "F24 waits stripped (N events)"
   - The recording is saved to `QuickRecord.last.F24.txt`
   
4. **Replay:** Press `F24`
   - QuickRecord executes the same key sequence with original timing
   
5. **Refine if needed:** Edit the file and press `Ctrl + F24` to reload

### Workflow 2: Refine Timing with Reload-from-File

**Goal:** Edit a recording to adjust timing without re-recording.

**Steps:**

1. **Record your sequence:** Use `Shift + F24` as above

2. **Open the file:** Navigate to `QuickRecord.last.F24.txt`
   - Format: `kind\tkey\tdelta` (tab-separated)
   - Example: `down\ta\t0` (press 'a' with no delay)
   
3. **Edit timing:** Change delta values to adjust delays
   - Increase a delta to add pause
   - Decrease to speed up
   
4. **Reload:** Press `Ctrl + F24`
   - A notification shows "F24 recording reloaded"
   
5. **Test:** Press `F24` to replay with new timing

### Workflow 3: Execute at Maximum Speed with Strip-Waits

**Goal:** Run a macro as fast as possible, ignoring original timing.

**Steps:**

1. **Record your sequence:** Use `Shift + F24`

2. **Strip all delays:** Press `Alt + F24`
   - A notification shows "F24 waits stripped (N events)"
   - All timing delays are removed
   
3. **Replay:** Press `F24`
   - QuickRecord executes keys with no delays between them
   - Useful for rapid automation or testing

### Workflow 4: Maintain Two Independent Macros

**Goal:** Record and manage two different sequences.

**Steps:**

1. **Record first macro:** Use `Shift + F24` for your first sequence

2. **Record second macro:** Use `Shift + F23` for your second sequence
   - The two recordings are completely independent
   - Each has its own file and state
   
3. **Replay either:** Press `F24` or `F23` as needed
   - They don't interfere with each other
   
4. **Manage separately:** Reload, strip, or clear each buffer independently

---

## File Format

QuickRecord stores recordings as **tab-separated text files** for easy editing and inspection.

### File Location

- **F24 buffer:** `QuickRecord.last.F24.txt`
- **F23 buffer:** `QuickRecord.last.f23.txt`

Both files are stored in the same directory as `QuickRecord.ahk`.

### File Format

Each line represents one key event:

```
kind	key	delta
down	a	0
up	a	78
down	b	0
up	b	45
```

**Fields:**

| Field | Meaning |
|-------|---------|
| `kind` | `down` (key pressed) or `up` (key released) |
| `key` | The key name (e.g., `a`, `Enter`, `LCtrl`) |
| `delta` | Milliseconds since the previous event |

### Understanding Deltas

Deltas are **relative timing** — the time between this event and the previous one:

- First event always has `delta = 0` (no previous event)
- Subsequent events show the delay since the last event
- Example: `delta = 100` means "wait 100ms before this event"

### Editing Recordings

You can manually edit the file to:

1. **Adjust timing:** Change delta values
2. **Remove events:** Delete lines
3. **Reorder events:** Rearrange lines (advanced)

After editing, press `Ctrl + F24` or `Ctrl + F23` to reload the changes.

### Persistence

Recordings are saved automatically when you stop recording (`Shift + F24/F23`). They persist across script restarts, so your macros are always available.

---

## Troubleshooting

### Hotkeys Not Working

**Problem:** Pressing `Shift + F24` doesn't start recording.

**Solutions:**
1. Verify QuickRecord is running (check system tray for green AHK icon)
2. Reload the script (right-click tray icon → Reload Script)
3. Check if another application is capturing F24 (e.g., gaming software)
4. Try a different function key if F24 is unavailable

### Recording Not Saving

**Problem:** Recording stops but the file isn't created.

**Solutions:**
1. Check that the script has write permissions in its directory
2. Verify the directory isn't read-only
3. Check disk space
4. Look for error notifications in the tray

### Replay Doesn't Work

**Problem:** Pressing `F24` doesn't replay the recording.

**Solutions:**
1. Verify a recording exists (check Status in tray menu)
2. Ensure you're not currently recording (mode should be "Idle")
3. Check that no other buffer is replaying
4. Try reloading the file with `Ctrl + F24`

### Timing Issues

**Problem:** Replay timing doesn't match the original recording.

**Solutions:**
1. Check the delta values in the file (very large values may be capped at 5000ms)
2. Try adjusting deltas manually and reloading
3. Re-record if timing is critical

### File Corruption

**Problem:** Error message about corrupt recording file.

**Solutions:**
1. Check the file format (should be `kind\tkey\tdelta`)
2. Verify all lines have exactly 3 tab-separated fields
3. Delete the file and re-record
4. Use Clear from tray menu to reset both buffers

---

## FAQ

### Can I record both F24 and F23 at the same time?

No. Only one buffer can be recording at a time. Start recording F24, stop it, then start F23. They're independent but not simultaneous.

### What if I accidentally press the hotkey?

The hotkey press itself is trimmed from the recording, so it won't appear in playback. If you started recording by accident, just press `Shift + F24` again to stop.

### Can I edit the recording file manually?

Yes. The file is plain text with a simple format. Edit the delta values to adjust timing, or delete lines to remove events. Press `Ctrl + F24` to reload your changes.

### What's the maximum recording length?

There's no hard limit, but very long recordings (thousands of events) may take longer to replay. Keep recordings focused on specific tasks.

### Can I share recordings with others?

Yes. The `.txt` files are portable. Share the file and the recipient can place it in their QuickRecord directory and reload it.

### What happens if I clear recordings?

Both F24 and F23 buffers are cleared, and both storage files are deleted. This cannot be undone, so make a backup if you want to keep the recordings.

### Can I use QuickRecord with other scripts?

Yes. QuickRecord uses F23 and F24, which are rarely used by other applications. If there's a conflict, you can modify the script to use different keys.

### Why is there a 5000ms cap on delays?

This prevents accidental long pauses if a recording captures an unexpectedly long delay. You can manually edit the file to use longer delays if needed.

### Can I record mouse movements?

No. QuickRecord only records keyboard events (key presses and releases). Mouse movements are not captured.

### What if the script crashes during replay?

The replay will stop and the `isReplaying` flag will be reset. You can try replaying again. If the script crashes, restart it from the tray menu.

---

## Tips for Power Users

### Manual File Editing

For advanced users, you can edit the recording file directly:

1. Open `QuickRecord.last.F24.txt` in a text editor
2. Modify delta values to adjust timing
3. Delete lines to remove events
4. Save the file
5. Press `Ctrl + F24` to reload

### Combining Workflows

You can combine features for complex automation:

1. Record a sequence with `Shift + F24`
2. Reload and edit timing with `Ctrl + F24`
3. Strip waits with `Alt + F24` for fast execution
4. Replay with `F24`

### Using Both Buffers

Maintain two related macros:

- **F24:** Main workflow
- **F23:** Cleanup or undo steps

Execute them in sequence for complex automation.

### Backup Your Recordings

Before clearing or modifying, copy your recording files:

```
Copy QuickRecord.last.F24.txt → QuickRecord.last.F24.backup.txt
Copy QuickRecord.last.f23.txt → QuickRecord.last.f23.backup.txt
```

Then you can restore them if needed.

---

## Limitations

- **Keyboard only:** Only records keyboard events, not mouse movements or clicks
- **Single replay:** Only one buffer can replay at a time (shared `isReplaying` state)
- **Delay cap:** Individual delays are capped at 5000ms to prevent accidental long pauses
- **No undo:** Clearing or stripping waits cannot be undone (make backups)
- **No conditional logic:** Recordings are linear sequences; no branching or loops

---

## Getting Help

If you encounter issues:

1. Check the **Troubleshooting** section above
2. Review the **FAQ** for common questions
3. Check the tray menu **Status** to see current state
4. Right-click the tray icon and **Reload Script** to reset
5. Check the script source code in `scripts/QuickRecord.ahk` for technical details
