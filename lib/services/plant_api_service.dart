import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:botanisht/models/isar_plant_entity.dart';
import 'package:botanisht/models/plant.dart';

class PlantApiService {
  static const String _baseUrl = 'https://openfarm.cc/api/v1';
  late final Isar _isar;
  late final http.Client _client;

  PlantApiService() {
    _init();
  }

  Future<void> _init() async {
    // Get the Isar instance that was already opened in main.dart
    _isar = Isar.getInstance('plant')!;
    _client = http.Client();
  }

  Future<Plant?> _getFromCache(int id) async {
    final entity = await _isar.plantEntitys.get(id);
    if (entity == null) return null;
    return _entityToPlant(entity);
  }

  Future<void> _putToCache(Plant plant) async {
    final entity = _plantToEntity(plant);
    await _isar.writeTxn(() => _isar.plantEntitys.put(entity));
  }

  Future<void> putPlant(Plant plant) async {
    await _putToCache(plant);
  }

  Future<Plant?> _fetchFromApi(int id) async {
    final response = await _client.get(Uri.parse('$_baseUrl/plants/$id'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Plant.fromJson(json['data'] as Map<String, dynamic>);
    }
    return null;
  }

  Future<Plant?> getPlant(int id) async {
    final cached = await _getFromCache(id);
    if (cached != null) return cached;
    final fromApi = await _fetchFromApi(id);
    if (fromApi != null) {
      await _putToCache(fromApi);
    }
    return fromApi;
  }

  Future<List<Plant>> searchPlants(String query) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/crops?filter=$query&page_size=10'),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> data = json['data'] as List<dynamic>;
      return data.map((e) => Plant.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('Failed to search plants');
  }

  Future<void> seedPopularPlants() async {
    final commonNames = [
      'tomato', 'basil', 'rose', 'lavender', 'mint',
      'parsley', 'thyme', 'rosemary', 'aloe vera', 'snake plant',
    ];
    for (final name in commonNames) {
      try {
        final results = await searchPlants(name);
        if (results.isNotEmpty) {
          await _putToCache(results.first);
        }
      } catch (_) {}
    }
  }

  PlantEntity _plantToEntity(Plant plant) => PlantEntity()
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
    ..isPetSafe = plant.isPetSafe;

  Plant _entityToPlant(PlantEntity entity) => Plant(
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
        isPetSafe: entity.isPetSafe,
      );

  void close() {
    _client.close();
  }
}