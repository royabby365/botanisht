import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/repository/plant_repository.dart';
import 'package:botanisht/models/hydroponic_log.dart';

/// Provides a singleton instance of [PlantRepository].
final plantRepositoryProvider = Provider<PlantRepository>((ref) {
  return PlantRepository();
});

/// Stream of the most recent [HydroponicLog] from the local Isar database.
/// Emits null when no data is available yet.
final hydroponicLatestProvider =
    StreamProvider.autoDispose<HydroponicLog?>((ref) {
  final repository = ref.read(plantRepositoryProvider);
  return repository.watchLatestHydroponicLog();
});