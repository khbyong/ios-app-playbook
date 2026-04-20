---
name: ios-app-architecture
description: Use when starting a new native iOS app, reshaping an existing SwiftUI codebase, or deciding how to structure screens, models, services, persistence, extensions, and app-wide conventions for fast solo shipping.
---

# iOS App Architecture

Design for fast solo iteration, not architecture theater.

## Defaults

- SwiftUI first
- UIKit only where platform APIs require it
- small focused view files
- clear service boundaries
- view models without UI imports
- persistence decisions made early
- zero third-party dependencies by default

## Recommended Shape

- `App/`
  - app entry, container setup, navigation state, app delegates
- `Models/`
  - persistent models and small domain types
- `Services/`
  - business operations, persistence helpers, sync, export, OCR, billing
- `ViewModels/`
  - screen state and orchestration
- `Views/`
  - product UI, grouped by feature
- `Utilities/`
  - constants, theming, environment helpers
- `Intents/`, `Widgets/`, `Extensions/`
  - separate when the app actually needs them

## State Rules

- `View` owns display state
- `ViewModel` owns screen logic
- `Service` owns reusable operations
- avoid singletons unless the dependency is truly app-wide
- if something is cross-screen but UI-driven, make the ownership explicit

## Persistence Rules

- choose the store model early
- keep model types small and obvious
- avoid mixing persistence logic throughout views
- isolate migrations, seeding, and shared-container setup near app boot
- if CloudKit is used, treat destructive recovery actions as high risk

## Solo-Friendly Boundary Test

For each file, answer:

- what is this file responsible for
- what can call it
- what should never live here

If the answer is fuzzy, the boundary is weak.

## Good Smells

- screen behavior understandable from one view model
- services reusable without copying logic
- one feature can be changed without touching six unrelated files
- extensions and widgets can read only what they actually need

## Bad Smells

- views doing persistence directly everywhere
- giant "manager" files
- global state solving local problems
- async work launched without clear ownership
- product rules spread across multiple screens

## When Refactoring Existing Apps

- preserve patterns that already work
- fix boundaries only where they block shipping or stability
- avoid large architecture rewrites unless the current structure is actively failing
