#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

contains() {
  local file="$1"
  local pattern="$2"
  rg -q --fixed-strings "$pattern" "$file" || fail "$file must contain: $pattern"
}

[[ ! -f skills/ios-app-icon-optimization/SKILL.md ]] || fail 'legacy ios-app-icon-optimization skill must be removed'
contains skills/ios-app-icon-and-brand-system/SKILL.md '## App Store Icon Review'
contains skills/ios-hig-design/SKILL.md '## Use This As The Baseline'
contains skills/swiftui-product-ui/SKILL.md '## Owns'
contains skills/ios-interface-polish/SKILL.md 'Use after the screen works'
contains skills/app-store-readiness/SKILL.md 'It does not archive, upload, or release the build.'
contains skills/solo-ios-release-flow/SKILL.md 'Run `app-store-readiness` before the upload step.'
contains skills/ios-app-store-optimization/SKILL.md 'It does not design or produce the assets.'

printf 'Skill boundaries verified.\n'
