import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/providers/plant_provider.dart';
import 'package:botanisht/providers/settings_provider.dart';
import 'package:botanisht/services/weather_alert_service.dart';

final weatherServiceProvider = Provider((ref) => WeatherAlertService());

/// True only when a valid 5-digit garden ZIP is set, so the dashboard can
/// prompt the user to enable weather alerts instead of relying on GPS.
final gardenLocationReadyProvider = Provider<bool>((ref) {
  final zip = ref.watch(settingsProvider).gardenZipCode;
  return zip != null && RegExp(r'^\d{5}$').hasMatch(zip);
});

/// Derives a contextual weather advisory for the user's garden, anchored to
/// the saved garden ZIP code (no device GPS).
///
/// On boot / first watch it returns the persisted cache instantly when it is
/// still fresh (< 4 hours), guaranteeing zero-lag startup. When the cache is
/// missing or stale it fires a foreground network refresh, then commits the
/// result (and the sync timestamp) back to Isar.
final weatherAlertProvider = FutureProvider<WeatherAlert?>((ref) async {
  final settings = ref.watch(settingsProvider);
  final zip = settings.gardenZipCode;
  if (zip == null || zip.isEmpty) return null;

  final last = settings.lastWeatherFetch;
  final fresh = last != null &&
      DateTime.now().difference(last) < const Duration(hours: 4);

  if (fresh && settings.cachedWeatherMessage != null) {
    return WeatherAlert(
      message: settings.cachedWeatherMessage!,
      plantNames: settings.cachedWeatherPlantNames ?? [],
    );
  }

  final plants = ref.watch(userPlantsProvider).valueOrNull ?? [];
  final alert = await ref.read(weatherServiceProvider).evaluate(plants, zip);
  ref.read(settingsProvider.notifier).cacheWeather(alert);
  return alert;
});

/// Persistent 4-hour refresh cycle. Watching this provider (e.g. from the
/// home screen) starts a background timer that re-syncs the weather advisory
/// at least every 4 hours for as long as the app is running.
final weatherAutoRefreshProvider = Provider<void>((ref) {
  final timer = Timer.periodic(const Duration(hours: 4), (_) {
    ref.invalidate(weatherAlertProvider);
  });
  ref.onDispose(timer.cancel);
});
