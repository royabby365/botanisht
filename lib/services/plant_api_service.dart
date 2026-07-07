import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:botanisht/models/plant.dart';
import 'package:hive/hive.dart';

class PlantApiService {
  static const String _baseUrl = 'https://openfarm.cc/api/v1';
  static const String _plantBoxName = 'plantBox';

  final _client = http.Client();
  late Box<Map<String, dynamic>> _plantBox;

  PlantApiService() {
    _initHive();
  }

  Future<void> _initHive() async {
    _plantBox = await Hive.openBox<Map<String, dynamic>>(_plantBoxName);
  }

  /// Fetch a plant by its OpenFarm ID, using cache if available and not expired.
  /// Cache expiry: 24 hours.
  Future<Plant?> getPlantById(int id) async {
    final cached = _plantBox.get(id.toString());
    if (cached != null) {
      final cachedTime = cached['_cachedAt'] as int?;
      if (cachedTime != null &&
          DateTime.now().millisecondsSinceEpoch - cachedTime < 24 * 60 * 60 * 1000) {
        return Plant.fromJson(cached['data'] as Map<String, dynamic>);
      }
    }

    final response =
        await _client.get(Uri.parse('$_baseUrl/plants/$id?include=photos'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final plantData = json['data'] as Map<String, dynamic>;
      final plant = Plant.fromJson(plantData);

      // Cache the plant data with timestamp
      await _plantBox.put(
        id.toString(),
        {
          'data': plant.toJson(),
          '_cachedAt': DateTime.now().millisecondsSinceEpoch,
        },
      );

      return plant;
    } else {
      throw Exception('Failed to load plant with id $id');
    }
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
  /// This can be called on app startup to seed the cache with popular plants.
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
          await _plantBox.put(
            plant.id.toString(),
            {
              'data': plant.toJson(),
              '_cachedAt': DateTime.now().millisecondsSinceEpoch,
            },
          );
        }
      } catch (e) {
        // Ignore errors for individual seeds
      }
    }
  }

  void close() {
    _plantBox.close();
    _client.close();
  }
}
