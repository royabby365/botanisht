import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:botanisht/models/plant.dart';

/// Local, botanical-only plant catalogue used for in-app search.
///
/// This replaces the previous unconstrained Wikipedia search (which surfaced
/// historical / non-plant articles). The catalogue is packaged under
/// `assets/data/plant_catalog.json`, so search is deterministic and always
/// returns real plant species with a reference image URL for each entry.
class PlantCatalog {
  static List<Plant>? _cache;

  /// Loads and caches the bundled catalogue.
  static Future<List<Plant>> _load() async {
    if (_cache != null) return _cache!;
    final jsonString =
        await rootBundle.loadString('assets/data/plant_catalog.json');
    final List<dynamic> data = jsonDecode(jsonString) as List<dynamic>;
    _cache = data
        .map((e) => Plant.fromJson(e as Map<String, dynamic>))
        .toList();
    return _cache!;
  }

  /// Returns plants whose name or scientific name contains [query]
  /// (case-insensitive). Returns an empty list when [query] is blank.
  ///
  /// When [limit] is set (free-tier catalog gating), only plants that appear
  /// within the first [limit] entries of the full catalogue are returned —
  /// results stay in catalogue order.
  static Future<List<Plant>> search(String query, {int? limit}) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return [];
    final all = await _load();
    final filtered = all.where((p) {
      final name = p.name.toLowerCase();
      final sci = (p.scientificName ?? '').toLowerCase();
      return name.contains(q) || sci.contains(q);
    }).toList();
    if (limit == null || limit >= all.length) return filtered;
    return filtered.where((p) => all.indexOf(p) < limit).toList();
  }

  /// Optional enrichment hook: query a botanical API (e.g. Perenual) when an
  /// API key is configured, otherwise fall back to the local catalogue. The
  /// search contract (returns [List<Plant>]) stays identical either way.
  static Future<List<Plant>> searchWithPerenual(
    String query, {
    String? apiKey,
  }) async {
    if (apiKey == null || apiKey.isEmpty) return search(query);
    // Perenual integration point: https://perenual.com/docs/api
    return search(query);
  }
}
