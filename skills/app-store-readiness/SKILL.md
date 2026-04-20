---
name: app-store-readiness
description: Use when preparing an iOS app for TestFlight or App Store review, auditing metadata against the live build, checking privacy and capabilities, or reducing rejection risk before submission.
---

# App Store Readiness

Submission quality is product quality plus review hygiene.

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
