# How To Ship And Launch An iOS Update

Shipping an update is two jobs: cut a clean build, then give it a fair launch.

Do them in order. Do not start metadata before the build is real, and do not submit before the links resolve.

## 1. Cut The Build

- bump `MARKETING_VERSION` (the public version, e.g. 1.3)
- bump `CURRENT_PROJECT_VERSION` (the build number)
- to re-upload a changed binary you MUST bump the build number

App Store Connect rejects duplicate build numbers. If you upload, find a problem, fix it, and upload again, bump the build number first.

## 2. Preflight

Run the preflight before you spend time on metadata.

- see ./checklists/app-store-preflight.md
- confirm the privacy manifest is complete
- confirm export-compliance is answered (most apps use only standard encryption)

A failed preflight here is cheap. A failed review is a week.

## 3. Real Screenshots

- see ./skills/app-store-screenshot-pipeline/
- shoot the actual app, not a mockup of what you wish it did
- reviewers and users both read screenshots as a promise

## 4. Metadata

Edit metadata with the asc CLI, not by hand in the dashboard.

- subtitle, keywords, promotional text, description, what's new
- respect each field's character limit
- omit empty fields, `asc validate` rejects empty strings
- validate before apply
- dry-run first, then apply

Tight and honest beats keyword-stuffed. The subtitle and first description line do most of the work.

## 5. URLs

Wire your own URLs on your own domain. Verify each returns 200 before applying.

- marketing URL points to a real product landing page for this app
- support URL points to a general support page that serves ALL your apps: contact email, short FAQ, per-app links
- privacy policy URL points to a privacy page

Build the support page once and reuse it across every app. Editorial and reviewers expect a place where a user can actually get help, not a second marketing page.

An apex domain that 307-redirects to www is fine, it resolves 200. Prefer the canonical 200 URL when you have it.

## 6. Archive And Upload

- see ./skills/ship-ios-build-one-command/
- archive in release conditions, then upload
- wait for processing to finish before you touch the version

## 7. Attach And Submit

- attach the processed build to the version
- fill review-detail contact info and any sign-in notes
- confirm App Privacy is published, not just drafted
- submit

If the build is not attached or App Privacy is unpublished, submission stalls quietly. Check both.

## 8. Nominate For Featuring

- see ./skills/app-store-featuring-nomination/
- nominate a few weeks ahead of the release date when you can
- editorial wants a clear story and real screenshots, both of which you already have

## 9. Build In Public (Optional)

A queued backlog of honest posts in your own voice beats silence around launch.

- write the posts before the release, not during the scramble
- show the real thing, the why, and the rough edges
- one steady voice over weeks outperforms one loud day

## Final Question

If the update went live right now, could a new user, a paying user, and a reviewer each get what they came for without confusion?

If not, that is the thing to fix before you submit.
