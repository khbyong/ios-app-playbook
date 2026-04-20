# iOS App Playbook

An opinionated open-source playbook for designing, building, and shipping polished iOS apps.

Built for intermediate solo builders who already know how to compile an app, but want sharper judgment around SwiftUI product UI, clean native design, App Store readiness, and indie shipping quality.

Authored by [@phrypy on Instagram](https://instagram.com/phrypy) and [khbyong on GitHub](https://github.com/khbyong).

## What This Repo Is

This is not just a pile of prompts or a random design dump.

It is a practical iOS playbook with four layers:

- `skills/`
  - Reusable agent skills for architecture, UI, review, shipping, and native iOS design decisions
- `guides/`
  - Human-readable playbooks for common product design problems
- `checklists/`
  - Fast review passes before shipping or submitting
- `references/`
  - Canonical Apple links and source material worth keeping close

## Who This Is For

- solo founders and indie iOS builders
- intermediate SwiftUI developers
- product-minded engineers who care about native feel
- builders shipping consumer apps, utilities, finance apps, creator tools, or productivity apps

This repo is not aimed at:

- total beginners learning Swift for the first time
- enterprise architecture committees
- web-to-mobile ports that want to keep web-native UX patterns intact

## Start Here

### If you are starting a new app

- `skills/ios-app-architecture`
- `skills/swiftui-product-ui`
- `skills/ios-hig-design`

### If your app works but doesn’t feel native enough

- `skills/ios-navigation-and-ia`
- `skills/ios-forms-and-input-design`
- `skills/ios-motion-and-microinteractions`
- `guides/how-to-make-swiftui-apps-feel-native.md`

### If your Settings or sync flows feel risky or unclear

- `skills/ios-settings-and-data-safety-ux`
- `guides/how-to-design-a-clean-ios-settings-screen.md`

### If you are getting close to shipping

- `skills/app-store-readiness`
- `skills/solo-ios-release-flow`
- `checklists/app-store-preflight.md`
- `checklists/accessibility-review.md`

## Skills

- `ios-app-architecture`
  - Structure a solo-friendly SwiftUI codebase with clean boundaries.
- `swiftui-product-ui`
  - Build real product screens with stronger hierarchy and product judgment.
- `ios-debug-and-stabilize`
  - Triage crashes, warnings, state bugs, and shipping regressions.
- `ios-hig-design`
  - Design iPhone and iPad interfaces that feel native to Apple platforms.
- `ios-navigation-and-ia`
  - Choose better tab, drill-down, modal, and information architecture patterns.
- `ios-settings-and-data-safety-ux`
  - Design settings, sync, restore, destructive actions, and trust-sensitive flows.
- `ios-forms-and-input-design`
  - Improve forms, pickers, validation, save behavior, and keyboard/input decisions.
- `ios-empty-states-and-first-run`
  - Make onboarding, empty states, and first-session UX clearer and calmer.
- `ios-motion-and-microinteractions`
  - Add subtle motion, feedback, and haptics without making the app feel noisy.
- `ios-adaptive-layout`
  - Handle iPhone, iPad, safe areas, readable width, and layout changes more cleanly.
- `ios-accessibility-design-review`
  - Review Dynamic Type, contrast, hit targets, VoiceOver, and reduced motion support.
- `ios-app-icon-and-brand-system`
  - Shape an app icon, lightweight brand system, and marketing consistency that still feel native.
- `app-store-readiness`
  - Preflight metadata, privacy, capabilities, and review risk.
- `solo-ios-release-flow`
  - Run a sane release loop from local verification to TestFlight and App Store submission.

## Guides

- [How To Design A Clean iOS Settings Screen](./guides/how-to-design-a-clean-ios-settings-screen.md)
- [How To Make SwiftUI Apps Feel Native](./guides/how-to-make-swiftui-apps-feel-native.md)
- [How To Prep An Indie iOS App For App Store Review](./guides/how-to-prep-an-indie-ios-app-for-app-store-review.md)

## Checklists

- [Clean iOS UI Review](./checklists/clean-ios-ui-review.md)
- [App Store Preflight](./checklists/app-store-preflight.md)
- [Accessibility Review](./checklists/accessibility-review.md)

## References

- [Official Apple iOS Design Links](./references/official-ios-design-links.md)

## Install

### Codex

Copy chosen skill folders into:

```bash
~/.codex/skills/
```

### Claude Code

Copy chosen skill folders into:

```bash
~/.claude/skills/
```

### Generic Agent Setup

If your agent supports `SKILL.md`-style folders, copy any skill directory from `skills/` into that agent’s skills directory.

## Philosophy

- SwiftUI first
- native behavior over trend-chasing
- trust-sensitive UX for settings, sync, and data
- product polish without bloated process
- ship with evidence, not vibes

## Notes

- These skills are intentionally opinionated.
- The goal is reusable judgment, not blind copying.
- If your app already has strong conventions, preserve them unless they are causing real product or maintenance problems.

Use [docs/adoption-guide.md](./docs/adoption-guide.md) for a practical setup path.
