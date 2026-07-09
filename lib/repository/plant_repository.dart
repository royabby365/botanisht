import 'package:isar/isar.dart';
import 'package:botanisht/models/isar_plant_entity.dart';
import 'package:botanisht/models/plant.dart';
import 'package:botanisht/models/hydroponic_log.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/services/plant_api_service.dart';
import 'package:path_provider/path_provider.dart';

class PlantRepository {
  PlantRepository() {
    _init();
  }

  late final Isar _isar;
  late final PlantApiService _apiService;

  Future<void> _init() async {
    // Get the Isar instance that was already opened in main.dart
    _isar = Isar.getInstance('plant')!;
    _apiService = PlantApiService();
  }

  Future<Plant?> getPlant(int id) async {
    return await _apiService.getPlant(id);
  }

  Future<List<Plant>> getAllPlants() async {
    final entities = await _isar.plantEntitys.where().findAll();
    return entities.map(_entityToPlant).toList();
  }

  Future<List<Plant>> getPlantsByCategory(String category) async {
    final entities = await _isar.plantEntitys
        .filter()
        .categoryEqualTo(category)
        .findAll();
    return entities.map(_entityToPlant).toList();
  }

  Future<void> savePlant(Plant plant) async {
    await _apiService.putPlant(plant);
  }

  Stream<HydroponicLog?> watchLatestHydroponicLog() {
    return _isar.hydroponicLogs
        .where()
        .sortByTimestampDesc()
        .limit(1)
        .watch(fireImmediately: true)
        .map((list) => list.isNotEmpty ? list.first : null);
  }
  
  Stream<HydroponicLog?> watchLatestHydroponicLogForZone(String zone) {
    return _isar.hydroponicLogs
        .filter()
        .zoneEqualTo(zone)
        .sortByTimestampDesc()
        .limit(1)
        .watch(fireImmediately: true)
        .map((list) => list.isNotEmpty ? list.first : null);
  }

  Stream<List<HydroponicLog>> watchHydroponicLogsForZone(String zone) {
    return _isar.hydroponicLogs
        .filter()
        .zoneEqualTo(zone)
        .sortByTimestampDesc()
        .watch(fireImmediately: true);
  }

  // User Plant methods
  Stream<List<UserPlant>> watchUserPlants() {
    return _isar.userPlants
        .where()
        .sortByAcquiredDateDesc()
        .watch(fireImmediately: true);
  }

  Future<List<UserPlant>> getUserPlantsSorted() async {
    return await _isar.userPlants
        .where()
        .sortByAcquiredDateDesc()
        .findAll();
  }

  Future<List<UserPlant>> getPlantsNeedingWater() async {
    final now = DateTime.now();
    final allPlants = await _isar.userPlants.where().findAll();
    return allPlants.where((p) {
      if (p.lastWatered == null) return true;
      final diff = now.difference(p.lastWatered!).inDays;
      return diff >= 7;
    }).toList();
  }

  Future<void> addUserPlantFromEntity(
    int plantEntityId, {
    String? customName,
    String? location,
    String? potSize,
    String? soilType,
    DateTime? acquiredDate,
    String? source,
    String? zone,
  }) async {
    final userPlant = UserPlant()
      ..plantEntityId = plantEntityId
      ..customName = customName
      ..location = location
      ..potSize = potSize
      ..soilType = soilType
      ..acquiredDate = acquiredDate ?? DateTime.now()
      ..source = source
      ..zone = zone ?? 'indoor'
      ..quantity = 1
      ..healthStatus = 'healthy'
      ..healthNotes = []
      ..photoPaths = []
      ..tags = [];

    await _isar.writeTxn(() => _isar.userPlants.put(userPlant));
  }

  Future<void> addCustomUserPlant({
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
    String? zone,
    int quantity = 1,
  }) async {
    final userPlant = UserPlant()
      ..customName = customName ?? name
      ..location = location
      ..potSize = potSize
      ..soilType = soilType
      ..acquiredDate = acquiredDate ?? DateTime.now()
      ..source = source
      ..zone = zone ?? 'indoor'
      ..quantity = quantity
      ..lightConditions = lightConditions
      ..temperatureRange = temperatureRange
      ..humidityLevel = humidityLevel
      ..tags = tags ?? []
      ..healthStatus = 'healthy'
      ..healthNotes = []
      ..photoPaths = [];

    await _isar.writeTxn(() => _isar.userPlants.put(userPlant));
  }

  Future<void> updateUserPlant(UserPlant plant) async {
    await _isar.writeTxn(() => _isar.userPlants.put(plant));
  }

  Future<void> deleteUserPlant(int id) async {
    await _isar.writeTxn(() => _isar.userPlants.delete(id));
  }

  /// Adjust the quantity of a specific crop (e.g. from the card stepper) and
  /// persist it inside an immediate write transaction.
  Future<void> setQuantity(int id, int quantity) async {
    final plant = await _isar.userPlants.get(id);
    if (plant == null) return;
    plant.quantity = quantity.clamp(1, 9999);
    await _isar.writeTxn(() => _isar.userPlants.put(plant));
  }

  /// Distinct, normalized zone names present across the user's garden.
  Future<List<String>> getUniqueZones() async {
    final all = await _isar.userPlants.where().findAll();
    final zones = <String>{};
    for (final p in all) {
      final z = (p.zone ?? 'uncategorized').toLowerCase();
      zones.add(z);
    }
    return zones.toList()..sort();
  }

  Future<void> recordWatering(int id, {String? notes, double? amount}) async {
    final plant = await _isar.userPlants.get(id);
    if (plant != null) {
      plant.lastWatered = DateTime.now();
      plant.healthNotes ??= [];
      if (notes != null && notes.isNotEmpty) {
        plant.healthNotes!.add('Watered: $notes');
      }
      await _isar.writeTxn(() => _isar.userPlants.put(plant));
    }
  }

