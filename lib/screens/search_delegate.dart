import 'package:flutter/material.dart';
import 'package:botanisht/services/plant_catalog.dart';
import 'package:botanisht/models/plant.dart';
import 'package:botanisht/widgets/plant_preview_sheet.dart';
import 'package:botanisht/widgets/pro_feature.dart' show freeCatalogLimit;

/// In-app plant search.
///
/// Uses the bundled botanical catalogue ([PlantCatalog]) only — no Wikipedia
/// or other free-text web search — so results are always real plant species
/// with a reference thumbnail for visual cross-referencing.
class PlantSearchDelegate extends SearchDelegate<Plant?> {
  /// When false (free tier), results are limited to the first
  /// [freeCatalogLimit] plants of the catalogue.
  final bool fullCatalog;

  PlantSearchDelegate({this.fullCatalog = false});

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear_rounded),
          onPressed: () => query = '',
          tooltip: 'Clear',
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () => close(context, null),
        tooltip: 'Back',
      );

  @override
  Widget buildResults(BuildContext context) => _buildSearchView();

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchView();

  Widget _buildSearchView() {
    final q = query.trim();

    if (q.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_rounded, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Search the Botanisht plant catalogue…',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      );
    }

    return FutureBuilder<List<Plant>>(
      // Keyed by query so a new keystroke triggers a fresh catalogue lookup.
      key: ValueKey(q),
      future: PlantCatalog.search(
        q,
        limit: fullCatalog ? null : freeCatalogLimit,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        final results = snapshot.data ?? [];
        if (results.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search_off_rounded, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No plants found', style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final plant = results[index];
            final hasImage =
                plant.imageUrl != null && plant.imageUrl!.isNotEmpty;
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF1B4332),
                backgroundImage:
                    hasImage ? NetworkImage(plant.imageUrl!) : null,
                child: hasImage
                    ? null
                    : const Icon(Icons.local_florist_rounded,
                        color: Colors.white),
              ),
              title: Text(
                plant.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                plant.scientificName ?? '',
                style: const TextStyle(fontSize: 15),
              ),
              onTap: () {
                close(context, null);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => PlantPreviewSheet(plant: plant),
                );
              },
            );
          },
        );
      },
    );
  }
}
