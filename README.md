# iOS App Skills

Opinionated open-source skills for solo builders shipping polished iOS apps with SwiftUI.

Built and maintained by [@phrypy on Instagram](https://instagram.com/phrypy) and [khbyong on GitHub](https://github.com/khbyong).

## Who This Is For

- Intermediate builders who can already compile an iOS app
- Solo founders and indie developers shipping their own products
- Teams that want a sharper SwiftUI product playbook without enterprise process overhead

This repo is not aimed at total beginners, agency handoff docs, or large-team architecture committees.

## What You Get

- `ios-app-architecture`
  - Structure native iOS apps for fast solo iteration without turning the codebase into soup.
- `swiftui-product-ui`
  - Build product-facing SwiftUI screens with stronger hierarchy, polish, and UX judgment.
- `ios-debug-and-stabilize`
  - Triage crashes, state bugs, concurrency issues, and shipping regressions methodically.
- `app-store-readiness`
  - Preflight an app for App Store submission, metadata alignment, privacy, and review risk.
- `solo-ios-release-flow`
  - Run a clean release loop from local verification to TestFlight to App Store submission.

## Install

### Codex

Copy the skill folders into:

```bash
~/.codex/skills/
```

### Claude Code

Copy the skill folders into:

```bash
~/.claude/skills/
```

### Generic Agent Setup

If your agent supports `SKILL.md`-style folders, copy any skill directory from `skills/` into that agent's skills directory.

## Repo Layout

```text
skills/
  ios-app-architecture/
  swiftui-product-ui/
  ios-debug-and-stabilize/
  app-store-readiness/
  solo-ios-release-flow/
docs/
  adoption-guide.md
```

## Philosophy

- SwiftUI first
- Product quality over demo polish
- Shipping bias
- Solo-friendly architecture
- Clear boundaries, small files, low ceremony
- Verification before claiming success

## How To Use These Skills

Start with the skill that matches the current phase:

- New app or major refactor: `ios-app-architecture`
- Screen work or UX polish: `swiftui-product-ui`
- Bugs, crashes, regressions: `ios-debug-and-stabilize`
- Review prep: `app-store-readiness`
- Shipping a build: `solo-ios-release-flow`

## Notes

- These skills are intentionally opinionated.
- They are designed to be adapted, not followed blindly.
- If a repo already has strong conventions, preserve them unless they are causing real problems.

See [docs/adoption-guide.md](./docs/adoption-guide.md) for a practical setup guide.
