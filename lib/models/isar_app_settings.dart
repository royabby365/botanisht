import 'package:isar/isar.dart';

part 'isar_app_settings.g.dart';

/// Per-zone environmental conditions and notes.
///
/// Stored as JSON inside [AppSettings.zoneConfigs] so it survives alongside
/// all other preferences without requiring a separate Isar collection.
class ZoneConfig {
  final String? sunExposure;
  final double? targetPh;
  final String? soilDrainage;
  final String? notes;
  final double? temperatureC;
  final int? humidityPercent;

  const ZoneConfig({
    this.sunExposure,
    this.targetPh,
    this.soilDrainage,
    this.notes,
    this.temperatureC,
    this.humidityPercent,
  });

  factory ZoneConfig.fromJson(Map<String, dynamic> json) => ZoneConfig(
        sunExposure: json['sunExposure'] as String?,
        targetPh: (json['targetPh'] as num?)?.toDouble(),
        soilDrainage: json['soilDrainage'] as String?,
        notes: json['notes'] as String?,
        temperatureC: (json['temperatureC'] as num?)?.toDouble(),
        humidityPercent: json['humidityPercent'] as int?,
      );

  Map<String, dynamic> toJson() => {
        if (sunExposure != null) 'sunExposure': sunExposure,
        if (targetPh != null) 'targetPh': targetPh,
        if (soilDrainage != null) 'soilDrainage': soilDrainage,
        if (notes != null) 'notes': notes,
        if (temperatureC != null) 'temperatureC': temperatureC,
        if (humidityPercent != null) 'humidityPercent': humidityPercent,
      };

  ZoneConfig copyWith({
    String? sunExposure,
    double? targetPh,
    String? soilDrainage,
    String? notes,
    double? temperatureC,
    int? humidityPercent,
    bool clearSunExposure = false,
    bool clearTargetPh = false,
    bool clearSoilDrainage = false,
    bool clearNotes = false,
    bool clearTemperatureC = false,
    bool clearHumidityPercent = false,
  }) {
    return ZoneConfig(
      sunExposure: clearSunExposure ? null : (sunExposure ?? this.sunExposure),
      targetPh: clearTargetPh ? null : (targetPh ?? this.targetPh),
      soilDrainage: clearSoilDrainage
          ? null
          : (soilDrainage ?? this.soilDrainage),
      notes: clearNotes ? null : (notes ?? this.notes),
      temperatureC:
          clearTemperatureC ? null : (temperatureC ?? this.temperatureC),
      humidityPercent:
          clearHumidityPercent ? null : (humidityPercent ?? this.humidityPercent),
    );
  }
}

/// Persisted application preferences (single-row settings collection).
///
/// Stored in Isar so theme, accessibility, and unit choices survive app
/// restarts. A [copyWith] is provided so the [SettingsNotifier] can produce
/// new immutable states cheaply.
@collection
class AppSettings {
  Id id = Isar.autoIncrement;

  // 0 = System default, 1 = Natural Cream (light), 2 = Evergreen (dark)
  // Evergreen is the app default (first-run onboarding renders in dark,
  // where all text is guaranteed high-contrast); Cream is an in-app choice.
  int themeMode = 2;

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

  /// Per-zone environmental conditions and notes, serialized as JSON.
  ///
  /// The value is a JSON-encoded `Map<String, ZoneConfig>` where each key is
  /// a zone name (e.g. "kitchen", "outdoor"). Deserialized on read via
  /// [ZoneConfig.fromJson].
  String? zoneConfigs;

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
    String? zoneConfigs,
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
          cachedWeatherPlantNames ?? this.cachedWeatherPlantNames
      ..zoneConfigs = zoneConfigs ?? this.zoneConfigs;
  }
}
