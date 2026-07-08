import 'package:dio/dio.dart';
import 'dart:async';
import 'package:botanisht/data/database/app_database.dart';

class LocalSensorService {
  final AppDatabase _db;
  final Dio _dio;
  Timer? _pollingTimer;

  LocalSensorService(this._db) : _dio = Dio();

  // Start polling a specific local IP/Endpoint every 30 seconds
  void startPolling(String zoneId, String endpointUrl) {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      await _fetchAndSaveSensorData(zoneId, endpointUrl);
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
  }

  Future<void> _fetchAndSaveSensorData(String zoneId, String url) async {
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;

        // Map incoming JSON payload directly to the Drift Companion
        final phValue = (data['pH'] as num?)?.toDouble() ?? 7.0;
        final tdsValue = (data['tds'] as num?)?.toDouble() ?? 0.0;
        final temperature = (data['temperature'] as num?)?.toDouble() ?? 22.0;
        final humidity = (data['humidity'] as num?)?.toDouble() ?? 50.0;

        await _db.insertLog(
          HydroponicLogsCompanion.insert(
            zoneId: zoneId,
            phValue: phValue,
            tdsValue: tdsValue,
            temperature: temperature,
            humidity: humidity,
            createdAt: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      // Handle or log connection failures silently to protect uptime
      print('Sensor Polling Error: $e');
    }
  }
}
