import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:botanisht/providers/plant_provider.dart';
import 'package:botanisht/models/plant.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/services/plant_api_service.dart';
import 'package:botanisht/screens/user_plant_detail_screen.dart';
import 'package:botanisht/widgets/plant_card.dart';
import 'package:botanisht/widgets/app_logo.dart';
import 'package:botanisht/widgets/add_plant_bottom_sheet.dart';
import 'package:botanisht/widgets/delete_plant_dialog.dart';
import 'package:botanisht/screens/search_delegate.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPlants = ref.watch(plantListNotifierProvider);
    final asyncUserPlants = ref.watch(userPlantsProvider);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: const AppLogo(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search, size: 24),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _showSearchDialog(context, ref),
                tooltip: 'Search plants',
              ),
            ],
          ),
          titleSpacing: 16,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(72),
            child: _buildCustomTabBar(),
          ),
        ),
        body: TabBarView(
          children: [
            _buildZoneTab(
              asyncPlants,
              ref,
              zone: 'indoor',
              icon: Icons.park,
              emptyMessage: 'No indoor plants yet.\nDiscover ferns, succulents, and tropicals.',
            ),
            _buildZoneTab(
              asyncPlants,
              ref,
              zone: 'hydro',
              icon: Icons.science,
              emptyMessage: 'No hydroponic plants yet.\nAdd lettuce, herbs, or tomatoes to your system.',
            ),
            _buildZoneTab(
              asyncPlants,
              ref,
              zone: 'kitchen',
              icon: Icons.eco,
              emptyMessage: 'No kitchen garden plants yet.\nGrow vegetables, herbs, and edible flowers.',
            ),
            _buildDiagnosticTab(asyncUserPlants, ref),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddPlantDialog(context, ref),
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add Plant'),
          heroTag: 'fab_home',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildLogo(BuildContext context) => const AppLogo();

  Widget _buildCustomTabBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1B4332).withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          color: const Color(0xFFD4A843),
          borderRadius: BorderRadius.circular(16),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: const Color(0xFF1B4332),
        unselectedLabelColor: const Color(0xFF1B4332).withOpacity(0.5),
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        tabs: const [
          Tab(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.park_rounded, size: 20),
                SizedBox(width: 8),
                Text('Indoor'),
              ],
            ),
          ),
          Tab(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.science_rounded, size: 20),
                SizedBox(width: 8),
                Text('Hydro'),
              ],
            ),
          ),
          Tab(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.eco_rounded, size: 20),
                SizedBox(width: 8),
                Text('Kitchen'),
              ],
            ),
          ),
          Tab(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.medical_services_rounded, size: 20),
                SizedBox(width: 8),
                Text('Diagnostic'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZoneTab(
    AsyncValue<List<Plant>> asyncPlants,
    WidgetRef ref, {
    required String zone,
    required IconData icon,
    required String emptyMessage,
  }) {
    return asyncPlants.when(
      data: (plants) {
        final zonePlants = plants.where((p) => p.category == zone).toList();

        if (zonePlants.isEmpty) {
          return _buildEmptyState(
            icon,
            emptyMessage,
            onAction: () => _showAddPlantDialog(ref.context!, ref),
            actionLabel: 'Discover $zone plants',
          );
        }

        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(plantListNotifierProvider),
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: zonePlants.length,
            itemBuilder: (context, index) {
              final plant = zonePlants[index];
              return PlantCard(
                plant: plant,
                isUserPlant: false,
                onTap: () => _showPlantDetail(context, ref, plant),
                onAddToGarden: () => _addToGarden(context, ref, plant),
                zone: zone,
              );
            },
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFFD4A843)),
      ),
      error: (e, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: Colors.red.shade300,
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load plants',
                style: Theme.of(ref.context!).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                e.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red.shade300),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(plantListNotifierProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiagnosticTab(AsyncValue<List<UserPlant>> asyncUserPlants, WidgetRef ref) {
    return asyncUserPlants.when(
      data: (userPlants) {
        if (userPlants.isEmpty) {
          return _buildEmptyState(
            Icons.medical_services_rounded,
            'Your garden is empty.\nAdd plants to start tracking their health.',
            onAction: () => _showAddPlantDialog(ref.context!, ref),
            actionLabel: 'Add Your First Plant',
          );
        }

        userPlants.sort((a, b) {
          final healthOrder = {'critical': 0, 'warning': 1, 'healthy': 2, 'dormant': 3};
          final aHealth = healthOrder[a.healthStatus] ?? 4;
          final bHealth = healthOrder[b.healthStatus] ?? 4;
          if (aHealth != bHealth) return aHealth.compareTo(bHealth);
          return (a.customName ?? '').compareTo(b.customName ?? '');
        });

        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(userPlantsProvider),
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: userPlants.length,
            itemBuilder: (context, index) {
              final userPlant = userPlants[index];
              return PlantCard(
                userPlant: userPlant,
                isUserPlant: true,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserPlantDetailScreen(plantId: userPlant.id!),
                  ),
                ),
                onLongPress: () => confirmDeletePlant(context, ref, userPlant),
              );
            },
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFFD4A843)),
      ),
      error: (e, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded, size: 64, color: Colors.red.shade300),
              const SizedBox(height: 16),
              Text('Failed to load garden', style: Theme.of(ref.context!).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(e.toString(), textAlign: TextAlign.center, style: TextStyle(color: Colors.red.shade300)),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: () => ref.invalidate(userPlantsProvider), child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    IconData icon,
    String message, {
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF1B4332).withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: const Color(0xFF1B4332).withOpacity(0.5)),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF1B4332),
                height: 1.5,
              ),
            ),
            if (onAction != null && actionLabel != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add_rounded),
                label: Text(actionLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showPlantDetail(BuildContext context, WidgetRef ref, Plant plant) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.65,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF5F0E1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: const Color(0xFF1B4332).withOpacity(0.1),
                      child: Icon(
                        _getIconForCategory(plant.category ?? 'Other'),
                        size: 32,
                        color: const Color(0xFF1B4332),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plant.name ?? 'Unknown Plant',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          if (plant.scientificName != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              plant.scientificName!,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: const Color(0xFF1B4332).withOpacity(0.7),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildInfoChips(plant),
                const SizedBox(height: 24),
                if (plant.isPetSafe != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: plant.isPetSafe!
                          ? Colors.green.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          plant.isPetSafe! ? Icons.pets_rounded : Icons.warning_amber_rounded,
                          color: plant.isPetSafe! ? Colors.green.shade700 : Colors.orange.shade700,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            plant.isPetSafe!
                                ? 'Safe for cats and dogs'
                                : 'Toxic to pets — keep out of reach',
                            style: TextStyle(
                              color: plant.isPetSafe! ? Colors.green.shade700 : Colors.orange.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                ],
                if (plant.sunRequirements != null || plant.waterRequirements != null) ...[
                  Text('Care Requirements', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  if (plant.sunRequirements != null) _buildCareRow(
                    context,
                    Icons.wb_sunny_rounded,
                    'Light',
                    plant.sunlight,
                    Colors.amber.shade700,
                  ),
                  if (plant.waterRequirements != null) _buildCareRow(
                    context,
                    Icons.water_drop_rounded,
                    'Water',
                    plant.watering,
                    Colors.blue.shade700,
                  ),
                ],
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _addToGarden(context, ref, plant);
                    },
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Add to My Garden'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChips(Plant plant) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (plant.category != null)
          _InfoChip(
            label: plant.category!.replaceAll('_', ' ').split(' ').map((w) => w[0].toUpperCase() + w.substring(1)).join(' '),
            icon: _getIconForCategory(plant.category!),
          ),
        if (plant.daysToHarvest != null)
          _InfoChip(
            label: '${plant.daysToHarvest} days to harvest',
            icon: Icons.calendar_today_rounded,
          ),
        if (plant.daysToHarvest == null && plant.category == 'hydro')
          _InfoChip(
            label: 'Hydroponic',
            icon: Icons.science_rounded,
          ),
      ],
    );
  }

  Widget _InfoChip({required String label, required IconData icon}) {
    return Chip(
      avatar: Icon(icon, size: 16, color: const Color(0xFF1B4332)),
      label: Text(label),
      backgroundColor: const Color(0xFF1B4332).withOpacity(0.08),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      labelStyle: const TextStyle(
        color: Color(0xFF1B4332),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildCareRow(BuildContext context, IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF1B4332).withOpacity(0.6),
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addToGarden(BuildContext context, WidgetRef ref, Plant plant) {
    ref.read(userPlantNotifierProvider.notifier).addFromEntity(
      plant.id,
      customName: plant.name,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${plant.name} to your garden!'),
        backgroundColor: const Color(0xFF1B4332),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showAddPlantDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddPlantBottomSheet(),
    );
  }

  void _showSearchDialog(BuildContext context, WidgetRef ref) {
    showSearch(
      context: context,
      delegate: PlantSearchDelegate(),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'indoor': return Icons.park_rounded;
      case 'kitchen': return Icons.eco_rounded;
      case 'hydro': return Icons.science_rounded;
      default: return Icons.local_florist_rounded;
    }
  }
}