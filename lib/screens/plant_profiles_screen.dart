import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/providers/plant_provider.dart' as plant_provider;
import 'package:botanisht/models/plant.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/screens/user_plant_detail_screen.dart';

class PlantProfilesScreen extends ConsumerWidget {
  const PlantProfilesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPlants = ref.watch(plant_provider.userPlantsProvider);
    final asyncCatalog = ref.watch(plant_provider.allPlantsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Care Profiles'),
        centerTitle: false,
      ),
      body: asyncCatalog.when(
        data: (catalogPlants) => asyncPlants.when(
          data: (userPlants) {
            // Group user plants by species (plantEntityId)
            final Map<int, List<UserPlant>> plantsBySpecies = {};
            for (final plant in userPlants) {
              if (plant.plantEntityId != null) {
                plantsBySpecies.putIfAbsent(plant.plantEntityId!, () => []).add(plant);
              }
            }

            // Create list of species with their user plants
            final speciesWithPlants = catalogPlants
                .where((p) => plantsBySpecies.containsKey(p.id))
                .toList();

            if (speciesWithPlants.isEmpty) {
              return _EmptyProfiles(onAddPlant: () => _showAddPlantDialog(context, ref));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: speciesWithPlants.length,
              itemBuilder: (context, index) {
                final species = speciesWithPlants[index];
                final myPlants = plantsBySpecies[species.id]!;
                return _SpeciesProfileCard(species: species, myPlants: myPlants);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  void _showAddPlantDialog(BuildContext context, WidgetRef ref) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Use the + button on Home to add plants')),
    );
  }
}

class _SpeciesProfileCard extends StatelessWidget {
  final Plant species;
  final List<UserPlant> myPlants;

  const _SpeciesProfileCard({required this.species, required this.myPlants});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final healthyCount = myPlants.where((p) => p.healthStatus == 'healthy').length;
    final totalCount = myPlants.length;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.eco_rounded, size: 32, color: colorScheme.onPrimaryContainer),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(species.name ?? 'Unnamed', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                      if (species.scientificName != null)
                        Text(species.scientificName!, style: theme.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic, color: colorScheme.onSurfaceVariant)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E7D4F).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text('$healthyCount/$totalCount thriving', style: theme.textTheme.labelSmall?.copyWith(color: const Color(0xFF2E7D4F), fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(width: 8),
                          if (species.category != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getCategoryColor(species.category!).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(species.category!, style: theme.textTheme.labelSmall?.copyWith(color: _getCategoryColor(species.category!), fontWeight: FontWeight.w600)),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(height: 1, color: colorScheme.outlineVariant),
            const SizedBox(height: 16),
            _CareProfileGrid(species: species),
            const SizedBox(height: 16),
            _MyPlantsList(myPlants: myPlants),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'indoor': return const Color(0xFF2E7D4F);
      case 'kitchen': return const Color(0xFFE0913A);
      case 'pollinator': return const Color(0xFFD2553F);
      case 'hydro': return const Color(0xFF3B82F6);
      default: return const Color(0xFF6B7280);
    }
  }
}

class _CareProfileGrid extends StatelessWidget {
  final Plant species;

  const _CareProfileGrid({required this.species});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Care Profile', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            if (species.sunRequirements != null && species.sunRequirements!.isNotEmpty)
              _CareMetric(icon: Icons.wb_sunny_rounded, label: 'Light', value: species.sunRequirements!.join(', ')),
            if (species.waterRequirements != null && species.waterRequirements!.isNotEmpty)
              _CareMetric(icon: Icons.water_drop_rounded, label: 'Water', value: species.waterRequirements!.join(', ')),
            if (species.daysToHarvest != null)
              _CareMetric(icon: Icons.schedule_rounded, label: 'Harvest', value: '${species.daysToHarvest} days'),
            if (species.propagationMethod != null)
              _CareMetric(icon: Icons.content_copy_rounded, label: 'Propagation', value: species.propagationMethod!),
            if (species.spacing != null)
              _CareMetric(icon: Icons.space_bar_rounded, label: 'Spacing', value: species.spacing!),
            if (species.seedDepth != null)
              _CareMetric(icon: Icons.arrow_downward_rounded, label: 'Seed Depth', value: species.seedDepth!),
          ],
        ),
      ],
    );
  }
}

class _CareMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _CareMetric({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant)),
              Text(value, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}

class _MyPlantsList extends StatelessWidget {
  final List<UserPlant> myPlants;

  const _MyPlantsList({required this.myPlants});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('My Plants (${myPlants.length})', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...myPlants.map((plant) => _MyPlantTile(plant: plant)).toList(),
      ],
    );
  }
}

class _MyPlantTile extends StatelessWidget {
  final UserPlant plant;

  const _MyPlantTile({required this.plant});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    Color statusColor;
    switch (plant.healthStatus) {
      case 'healthy': statusColor = const Color(0xFF2E7D4F); break;
      case 'warning': statusColor = const Color(0xFFE0913A); break;
      case 'critical': statusColor = const Color(0xFFD2553F); break;
      default: statusColor = colorScheme.onSurfaceVariant;
    }

    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserPlantDetailScreen(plantId: plant.id))),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: statusColor.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plant.customName ?? 'Unnamed', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  if (plant.zone != null)
                    Text('Zone: ${plant.zone}', style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            Text(plant.healthStatus?.toUpperCase() ?? 'UNKNOWN', style: theme.textTheme.labelSmall?.copyWith(color: statusColor, fontWeight: FontWeight.w700)),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right_rounded, color: colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class _EmptyProfiles extends StatelessWidget {
  final VoidCallback onAddPlant;

  const _EmptyProfiles({required this.onAddPlant});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.menu_book_rounded, size: 60, color: colorScheme.primary),
            ),
            const SizedBox(height: 24),
            Text('No Plant Profiles Yet', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Text('Add plants to your garden to build your personal care library.', style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            FilledButton.icon(onPressed: onAddPlant, icon: const Icon(Icons.add_rounded), label: const Text('Add Your First Plant')),
          ],
        ),
      ),
    );
  }
}