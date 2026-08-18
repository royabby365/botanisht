# Publishing Botanisht — Step-by-Step

## Part 1: Google Play

### What's already done in the repo (v3.3.0)
- Application ID changed: `com.example.botanisht` → `com.royabernathy.botanisht`
  (cannot be changed again after first upload — this is THE identifier)
- Release signing: `android/upload-keystore.jks` (alias `botanisht`) with
  `android/key.properties` (gitignored). The AAB is signed with this upload key.
- targetSdk 35 (required by Play for 2026 updates), compileSdk 35.
- Proper launcher icons (adaptive + legacy), Play 512px icon, feature graphic.
- Store screenshots in `store/screenshots/` (1080x1920).
- Plant catalog expanded to 121 plants.
- Privacy policy + listing copy in `store/`.

### Back this up first
```
android/upload-keystore.jks
android/key.properties   (contains the signing passwords)
```
Copy both to a Google Drive / password manager. Lose the keystore
and you can still recover via Play's "reset upload key" flow, but it's a
pain — back it up first.

### Console steps (accounts → upload)
1. Create a Google Play Developer account (one-time $25):
   https://play.google.com/console/signup — use your personal Google account
   (the one tied to royabby365).
2. Play Console → "Create app" → name **Botanisht**, default language
   English (US), app type **App**, category **Lifestyle** → Create.
3. **Set up app access**: all pages complete (app is fully functional).
4. **App content** form:
   - Privacy policy → host `store/privacy_policy.md` (GitHub Pages or
     botanisht.com/privacy) and paste the URL.
   - Data safety → "No data collected" (the app is local-first). Declare
     that no data is shared or collected.
   - Ads → No.
   - Content rating → complete the questionnaire (Everyone; no
     mature/violent content; be honest about the IARC questions — the app
     has no user-generated content, no ads, no purchases).
   - Target audience → 13+ (no directed-to-children).
   - News apps / Health apps declarations → not applicable.
5. **Production → Create release**:
   - Upload `build/app/outputs/bundle/release/app-release.aab`.
   - Enter release notes:
     ```
     First release of Botanisht! A local-first garden companion with
     121 plants, care tracking, companion planting alerts, hydroponic
     logging, diagnostics, and an optional Pro tier (honor system).
     ```
   - Rollout → 100% (or start with internal/closed testing first — see below).
6. **Store listing**: paste copy from `store/listing_copy.md`, upload the
   512px icon, feature graphic, and 6 screenshots from `store/screenshots/`.
7. **Monetization**: none / no products.
8. Click **Review app** and submit. Typical review: 2–7 days (first release
   often slower).

### Recommended: test before production
Use **Testing → Internal testing** first:
1. Create a track, add the AAB, add yourself (the email on your Play
   account) as a tester.
2. Accept the tester invite, install via the Play Store link, verify.
3. Promote the same release to Production once you're happy.

### Rebuilding the AAB for future updates
```
cd /home/rabby/botanisht
flutter build appbundle --release
# bump version in pubspec.yaml first (e.g. 3.3.0 -> 3.3.1)
```
Upload the new AAB to the same release track. Keep versionCode increasing.

---

## Part 2: Apple App Store (needs a Mac — prep is done in the repo)

### The blocker
iOS builds require Xcode on macOS. Everything else is prepared:
- iOS bundle ID set to `com.royabernathy.botanisht` (Runner.xcodeproj).
- All dependencies (Isar, url_launcher, flutter_svg, notifications) are
  iOS-compatible; the project has iOS scaffolding.
- App icon: you'll need a 1024x1024 App Store icon (the 512px version in
  `store/icon-512.png` can be upscaled, or regenerate from logo.svg).

### On the Mac
1. Buy an Apple Developer Program membership ($99/year):
   https://developer.apple.com/programs/ — needed for store distribution.
2. Install Xcode from the App Store + `sudo xcodebuild -runFirstLaunch`,
   then `brew install cocoapods`.
3. Clone the repo and:
   ```
   cd botanisht
   flutter pub get
   cd ios && pod install && cd ..
   flutter build ios --release --no-codesign
   ```
   If Isar codegen is needed: `dart run build_runner build` first.
4. **App Store Connect** (https://appstoreconnect.apple.com):
   - Create the app (Bundle ID `com.royabernathy.botanisht`, name Botanisht).
   - Set up the app icon, screenshots (6.9"/6.5"/5.5" sizes — capture on a
     real iPhone or simulator), description from `store/listing_copy.md`.
   - Privacy policy URL (same hosted policy as Play).
   - App Privacy → "Data Not Collected" (declare the same data-safety story).
5. Signing: in Xcode, set your team under Signing & Capabilities
   (Automatically manage signing). Xcode generates the certificates +
   provisioning profiles.
6. Archive: Xcode → Product → Archive → Distribute → App Store Connect.
7. Submit for review (24–48h typical).

### Apple-specific notes
- Notifications: iOS will ask to enable push/local notifications — you use
  local notifications only, so no push entitlement is required. The first
  run prompts for local notification permission on iOS 17+; fine for review.
- The App Store review will check for an account-deletion option only if you
  offer accounts — you don't, so nothing to add.

---

## Post-launch checklist
- [ ] Back up keystore + key.properties (Play) — DO THIS FIRST
- [ ] Host privacy policy and give both stores the URL
- [ ] Internal testing on Play → install → verify → promote to production
- [ ] Buy Apple Developer Program + build iOS on a Mac
- [ ] Update botanisht.com with App Store + Play badges
- [ ] After first store release: Telegram announcement with links

## Files at a glance
```
store/
  01-06 screenshots     — 1080x1920 captures from the emulator
  icon-512.png          — Play Store icon
  feature_graphic.png   — 1024x500 Play feature graphic
  listing_copy.md       — titles/descriptions/keywords for both stores
  privacy_policy.md     — local-first privacy policy (host it)
android/upload-keystore.jks — THE upload keystore (back it up!)
```
