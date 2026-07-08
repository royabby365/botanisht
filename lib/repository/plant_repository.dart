import 'package:isar/isar.dart';
import 'package:botanisht/models/isar_plant_entity.dart';
import 'package:botanisht/models/plant.dart';
import 'package:botanisht/models/hydroponic_log.dart';
import 'package:botanisht/services/plant_api_service.dart';
import 'package:path_provider/path_provider.dart';

class PlantRepository {
  late final Isar _isar;
  late final PlantApiService _apiService;

  PlantRepository() {
    _isar = Isar.getInstance('plant')!;
    _apiService = PlantApiService(_isar);
  }

  /// Get a plant by ID, using cache (Isar) then API if needed.
  Future<Plant?> getPlant(int id) async {
    return await _apiService.getPlant(id);
  }

  /// Get all plants from the local database.
  Future<List<Plant>> getAllPlants() async {
    final entities = await _isar.plantEntitys.where().findAll();
    return entities.map(_entityToPlant).toList();
  }

  /// Get plants by category (indoorJungle, kitchenGarden, etc.)
  Future<List<Plant>> getPlantsByCategory(String category) async {
    final entities = await _isar.plantEntitys
        .filter()
        .categoryEqualTo(category)
        .findAll();
    return entities.map(_entityToPlant).toList();
  }

  /// Save or update a plant (e.g., after user edits custom name/category).
  Future<void> savePlant(Plant plant) async {
    await _apiService.putPlant(plant);
  }

  /// Stream the most recent HydroponicLog entry (ordered by timestamp DESC).
  Stream<HydroponicLog?> watchLatestHydroponicLog() {
    return _isar.hydroponicLogs
        .where()
        .sortByTimestampDesc()
        .limit(1)
        .watch(fireImmediately: true)
        .map((list) => list.isNotEmpty ? list.first : null);
  }

  void dispose() {
    _apiService.close();
    // Do not close Isar here; it's shared.
  }

  // Conversion helpers
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
    ..isPetSafe = p.isPetSafe;}
