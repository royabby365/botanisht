import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import '../models/hydroponic_log.dart';

/// Service responsible for pulling sensor data from a local network endpoint
/// (e.g., ESP32, Arduino, Raspberry Pi) and persisting it as a [HydroponicLog].
class LocalSensorService {
  final Isar _isar;
  final http.Client _httpClient;

  LocalSensorService(this._isar, this._httpClient);

  /// Fetch a JSON payload from the supplied [url].
  /// Expected keys (case‑insensitive, aliases accepted):
  ///   - pH / waterPH -> double
  ///   - tds / nutrientTDS -> double (ppm)
  ///   - pumpInterval / pumpCycleMinutes -> int (minutes)
  ///   - temperature / temp -> double (°C)  // optional, not stored
  ///   - humidity / hum -> double (%RH)   // optional, not stored
  ///   - notes -> String (optional free‑form)
  Future<Map<String, dynamic>> _fetchJson(String url) async {
    final uri = Uri.parse(url);
    final response = await _httpClient.get(uri);
    if (response.statusCode != 200) {
      throw Exception(
          'Failed to fetch sensor data: ${response.statusCode} ${response.reasonPhrase}');
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  /// Parse the raw JSON map and store it as a new HydroponicLog.
  /// Returns the saved log with its assigned ID.
  Future<HydroponicLog> saveSensorData(String url) async {
    final json = await _fetchJson(url);

    // Helper to get a double from various possible keys
    double? getDouble(String key1, [String? key2]) {
      final v1 = json[key1] as double?;
      if (v1 != null) return v1;
      if (key2 != null) {
        final v2 = json[key2] as double?;
        return v2;
      }
      return null;
    }

    // Helper to get an int from various possible keys
    int? getInt(String key1, [String? key2]) {
      final v1 = json[key1] as int?;
      if (v1 != null) return v1;
      if (key2 != null) {
        final v2 = json[key2] as int?;
        return v2;
      }
      return null;
    }

    final log = HydroponicLog()
      ..waterPH = getDouble('ph', 'waterPH')
      ..nutrientTds = getDouble('tds', 'nutrientTDS')
      ..pumpCycleMinutes = getInt('pumpInterval', 'pumpCycleMinutes')
      ..timestamp = DateTime.now()
      ..notes = json['notes'] as String?;

    final id = await _isar.writeTxn(() => _isar.hydroponicLogs.put(log));
    log.id = id;
    return log;
  }

  /// Convenience: fetch from [url] and immediately persist.
  Future<HydroponicLog> fetchAndStore(String url) => saveSensorData(url);

  /// Returns a stream that emits a new [HydroponicLog] each time fresh data
  /// is fetched and stored from [url] at the given [interval].
  /// The caller should cancel the returned [StreamSubscription] when done.
  Stream<HydroponicLog> pollAndStore(String url, Duration interval) async* {
    while (true) {
      try {
        final log = await saveSensorData(url);
        yield log;
      } catch (e) {
        // Optionally emit an error object; here we re‑throw to stop the stream.
        rethrow;
      }
      await Future.delayed(interval);
    }
  }
}