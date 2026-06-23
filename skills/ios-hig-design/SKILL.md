---
name: ios-hig-design
description: Use when establishing or auditing the Apple-platform baseline for an iPhone or iPad interface, especially native conventions, system constraints, and HIG-aligned decisions.
---

# iOS HIG Design

Design for the platform people think they are using, not a generic mobile app.

This skill is a distilled public playbook inspired by Apple's Human Interface Guidelines and adapted for practical solo-product work.

See official references in [references/hig-links.md](references/hig-links.md).

## Use This As The Baseline

Use this skill to establish platform conventions before designing a feature or audit a screen against those conventions. It is not the owner of feature-specific decisions:

- navigation structure: `ios-navigation-and-ia`
- forms and input: `ios-forms-and-input-design`
- first run and empty states: `ios-empty-states-and-first-run`
- adaptive layouts: `ios-adaptive-layout`
- accessibility audit: `ios-accessibility-design-review`
- motion and haptics: `ios-motion-and-microinteractions`
- post-build visual refinement: `ios-interface-polish`

## Core Principles

- clarity over decoration
- hierarchy before effects
- native interaction patterns over novelty
- accessibility as a product requirement, not cleanup
- motion that explains, not distracts

## What Native Usually Means

- safe areas are respected
- bars, sheets, and drill-down navigation feel familiar
- text uses semantic hierarchy instead of random size jumps
- icons look like SF Symbols belong beside them
- the app works in light mode, dark mode, and larger text sizes
- controls look tappable and behave predictably

## Layout

- respect safe areas for interactive content
- default to 16-20pt horizontal margins on iPhone
- minimum tap target is 44x44pt
- design for small phones first, then expand gracefully
- use `.ignoresSafeArea()` for backgrounds, not critical controls

If a layout fights the notch, Dynamic Island, tab bar, or home indicator, it is not done.

## Navigation Baseline

- use tab bars for primary destinations
- use navigation stacks for hierarchy
- use sheets for focused side tasks
- avoid hamburger navigation on iPhone unless the product has an unusual constraint
- every screen needs an obvious exit path

## Typography

- use semantic text styles when possible
- keep body text easy to read before making headers bigger
- prefer stronger hierarchy through weight, spacing, and grouping
- test at larger Dynamic Type sizes before calling the screen complete

## Controls

- prefer native controls unless a custom pattern is clearly better
- primary actions should be visually obvious
- destructive actions should slow the user down
- status and action should not be conflated in the same control

## Color And Depth

- use color semantically
- do not rely on color alone to communicate state
- if using branded color, apply it where it improves recognition or action priority
- depth should support hierarchy, not become the whole visual system

## Accessibility Baseline

- every important control needs a usable label
- support Dynamic Type
- maintain readable contrast in light and dark mode
- make empty, loading, and error states understandable without visual guesswork
- test with VoiceOver or Accessibility Inspector for important flows

## Motion Baseline

- use motion to explain transitions, hierarchy, and cause-effect
- avoid decorative motion that delays utility work
- reduce intensity when it does not add understanding
- respect reduced-motion expectations

## Icons

- prefer SF Symbols for product UI
- keep icon usage consistent by role and size
- app icons should be bold, simple, and legible at small sizes
- do not use raw bitmap edges in product UI where masks or transparency assumptions will break

## Review Lens

When reviewing a screen, ask:

1. does this feel like iOS or like a transplanted web/mobile pattern
2. are layout and navigation obvious without explanation
3. does the interface stay readable and tappable under real device constraints
4. is any custom styling making the product harder to trust or understand

## When To Push Back

Push back on designs that:

- hide controls under hardware or system UI
- invent custom navigation without a strong reason
- break Dynamic Type or accessibility
- add heavy visual treatment without improving comprehension
- imitate Apple superficially while missing native behavior
