// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:isar/isar.dart';
import 'package:botanisht/models/isar_plant_entity.dart';
import 'package:botanisht/models/plant.dart';
import 'package:path_provider/path_provider.dart';

class PlantApiService {
  static const String _baseUrl = 'https://openfarm.cc/api/v1';
  late final Isar _isar;
  late final http.Client _client;

  PlantApiService() {
    _init();
  }

  Future<void> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    if (!Isar.instanceNames.contains('plant')) {
      final isar = await Isar.open(
        [PlantEntitySchema, HydroponicLogSchema],
        directory: dir.path,
        name: 'plant',
      );
      _isar = isar;
    } else {
      _isar = Isar.getInstance('plant')!;
    }
    _client = http.Client();
  }

  /// Get plant by ID from local cache (Isar). Returns null if not found.
  Future<Plant?> _getFromCache(int id) async {
    final entity = await _isar.plantEntitys.get(id);
    if (entity == null) return null;
    return _entityToPlant(entity);
  }

  /// Save or update a plant to the Isar database.
  Future<void> _putToCache(Plant plant) async {
    final entity = _plantToEntity(plant);
    await _isar.writeTxn(() => _isar.plantEntitys.put(entity));
  }

  /// Public method to put a plant (used by repository).
  Future<void> putPlant(Plant plant) async {
    await _putToCache(plant);
  }

  /// Fetch a plant from the OpenFarm API by ID.
  Future<Plant?> _fetchFromApi(int id) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/plants/$id'),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Plant.fromJson(json['data'] as Map<String, dynamic>);
    }
    return null;
  }

  /// Get a plant by ID, first trying local cache, then API.
  Future<Plant?> getPlant(int id) async {
    // Try cache first
    final cached = await _getFromCache(id);
    if (cached != null) return cached;

    // Fetch from API
    final fromApi = await _fetchFromApi(id);
    if (fromApi != null) {
      await _putToCache(fromApi);
    }
    return fromApi;
  }

  /// Search for plants by name (common or scientific) and returns a list of plants.
  Future<List<Plant>> searchPlants(String query) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/plants?filter=$query&page_size=10'),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> data = json['data'] as List<dynamic>;
      return data.map((e) => Plant.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to search plants');
    }
  }

  /// Get a list of common plants to pre-populate the cache (optional).
  Future<void> seedPopularPlants() async {
    final commonNames = [
      'tomato',
      'basil',
      'rose',
      'lavender',
      'mint',
      'parsley',
      'thyme',
      'rosemary',
      'aloe vera',
      'snake plant',
    ];

    for (final name in commonNames) {
      try {
        final results = await searchPlants(name);
        if (results.isNotEmpty) {
          final plant = results.first;
          await _putToCache(plant);
        }
      } catch (e) {
        // Ignore errors for individual seeds
      }
    }
  }

  /// Convert API Plant model to IsarEntity
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

  /// Convert IsarEntity to API Plant model
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
    );
  }

  void close() {
    _client.close();
    // Do not close Isar instance here; it's shared.
  }
}