  Future<void> recordFertilizing(int id, {String? notes, String? fertilizerType}) async {
    final plant = await _isar.userPlants.get(id);
    if (plant != null) {
      plant.lastFertilized = DateTime.now();
      plant.healthNotes ??= [];
      if (notes != null && notes.isNotEmpty) {
        plant.healthNotes!.add('Fertilized: $notes${fertilizerType != null ? ' ($fertilizerType)' : ''}');
      }
      await _isar.writeTxn(() => _isar.userPlants.put(plant));
    }
  }

  Future<void> recordPruning(int id, {String? notes}) async {
    final plant = await _isar.userPlants.get(id);
    if (plant != null) {
      plant.lastPruned = DateTime.now();
      plant.healthNotes ??= [];
      if (notes != null && notes.isNotEmpty) {
        plant.healthNotes!.add('Pruned: $notes');
      }
      await _isar.writeTxn(() => _isar.userPlants.put(plant));
    }
  }

  Future<void> updateHealthStatus(int id, String status, String note) async {
    final plant = await _isar.userPlants.get(id);
    if (plant == null) return;
    // Create a COPY of the object with the new status and persist it
    // explicitly within a write transaction so Isar actually saves it.
    final updated = UserPlant()
      ..id = plant.id
      ..plantEntityId = plant.plantEntityId
      ..customName = plant.customName
      ..location = plant.location
      ..potSize = plant.potSize
      ..soilType = plant.soilType
      ..acquiredDate = plant.acquiredDate
      ..source = plant.source
      ..wateringSchedule = plant.wateringSchedule
      ..fertilizingSchedule = plant.fertilizingSchedule
      ..pruningSchedule = plant.pruningSchedule
      ..healthStatus = status
      ..healthNotes = [...?plant.healthNotes, '$status: $note']
      ..lastWatered = plant.lastWatered
      ..lastFertilized = plant.lastFertilized
      ..lastPruned = plant.lastPruned
      ..wateringReminderEnabled = plant.wateringReminderEnabled
      ..fertilizingReminderEnabled = plant.fertilizingReminderEnabled
      ..pruningReminderEnabled = plant.pruningReminderEnabled
      ..lightConditions = plant.lightConditions
      ..temperatureRange = plant.temperatureRange
      ..humidityLevel = plant.humidityLevel
      ..isPetSafe = plant.isPetSafe
      ..heightCm = plant.heightCm
      ..widthCm = plant.widthCm
      ..lastMeasured = plant.lastMeasured
      ..photoPaths = plant.photoPaths
      ..zone = plant.zone
      ..quantity = plant.quantity
      ..tags = plant.tags;
    await _isar.writeTxn(() => _isar.userPlants.put(updated));
  }

  Future<void> recordMeasurement(int id, {double? heightCm, double? widthCm}) async {
    final plant = await _isar.userPlants.get(id);
    if (plant != null) {
      if (heightCm != null) plant.heightCm = heightCm;
      if (widthCm != null) plant.widthCm = widthCm;
      plant.lastMeasured = DateTime.now();
      await _isar.writeTxn(() => _isar.userPlants.put(plant));
    }
  }

  Future<void> addPhoto(int id, String photoPath) async {
    final plant = await _isar.userPlants.get(id);
    if (plant != null) {
      plant.photoPaths ??= [];
      plant.photoPaths!.add(photoPath);
      await _isar.writeTxn(() => _isar.userPlants.put(plant));
    }
  }

  void dispose() {
    _apiService.close();
  }

  Plant _entityToPlant(PlantEntity e) => Plant(
        id: e.id,
        name: e.name ?? '',
        description: e.description,
        scientificName: e.scientificName,
        imageUrl: e.imageUrl,
        sunRequirements: e.sunRequirements,
        waterRequirements: e.waterRequirements,
        propagationMethod: e.propagationMethod,
        daysToHarvest: e.daysToHarvest,
        companions: e.companions,
        antagonists: e.antagonists,
        spacing: e.spacing,
        rowSpacing: e.rowSpacing,
        seedDepth: e.seedDepth,
        sowMethod: e.sowMethod,
        sowRightBeforeLastFrostDate: e.sowRightBeforeLastFrostDate,
        sowLastBeforeLastFrostDate: e.sowLastBeforeLastFrostDate,
        sowFirstAfterLastFrostDate: e.sowFirstAfterLastFrostDate,
        sowLastAfterLastFrostDate: e.sowLastAfterLastFrostDate,
        category: e.category,
        customName: e.customName,
        isPetSafe: e.isPetSafe,
      );

  PlantEntity _plantToEntity(Plant p) => PlantEntity()
    ..id = p.id
    ..name = p.name
    ..description = p.description
    ..scientificName = p.scientificName
    ..imageUrl = p.imageUrl
    ..sunRequirements = p.sunRequirements
    ..waterRequirements = p.waterRequirements
    ..propagationMethod = p.propagationMethod
    ..daysToHarvest = p.daysToHarvest
    ..companions = p.companions
    ..antagonists = p.antagonists
    ..spacing = p.spacing
    ..rowSpacing = p.rowSpacing
    ..seedDepth = p.seedDepth
    ..sowMethod = p.sowMethod
    ..sowRightBeforeLastFrostDate = p.sowRightBeforeLastFrostDate
    ..sowLastBeforeLastFrostDate = p.sowLastBeforeLastFrostDate
    ..sowFirstAfterLastFrostDate = p.sowFirstAfterLastFrostDate
    ..sowLastAfterLastFrostDate = p.sowLastAfterLastFrostDate
    ..category = p.category
    ..customName = p.customName
    ..isPetSafe = p.isPetSafe;
}