import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/repository/plant_repository.dart';
import 'package:botanisht/models/plant.dart';
import 'package:botanisht/models/isar_user_plant.dart';

// Provider for the PlantRepository (singleton)
final plantRepositoryProvider = Provider<PlantRepository>((ref) {
  return PlantRepository();
});

// Provider that returns a list of all plants from the local database (cached API plants).
final allPlantsProvider = FutureProvider<List<Plant>>((ref) {
  final repo = ref.read(plantRepositoryProvider);
  return repo.getAllPlants();
});

// Provider for user's plants (their garden) - stream for real-time updates.
final userPlantsProvider = StreamProvider<List<UserPlant>>((ref) {
  final repo = ref.read(plantRepositoryProvider);
  return repo.watchUserPlants();
});

// Provider for user's plants sorted by acquisition date.
final userPlantsSortedProvider = FutureProvider<List<UserPlant>>((ref) {
  final repo = ref.read(plantRepositoryProvider);
  return repo.getUserPlantsSorted();
});

// Provider for plants needing water.
final plantsNeedingWaterProvider = FutureProvider<List<UserPlant>>((ref) {
  final repo = ref.read(plantRepositoryProvider);
  return repo.getPlantsNeedingWater();
});

// Optional: a notifier to allow refreshing or filtering cached API plants.
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

// Notifier for user plant actions.
class UserPlantNotifier extends StateNotifier<AsyncValue<void>> {
  final PlantRepository _repository;

  UserPlantNotifier(this._repository) : super(const AsyncData(null));

  Future<void> addFromEntity(int plantEntityId, {
    String? customName,
    String? location,
    String? potSize,
    String? soilType,
    DateTime? acquiredDate,
    String? source,
  }) async {
    state = const AsyncLoading();
    try {
      await _repository.addUserPlantFromEntity(
        plantEntityId,
        customName: customName,
        location: location,
        potSize: potSize,
        soilType: soilType,
        acquiredDate: acquiredDate,
        source: source,
      );
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> addCustom({
    required String name,
    String? customName,
    String? location,
    String? potSize,
    String? soilType,
    DateTime? acquiredDate,
    String? source,
    String? lightConditions,
    String? temperatureRange,
    String? humidityLevel,
    List<String>? tags,
  }) async {
    state = const AsyncLoading();
    try {
      await _repository.addCustomUserPlant(
        name: name,
        customName: customName,
        location: location,
        potSize: potSize,
        soilType: soilType,
        acquiredDate: acquiredDate,
        source: source,
        lightConditions: lightConditions,
        temperatureRange: temperatureRange,
        humidityLevel: humidityLevel,
        tags: tags,
      );
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> update(UserPlant plant) async {
    state = const AsyncLoading();
    try {
      await _repository.updateUserPlant(plant);
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> delete(int id) async {
    state = const AsyncLoading();
    try {
      await _repository.deleteUserPlant(id);
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> recordWatering(int id, {String? notes, double? amount}) async {
    try {
      await _repository.recordWatering(id, notes: notes, amount: amount);
    } catch (e) {
      // Ignore for now
    }
  }

  Future<void> recordFertilizing(int id, {String? notes, String? fertilizerType}) async {
    try {
      await _repository.recordFertilizing(id, notes: notes, fertilizerType: fertilizerType);
    } catch (e) {
      // Ignore for now
    }
  }

  Future<void> recordPruning(int id, {String? notes}) async {
    try {
      await _repository.recordPruning(id, notes: notes);
    } catch (e) {
      // Ignore for now
    }
  }

  Future<void> updateHealthStatus(int id, String status, String note) async {
    try {
      await _repository.updateHealthStatus(id, status, note);
    } catch (e) {
      // Ignore for now
    }
  }

  Future<void> recordMeasurement(int id, {double? heightCm, double? widthCm}) async {
    try {
      await _repository.recordMeasurement(id, heightCm: heightCm, widthCm: widthCm);
    } catch (e) {
      // Ignore for now
    }
  }

  Future<void> addPhoto(int id, String photoPath) async {
    try {
      await _repository.addPhoto(id, photoPath);
    } catch (e) {
      // Ignore for now
    }
  }
}

final userPlantNotifierProvider =
    StateNotifierProvider<UserPlantNotifier, AsyncValue<void>>((ref) {
  final repo = ref.read(plantRepositoryProvider);
  return UserPlantNotifier(repo);
});