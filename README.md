# Botanisht 🌱

A **subscription-free, privacy-centric** plant care companion. Botanisht is a
local-first garden tracker: *your plants, your data, your device.* No accounts,
no cloud lock-in, no monthly fees — every measurement, photo path, and care
log is stored on-device in a fast, ACID-compliant local database.

Built for growers of every level — from a first windowsill herb to a full
hydroponic rig — Botanisht organizes your garden into focused zones, runs
smart cultivation engines entirely offline, and embraces universal design
principles with triple theming and strict contrast ratios.

---

## Table of Contents

- [Core Feature Architecture](#core-feature-architecture)
- [Technical Stack Blueprint](#technical-stack-blueprint)
- [First-Run Onboarding](#first-run-onboarding)
- [Developer Setup & Compilation Guide](#developer-setup--compilation-guide)
- [Project Layout](#project-layout)
- [License](#license)

---

## Core Feature Architecture

### Dynamic Multi-Zone Tracking
Plants are automatically routed into four independent environments based on
category, each with its own focused dashboard:

- **Indoor** — houseplants, ferns, succulents, and tropicals.
- **Hydro** — water-based growing; log pH, TDS, or pump cycles manually
  (no sensors required).
- **Kitchen** — herbs, vegetables, and edible flowers.
- **Diagnostics** — a unified health and alert view across every zone.

### Local Smart Engines
All intelligence runs on-device — no network round-trips, no telemetry leak:

- **Companion Planting Engine** — performs static rule lookups to warn you
  about nutrient competition or highlight beneficial synergies when plants
  share a zone.
- **Contextual Weather Alerts** — monitors the local forecast and, on storms,
  hail, freezing, or frost, scans outdoor zones and produces a "move inside"
  advisory for the affected plants.

### Universal Design & Accessibility
- **Adaptive Triple Theming**: Natural Cream (light), Deep Evergreen (dark), and a dedicated High-Contrast mode designed for absolute legibility.
- **WCAG AAA Compliance**: Enforces rigid contrast ratios across all themes to support low-vision users and outdoor readability under direct sunlight glare.
- **High-Legibility Typography**: Enhanced font weights and sizing throughout (bold headers ≥ 22sp, body text ≥ 18sp) to ensure effortless navigation.

### Comprehensive Care Data
- Hydroponics (optional): pH, TDS, and pump cycles logged manually — no hardware required.
- Quantity and growth tracking per plant.
- Local image-path referencing (photos stay on your device).

---

## Technical Stack Blueprint

| Layer              | Technology                                            |
|--------------------|-------------------------------------------------------|
| Frontend Framework | **Flutter** — cross-platform Dart execution          |
| State Architecture | **Riverpod** — predictable, unified data-flow mapping |
| Local Storage      | **Isar Database** — fast, lightweight, ACID NoSQL     |

The app isolates persistence (`Isar` collections + repositories), domain
state (`Riverpod` notifiers), and UI (`Widgets`) so features can be added or
audited independently — a clean surface for due-diligence and acquisition
review.

---

## First-Run Onboarding

New installs launch directly into a full-screen, high-visibility onboarding
tutorial (`lib/screens/onboarding_screen.dart`):

1. **Welcome** — the Botanisht logo and a plain-language pitch for the
   secure, local-first, privacy-focused philosophy.
2. **The Multi-Zone System** — introduces the Indoor, Hydro, Kitchen, and
   Diagnostics tabs and explains how plants route dynamically by category.
3. **Smart Cultivation** — explains the Companion Planting Engine and the
   Contextual Weather Alert system.
4. **Preferences Initialization** — lets the user pick Measurement System
   (Metric/Imperial), Temperature (Celsius/Fahrenheit), and Theme Mode
   (Cream / Evergreen / High Contrast) before tapping **Get Started**.

On completion the tutorial persists these preferences and flips the
`isFirstRun` flag in the `AppSettings` Isar collection to `false`, so all
future launches boot straight to the main dashboard. The flag is checked in
`lib/main.dart` before `runApp`.

---

## Developer Setup & Compilation Guide

### 1. Prerequisites
- Flutter SDK (>= 3.19) and Dart (>= 3.5)
- Android SDK (for APK builds) or Xcode (for iOS)
- An emulator, simulator, or physical device

### 2. Clone & install dependencies
```bash
git clone https://github.com/royabby365/botanisht.git
cd botanisht
flutter pub get
```

### 3. Populate local asset directories
The app bundles fallback catalog data. These assets already ship in
`assets/data/`:

- `assets/data/fallback_plants.json`
- `assets/data/plant_catalog.json`

If you fork or reset the repo, ensure both files exist under `assets/data/`
(or regenerate them from your plant source) so the catalog screen has a local
fallback when offline.

### 4. Run the Isar code generator
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
This regenerates the `*.g.dart` collection schemas (including `AppSettings`,
which carries the first-run and theme preferences).

### 5. Run in debug
```bash
flutter run
```
On first launch you'll see the onboarding tutorial; subsequent launches boot
directly to the dashboard.

### 6. Build a release APK
```bash
flutter build apk --release
```
The release artifact is emitted to
`build/app/outputs/flutter-apk/app-release.apk`.

---

## Project Layout

```
lib/
  core/theme/        # Triple-theme definitions + resolver
  models/            # Isar entities (plants, logs, settings)
  providers/         # Riverpod state (plants, settings)
  repository/        # Isar read/write access
  screens/           # Onboarding, Home (zones), Splash, Detail
  services/          # Companion rules, weather alerts, sensors
  widgets/           # Logo, cards, dialogs
assets/data/         # fallback_plants.json, plant_catalog.json
```

---

## License

See the repository license file. Botanisht is provided as-is for private,
subscription-free garden management.

[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/royabby)
