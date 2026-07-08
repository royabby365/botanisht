import 'package:flutter/material.dart';
import 'package:botanisht/services/plant_api_service.dart';
import 'package:botanisht/models/plant.dart';

class PlantSearchDelegate extends SearchDelegate<Plant?> {
  PlantSearchDelegate();

  // Cache the in-flight request so we don't re-hit the network on every
  // keystroke rebuild; the future is reused as long as the query is unchanged.
  Future<List<Plant>>? _searchFuture;
  String? _searchQuery;

  Future<List<Plant>> _fetch(String query) {
    if (_searchQuery != query) {
      _searchQuery = query;
      _searchFuture = PlantApiService().searchPlants(query);
    }
    return _searchFuture!;
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
      future: _fetch(q),
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
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.search_off_rounded, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text('No plants found for "$q"'),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final plant = results[index];
            return ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF1B4332),
                child: Icon(Icons.local_florist_rounded, color: Colors.white),
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
