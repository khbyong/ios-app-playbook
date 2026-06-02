#!/usr/bin/env bash
# archive-ios-build.sh - archive an iOS app for the App Store, export a signed
# .ipa, and (by default) upload it to App Store Connect and attach it to the
# version. Mirrors the exact, verified flow:
#   xcodebuild archive  (Release, generic/platform=iOS, -allowProvisioningUpdates)
#   xcodebuild -exportArchive  (method app-store-connect, automatic signing)
#   asc publish appstore --ipa ... --version <v> --wait   (no --submit by default)
#
# Auto-detects project/workspace, scheme, team, version, build, bundle id, and
# the ASC app id. Never reads credential stores: xcodebuild signs via the
# Xcode-logged-in account (-allowProvisioningUpdates) and asc uses its own
# keychain auth. First App Store archive on a machine auto-CREATES an Apple
# Distribution certificate + App Store provisioning profile (expected).
set -euo pipefail

CONFIG="Release"
PROJECT=""        # path to .xcodeproj/.xcworkspace (auto-detected if empty)
SCHEME=""         # auto-detected from the project if empty
APP_ID=""         # ASC app id (auto-resolved from bundle id if empty)
VERSION=""        # auto from MARKETING_VERSION if empty
OUTDIR=""         # export dir (default: a temp dir)
DO_UPLOAD=1
DO_SUBMIT=0
DRY_RUN=0
TIMEOUT="30m"

die() { echo "ERROR: $*" >&2; exit 1; }
note() { echo "▸ $*"; }

usage() {
  cat <<'EOF'
archive-ios-build.sh - archive + export + upload an iOS App Store build

USAGE
  archive-ios-build.sh [flags]            # run from the project dir, or pass --project

FLAGS
  --project PATH    .xcodeproj or .xcworkspace (default: auto-detect in CWD)
  --scheme NAME     Xcode scheme (default: auto-detect; first shared scheme)
  --config NAME     build configuration (default: Release)
  --app ID          App Store Connect app id (default: resolve from bundle id via asc)
  --version VER     App Store version string (default: MARKETING_VERSION)
  --out DIR         export output dir (default: a temp dir)
  --no-upload       archive + export only; do NOT upload to ASC
  --submit          after attaching the build, submit for review (adds --submit --confirm)
  --timeout DUR     asc upload+processing timeout (default: 30m)
  --dry-run         detect + print the plan, run nothing
  -h, --help        this help

NOTES
  * Signing is automatic. -allowProvisioningUpdates lets xcodebuild create the
    Apple Distribution cert + App Store profile via the Xcode-logged-in account.
  * Upload uses `asc publish appstore` (its own keychain auth). Without --submit it
    uploads + attaches the build to the version but does NOT submit for review.
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --project) PROJECT="$2"; shift 2;;
    --scheme) SCHEME="$2"; shift 2;;
    --config) CONFIG="$2"; shift 2;;
    --app) APP_ID="$2"; shift 2;;
    --version) VERSION="$2"; shift 2;;
    --out) OUTDIR="$2"; shift 2;;
    --no-upload) DO_UPLOAD=0; shift;;
    --submit) DO_SUBMIT=1; shift;;
    --timeout) TIMEOUT="$2"; shift 2;;
    --dry-run) DRY_RUN=1; shift;;
    -h|--help) usage; exit 0;;
    *) die "unknown flag: $1 (see --help)";;
  esac
done

command -v xcodebuild >/dev/null || die "xcodebuild not found (install Xcode)."

# --- 1. Locate the project / workspace -------------------------------------
PROJ_FLAG=""; PROJ_PATH=""
if [ -n "$PROJECT" ]; then
  PROJ_PATH="$PROJECT"
else
  # Prefer a workspace, else a project, in the current directory.
  PROJ_PATH="$(/bin/ls -d ./*.xcworkspace 2>/dev/null | head -1 || true)"
  [ -z "$PROJ_PATH" ] && PROJ_PATH="$(/bin/ls -d ./*.xcodeproj 2>/dev/null | head -1 || true)"
