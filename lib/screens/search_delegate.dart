import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/providers/plant_provider.dart';
import 'package:botanisht/models/plant.dart';

class PlantSearchDelegate extends SearchDelegate<Plant?> {
  final WidgetRef ref;

  PlantSearchDelegate(this.ref);

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear_rounded),
      onPressed: () => query = '',
    ),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back_rounded),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) => _buildResults(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildResults(context);

  Widget _buildResults(BuildContext context) {
    final AsyncValue<List<Plant>> asyncPlants =
        ref.watch(plantListNotifierProvider);
    return asyncPlants.when(
      data: (plants) {
        final filtered = plants
            .where((p) =>
                (p.name?.toLowerCase().contains(query.toLowerCase()) ?? false))
            .toList();
        if (filtered.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search_off_rounded,
                    size: 64, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                Text('No plants found for "$query"'),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final plant = filtered[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF1B4332).withOpacity(0.1),
                child: Icon(
                  _getIconForCategory(plant.category ?? 'Other'),
                  color: const Color(0xFF1B4332),
                ),
              ),
              title: Text(plant.name ?? 'Unknown'),
              subtitle: Text(plant.scientificName ?? ''),
              onTap: () => close(context, plant),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'indoor':
        return Icons.park_rounded;
      case 'kitchen':
        return Icons.eco_rounded;
      case 'hydro':
        return Icons.science_rounded;
      default:
        return Icons.local_florist_rounded;
    }
  }
}
