import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/repository/plant_repository.dart';
import 'package:botanisht/models/plant.dart';

// Provider for the PlantRepository (singleton)
final plantRepositoryProvider = Provider<PlantRepository>((ref) {
  // The repository will use the shared Isar instance.
  return PlantRepository();
});

// Provider that returns a list of all plants from the local database.
// This will be used by the home screen to display plants in tabs.
final allPlantsProvider = FutureProvider<List<Plant>>((ref) {
  final repo = ref.read(plantRepositoryProvider);
  return repo.getAllPlants();
});

// Optional: a notifier to allow refreshing or filtering.
class PlantListNotifier extends StateNotifier<AsyncValue<List<Plant>>> {
  final PlantRepository _repository;

  PlantListNotifier(this._repository) : super(const AsyncLoading()) {
    loadPlants();
  }

  Future<void> loadPlants() async {
    state = const AsyncLoading();
    try {
      final plants = await _repository.getAllPlants();
      state = AsyncData(plants);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> refresh() => loadPlants();
}

// Provider that exposes the notifier.
final plantListNotifierProvider =
    StateNotifierProvider<PlantListNotifier, AsyncValue<List<Plant>>>((ref) {
  final repo = ref.read(plantRepositoryProvider);
  return PlantListNotifier(repo);
});