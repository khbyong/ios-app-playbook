# Onboarding Copy Before/After

## Problem

An onboarding screen tried to communicate app value and set up permissions at the same time. The result was a wall of text that users skipped, combined with a permission prompt they didn't understand.

## Weak Version

**Screen 1 — Welcome**
- Title: `Welcome to Budgetly`
- Body: `Budgetly is the smart personal finance app that helps you track your spending, set budgets, manage subscriptions, view trends, and achieve your financial goals — all in one place.`
- Button: `Get Started`

**Screen 2 — Notifications**
- Title: `Enable Notifications`
- Body: `We need permission to send you notifications.`
- Button: `Allow`

## Stronger Version

**Screen 1 — Welcome**
- Title: `See where your money goes`
- Body: `Log expenses, set a budget, and get a clear view of your spending each week.`
- Button: `Start Tracking`

**Screen 2 — Notifications**
- Title: `Stay on top of your budget`
- Body: `Get a nudge when you're close to your limit. You can change this at any time in Settings.`
- Button: `Turn On Notifications`
- Secondary: `Skip for now`

## Why It Is Better

**The welcome copy describes a job, not a feature list.** The original tried to list everything the app does. The stronger version names the single job the user wants done. Users scan onboarding — a short, concrete promise lands faster than an exhaustive list.

**The notification screen earns the ask.** The original asked for permission without explaining the value. The stronger version connects the permission directly to a benefit the user already cares about. It also reduces fear by noting the setting is reversible.

**The button copy is active and specific.** "Get Started" is a placeholder. "Start Tracking" tells the user what they are doing. "Turn On Notifications" is honest about what the button does. "Skip for now" is a real out, not a dark pattern.

## Principle

Onboarding copy should do one thing per screen: answer the question the user is implicitly asking at that moment. On a welcome screen, the question is "what is this and why should I care." On a permission screen, it is "what do I get by saying yes."

## Playbook Skills Behind It

- `ios-empty-states-and-first-run`
- `swiftui-product-ui`
