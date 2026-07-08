import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/data/database/app_database.dart';
import 'package:botanisht/data/database/hydroponic_log.dart';

// Provide the database instance
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError(
    'AppDatabase instance must be provided. Override in main.dart with: '
    'appDatabaseProvider.overrideWithValue(appDatabaseInstance)'
  );
});

// Stream the latest logs
final latestHydroponicLogsProvider = StreamProvider.autoDispose.family<List<HydroponicLog>, int>((ref, limit) {
  return ref.watch(appDatabaseProvider).watchLatestLogs(limit: limit);
});

// Stream a specific zone's log
final latestLogForZoneProvider = StreamProvider.autoDispose.family<HydroponicLog?, String>((ref, zoneId) {
  return ref.watch(appDatabaseProvider).watchLatestLogForZone(zoneId);
});

// Stream specific telemetry
final latestPhStreamProvider = StreamProvider.autoDispose.family<double, String>((ref, zoneId) {
  return ref.watch(appDatabaseProvider).watchLatestPhForZone(zoneId);
});

final latestTdsStreamProvider = StreamProvider.autoDispose.family<double, String>((ref, zoneId) {
  return ref.watch(appDatabaseProvider).watchLatestTdsForZone(zoneId);
});
