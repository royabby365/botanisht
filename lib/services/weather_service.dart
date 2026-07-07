import 'dart:convert';
import 'package:http/http.dart' as http;

/// Simple wrapper around the free Open-Meteo API.
/// Provides current temperature and a 7-day forecast (daily max/min).
class WeatherService {
  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  /// Fetch weather data for a given latitude/longitude.
  /// Returns a map with:
  ///   - currentTemperature (°C)
  ///   - daily containing time, temperature_2m_max, temperature_2m_min
  Future<Map<String, dynamic>> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'current_weather': 'true',
        'daily': 'temperature_2m_max,temperature_2m_min',
        'timezone': 'auto',
      },
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception(
          'Failed to load weather data: ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    // Normalise the response for easier consumption elsewhere
    return {
      'currentTemperature':
          (json['current_weather'] as Map<String, dynamic>)['temperature'],
      'daily': {
        'time': (json['daily'] as Map<String, dynamic>)['time'] as List<dynamic>,
        'temperature_2m_max':
            (json['daily'] as Map<String, dynamic>)['temperature_2m_max']
                as List<dynamic>,
        'temperature_2m_min':
            (json['daily'] as Map<String, dynamic>)['temperature_2m_min']
                as List<dynamic>,
      },
    };
  }

  /// Convenience: check if any of the next 7 days forecast drops below freezing.
  /// Returns true if a frost warning should be issued.
  Future<bool> willFreezeInNext7Days({
    required double latitude,
    required double longitude,
  }) async {
    final data = await fetchWeather(latitude: latitude, longitude: longitude);
    final daily = data['daily'] as Map<String, dynamic>;
    final List<dynamic> mins = daily['temperature_2m_min'] as List<dynamic>;

    // Check the next 7 days (including today) for any temperature < 0°C
    for (var i = 0; i < mins.length && i < 7; i++) {
      final temp = mins[i] as double?;
      if (temp != null && temp < 0) {
        return true;
      }
    }
    return false;
  }
}
