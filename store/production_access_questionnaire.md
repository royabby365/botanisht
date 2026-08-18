# Botanisht — Production Access Questionnaire

Answers for Google's "Apply for production access" form, covering app
design, testing process, and production readiness for the v3.3.0
closed-test submission.

---

## Q: How do users interact with your app? What is the core functionality?
**A:** Botanisht is a local-first garden companion. Users organize plants
into zones (Indoor, Kitchen, Hydroponic, Pollinator, Outdoor), track care
history (watering, fertilizing, pruning, measurements), get companion-plant
and clash alerts computed against their own garden, and log hydroponic
environment data (pH, TDS, temperature, humidity, light hours). Everything
is stored on-device in a local Isar database. There is no account, no cloud
sync, and no location permission — optional severe-weather advisories use a
manually entered ZIP code.

## Q: Describe your testing process / how the app was tested before this release.
**A:** The app was developed publicly on GitHub (royabby365/botanisht) with
a release build validated on a physical Android device and an emulator
across multiple versions. The closed-test track has been live for 14+ days
with 12+ opted-in testers. Testers installed from the Play Store link and
kept the app installed for the full period; feedback was collected in the
repo's issues/discussions. Crash reporting is handled on-device (local
logging only; no analytics SDKs are present in the app).

## Q: How do you plan to handle user feedback and support after release?
**A:** Support is handled through the public GitHub repository (issues and
discussions) and a support email (roy@royabernathy.info). Bug reports are
triaged in the repo, and updates are released as new AABs via the Play
Console with incrementing version codes. Release notes accompany every
version.

## Q: How do you test app updates / handle regressions?
**A:** Every release is built with `flutter analyze` clean of blocking
warnings and validated on a physical Android device before upload. The
app uses on-device data migration (Isar) so updates preserve existing user
gardens. The closed test track is reused for significant feature releases
before they are promoted to production.

## Q: How does the app handle data privacy and security?
**A:** Botanisht is local-first by design. All user data — plants, care
logs, zones, and settings — is stored exclusively on the user's device.
No personal data is collected, uploaded, or shared. The app declares no
permissions beyond INTERNET (for optional weather advisories) and
POST_NOTIFICATIONS (for local care reminders). See the privacy policy at
https://botanisht.com/privacy/

## Q: Does the app comply with Google Play policies (content, ads, payments)?
**A:** Yes. The app is rated Everyone, contains no ads, no in-app
purchases, and no user-generated content. Botanisht Pro is an honor-system
tier unlocked in-app for free; there is no payment mechanism in the app and
no Play Billing integration. Donations are offered externally (GitHub
Sponsors / Buy Me a Coffee) outside the app.

## Q: What is your app's monetization model?
**A:** The app is free with no ads and no subscriptions. An optional
"Pro" tier (garden scoreboard, XP, expanded catalog) is unlocked entirely
on the honor system — users can use it without paying. Donations are
accepted through external links on the project website. No Play Billing.

## Q: How is the app available / distributed?
**A:** The app targets Android (minSdk via Flutter default, targetSdk 35,
arm64). It is currently distributed through the Play closed-test track and
will roll out to production once access is granted. The project is
open-source (MIT) at https://github.com/royabby365/botanisht

---

## Quick facts (in case the form asks them separately)

- App name: Botanisht
- Package: com.royabernathy.botanisht
- Version at submission: 3.3.0 (versionCode 10)
- Support email: roy@royabernathy.info
- Privacy policy URL: https://botanisht.com/privacy/
- Website: https://botanisht.com
- Open source: https://github.com/royabby365/botanisht
- Data safety declaration: No data collected / No data shared / No ads /
  No Play Billing
