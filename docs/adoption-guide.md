# Adoption Guide

## Start Simple

Do not import every skill into every project by default.

Start with:

- `ios-app-architecture`
- `swiftui-product-ui`
- `ios-debug-and-stabilize`

Add `app-store-readiness` and `solo-ios-release-flow` once the product is approaching ship.

## Best Fit Projects

These skills work best for:

- SwiftUI-first iPhone apps
- solo-built consumer apps
- productivity, finance, wellness, creator, and utility products
- apps where UX polish and shipping quality matter

## What To Customize First

Before using these skills heavily in a repo, adapt:

- your app's design tokens
- your naming conventions
- your folder structure
- your monetization and release model
- your preferred verification commands

## What Not To Copy Blindly

- exact architecture labels
- every service boundary
- every release step
- any App Store copy pattern that does not match your product

The point is reusable judgment, not cargo culting.

## Suggested Pairing

Pair these skills with a repo-level instruction file that defines:

- app identity
- bundle IDs and targets
- platform minimums
- data model rules
- design tokens
- release conventions

## Maintenance

When a skill becomes vague, too long, or too general:

- tighten trigger conditions
- remove repeated advice
- move detailed examples into a reference file only if truly needed
- keep the main `SKILL.md` compact
