import 'package:flutter/material.dart';
import 'package:botanisht/services/plant_api_service.dart';
import 'package:botanisht/models/plant.dart';

class PlantSearchDelegate extends SearchDelegate<Plant?> {
  PlantSearchDelegate();

  // A single API client reused across keystrokes. Closed in dispose() so we
  // don't leak an http.Client per character typed.
  final PlantApiService _api = PlantApiService();

  @override
  void dispose() {
    _api.close();
    super.dispose();
  }

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

  // Both results and suggestions come from the live OpenFarm API call below.
  Widget _buildSearchView() {
    final q = query.trim();

    if (q.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_rounded, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Search OpenFarm for any plant…'),
          ],
        ),
      );
    }

    return FutureBuilder<List<Plant>>(
      // Keyed by query so a new keystroke triggers a fresh network request.
      key: ValueKey(q),
      future: _api.searchPlants(q),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Could not reach OpenFarm.\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final results = snapshot.data ?? [];
        if (results.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search_off_rounded, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No plants found'),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final plant = results[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF1B4332),
                backgroundImage:
                    plant.imageUrl != null ? NetworkImage(plant.imageUrl!) : null,
                child: plant.imageUrl == null
                    ? const Icon(Icons.local_florist_rounded, color: Colors.white)
                    : null,
              ),
              title: Text(plant.name),
              subtitle: Text(plant.scientificName ?? ''),
              onTap: () => close(context, plant),
            );
          },
        );
      },
    );
  }
}
