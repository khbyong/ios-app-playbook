---
name: ios-debug-and-stabilize
description: Use when an iOS app is crashing, hanging, misrendering, failing tests, or showing warnings around SwiftUI state, SwiftData, concurrency, entitlements, simulator/device differences, or App Store submission stability.
---

# iOS Debug And Stabilize

Treat debugging as evidence work, not guesswork.

## Order Of Operations

1. reproduce the issue
2. identify whether it is simulator-only, device-only, or both
3. narrow to the exact screen, interaction, or launch phase
4. inspect logs and crash signals
5. fix the smallest proven cause
6. verify the specific failure is gone

## High-Risk Areas

- SwiftUI body-time side effects
- mixed state ownership across views and singletons
- detached tasks touching UI or persistence
- CloudKit and shared-container startup paths
- extension-safe code paths
- capabilities that do not match runtime behavior

## Crash Triage Rules

- `EXC_BAD_ACCESS` in SwiftUI often means invalid ownership, stale objects, or unsafe cross-thread access
- `signal 9` is termination, not a normal Swift crash
- if CloudKit is involved, separate sync errors from UI crashes
- if the line highlighted is `body`, the bug is often upstream in state or side effects

## Warning Policy

Fix warnings that suggest:

- undefined concurrency behavior
- actor isolation violations
- deprecated platform paths tied to release code
- entitlement, capability, privacy, or review risk

Ignore only clear simulator noise after confirming it does not affect device or archive builds.

## Verification Standard

- the failing interaction now works
- the project builds cleanly
- the relevant tests pass
- if the bug was device-specific, confirm on device before claiming victory

Do not call something fixed just because the simulator stopped crashing once.
