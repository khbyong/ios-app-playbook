---
name: ios-settings-and-data-safety-ux
description: Use when designing iOS settings screens and trust-sensitive flows involving sync, restore, storage, imports, exports, destructive actions, permissions, and any wording that could cause user confusion or data loss.
---

# iOS Settings And Data Safety UX

Clarity is a safety feature.

## Rules

- do not label a status check as a sync
- do not imply restore unless a real recovery path exists
- separate passive state from active actions
- explain what happens on this device, not in abstract backend terms
- destructive actions need stronger wording and stronger friction

## Good Copy

- `Refresh Status`
- `Restore From iCloud`
- `Stored Only On This iPhone`
- `Queued For Next Launch`

## Bad Copy

- `Sync Now` when it only saves locally
- `Reset` without saying what resets
- `Unavailable` without next-step guidance
- `Delete` without naming what is deleted

## Use This Skill For

- settings rows
- sync panels
- storage explanations
- restore flows
- backup or export UX
- permission prompts with trust implications
