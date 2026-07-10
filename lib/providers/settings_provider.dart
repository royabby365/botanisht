import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/repository/plant_repository.dart';
import 'package:botanisht/models/isar_app_settings.dart';
import 'package:botanisht/models/plant.dart';
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
    _repository.saveSettings(state);
  }

  /// Persists the garden ZIP code used to anchor weather alerts (no GPS).
  void setGardenZip(String? zip) {
    state = state.copyWith(gardenZipCode: zip);
    _repository.saveSettings(state);
  }

  /// Writes the latest weather advisory and sync timestamp to Isar so the
  /// dashboard can boot with zero lag from the local cache.
  void cacheWeather(WeatherAlert? alert) {
    state = state.copyWith(
      lastWeatherFetch: DateTime.now(),
      cachedWeatherMessage: alert?.message,
      cachedWeatherPlantNames: alert?.plantNames,
    );
    _repository.saveSettings(state);
  }
}
