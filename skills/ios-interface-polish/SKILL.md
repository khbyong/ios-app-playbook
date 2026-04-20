---
name: ios-interface-polish
description: Use when an iOS app already works but still feels slightly off. Focus on spacing, radius logic, visual hierarchy, motion restraint, feedback, numeric alignment, and the small details that make native apps feel finished.
---

# iOS Interface Polish

Polish is usually not a big redesign. It is a series of small corrections that remove friction and visual hesitation.

## Use This Skill For

- screens that feel flat, noisy, or slightly awkward
- controls that work but do not feel tactile
- cards, rows, sheets, and grouped settings that need refinement
- SwiftUI interfaces that feel web-shaped instead of iOS-shaped

## Polish Rules

- make spacing feel intentional, not evenly distributed by default
- keep nested corner radii visually related
- align icons and text optically, not only mathematically
- use semantic hierarchy before adding more color
- prefer one clear emphasis point per section
- keep shadows soft and sparse
- use tabular numbers for changing totals, prices, and stats
- make touch feedback subtle and consistent
- use motion to confirm or guide, never to decorate

## Common Fixes

- reduce visual clutter before adding styling
- turn hard dividers into whitespace when the layout can support it
- widen hit areas even if the visible control stays small
- tighten row layouts so labels and values read as pairs
- remove one-off font weights, opacities, and radii that weaken consistency
- make exits calmer than entrances

## Native Feel Checks

- does the screen still feel clear in dark mode?
- do large numbers stay aligned while changing?
- do grouped sections read like Apple settings, not dashboard cards?
- does pressing a control feel acknowledged immediately?
- is animation fast enough that it never feels like waiting?

## Avoid

- decorative gradients on utility screens
- thick borders everywhere
- overusing haptics
- scaling or bouncing every interaction
- adding polish details that fight accessibility or readability
