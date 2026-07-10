import 'package:isar/isar.dart';

part 'isar_app_settings.g.dart';

/// Persisted application preferences (single-row settings collection).
///
/// Stored in Isar so theme, accessibility, and unit choices survive app
/// restarts. A [copyWith] is provided so the [SettingsNotifier] can produce
/// new immutable states cheaply.
@collection
class AppSettings {
  Id id = Isar.autoIncrement;

  // 0 = System default, 1 = Natural Cream (light), 2 = Evergreen (dark)
  int themeMode = 0;

  // High-contrast accessibility mode.
  bool highContrast = false;

  // 0 = Metric (cm / m), 1 = Imperial (in / ft)
  int units = 0;

  // 0 = Celsius, 1 = Fahrenheit
  int temperatureScale = 0;

  /// True until the user finishes the first-run onboarding tutorial.
  ///
  /// Checked in [main] to decide whether to route to [OnboardingScreen] or
  /// straight to the main dashboard. Defaults to `true` so a brand-new
  /// install always lands on the tutorial.
  bool isFirstRun = true;

  /// Optional garden location used to anchor weather alerts. Stored as a
  /// 5-digit US ZIP code so the app never needs device GPS or location
  /// permissions — fully privacy-friendly and local-first.
  String? gardenZipCode;

  /// Timestamp of the last successful weather sync, used to enforce the
  /// 4-hour cache freshness window.
  DateTime? lastWeatherFetch;

  /// Persisted storm/frost advisory so the dashboard can boot with zero lag.
  String? cachedWeatherMessage;
  List<String>? cachedWeatherPlantNames;

  AppSettings();

  AppSettings copyWith({
    int? themeMode,
    bool? highContrast,
    int? units,
    int? temperatureScale,
    bool? isFirstRun,
    String? gardenZipCode,
    DateTime? lastWeatherFetch,
    String? cachedWeatherMessage,
    List<String>? cachedWeatherPlantNames,
  }) {
    return AppSettings()
      ..id = id
      ..themeMode = themeMode ?? this.themeMode
      ..highContrast = highContrast ?? this.highContrast
      ..units = units ?? this.units
      ..temperatureScale = temperatureScale ?? this.temperatureScale
      ..isFirstRun = isFirstRun ?? this.isFirstRun
      ..gardenZipCode = gardenZipCode ?? this.gardenZipCode
      ..lastWeatherFetch = lastWeatherFetch ?? this.lastWeatherFetch
      ..cachedWeatherMessage =
          cachedWeatherMessage ?? this.cachedWeatherMessage
      ..cachedWeatherPlantNames =
          cachedWeatherPlantNames ?? this.cachedWeatherPlantNames;
  }
}
