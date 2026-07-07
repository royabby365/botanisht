# Botanisht 🌿

A cross‑platform gardening and plant‑care app built with Flutter/Dart. Botanisht helps beginners (“botanist‑ish”) keep track of their plants, receive smart care schedules, sync with local climate data, log plant health, and monitor hydroponic systems—all with a clean, approachable UI.

## Features

- **Smart Care Schedules** – Dynamic watering, fertilizing, and pruning reminders based on plant species and indoor/outdoor placement.
- **Local Climate Sync** – Integration with Open‑Meteo (or similar) for frost alerts and planting windows.
- **Health & Diagnostic Log** – Track growth, log symptoms (e.g., yellowing leaves), and get basic troubleshooting advice.
- **Pet Safety** – Flag whether a plant is safe for cats and dogs.
- **Environment Categories** – Organize plants into:
  - Indoor Jungle
  - Kitchen Garden
  - Pollinator Yard
  - Native Meadow
  - Hydroponics
  - Permeable Landscape
  - Botanical Bento
- **Hydroponic Monitoring** – Log and view live pH, TDS, pump‑cycle data from local wireless gauges.
- **Local‑First Data** – All plant and sensor data stored on‑device using Isar (with optional sync to OpenFarm API).
- **State Management** – Riverpod for reactive UI updates.
- **Branding** – Simple green text logo where the ‘o’ is replaced by a green thumb, the letters “ish” are italicized, and a small leaf icon follows the word.

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=2.19.0)
- An IDE (Android Studio, VS Code, or IntelliJ) with Flutter & Dart plugins.
- A device or emulator (Android/iOS/web) for testing.

### Setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/royabby365/botanisht.git
   cd botanisht
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **(Optional) Run the build generator** – required for Isar and JSON serializable code.

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**

   ```bash
   flutter run
   ```

   Choose a device or emulator when prompted.

### Project Structure

```
lib/
├─ main.dart                 # App entry point, Isar init, Riverpod ProviderScope
├─ models/                   # Data models (Plant, PlantEntity, HydroponicLog, etc.)
├─ services/                 # API & sensor services (OpenFarm, Weather, LocalSensor)
├─ repository/               # PlantRepository (Isar + API fallback)
├─ providers/                # Riverpod providers (plant list, hydroponic telemetry)
├─ screens/                  # UI screens (HomeScreen with tabbed dashboard)
└─ widgets/                  # Reusable widgets (HydroponicDashboardCard, etc.)
```

### Key Files

- `lib/models/isar_plant_entity.dart` – Isar entity for plants, includes `EnvironmentCategory` enum and `isPetSafe` flag.
- `lib/models/hydroponic_log.dart` – Isar entity for hydroponic telemetry (pH, TDS, pump cycle, timestamp).
- `lib/services/local_sensor_service.dart` – Polls a local JSON endpoint and saves readings to `HydroponicLog`.
- `lib/widgets/hydroponic_dashboard_card.dart` – Reactive card showing the latest pH/TDS values.
- `lib/providers/hydroponic_provider.dart` – Riverpod `StreamProvider` that watches the most recent `HydroponicLog`.
- `lib/screens/home_screen.dart` – Tabbed dashboard (horizontal, scrollable) for all plant categories.
- `lib/services/weather_service.dart` – Wrapper around Open‑Meteo for frost‑warning logic.

### Contributing

Feel free to open issues or submit pull requests. Please follow the existing code style and write tests for new logic.

### License

This project is open source and available under the [MIT License](LICENSE).

---

Enjoy growing with Botanisht! 🌱💧🌞