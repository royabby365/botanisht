import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/services/notification_service.dart';

/// A single atmospheric forecast reading.
class WeatherForecast {
  final String condition; // e.g. "Scattered Storms"
  final double? temperatureC;

  WeatherForecast({required this.condition, this.temperatureC});
}

/// A derived advisory for the user's garden.
class WeatherAlert {
  final String message;
  final List<String> plantNames;

  WeatherAlert({required this.message, required this.plantNames});
}

/// Local, privacy-first weather analyzer.
///
/// Garden location is anchored to a saved 5-digit ZIP code — the app never
/// requests device GPS or location permissions. Coordinates are resolved
/// through a keyless public geocoding API (with a small offline fallback
/// table), and the forecast is fetched from Open-Meteo (also keyless). When
/// offline, a bundled asset keeps the engine deterministic.
class WeatherAlertService {
  static const List<String> _severeKeywords = [
    'storm',
    'hail',
    'freezing',
    'frost',
    'snow',
    'hurricane',
    'tornado',
    'thunder',
  ];

  // Zones whose plants are physically exposed to the elements.
  static const List<String> _outdoorZones = [
    'kitchen',
    'outdoor',
    'garden',
    'balcony',
    'patio',
    'yard',
    'backyard',
  ];

  // Small offline fallback table (US ZIP → lat/lon) used when the geocoding
  // API is unreachable. Covers a few common codes; everything else falls back
  // to a central-US coordinate.
  static const Map<String, ({double latitude, double longitude})> _zipFallback = {
    '62220': (latitude: 38.8108, longitude: -89.9445), // Edwardsville, IL
    '10001': (latitude: 40.7128, longitude: -74.0060), // New York, NY
    '90210': (latitude: 34.0901, longitude: -118.4065), // Beverly Hills, CA
    '60601': (latitude: 41.8781, longitude: -87.6298), // Chicago, IL
    '94105': (latitude: 37.7905, longitude: -122.3893), // San Francisco, CA
    '73301': (latitude: 30.2672, longitude: -97.7431), // Austin, TX
    '98101': (latitude: 47.6101, longitude: -122.3344), // Seattle, WA
    '33101': (latitude: 25.7617, longitude: -80.1918), // Miami, FL
  };

  static const _defaultCoords = (latitude: 39.5, longitude: -98.35);

  /// Loads the bundled forecast asset (offline deterministic fallback).
  Future<WeatherForecast> loadForecast() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/weather_forecast.json');
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      return WeatherForecast(
        condition: (data['condition'] as String?) ?? 'Clear',
        temperatureC: (data['temperature_c'] as num?)?.toDouble(),
      );
    } catch (_) {
      return WeatherForecast(condition: 'Clear');
    }
  }

  /// Resolves a US ZIP to coordinates via a keyless geocoding API, falling
  /// back to the offline table, then a central-US default.
  Future<({double latitude, double longitude})> resolveZip(String zip) async {
    try {
      final resp = await http.get(Uri.https('api.zippopotam.us', 'us/$zip'));
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body) as Map<String, dynamic>;
        final place = (data['places'] as List).first as Map<String, dynamic>;
        final lat = double.tryParse(place['latitude'] as String);
        final lon = double.tryParse(place['longitude'] as String);
        if (lat != null && lon != null) {
          return (latitude: lat, longitude: lon);
        }
      }
    } catch (_) {
      // Network unavailable — fall through to the local table.
    }
    final fallback = _zipFallback[zip];
    if (fallback != null) return fallback;
    return _defaultCoords;
  }

  /// Fetches the current forecast for the given coordinates from Open-Meteo
  /// (keyless, privacy-friendly). Falls back to the bundled asset offline.
  Future<WeatherForecast> fetchForecast(double lat, double lon) async {
    try {
      final resp = await http.get(Uri.https('api.open-meteo.com', 'v1/forecast',
          {
            'latitude': lat.toStringAsFixed(4),
            'longitude': lon.toStringAsFixed(4),
            'current': 'temperature_2m,weather_code',
          }));
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body) as Map<String, dynamic>;
        final current = data['current'] as Map<String, dynamic>;
        final code = (current['weather_code'] as num?)?.toInt() ?? 0;
        final tempC = (current['temperature_2m'] as num?)?.toDouble();
        return WeatherForecast(
          condition: _weatherCodeToCondition(code),
          temperatureC: tempC,
        );
      }
    } catch (_) {
      // Offline — use the bundled asset as a deterministic fallback.
    }
    return loadForecast();
  }

  String _weatherCodeToCondition(int code) {
    // WMO weather interpretation codes → a condition string that contains the
    // severe keywords so _isSevere() can detect storms/frost/freezing/snow.
    if (code >= 71 && code <= 77) return 'Snow';
    if (code >= 85 && code <= 86) return 'Snow Showers';
    if (code >= 95) return 'Thunderstorm';
    if (code == 56 || code == 57 || code == 66 || code == 67) {
      return 'Freezing Rain';
    }
    if (code >= 80 && code <= 82) return 'Rain Showers';
    if (code >= 51 && code <= 67) return 'Drizzle';
    if (code >= 45 && code <= 48) return 'Fog';
    return 'Clear';
  }

  bool _isSevere(String condition) {
    final c = condition.toLowerCase();
    return _severeKeywords.any((k) => c.contains(k));
  }

  /// Produces a move-inside advisory for outdoor plants when the forecast
  /// (resolved from the garden ZIP) turns severe.
  Future<WeatherAlert?> evaluate(List<UserPlant> plants, String zip) async {
    final coords = await resolveZip(zip);
    final forecast = await fetchForecast(coords.latitude, coords.longitude);
    if (!_isSevere(forecast.condition)) return null;

    final atRisk = plants.where((p) {
      final z = (p.zone ?? '').toLowerCase();
      return _outdoorZones.any((oz) => z.contains(oz));
    }).toList();

    if (atRisk.isEmpty) return null;

    final names = atRisk.map((p) => p.customName ?? 'your plant').toList();
    final shown = names.take(3).join(', ');
    final extra = names.length > 3 ? ' and ${names.length - 3} more' : '';

    // Also surface the advisory in the device system tray so it reaches the
    // user even when the app is minimised or the phone is locked.
    NotificationService.instance.showWeatherAlert();
    return WeatherAlert(
      message:
          'Storms/Frost in the forecast — you may want to move your outdoor $shown$extra inside!',
      plantNames: names,
    );
  }
}
