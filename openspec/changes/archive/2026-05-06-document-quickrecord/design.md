## Context

QuickRecord has evolved through three recent feature additions (dual-buffer F23 support, reload-from-file, strip-waits), but lacks user documentation. The existing WindowPadPlus.md provides a proven template for clear, accessible documentation with sections on concepts, hotkey reference, and workflows. Documentation should match that style and structure.

## Goals / Non-Goals

**Goals:**
- Create comprehensive user documentation for QuickRecord
- Match the style, structure, and tone of WindowPadPlus.md
- Document all hotkeys and their modifiers (Shift, Ctrl, Alt)
- Explain the dual-buffer system and how F24/F23 work independently
- Provide clear examples and common workflows
- Include troubleshooting and FAQ sections
- Make the documentation discoverable and easy to reference

**Non-Goals:**
- Document the internal architecture or code structure
- Create API documentation for developers
- Provide installation instructions (assume AutoHotkey is already installed)
- Create video tutorials or interactive guides

## Decisions

**Decision 1: Match WindowPadPlus.md Structure**
- Use the same section hierarchy, formatting, and style as the existing documentation
- Include Installation, Concepts, Hotkey Reference, Workflows, and Troubleshooting sections
- Use ASCII diagrams for visual clarity where helpful
- Rationale: Consistency across project documentation, familiar to users who've read WindowPadPlus.md

**Decision 2: Organize Hotkeys by Function, Not by Modifier**
- Group hotkeys by what they do (Record, Replay, Reload, Strip) rather than by modifier key
- Within each group, show all modifier variants (Shift+F24, F24, Ctrl+F24, Alt+F24)
- Rationale: Users think about tasks, not modifiers. This organization matches their mental model.

**Decision 3: Explain Dual-Buffer as a Core Concept**
- Dedicate a "Concepts" section to explain F24 and F23 as independent, parallel buffers
- Show that they don't interfere with each other
- Clarify the shared `isReplaying` state (one buffer can't replay while the other is recording)
- Rationale: This is a key differentiator from single-buffer macro tools and needs clear explanation

**Decision 4: Include Practical Workflows**
- Provide 3-4 common use cases with step-by-step instructions
- Examples: "Record a complex sequence", "Refine timing with reload", "Execute at max speed with strip-waits"
- Rationale: Helps users understand how to combine features for real tasks

**Decision 5: Document File Format and Persistence**
- Include a section on the tab-separated format used for storage
- Explain how deltas work and why timing is relative
- Rationale: Enables power users to manually edit files if needed

## Risks / Trade-offs

**Risk: Documentation Becomes Outdated**
- As new features are added, documentation must be updated
- Mitigation: Keep documentation close to code; update it when features are added

**Risk: Over-Documentation**
- Too much detail could overwhelm new users
- Mitigation: Organize with "Getting Started" for basics, "Advanced" sections for power users

**Trade-off: Brevity vs. Completeness**
- Shorter docs are easier to read but may miss edge cases
- Rationale: Start with clear, concise documentation; expand based on user questions

## Open Questions

- Should we document the 5000ms delay cap in Replay? Is this a user-facing concern or an implementation detail?
- Should we include a section on limitations (e.g., shared `isReplaying` state)?
- Should we document the artifact trimming behavior (removing F24/F23 key presses from recordings)?
