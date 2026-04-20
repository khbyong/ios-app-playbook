---
name: swiftui-product-ui
description: Use when building or refining SwiftUI screens for real products, especially onboarding, settings, dashboards, forms, paywalls, empty states, or flows that need stronger hierarchy, polish, and product judgment.
---

# SwiftUI Product UI

The target is product quality, not generic demo UI.

## Core Principles

- preserve the app's existing visual language when one exists
- if there is no strong language yet, pick one intentionally
- optimize for scanability, confidence, and speed
- keep screens calm even when feature-rich

## Visual Rules

- one strong primary action per screen
- clear hierarchy before decoration
- spacing should separate meaning, not just fill space
- avoid default-looking stacks with interchangeable cards
- use color semantically, not decoratively

## Product Patterns

- dashboards should answer "what matters right now"
- settings should feel operational, not overwhelming
- onboarding should get users to value quickly
- empty states should teach the next move
- forms should reduce uncertainty before submission

## SwiftUI Composition

- break long bodies into small readable sections
- use dedicated subviews when a section has distinct intent
- avoid computed view helpers that hide too much logic
- keep state ownership obvious

## Polish Checklist

- typography has visible hierarchy
- interactive elements look tappable
- loading, empty, success, and error states exist
- destructive actions are clearly separated
- sheets and navigation destinations feel intentional
- iPhone and iPad layouts both make sense

## Settings-Specific Rules

- rows should explain consequence, not just label an option
- separate status from action
- avoid action labels that imply unsafe behavior
- if a control can destroy data or confuse sync state, slow it down with explanation

## Avoid

- purple-on-white defaults
- glassmorphism as a substitute for hierarchy
- too many equal-weight cards
- over-animated transitions for utility screens
- hiding product risk behind vague button copy
