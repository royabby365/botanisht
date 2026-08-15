import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/models/hydroponic_log.dart';
import 'package:botanisht/repository/plant_repository.dart';

final plantRepositoryProvider = Provider((ref) => PlantRepository());

/// Stream of the latest hydroponic log for a specific zone
final latestLogForZoneProvider = StreamProvider.family.autoDispose<HydroponicLog?, String>((ref, zone) {
  final repository = ref.read(plantRepositoryProvider);
  return repository.watchLatestHydroponicLogForZone(zone);
});

/// Stream of all hydroponic logs for a zone
final hydroponicLogsForZoneProvider = StreamProvider.family.autoDispose<List<HydroponicLog>, String>((ref, zone) {
  final repository = ref.read(plantRepositoryProvider);
  return repository.watchHydroponicLogsForZone(zone);
});

/// Stream of ALL hydroponic logs (for the Hydroponic Log screen)
final hydroponicLogsProvider = StreamProvider.autoDispose<List<HydroponicLog>>((ref) {
  final repository = ref.read(plantRepositoryProvider);
  return repository.watchAllHydroponicLogs();
});