import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:botanisht/models/isar_user_plant.dart';

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

/// Local weather analyzer.
///
/// Tracks the current forecast and, when it turns severe (storms, hail,
/// freezing/frost), scans the user's garden for plants sitting in outdoor
/// zones and produces a move-inside advisory.
///
/// The forecast is loaded from a bundled asset (`assets/data/weather_forecast.json`)
/// so the engine works fully offline and deterministically. Swap [loadForecast]
/// for a real API call (e.g. Open-Meteo) when a network source is available.
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

  bool _isSevere(String condition) {
    final c = condition.toLowerCase();
    return _severeKeywords.any((k) => c.contains(k));
  }

  Future<WeatherAlert?> evaluate(List<UserPlant> plants) async {
    final forecast = await loadForecast();
    if (!_isSevere(forecast.condition)) return null;

    final atRisk = plants.where((p) {
      final z = (p.zone ?? '').toLowerCase();
      return _outdoorZones.any((oz) => z.contains(oz));
    }).toList();

    if (atRisk.isEmpty) return null;

    final names = atRisk.map((p) => p.customName ?? 'your plant').toList();
    final shown = names.take(3).join(', ');
    final extra = names.length > 3 ? ' and ${names.length - 3} more' : '';

    return WeatherAlert(
      message:
          '${forecast.condition} are in the forecast — you may want to move $shown$extra inside!',
      plantNames: names,
    );
  }
}
