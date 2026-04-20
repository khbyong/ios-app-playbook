---
name: solo-ios-release-flow
description: Use when shipping a SwiftUI app as a solo builder, including build verification, release cleanup, TestFlight prep, App Store Connect updates, and the final go/no-go checklist before pushing a release live.
---

# Solo iOS Release Flow

Ship with a repeatable loop. Do not improvise the final mile.

## Recommended Sequence

1. clean up real warnings
2. run the relevant tests
3. build the app in release conditions
4. smoke test the main user flows
5. verify store metadata matches the build
6. archive and upload
7. check processing, screenshots, and review notes

## Before You Upload

- remove debug-only behavior
- confirm version and build numbers
- check app icons and launch assets
- verify bundle IDs and capabilities
- confirm any last-minute copy changes made it into the build

## Solo Builder Priorities

- stability beats extra features
- reduce ambiguity in settings, paywalls, and sync
- do one final pass on first-run experience
- keep release notes tight and honest

## Go / No-Go Questions

- can a new user understand the core loop
- can a paying user understand what they are buying
- can a reviewer reach the important surfaces without confusion
- does the app promise only what the build actually does

If any answer is no, stop and fix that first.

## After Upload

- watch build processing
- re-check metadata in App Store Connect
- prepare concise review notes when needed
- keep one short list of post-submit follow-ups instead of thrashing the release
