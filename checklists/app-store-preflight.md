# App Store Preflight

- Release build succeeds
- Important device flows tested manually
- Metadata matches the build
- Privacy manifest is complete
- Entitlements and capabilities are intentional
- Subscription and restore flows are understandable
- Legal and support links resolve
- “Coming soon” features are not sold as live
- App icon and screenshots are final
- Review notes are ready if needed

## Privacy Manifest

Required when the app or any extension touches a Required Reason API. Miss it and Apple emails ITMS-91053 after upload.

- Add a `PrivacyInfo.xcprivacy` to the app target and to each extension target. With file-system-synchronized groups, a file dropped in the target's folder is auto-included.
- For a local, no-account app set `NSPrivacyTracking` = false, `NSPrivacyTrackingDomains` = [], `NSPrivacyCollectedDataTypes` = [].
- Declare `NSPrivacyAccessedAPITypes` for each Required Reason API you use. Common ones:
  - UserDefaults -> reason `CA92.1`
  - file timestamp (`.contentModificationDate` and friends) -> reason `C617.1`
  - system boot time -> reason `35F9.1`
  - disk space -> reason `E174.1`
- Verify it bundles. After a release build, the file must exist inside the `.app` and inside each `.appex`.

## Export Compliance

Declare encryption usage so you are not prompted or blocked at submit.

- Standard HTTPS is exempt.
- Set `ITSAppUsesNonExemptEncryption` in Info.plist, or answer the encryption question at upload.
- Pick the value that matches reality so the prompt never stalls the release.