fi
[ -n "$PROJ_PATH" ] || die "no .xcworkspace/.xcodeproj found (run in the project dir or pass --project)."
case "$PROJ_PATH" in
  *.xcworkspace) PROJ_FLAG="-workspace";;
  *.xcodeproj)   PROJ_FLAG="-project";;
  *) die "--project must be a .xcodeproj or .xcworkspace";;
esac

# --- 2. Resolve the scheme --------------------------------------------------
if [ -z "$SCHEME" ]; then
  SCHEME="$(xcodebuild "$PROJ_FLAG" "$PROJ_PATH" -list -json 2>/dev/null \
    | python3 -c 'import sys,json;d=json.load(sys.stdin);k="workspace" if "workspace" in d else "project";s=d[k].get("schemes",[]);print(s[0] if s else "")' 2>/dev/null || true)"
fi
[ -n "$SCHEME" ] || die "could not resolve a scheme (pass --scheme)."

# --- 3. Read build settings (team / version / build / bundle id) -----------
SETTINGS="$(xcodebuild "$PROJ_FLAG" "$PROJ_PATH" -scheme "$SCHEME" -configuration "$CONFIG" -showBuildSettings 2>/dev/null || true)"
get() { printf '%s\n' "$SETTINGS" | awk -v k="$1" '$1==k && $2=="=" {sub(/^[^=]*= /,"");print;exit}'; }
TEAM="$(get DEVELOPMENT_TEAM)"
BUNDLE="$(get PRODUCT_BUNDLE_IDENTIFIER)"
MKTVER="$(get MARKETING_VERSION)"
BUILDNO="$(get CURRENT_PROJECT_VERSION)"
[ -n "$VERSION" ] || VERSION="$MKTVER"
[ -n "$TEAM" ] || die "could not detect DEVELOPMENT_TEAM (set it in the project, or the project uses manual signing)."

# --- 4. Resolve ASC app id from the bundle id (for upload) ------------------
if [ "$DO_UPLOAD" = "1" ] && [ -z "$APP_ID" ]; then
  if command -v asc >/dev/null; then
    APP_ID="$(asc apps list --bundle-id "$BUNDLE" --output json 2>/dev/null \
      | python3 -c 'import sys,json
try:
  d=json.load(sys.stdin); rows=d if isinstance(d,list) else d.get("data",[])
  print((rows[0].get("id") if rows else "") or "")
except Exception: print("")' 2>/dev/null || true)"
  fi
  [ -n "$APP_ID" ] || die "could not resolve ASC app id for bundle '$BUNDLE' (pass --app, or check 'asc auth status')."
fi

[ -n "$OUTDIR" ] || OUTDIR="$(mktemp -d -t ios-archive)"
ARCHIVE="$OUTDIR/$SCHEME.xcarchive"
PLIST="$OUTDIR/ExportOptions.plist"
LOG="$OUTDIR/build.log"

cat <<EOF
── archive-ios-build plan ───────────────────────────────
  project   : $PROJ_PATH ($PROJ_FLAG)
  scheme    : $SCHEME
  config    : $CONFIG
  team      : $TEAM
  bundle id : $BUNDLE
  version   : ${VERSION:-?}   build: ${BUILDNO:-?}
  export to : $OUTDIR
  upload    : $([ "$DO_UPLOAD" = 1 ] && echo "yes -> asc app $APP_ID (submit=$DO_SUBMIT)" || echo "no")
─────────────────────────────────────────────────────────
EOF

[ "$DRY_RUN" = "1" ] && { note "dry run - nothing executed."; exit 0; }
[ -n "$VERSION" ] || die "no version (set MARKETING_VERSION or pass --version)."

