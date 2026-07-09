import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:botanisht/models/isar_plant_entity.dart';
import 'package:botanisht/models/plant.dart';

/// Live plant data source.
///
/// OpenFarm (https://openfarm.cc) is effectively defunct (its API now returns
/// HTTP 301 / an HTML parking page), so the live search + detail source is
/// Wikipedia's public REST API, which is keyless and returns clean JSON plus
/// thumbnail images. When the network is unavailable we fall back to a bundled
/// local asset (assets/data/fallback_plants.json) so search never crashes.
class PlantApiService {
  late final Isar _isar;
  late final http.Client _client;

  PlantApiService() {
    _init();
  }

  Future<void> _init() async {
    // Get the Isar instance that was already opened in main.dart.
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
    try {
      final uri = Uri.https('en.wikipedia.org', '/w/api.php', {
        'action': 'query',
        'pageids': id.toString(),
        'prop': 'pageimages|extracts',
        'piprop': 'thumbnail',
        'pithumbsize': '600',
        'explaintext': '1',
        'format': 'json',
      });
      final response = await _client.get(uri);
      if (response.statusCode != 200) return null;
      final body = response.body;
      if (_looksLikeHtml(body)) return null;
      final json = jsonDecode(body) as Map<String, dynamic>;
      final pages = (json['query']?['pages'] as Map<String, dynamic>?) ?? {};
      if (pages.isEmpty) return null;
      final p = pages.values.first as Map<String, dynamic>;
      final thumb =
          (p['thumbnail'] as Map<String, dynamic>?)?['source'] as String?;
      return _wikiToPlant(p, thumb);
    } catch (_) {
      return null;
    }
  }

  Future<Plant?> getPlant(int id) async {
    final cached = await _getFromCache(id);
    if (cached != null) return cached;
    final fromApi = await _fetchFromApi(id);
    if (fromApi != null) await _putToCache(fromApi);
    return fromApi;
  }

  Future<List<Plant>> searchPlants(String query) async {
    try {
      final uri = Uri.https('en.wikipedia.org', '/w/api.php', {
        'action': 'query',
        'generator': 'search',
        'gsrsearch': query,
        'gsrlimit': '10',
        'prop': 'pageimages|extracts',
        'piprop': 'thumbnail',
        'pithumbsize': '400',
        'exintro': '1',
        'explaintext': '1',
        'format': 'json',
      });
      final response = await _client.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Wikipedia request failed (${response.statusCode})');
      }
      final body = response.body;
      if (_looksLikeHtml(body)) {
        throw const FormatException('Received HTML instead of JSON');
      }
      final json = jsonDecode(body) as Map<String, dynamic>;
      final pages = (json['query']?['pages'] as Map<String, dynamic>?) ?? {};
      if (pages.isEmpty) return _loadFallbackPlants();
      final results = pages.values.map((page) {
        final p = page as Map<String, dynamic>;
        final thumb =
            (p['thumbnail'] as Map<String, dynamic>?)?['source'] as String?;
        return _wikiToPlant(p, thumb);
      }).toList();
      return results;
    } on FormatException {
      // Network returned HTML / malformed body — fall back to local data.
      return _loadFallbackPlants();
    } catch (_) {
      // Any other failure (no network, timeout) — also fall back locally.
      return _loadFallbackPlants();
    }
  }

  /// Build a [Plant] from a Wikipedia OpenSearch/page result.
  Plant _wikiToPlant(Map<String, dynamic> p, String? thumb) {
    return Plant.fromJson({
      'id': p['pageid'],
      'attributes': {
        'name': p['title'],
        'scientific_name': null,
        'description': p['extract'],
        'photo_url': thumb,
      }
    });
  }

  bool _looksLikeHtml(String body) {
    final trimmed = body.trimLeft();
    return trimmed.startsWith('<!DOCTYPE') || trimmed.startsWith('<');
  }

  /// Load the bundled offline plant list when the network is unavailable.
  Future<List<Plant>> _loadFallbackPlants() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/fallback_plants.json');
      final List<dynamic> data = jsonDecode(jsonString) as List<dynamic>;
      return data
          .map((e) => Plant.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
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
