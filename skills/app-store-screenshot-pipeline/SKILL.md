---
name: app-store-screenshot-pipeline
description: Use when producing App Store screenshots from real app renders instead of faked CSS mockups, covering the headless simulator export stage, the composition-to-device-sizes stage, and the gotchas that quietly waste hours. Pairs with ios-app-store-optimization, which covers what the screenshots should say.
---

# App Store Screenshot Pipeline

Marketing screenshots should be the real app, rendered, not a div pretending to be the app.

A CSS mockup drifts from the product the moment you ship a UI change. A real render stays honest, and the listing keeps matching the first-run experience. Build screenshots in two stages: render real views from the app, then compose those PNGs into App Store sizes.

For what the screenshots should say, see `ios-app-store-optimization`. This skill only produces the files from that approved direction; it does not decide the listing message or visual identity.

## The Two Stages

1. headless render from the app, offscreen, on a booted simulator
2. compose those renders into App Store device sizes and upload

Keep the stages separate. Stage one owns pixels of real UI. Stage two owns layout, headlines, and final dimensions.

## Stage 1: Headless Render From The App

Add export functions behind an env gate so they never touch production paths.

```swift
if ProcessInfo.processInfo.environment["APP_EXPORT_SHOTS"] == "1" {
    renderOffscreenAndWritePNGs()
}
```

Inside that path, rasterize specific views with SwiftUI `ImageRenderer` (or `UIGraphicsImageRenderer`) and write PNGs into the app's Documents directory.

Trigger it from a booted simulator and pass the env with the `SIMCTL_CHILD_` prefix:

```sh
xcrun simctl launch <device> <bundleid>
# with: SIMCTL_CHILD_APP_EXPORT_SHOTS=1
```

Then pull the PNGs out of the app's data container.

## Stage 1 Gotchas

These are the ones that cost real time. Read them before you start.

- `ImageRenderer` cannot rasterize a `NavigationStack`. You get a yellow box with a red prohibition symbol, not your view.
- it cannot rasterize `ScrollView` content either. That renders blank.
- a `Picker` with `.pickerStyle(.menu)` renders the same placeholder.
- so give yourself a chromeless render path: a plain `VStack`, no `NavigationStack`, no `ScrollView`, and present pickers as sheets rather than inline. Render the content, not the chrome.
- `simctl install` changes the app's data container id. Call `xcrun simctl get_app_container <device> <bundleid> data` after install, never before, or you will read the wrong folder.
- pass env to the launched app with the `SIMCTL_CHILD_` prefix. Without it the variable is set on `simctl`, not on your app.
- render at scale 2 to 3, and set `isOpaque = false` when you need transparency.
- App Store app icon PNGs must be 1024x1024 with no alpha channel. Strip alpha on the icon specifically, even if the rest of your renders keep it.
- when inspecting renders as an agent, downscale first with `sips` before viewing. Very large PNGs fail to display.

## Stage 2: Compose To App Store Sizes

Use a small Next.js plus Playwright generator. Lay out each slide in the browser using the real PNGs from stage one, then capture each slide at literal device pixel dimensions.

Required sizes:

- iPhone 6.9": 1320x2868
- iPad 13": 2064x2752

Capture at exact pixels. Do not capture at a CSS size and scale up, or text and device frames go soft.

One sync trap: if a Node export script keeps its own hardcoded slug or slide list, it will silently skip any slide you add to the manifest but forget to add to the script. Either drive the export from the manifest, or treat the two lists as one thing you change together. A new slide that never exports is easy to miss until upload.

## Upload With asc

Use `asc` and replace the set so the listing is exactly what you intend, with no leftover duplicates.

```sh
asc screenshots upload --replace --device-type APP_IPHONE_69 --path metadata/screenshots
asc screenshots upload --replace --device-type APP_IPAD_PRO_3GEN_129 --path metadata/screenshots
```

`--path` must point at the parent folder whose immediate children are locale directories. For example `metadata/screenshots` with a child `en-US/`, not the locale folder itself.

## Avoid

- div and CSS mockups standing in for real UI
- rasterizing a `NavigationStack`, `ScrollView`, or menu `Picker` and wondering why it is blank or a yellow box
- reading the data container path before install
- forgetting the `SIMCTL_CHILD_` prefix and assuming the env reached the app
- shipping a 1024x1024 icon that still carries an alpha channel
- a manifest slide that never reaches the exporter because a hardcoded list went stale
- uploading without `--replace` and leaving stale screenshots in the set