# --- 5. Archive (Release, device). Do not pipe xcodebuild (pipe hides its
#        exit code via PIPESTATUS); tee to a log and check the real status. ---
note "archiving… (logs: $LOG)"
rm -rf "$ARCHIVE"
set +e
xcodebuild "$PROJ_FLAG" "$PROJ_PATH" -scheme "$SCHEME" -configuration "$CONFIG" \
  -destination "generic/platform=iOS" -archivePath "$ARCHIVE" \
  -allowProvisioningUpdates archive > "$LOG" 2>&1
RC=${PIPESTATUS[0]}
set -e
{ [ "$RC" -eq 0 ] && grep -q "ARCHIVE SUCCEEDED" "$LOG"; } || { tail -25 "$LOG" >&2; die "archive failed (rc=$RC). See $LOG"; }
[ -d "$ARCHIVE" ] || die "archive missing at $ARCHIVE despite success."
note "ARCHIVE SUCCEEDED - $ARCHIVE"

# --- 6. ExportOptions.plist (App Store, automatic signing) ------------------
cat > "$PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>method</key><string>app-store-connect</string>
  <key>teamID</key><string>$TEAM</string>
  <key>signingStyle</key><string>automatic</string>
  <key>uploadSymbols</key><true/>
  <key>destination</key><string>export</string>
</dict>
</plist>
EOF

# --- 7. Export the signed .ipa (creates Distribution cert/profile if needed) -
note "exporting App Store .ipa…"
set +e
xcodebuild -exportArchive -archivePath "$ARCHIVE" -exportOptionsPlist "$PLIST" \
  -exportPath "$OUTDIR/export" -allowProvisioningUpdates >> "$LOG" 2>&1
RC=${PIPESTATUS[0]}
set -e
{ [ "$RC" -eq 0 ] && grep -q "EXPORT SUCCEEDED" "$LOG"; } || {
  # Fallback for older Xcode that names the method "app-store" not "app-store-connect".
  if grep -qi "app-store-connect" "$LOG" && grep -qi "not a valid export method\|unsupported" "$LOG"; then
    note "retrying export with legacy method 'app-store'…"
    sed -i '' 's/app-store-connect/app-store/' "$PLIST"
    set +e
    xcodebuild -exportArchive -archivePath "$ARCHIVE" -exportOptionsPlist "$PLIST" \
      -exportPath "$OUTDIR/export" -allowProvisioningUpdates >> "$LOG" 2>&1
    RC=${PIPESTATUS[0]}; set -e
  fi
  { [ "$RC" -eq 0 ] && grep -q "EXPORT SUCCEEDED" "$LOG"; } || { tail -25 "$LOG" >&2; die "export failed (rc=$RC). See $LOG"; }
}
IPA="$(/bin/ls "$OUTDIR/export/"*.ipa 2>/dev/null | head -1 || true)"
[ -n "$IPA" ] || die "export reported success but no .ipa found in $OUTDIR/export."
note "EXPORT SUCCEEDED - $IPA"

# --- 8. Upload + attach to the version (no submit unless --submit) ----------
if [ "$DO_UPLOAD" = "0" ]; then
  echo "Done. Signed .ipa: $IPA  (upload skipped)"
  exit 0
fi
command -v asc >/dev/null || die "asc not found, but upload requested (use --no-upload, or install asc)."
note "uploading to App Store Connect (app $APP_ID, version $VERSION)…"
SUBMIT_FLAGS=()
[ "$DO_SUBMIT" = "1" ] && SUBMIT_FLAGS=(--submit --confirm)
# Expand a possibly-empty array safely under `set -u` (macOS bash 3.2 errors on
# "${arr[@]}" when arr is empty; the ${arr[@]+...} guard avoids "unbound variable").
asc publish appstore --app "$APP_ID" --ipa "$IPA" --version "$VERSION" \
  --platform IOS --wait --timeout "$TIMEOUT" ${SUBMIT_FLAGS[@]+"${SUBMIT_FLAGS[@]}"}
echo "Done. Build $BUILDNO ($VERSION) uploaded$([ "$DO_SUBMIT" = 1 ] && echo ' + submitted' || echo ' + attached (not submitted)')."
