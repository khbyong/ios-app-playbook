---
name: ios-adaptive-layout
description: Use when adapting an iOS app across iPhone and iPad, handling safe areas, readable widths, compact versus regular size classes, split layouts, and SwiftUI structures that need to stay native across device contexts.
---

# iOS Adaptive Layout

Adaptability should feel natural, not like a stretched phone UI.

## Rules

- design for small iPhone first
- expand with intention on larger devices
- keep readable width under control
- avoid edge-to-edge text walls on iPad
- use available space to improve clarity, not just fit more widgets

## Review Questions

- does the iPad version feel intentionally laid out
- do safe areas and system bars still read correctly
- does content become more readable as width grows
- are touch targets still easy to reach
