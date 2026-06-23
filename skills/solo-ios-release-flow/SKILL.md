---
name: solo-ios-release-flow
description: Use when coordinating the end-to-end release sequence for a prepared SwiftUI app, from final verification through TestFlight or App Store submission.
---

# Solo iOS Release Flow

Ship with a repeatable loop. Do not improvise the final mile.

## Recommended Sequence

1. clean up real warnings
2. run the relevant tests
3. build the app in release conditions
4. smoke test the main user flows
5. run `app-store-readiness`
6. archive and upload
7. check processing, screenshots, and review notes

Run `app-store-readiness` before the upload step. That skill is the go/no-go audit; this skill owns the order of operations. Use `ship-ios-build-one-command` only for the archive, sign, export, and upload step.

## Before You Upload

- remove debug-only behavior
- confirm version and build numbers
- hand App Store metadata, privacy, capability, and reviewer-risk checks to `app-store-readiness`

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
