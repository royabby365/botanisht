import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/models/isar_app_settings.dart';
import 'package:botanisht/repository/settings_repository.dart';
import 'package:botanisht/services/weather_alert_service.dart';
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository();
});

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  final repo = ref.read(settingsRepositoryProvider);
  return SettingsNotifier(repo);
});

class SettingsNotifier extends StateNotifier<AppSettings> {
  final SettingsRepository _repo;

  SettingsNotifier(this._repo) : super(AppSettings()) {
    _load();
  }

  Future<void> _load() async {
    state = await _repo.getSettings();
  }

  Future<void> _persist() => _repo.saveSettings(state);

  void setThemeMode(int value) {
    state = state.copyWith(themeMode: value);
    _persist();
  }

  void setHighContrast(bool value) {
    state = state.copyWith(highContrast: value);
    _persist();
  }

  void setUnits(int value) {
    state = state.copyWith(units: value);
    _persist();
  }

  void setTemperatureScale(int value) {
    state = state.copyWith(temperatureScale: value);
    _persist();
  }

  /// Persists the preferences chosen on the first-run onboarding tutorial and
  /// flips [AppSettings.isFirstRun] to `false` so subsequent launches boot
  /// straight to the main dashboard.
  void completeOnboarding({
    required int themeMode,
    required bool highContrast,
    required int units,
    required int temperatureScale,
    String? gardenZipCode,
  }) {
    state = state.copyWith(
      themeMode: themeMode,
      highContrast: highContrast,
      units: units,
      temperatureScale: temperatureScale,
      gardenZipCode: gardenZipCode,
      isFirstRun: false,
    );
    _repo.saveSettings(state);
  }

  /// Persists the garden ZIP code used to anchor weather alerts (no GPS).
  void setGardenZip(String? zip) {
    state = state.copyWith(gardenZipCode: zip);
    _repo.saveSettings(state);
  }

  /// Writes the latest weather advisory and sync timestamp to Isar so the
  /// dashboard can boot with zero lag from the local cache.
  void cacheWeather(WeatherAlert? alert) {
    state = state.copyWith(
      lastWeatherFetch: DateTime.now(),
      cachedWeatherMessage: alert?.message,
      cachedWeatherPlantNames: alert?.plantNames,
    );
    _repo.saveSettings(state);
  }

  // ---------------------------------------------------------------------------
  // Zone config helpers
  // ---------------------------------------------------------------------------

  /// Deserialises the zone config map from [state.zoneConfigs].
  Map<String, ZoneConfig> getAllZoneConfigs() {
    final raw = state.zoneConfigs;
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return decoded.map((k, v) =>
          MapEntry(k, ZoneConfig.fromJson(v as Map<String, dynamic>)));
    } catch (_) {
      return {};
    }
  }

  /// Returns the [ZoneConfig] for a single zone, or `null` if none is stored.
  ZoneConfig? getZoneConfig(String zoneName) {
    return getAllZoneConfigs()[zoneName.toLowerCase().trim()];
  }

  /// Merges [config] into the stored settings for [zoneName] and persists.
  void updateZoneConfig(String zoneName, String config) {
    final key = zoneName.toLowerCase().trim();
    final all = getAllZoneConfigs();
    all[key] = ZoneConfig.fromJson(jsonDecode(config) as Map<String, dynamic>);
    state = state.copyWith(zoneConfigs: jsonEncode(all));
    _repo.saveSettings(state);
  }

  /// Convenience: accepts a [ZoneConfig] object directly.
  void setZoneConfig(String zoneName, ZoneConfig config) {
    final key = zoneName.toLowerCase().trim();
    final all = getAllZoneConfigs();
    all[key] = config;
    state = state.copyWith(zoneConfigs: jsonEncode(all));
    _repo.saveSettings(state);
  }
}
