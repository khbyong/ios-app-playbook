---
name: app-store-readiness
description: Use when auditing a prepared iOS release for App Store or TestFlight submission risk, including metadata, privacy, capabilities, and reviewer-facing behavior.
---

# App Store Readiness

Submission quality is product quality plus review hygiene.

This is the submission audit gate. It does not archive, upload, or release the build. Use `solo-ios-release-flow` for the release sequence and `ship-ios-build-one-command` for the archive-to-upload operation.

## Audit In This Order

1. the app build itself
2. store metadata versus real behavior
3. privacy, entitlements, and capabilities
4. subscriptions, legal URLs, and account flows
5. screenshots and review notes

## Metadata Rules

- never claim a feature is live if it is hidden, disabled, or "coming soon"
- title, subtitle, promo text, and description should match the shipped build
- if a capability is conditional or manual, describe it honestly

## Review Risk Areas

- unused background modes
- incomplete privacy manifests
- entitlement drift
- broken paywalls or restore flows
- misleading screenshots
- half-finished imports, notifications, or sync claims

## iCloud And Restore Rules

- do not label a status refresh as a restore
- destructive or recovery actions need explicit user language
- if a restore path exists, explain exactly what device state it rebuilds and when

## Pre-Submit Checks

- release build succeeds
- app opens and core loop works on device
- purchase and restore flows are understandable
- notification and permission prompts appear at sensible moments
- legal links resolve
- support path exists

## Final Standard

If a reviewer or first-time user could misunderstand what the app does, the submission is not ready yet.
