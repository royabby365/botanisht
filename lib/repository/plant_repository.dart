import 'package:isar/isar.dart';
import 'package:botanisht/models/isar_plant_entity.dart';
import 'package:botanisht/models/plant.dart';
import 'package:botanisht/services/plant_api_service.dart';
import 'package:path_provider/path_provider.dart';

class PlantRepository {
  PlantRepository() {
    _init();
  }

  late final Isar _isar;
  late final PlantApiService _apiService;

  Future<void> _init() async {
    // Initialize Isar instance (same as used in main)
    if (!Isar.instanceNames().contains('plant')) {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        [PlantEntity],
        directory: dir.path,
        instanceName: 'plant',
      );
      _isar = isar;
    } else {
      _isar = Isar.getInstance('plant')!;
    }
    _apiService = PlantApiService();
  }

  /// Get a plant by ID, using cache (Isar) then API if needed.
  Future<Plant?> getPlant(int id) async {
    return await _apiService.getPlant(id);
  }

  /// Get all plants from the local database.
  Future<List<Plant>> getAllPlants() async {
    final entities = await _isar.plantEntities.where().findAll();
    return entities.map(_entityToPlant).toList();
  }

  /// Get plants by category (indoor, kitchen, pollinator).
  Future<List<Plant>> getPlantsByCategory(String category) async {
    final entities = await _isar.plantEntities
        .filter()
        .categoryEqualTo(category)
        .findAll();
    return entities.map(_entityToPlant).toList();
  }

  /// Save or update a plant (e.g., after user edits custom name/category).
  Future<void> savePlant(Plant plant) async {
    await _apiService.putPlant(plant);
  }

  void dispose() {
    _apiService.close();
    // Do not close Isar here; it's shared.
  }

  // Conversion helpers
  Plant _entityToPlant(PlantEntity entity) {
    return Plant(
      id: entity.id,
      name: entity.name ?? '',
      description: entity.description,
      scientificName: entity.scientificName,
      imageUrl: entity.imageUrl,
      sunRequirements: entity.sunRequirements,
      waterRequirements: entity.waterRequirements,
      propagationMethod: entity.propagationMethod,
      daysToHarvest: entity.daysToHarvest,
      companions: entity.companions,
      antagonists: entity.antagonists,
      spacing: entity.spacing,
      rowSpacing: entity.rowSpacing,
      seedDepth: entity.seedDepth,
      sowMethod: entity.sowMethod,
      sowRightBeforeLastFrostDate: entity.sowRightBeforeLastFrostDate,
      sowLastBeforeLastFrostDate: entity.sowLastBeforeLastFrostDate,
      sowFirstAfterLastFrostDate: entity.sowFirstAfterLastFrostDate,
      sowLastAfterLastFrostDate: entity.sowLastAfterLastFrostDate,
      category: entity.category,
      customName: entity.customName,
    );
  }

  PlantEntity _plantToEntity(Plant plant) {
    return PlantEntity()
      ..id = plant.id
      ..name = plant.name
      ..description = plant.description
      ..scientificName = plant.scientificName
      ..imageUrl = plant.imageUrl
      ..sunRequirements = plant.sunRequirements
      ..waterRequirements = plant.waterRequirements
      ..propagationMethod = plant.propagationMethod
      ..daysToHarvest = plant.daysToHarvest
      ..companions = plant.companions
      ..antagonists = plant.antagonists
      ..spacing = plant.spacing
      ..rowSpacing = plant.rowSpacing
      ..seedDepth = plant.seedDepth
      ..sowMethod = plant.sowMethod
      ..sowRightBeforeLastFrostDate = plant.sowRightBeforeLastFrostDate
      ..sowLastBeforeLastFrostDate = plant.sowLastBeforeLastFrostDate
      ..sowFirstAfterLastFrostDate = plant.sowFirstAfterLastFrostDate
      ..sowLastAfterLastFrostDate = plant.sowLastAfterLastFrostDate
      ..customName = plant.customName
      ..category = plant.category;
  }
}