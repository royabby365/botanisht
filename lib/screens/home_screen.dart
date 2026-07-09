import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/providers/plant_provider.dart';
import 'package:botanisht/providers/settings_provider.dart';
import 'package:botanisht/providers/weather_provider.dart';
import 'package:botanisht/widgets/plant_card.dart';
import 'package:botanisht/widgets/brand_logo.dart';
import 'package:botanisht/widgets/add_plant_bottom_sheet.dart';
import 'package:botanisht/widgets/delete_plant_dialog.dart';
import 'package:botanisht/screens/search_delegate.dart';
import 'package:botanisht/screens/user_plant_detail_screen.dart';
import 'package:botanisht/data/companion_rules.dart';
import 'package:botanisht/services/weather_alert_service.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUserPlants = ref.watch(userPlantsProvider);
    final weatherAsync = ref.watch(weatherAlertProvider);
    final alert = weatherAsync.value;

    return asyncUserPlants.when(
      data: (userPlants) {
        // Build dynamic tabs from the unique zones present in the garden.
        final Map<String, List<UserPlant>> zoneGroups = {};
        for (final p in userPlants) {
          final z = (p.zone ?? 'uncategorized').toLowerCase().trim();
          zoneGroups.putIfAbsent(z, () => []).add(p);
        }
        final zones = zoneGroups.keys.toList()..sort();
        final tabTitles = [...zones, 'Diagnostic'];

        return DefaultTabController(
          length: tabTitles.length,
          child: Scaffold(
            drawer: const AppSettingsDrawer(),
            appBar: AppBar(
              leading: Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu_rounded),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                  tooltip: 'Menu & settings',
                ),
              ),
              title: const BrandLogo(),
              centerTitle: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () => _showSearchDialog(context, ref),
                  tooltip: 'Search plants',
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: TabBar(
                  isScrollable: true,
                  tabs: tabTitles.map((t) => Tab(text: _pretty(t))).toList(),
                ),
              ),
            ),
            body: Column(
              children: [
                if (alert != null) _WeatherAlertCard(alert: alert),
                Expanded(
                  child: TabBarView(
                    children: [
                      ...zones.map(
                        (z) => _buildZoneTab(
                          context,
                          ref,
                          z,
                          zoneGroups[z]!,
                          userPlants,
                        ),
                      ),
                      _buildDiagnosticTab(context, ref, userPlants),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _showAddPlantDialog(context, ref),
              icon: const Icon(Icons.add_rounded),
              label: const Text(
                'Add Plant',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              tooltip: 'Add plant',
            ),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu_rounded),
          title: const BrandLogo(),
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const BrandLogo()),
        body: Center(
          child: Text(
            'Failed to load garden: $e',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildZoneTab(
    BuildContext context,
    WidgetRef ref,
    String zone,
    List<UserPlant> plants,
    List<UserPlant> all,
  ) {
    if (plants.isEmpty) return _emptyState();

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(userPlantsProvider),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: plants.length,
        itemBuilder: (context, index) {
          final userPlant = plants[index];
          final neighbors = plants
              .where((p) => p.id != userPlant.id)
              .map((p) => p.customName ?? 'Plant')
              .toList();
          final advice = CompanionRules.evaluate(
            userPlant.customName ?? 'Plant',
            neighbors,
          );
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PlantCard(
              userPlant: userPlant,
              isUserPlant: true,
              companionAdvice: advice?.message,
              companionIsWarning: advice?.isWarning ?? false,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      UserPlantDetailScreen(plantId: userPlant.id!),
                ),
              ),
              onLongPress: () => confirmDeletePlant(context, ref, userPlant),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDiagnosticTab(
    BuildContext context,
    WidgetRef ref,
    List<UserPlant> plants,
  ) {
    if (plants.isEmpty) return _emptyState();

    final sorted = [...plants]
      ..sort((a, b) => _healthRank(b).compareTo(_healthRank(a)));

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(userPlantsProvider),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sorted.length,
        itemBuilder: (context, index) {
          final userPlant = sorted[index];
          // Companion scan is scoped to the plant's own zone.
          final neighbors = plants
              .where((p) =>
                  p.id != userPlant.id &&
                  (p.zone ?? '') == (userPlant.zone ?? ''))
              .map((p) => p.customName ?? 'Plant')
              .toList();
          final advice = CompanionRules.evaluate(
            userPlant.customName ?? 'Plant',
            neighbors,
          );
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PlantCard(
              userPlant: userPlant,
              isUserPlant: true,
              companionAdvice: advice?.message,
              companionIsWarning: advice?.isWarning ?? false,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      UserPlantDetailScreen(plantId: userPlant.id!),
                ),
              ),
              onLongPress: () => confirmDeletePlant(context, ref, userPlant),
            ),
          );
        },
      ),
    );
  }

  Widget _emptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_florist_rounded, size: 72, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Your garden is empty.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Tap the + button or use Search to add your first plant.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context, WidgetRef ref) {
    showSearch(
      context: context,
      delegate: PlantSearchDelegate(),
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

  String _pretty(String z) {
    if (z == 'uncategorized') return 'Garden';
    const map = {
      'indoor': 'Indoor',
      'hydro': 'Hydroponic',
      'kitchen': 'Kitchen',
      'outdoor': 'Outdoor',
      'garden': 'Garden',
      'balcony': 'Balcony',
      'patio': 'Patio',
      'yard': 'Yard',
    };
    final known = map[z];
    if (known != null) return known;
    return z[0].toUpperCase() + z.substring(1);
  }

  int _healthRank(UserPlant p) {
    switch (p.healthStatus) {
      case 'healthy':
        return 3;
      case 'warning':
        return 2;
      case 'critical':
        return 1;
      case 'dormant':
        return 0;
      default:
        return 2;
    }
  }
}

/// Soft-amber contextual weather advisory shown at the top of the dashboard.
class _WeatherAlertCard extends StatelessWidget {
  final WeatherAlert alert;
  const _WeatherAlertCard({required this.alert});

  @override
  Widget build(BuildContext context) {
    final onAmber = ThemeData.estimateBrightnessForColor(
              const Color(0xFFF4B860)) ==
          Brightness.dark
        ? Colors.white
        : const Color(0xFF3A2A00);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4B860),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD99A3C), width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: Color(0xFF7A4E00), size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              alert.message,
              style: TextStyle(
                color: onAmber,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Settings / navigation drawer. All toggles persist immediately to Isar via
/// [SettingsNotifier], so preferences survive app restarts.
class AppSettingsDrawer extends ConsumerWidget {
  const AppSettingsDrawer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BrandLogo(maxWidth: 170),
                const SizedBox(height: 12),
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Appearance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: SegmentedButton<int>(
              selected: {settings.themeMode},
              onSelectionChanged: (s) => notifier.setThemeMode(s.first),
              segments: const [
                ButtonSegment(
                  value: 0,
                  label: Text('System', style: TextStyle(fontSize: 16)),
                ),
                ButtonSegment(
                  value: 1,
                  label: Text('Cream', style: TextStyle(fontSize: 16)),
                ),
                ButtonSegment(
                  value: 2,
                  label: Text('Evergreen', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
          SwitchListTile(
            title: const Text('High contrast',
                style: TextStyle(fontSize: 18)),
            subtitle: const Text('Stronger text contrast for low vision'),
            value: settings.highContrast,
            onChanged: (v) => notifier.setHighContrast(v),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Measurements',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: const Text('Imperial units',
                style: TextStyle(fontSize: 18)),
            subtitle: const Text('inches / feet (vs metric cm)'),
            value: settings.units == 1,
            onChanged: (v) => notifier.setUnits(v ? 1 : 0),
          ),
          SwitchListTile(
            title: const Text('Fahrenheit', style: TextStyle(fontSize: 18)),
            subtitle: const Text('vs Celsius'),
            value: settings.temperatureScale == 1,
            onChanged: (v) => notifier.setTemperatureScale(v ? 1 : 0),
          ),
        ],
      ),
    );
  }
}
