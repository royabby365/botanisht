import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/providers/plant_provider.dart';
import 'package:botanisht/models/plant.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/screens/user_plant_detail_screen.dart';
import 'package:botanisht/widgets/plant_card.dart';

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
          title: _buildLogo(context),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(72),
            child: _buildCustomTabBar(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, size: 28),
              onPressed: () => _showSearchDialog(context, ref),
              tooltip: 'Search plants',
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: TabBarView(
          children: [
            // Indoor tab
            _buildZoneTab(
              asyncPlants,
              ref,
              zone: 'indoor',
              icon: Icons.park,
              emptyMessage: 'No indoor plants yet.\nDiscover ferns, succulents, and tropicals.',
            ),
            // Hydro tab
            _buildZoneTab(
              asyncPlants,
              ref,
              zone: 'hydro',
              icon: Icons.science,
              emptyMessage: 'No hydroponic plants yet.\nAdd lettuce, herbs, or tomatoes to your system.',
            ),
            // Kitchen tab
            _buildZoneTab(
              asyncPlants,
              ref,
              zone: 'kitchen',
              icon: Icons.eco,
              emptyMessage: 'No kitchen garden plants yet.\nGrow vegetables, herbs, and edible flowers.',
            ),
            // Diagnostic tab (My Garden)
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

  Widget _buildLogo(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: const [
          TextSpan(
            text: 'Botan',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: Icon(Icons.thumb_up_rounded, size: 26),
            ),
          ),
          TextSpan(
            text: 'ish',
            style: TextStyle(
              fontSize: 26,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Icon(Icons.eco_rounded, size: 22),
            ),
          ),
        ],
      ),
    );
  }

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

        // Sort by health status (critical first)
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
                    builder: (_) => UserPlantDetailScreen(userPlant: userPlant),
                  ),
                ),
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
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.85,
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
                Text(
                  'Add Plant to Garden',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Search our database or create a custom entry',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF1B4332).withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search plants...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: const Icon(Icons.mic_rounded),
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                Text(
                  'Or create custom',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                _buildCustomPlantForm(context, ref),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomPlantForm(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final customNameController = TextEditingController();
    final locationController = TextEditingController();
    String? selectedZone = 'indoor';

    return StatefulBuilder(
      builder: (context, setState) => Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Plant Name *',
              hintText: 'e.g., Monstera Deliciosa',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: customNameController,
            decoration: const InputDecoration(
              labelText: 'Custom Name (Optional)',
              hintText: 'e.g., Living Room Monster',
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: selectedZone,
            decoration: const InputDecoration(labelText: 'Zone'),
            items: const [
              DropdownMenuItem(value: 'indoor', child: Text('🌿 Indoor')),
              DropdownMenuItem(value: 'hydro', child: Text('💧 Hydro')),
              DropdownMenuItem(value: 'kitchen', child: Text('🥕 Kitchen')),
            ],
            onChanged: (value) => setState(() => selectedZone = value),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: locationController,
            decoration: const InputDecoration(
              labelText: 'Location (Optional)',
              hintText: 'e.g., Kitchen window, Balcony, Grow tent',
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: nameController.text.isNotEmpty
                  ? () {
                      ref.read(userPlantNotifierProvider.notifier).addCustom(
                        name: nameController.text,
                        customName: customNameController.text.isNotEmpty ? customNameController.text : null,
                        location: locationController.text.isNotEmpty ? locationController.text : null,
                        lightConditions: selectedZone == 'hydro' ? 'Grow lights' : null,
                        temperatureRange: selectedZone == 'hydro' ? '68-75°F' : null,
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added ${nameController.text} to garden!'),
                          backgroundColor: const Color(0xFF1B4332),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  : null,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add Custom Plant'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context, WidgetRef ref) {
    showSearch(
      context: context,
      delegate: _PlantSearchDelegate(ref),
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
      case 'pollinator':
        return Icons.bug_report_rounded;
      case 'native':
        return Icons.landscape_rounded;
      case 'permeable':
        return Icons.terrain_rounded;
      case 'bento':
        return Icons.restaurant_rounded;
      default:
        return Icons.local_florist_rounded;
    }
  }
}

class _PlantSearchDelegate extends SearchDelegate<Plant?> {
  final WidgetRef ref;

  _PlantSearchDelegate(this.ref);

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
  Widget buildResults(BuildContext context) => _buildResults();

  @override
  Widget buildSuggestions(BuildContext context) => _buildResults();

  Widget _buildResults() {
    final asyncPlants = ref.watch(plantListNotifierProvider);
    return asyncPlants.when(
      data: (plants) {
        final filtered = plants
            .where((p) => p.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
            .toList();
        if (filtered.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search_off_rounded, size: 64, color: Colors.grey.shade300),
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
                child: Icon(_getIconForCategory(plant.category ?? 'Other'), color: const Color(0xFF1B4332)),
              ),
              title: Text(plant.name ?? 'Unknown'),
              subtitle: Text(plant.scientificName ?? ''),
              onTap: () => close(null, plant),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
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