import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/providers/plant_provider.dart';
import 'package:botanisht/models/plant.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPlants = ref.watch(plantListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: _buildLogo(context),
        centerTitle: true,
        backgroundColor: Colors.green.shade50,
        elevation: 0,
        foregroundColor: Colors.green.shade800,
        toolbarHeight: 70, // Slightly taller to fit the subtitle
      ),
      body: asyncPlants.when(
        data: (plants) {
          if (plants.isEmpty) {
            return const Center(
              child: Text(
                'No plants yet.\nAdd some to get started!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }
          // Group plants by category (null/unknown go to 'Other')
          final Map<String, List<Plant>> grouped = {};
          for (final plant in plants) {
            final cat = plant.category ?? 'Other';
            if (!grouped.containsKey(cat)) {
              grouped[cat] = [];
            }
            grouped[cat]!.add(plant);
          }

          // Default tabs we want to show; if a category has no plants, show empty.
          final List<String> tabLabels = [
            'Indoor Jungle',
            'Kitchen Garden',
            'Pollinator Yard',
          ];

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                ),
                child: TabBar(
                  labelColor: Colors.green.shade800,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.green.shade400,
                  indicatorWeight: 3,
                  tabs: tabLabels
                      .map((label) => Tab(text: label))
                      .toList(),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: tabLabels.map((label) {
                    final category = _labelToCategory(label);
                    final List<Plant> categoryPlants =
                        grouped.containsKey(category)
                            ? grouped[category]!
                            : [];
                    return _buildPlantList(categoryPlants);
                  }).toList(),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.green),
        ),
        error: (e, _) => Center(
          child: Text(
            'Error loading plants: $e',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'B',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.thumb_up, color: Colors.green.shade700, size: 26),
                  const Icon(Icons.eco, color: Colors.white, size: 14),
                ],
              ),
            ),
            Text(
              'tan',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            Text(
              'isht',
              style: TextStyle(
                fontSize: 28,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(width: 2),
            Icon(Icons.eco_outlined, color: Colors.green.shade700, size: 26),
          ],
        ),
        Text(
          'Beginner-Friendly Gardening & Plant Care',
          style: TextStyle(
            fontSize: 10,
            color: Colors.green.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPlantList(List<Plant> plants) {
    if (plants.isEmpty) {
      return const Center(
        child: Text(
          'No plants in this category yet.\nAdd some to get started!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: plants.length,
      itemBuilder: (context, index) {
        final plant = plants[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Colors.green.shade50,
              radius: 28,
              child: Icon(
                _getIconForCategory(plant.category ?? 'Other'),
                size: 28,
                color: Colors.green.shade700,
              ),
            ),
            title: Text(
              plant.name ?? 'Unknown Plant',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'Scientific: ${plant.scientificName ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Sun: ${plant.sunlight ?? 'Unknown'}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Water: ${plant.watering ?? 'Unknown'}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: Colors.green.shade400,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added ${plant.name} to your garden!'),
                    backgroundColor: Colors.green.shade700,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  String _labelToCategory(String label) {
    switch (label) {
      case 'Indoor Jungle':
        return 'indoor';
      case 'Kitchen Garden':
        return 'kitchen';
      case 'Pollinator Yard':
        return 'pollinator';
      default:
        return 'other';
    }
  }

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'indoor':
        return Icons.grass;
      case 'kitchen':
        return Icons.restaurant_menu;
      case 'pollinator':
        return Icons.nature_people;
      default:
        return Icons.label;
    }
  }
}
