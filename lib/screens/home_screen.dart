import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/models/isar_app_settings.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/providers/plant_provider.dart';
import 'package:botanisht/providers/settings_provider.dart';
import 'package:botanisht/providers/weather_provider.dart';
import 'package:botanisht/widgets/garden_score_card.dart';
import 'package:botanisht/widgets/hydroponic_dashboard_card.dart';
import 'package:botanisht/widgets/garden_overview_card.dart';
import 'package:botanisht/widgets/plant_card.dart';
import 'package:botanisht/widgets/brand_logo.dart';
import 'package:botanisht/widgets/add_plant_bottom_sheet.dart';
import 'package:botanisht/widgets/delete_plant_dialog.dart';
import 'package:botanisht/screens/search_delegate.dart';
import 'package:botanisht/screens/user_plant_detail_screen.dart';
import 'package:botanisht/data/companion_rules.dart';
import 'package:botanisht/services/weather_alert_service.dart';
import 'package:botanisht/services/garden_data_service.dart';

const List<String> _outdoorZones = [
  'kitchen',
  'outdoor',
  'garden',
  'balcony',
  'patio',
  'yard',
  'backyard',
];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUserPlants = ref.watch(userPlantsProvider);
    final weatherAsync = ref.watch(weatherAlertProvider);
    final alert = weatherAsync.value;
    final locationReady = ref.watch(gardenLocationReadyProvider);
    // Keeps the 4-hour weather refresh cycle alive for the app session.
    ref.watch(weatherAutoRefreshProvider);

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
                // Day/Night toggle — mirrors the sun/moon icon in the website mockup
                Consumer(
                  builder: (ctx, ref, _) {
                    final settings = ref.watch(settingsProvider);
                    final isDark = settings.themeMode == 2;
                    return IconButton(
                      icon: Icon(
                        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                        semanticLabel: isDark ? 'Switch to Cream theme' : 'Switch to Evergreen theme',
                      ),
                      onPressed: () {
                        ref.read(settingsProvider.notifier).setThemeMode(isDark ? 1 : 2);
                      },
                      tooltip: 'Toggle theme (Cream ↔ Evergreen)',
                    );
                  },
                ),
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
                  tabs: tabTitles.map((t) => Tab(
                    icon: Icon(_zoneIcon(t)),
                    text: _pretty(t),
                  )).toList(),
                ),
              ),
            ),
            body: Column(
              children: [
                const GardenScoreCard(),
                if (alert != null) _WeatherAlertCard(alert: alert),
                if (!locationReady) const _GardenLocationHint(),
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
    if (plants.isEmpty) return _emptyState(context, ref);

    // --- Zone-tab advisories (contextual to this zone) ---
    final headers = <Widget>[
      GardenOverviewCard(
        zoneName: zone,
        plants: plants,
        totalAcrossGarden: all.length,
      ),
    ];

    // Watering reminders — "Water raised bed — in 2h" style
    headers.add(_buildWateringReminders(context, plants));

    // Weather "move inside" advisory for physically-exposed (outdoor) zones.
    final alert = ref.watch(weatherAlertProvider).value;
    final isOutdoor = _outdoorZones.any((k) => zone.toLowerCase().contains(k));
    if (isOutdoor && alert != null) {
      final atRisk = plants
          .where((p) =>
              p.customName != null && alert.plantNames.contains(p.customName))
          .map((p) => p.customName!)
          .toList();
      if (atRisk.isNotEmpty) headers.add(_ZoneMoveInsideCard(plants: atRisk));
    }

    // Zone-level companion-planting summary.
    final companionAdvices = <String, bool>{};
    for (final p in plants) {
      final neighbors = plants
          .where((n) => n.id != p.id)
          .map((n) => n.customName ?? 'Plant')
          .toList();
      final advice = CompanionRules.evaluate(p.customName ?? 'Plant', neighbors);
      if (advice != null) companionAdvices[advice.message] = advice.isWarning;
    }
    if (companionAdvices.isNotEmpty) {
      headers.add(_ZoneCompanionSummaryCard(advices: companionAdvices));
    }

    // Hydroponic dashboard card — only for non-diagnostic zone tabs
    headers.add(HydroponicDashboardCard(zone: zone));

    // Zone conditions card — shows sun, pH, temp, humidity, notes
    final zoneConfig = ref.read(settingsProvider.notifier).getZoneConfig(zone);
    if (zoneConfig != null) {
      final hasConditions = zoneConfig.sunExposure != null ||
          zoneConfig.targetPh != null ||
          zoneConfig.temperatureC != null ||
          zoneConfig.humidityPercent != null;
      if (hasConditions || zoneConfig.notes != null) {
        headers.add(_ZoneConditionsCard(config: zoneConfig));
      }
    }

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(userPlantsProvider),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: headers.length + plants.length,
        itemBuilder: (context, index) {
          if (index < headers.length) return headers[index];
          final userPlant = plants[index - headers.length];
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
                      UserPlantDetailScreen(plantId: userPlant.id),
                ),
              ),
              onLongPress: () => confirmDeletePlant(context, ref, userPlant),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWateringReminders(BuildContext context, List<UserPlant> plants) {
    final withReminders = plants.where((p) => p.wateringReminderEnabled).toList();
    if (withReminders.isEmpty) return const SizedBox.shrink();

    // Sort: overdue first (most urgent), then upcoming (closest to due).
    final now = DateTime.now();
    withReminders.sort((a, b) {
      final aHours = a.lastWatered != null
          ? now.difference(a.lastWatered!).inHours
          : -1;
      final bHours = b.lastWatered != null
          ? now.difference(b.lastWatered!).inHours
          : -1;
      final aOverdue = (a.lastWatered == null || aHours >= a.wateringIntervalHours);
      final bOverdue = (b.lastWatered == null || bHours >= b.wateringIntervalHours);
      if (aOverdue && !bOverdue) return -1;
      if (!aOverdue && bOverdue) return 1;
      // Both overdue or both upcoming: sort by how far past/until due.
      if (a.lastWatered == null) return -1;
      if (b.lastWatered == null) return 1;
      return bHours.compareTo(aHours);
    });

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.primary.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.water_drop_rounded, color: colors.primary, size: 22),
              const SizedBox(width: 8),
              Text(
                'Watering reminders',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...withReminders.map((p) {
            final name = p.customName ?? 'Plant';
            final hoursSince = p.lastWatered != null
                ? now.difference(p.lastWatered!).inHours
                : null;
            final interval = p.wateringIntervalHours;

            String timeText;
            Color textColor;
            IconData icon;

            if (hoursSince == null) {
              // Never watered
              timeText = '— never watered';
              textColor = colors.error;
              icon = Icons.error_outline_rounded;
            } else if (hoursSince < interval) {
              // Not yet due: show time until watering is needed
              final hoursUntil = interval - hoursSince;
              if (hoursUntil >= 48) {
                timeText = '— in ${hoursUntil ~/ 24}d';
              } else {
                timeText = '— in ${hoursUntil}h';
              }
              textColor = colors.onSurfaceVariant;
              icon = Icons.water_drop_rounded;
            } else {
              // Overdue
              final hoursOverdue = hoursSince - interval;
              if (hoursOverdue >= 48) {
                timeText = '— ${hoursOverdue ~/ 24}d overdue';
              } else {
                timeText = '— ${hoursOverdue}h overdue';
              }
              textColor = colors.error;
              icon = Icons.warning_amber_rounded;
            }

            return Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                children: [
                  Icon(icon, size: 16, color: textColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Water $name $timeText',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDiagnosticTab(
    BuildContext context,
    WidgetRef ref,
    List<UserPlant> plants,
  ) {
    if (plants.isEmpty) return _emptyState(context, ref);

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
                      UserPlantDetailScreen(plantId: userPlant.id),
                ),
              ),
              onLongPress: () => confirmDeletePlant(context, ref, userPlant),
            ),
          );
        },
      ),
    );
  }

  Widget _emptyState(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Botanical illustration — a sprout in a pot
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.eco_rounded,
                    size: 64,
                    color: colors.primary.withOpacity(0.25),
                  ),
                  Icon(
                    Icons.spa_rounded,
                    size: 32,
                    color: colors.primary.withOpacity(0.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Your garden is empty',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Tap the + button or use Search to browse our catalog of ${_kTotalPlants} plants and start building your green space.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () => _showSearchDialog(context, ref),
              icon: const Icon(Icons.search_rounded),
              label: const Text('Browse Plants'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
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

  /// Icon for each zone tab, matching the website mockup.
  static IconData _zoneIcon(String z) {
    switch (z) {
      case 'indoor': return Icons.meeting_room_rounded;
      case 'hydro': return Icons.science_rounded;
      case 'kitchen': return Icons.kitchen_rounded;
      case 'outdoor': return Icons.nature_people_rounded;
      case 'garden': return Icons.local_florist_rounded;
      case 'balcony': return Icons.deck_rounded;
      case 'patio': return Icons.yard_rounded;
      case 'yard': return Icons.grass_rounded;
      case 'diagnostic': return Icons.analytics_rounded;
      default: return Icons.eco_rounded;
    }
  }

  static const int _kTotalPlants = 73;

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

/// Quiet, non-alarming hint shown when no garden ZIP is set, so weather
/// alerts stay opt-in and privacy-friendly (no GPS required).
class _GardenLocationHint extends StatelessWidget {
  const _GardenLocationHint();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.onSurface.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: scheme.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Set a garden location in Settings to enable automatic '
              'storm/frost warnings.',
              style: TextStyle(fontSize: 15, color: scheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}

/// Per-zone "move inside" advisory shown at the top of outdoor zone tabs when
/// a severe-weather alert is active for that zone's plants.
class _ZoneMoveInsideCard extends StatelessWidget {
  final List<String> plants;

  const _ZoneMoveInsideCard({required this.plants});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF3A2A00);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4B860),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD99A3C), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: ink),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Move inside — severe weather',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: ink),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Bring these in before the storm or frost:',
            style: TextStyle(fontSize: 16, color: ink),
          ),
          const SizedBox(height: 4),
          ...plants.map(
            (n) => Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text('• $n', style: const TextStyle(fontSize: 16, color: ink)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Zone-level companion-planting overview shown at the top of a zone tab,
/// aggregating every warning/tip that applies to the plants sharing it.
class _ZoneCompanionSummaryCard extends StatelessWidget {
  final Map<String, bool> advices;

  const _ZoneCompanionSummaryCard({required this.advices});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasWarning = advices.values.any((v) => v);
    final borderColor = hasWarning
        ? Colors.amber.shade700
        : const Color(0xFF52B788); // Leaf Green
    final bgColor = hasWarning
        ? Colors.amber.withValues(alpha: 0.08)
        : const Color(0xFF52B788).withValues(alpha: 0.06);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor.withValues(alpha: 0.5), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasWarning
                    ? Icons.warning_amber_rounded
                    : Icons.eco_rounded,
                color: hasWarning ? Colors.amber.shade700 : const Color(0xFF52B788),
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                hasWarning ? '⚠️ Companion Clash' : '🌿 Companion Planting',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: hasWarning ? Colors.amber.shade800 : const Color(0xFF1B4332)),
              ),
              if (hasWarning) ...[
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${advices.values.where((v) => v).length} clash${advices.values.where((v) => v).length > 1 ? 'es' : ''}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          ...advices.entries.map(
            (e) => Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: e.value
                          ? Colors.amber.withValues(alpha: 0.15)
                          : const Color(0xFF52B788).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      e.value
                          ? Icons.warning_amber_rounded
                          : Icons.lightbulb_rounded,
                      size: 20,
                      color: e.value ? Colors.amber.shade800 : const Color(0xFF52B788),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      e.key,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: e.value ? FontWeight.w600 : FontWeight.normal,
                          color: e.value
                              ? Colors.amber.shade900
                              : const Color(0xFF1B4332)),
                    ),
                  ),
                ],
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
  const AppSettingsDrawer({super.key});

  /// Icon for each zone, matching the website mockup.
  static IconData _zoneIcon(String z) {
    switch (z) {
      case 'indoor': return Icons.meeting_room_rounded;
      case 'hydro': return Icons.science_rounded;
      case 'kitchen': return Icons.kitchen_rounded;
      case 'outdoor': return Icons.nature_people_rounded;
      case 'garden': return Icons.local_florist_rounded;
      case 'balcony': return Icons.deck_rounded;
      case 'patio': return Icons.yard_rounded;
      case 'yard': return Icons.grass_rounded;
      default: return Icons.eco_rounded;
    }
  }

  static String _pretty(String z) {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final userPlantsAsync = ref.watch(userPlantsProvider);

    // Collect unique zone names from user's plants.
    final zones = <String>[];
    userPlantsAsync.whenData((plants) {
      for (final p in plants) {
        final z = (p.zone ?? 'uncategorized').toLowerCase().trim();
        if (!zones.contains(z)) zones.add(z);
      }
    });

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 180,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: BrandLogo(),
                  ),
                ),
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.location_on_rounded),
            title: const Text('Garden Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            subtitle: Text(
              settings.gardenZipCode?.isNotEmpty == true
                  ? 'ZIP ${settings.gardenZipCode}'
                  : 'Set a ZIP code for weather alerts',
              style: const TextStyle(fontSize: 14),
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _showGardenLocationDialog(context, ref),
          ),
          if (zones.isNotEmpty) ...[
            const Divider(),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Zone Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...zones.map(
              (z) => ListTile(
                leading: Icon(_zoneIcon(z)),
                title: Text(
                  _pretty(z),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  _zoneSettingsSubtitle(notifier.getZoneConfig(z)),
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => _showZoneSettingsSheet(context, ref, z),
              ),
            ),
          ],
          const Divider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Data Portability',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.upload_file_rounded),
            title: const Text('Export Garden Data',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            subtitle: const Text('Back up plants, logs & settings as JSON',
                style: TextStyle(fontSize: 14)),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _exportGardenData(context),
          ),
          ListTile(
            leading: const Icon(Icons.download_rounded),
            title: const Text('Import Garden Data',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            subtitle: const Text('Merge a JSON backup into this garden',
                style: TextStyle(fontSize: 14)),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _importGardenData(context, ref),
          ),
        ],
      ),
    );
  }

  String _zoneSettingsSubtitle(ZoneConfig? cfg) {
    if (cfg == null) return 'Configure zone conditions';
    final parts = <String>[];
    if (cfg.sunExposure != null) parts.add(cfg.sunExposure!);
    if (cfg.targetPh != null) parts.add('pH ${cfg.targetPh!.toStringAsFixed(1)}');
    if (cfg.temperatureC != null) parts.add('${cfg.temperatureC!.round()}°C');
    if (cfg.humidityPercent != null) parts.add('${cfg.humidityPercent}%');
    return parts.isNotEmpty ? parts.join(' · ') : 'Configure zone conditions';
  }

  void _showGardenLocationDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(
      text: ref.read(settingsProvider).gardenZipCode ?? '',
    );
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Garden Location'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLength: 5,
          decoration: const InputDecoration(
            labelText: 'ZIP Code',
            hintText: '62220',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on_rounded),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final zip = controller.text.trim();
              if (RegExp(r'^\d{5}$').hasMatch(zip)) {
                ref.read(settingsProvider.notifier).setGardenZip(zip);
                ref.invalidate(weatherAlertProvider);
                Navigator.pop(ctx);
              } else {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(
                      content: Text('Enter a valid 5-digit ZIP code')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showZoneSettingsSheet(BuildContext context, WidgetRef ref, String zone) {
    final notifier = ref.read(settingsProvider.notifier);
    final existing = notifier.getZoneConfig(zone);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ZoneSettingsSheet(zone: zone, initial: existing),
    );
  }

  /// Serialises the whole garden (plants, hydroponic logs, settings) to a
  /// timestamped JSON file and surfaces the file path in a snackbar.
  Future<void> _exportGardenData(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final service = GardenDataService();
    try {
      final summary = await service.buildExportSummary();
      if (!context.mounted) return;
      final path = await service.exportToFile();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Exported ${summary.plantCount} plant(s) & ${summary.logCount} '
            'log(s) → $path',
          ),
          duration: const Duration(seconds: 6),
        ),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    }
  }

  /// Pastes / parses a JSON backup, confirms what will be merged, then
  /// imports plants, hydroponic logs and settings into the current garden.
  Future<void> _importGardenData(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final service = GardenDataService();
    final controller = TextEditingController();

    GardenDataSummary? parsed;
    String? errorText;
    parsed = await showDialog<GardenDataSummary>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Import Garden Data'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Paste a Botanisht JSON export below. It will be merged '
                  'into your current garden — nothing existing is deleted.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller,
                  maxLines: 10,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                  decoration: const InputDecoration(
                    hintText: '{\n  "version": 1,\n  "plants": [...],\n  ...\n}',
                    border: OutlineInputBorder(),
                  ),
                ),
                if (errorText != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    errorText!,
                    style: TextStyle(
                      color: Theme.of(ctx).colorScheme.error,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  final summary = service.parseImport(controller.text);
                  Navigator.pop(ctx, summary);
                } on FormatException catch (e) {
                  setState(() => errorText = e.message);
                } catch (_) {
                  setState(() => errorText =
                      'Could not read this text as a garden export.');
                }
              },
              child: const Text('Parse'),
            ),
          ],
        ),
      ),
    );
    if (parsed == null || !context.mounted) return;
    final summary = parsed;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Import'),
        content: Text(
          'This will merge into your garden:\n\n'
          '• ${summary.plantCount} plant(s)\n'
          '• ${summary.logCount} hydroponic log(s)\n'
          '• ${summary.hasSettings ? 'App settings' : 'No settings'}\n\n'
          'Existing data is kept.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Import'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    try {
      final result = await service.importFromJson(controller.text);
      // Refresh every view of the garden so imported data shows up
      // immediately.
      ref.invalidate(userPlantsProvider);
      ref.invalidate(userPlantsSortedProvider);
      ref.invalidate(plantsNeedingWaterProvider);
      ref.invalidate(settingsProvider);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Imported ${result.summary.plantCount} plant(s) & '
            '${result.summary.logCount} log(s)',
          ),
        ),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Import failed: $e')),
      );
    }
  }
}

/// Card showing the environmental conditions configured for a zone.
///
/// Only rendered when at least one condition or note is present, styled with
/// the same cream / evergreen palette as the other dashboard cards.
class _ZoneConditionsCard extends StatelessWidget {
  final ZoneConfig config;

  const _ZoneConditionsCard({required this.config});

  @override
  Widget build(BuildContext context) {
    const evergreen = Color(0xFF1B4332);
    const cream = Color(0xFFF5F0E1);
    const leafGreen = Color(0xFF52B788);

    final rows = <Widget>[];

    if (config.sunExposure != null) {
      rows.add(_conditionRow(
        Icons.wb_sunny_rounded,
        'Sunlight',
        config.sunExposure!,
        leafGreen,
      ));
    }
    if (config.targetPh != null) {
      rows.add(_conditionRow(
        Icons.science_rounded,
        'Soil pH',
        config.targetPh!.toStringAsFixed(1),
        leafGreen,
      ));
    }
    if (config.temperatureC != null) {
      rows.add(_conditionRow(
        Icons.thermostat_rounded,
        'Temperature',
        '${config.temperatureC!.round()}°C',
        leafGreen,
      ));
    }
    if (config.humidityPercent != null) {
      rows.add(_conditionRow(
        Icons.water_drop_rounded,
        'Humidity',
        '${config.humidityPercent}%',
        leafGreen,
      ));
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cream.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: evergreen.withValues(alpha: 0.15),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.eco_rounded, color: evergreen, size: 22),
              const SizedBox(width: 8),
              Text(
                'Zone Conditions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: evergreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (rows.isNotEmpty) ...rows,
          if (config.notes != null && config.notes!.isNotEmpty) ...[
            if (rows.isNotEmpty) const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: evergreen.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.notes_rounded,
                      size: 18, color: evergreen.withValues(alpha: 0.6)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      config.notes!,
                      style: TextStyle(
                        fontSize: 14,
                        color: evergreen.withValues(alpha: 0.8),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _conditionRow(
      IconData icon, String label, String value, Color accent) {
    const evergreen = Color(0xFF1B4332);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: accent),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: evergreen.withValues(alpha: 0.7),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: evergreen,
            ),
          ),
        ],
      ),
    );
  }
}

/// Bottom-sheet form for editing per-zone environmental conditions and notes.
class _ZoneSettingsSheet extends ConsumerStatefulWidget {
  final String zone;
  final ZoneConfig? initial;

  const _ZoneSettingsSheet({required this.zone, this.initial});

  @override
  ConsumerState<_ZoneSettingsSheet> createState() =>
      _ZoneSettingsSheetState();
}

class _ZoneSettingsSheetState extends ConsumerState<_ZoneSettingsSheet> {
  late String _sunExposure;
  late double _targetPh;
  late String _soilDrainage;
  late double _temperatureC;
  late double _humidityPercent;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    final c = widget.initial;
    _sunExposure = c?.sunExposure ?? 'Partial shade';
    _targetPh = c?.targetPh ?? 6.5;
    _soilDrainage = c?.soilDrainage ?? 'Well-drained';
    _temperatureC = c?.temperatureC ?? 21.0;
    _humidityPercent = (c?.humidityPercent ?? 50).toDouble();
    _notesController = TextEditingController(text: c?.notes ?? '');
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const evergreen = Color(0xFF1B4332);
    const leafGreen = Color(0xFF52B788);

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F0E1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: evergreen.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Title
            Text(
              '${_pretty(widget.zone)} Conditions',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: evergreen,
              ),
            ),
            const SizedBox(height: 20),

            // Sun exposure
            const Text('Sun Exposure',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                    color: evergreen)),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              selected: {_sunExposure},
              onSelectionChanged: (v) =>
                  setState(() => _sunExposure = v.first),
              segments: const [
                ButtonSegment(value: 'Full sun', label: Text('Full sun')),
                ButtonSegment(value: 'Partial shade',
                    label: Text('Partial shade')),
                ButtonSegment(value: 'Indirect light',
                    label: Text('Indirect')),
                ButtonSegment(value: 'Grow lights',
                    label: Text('Grow lights')),
              ],
            ),
            const SizedBox(height: 20),

            // Target pH
            Row(
              children: [
                const Text('Target Soil pH',
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: evergreen)),
                const Spacer(),
                Text(
                  _targetPh.toStringAsFixed(1),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: leafGreen),
                ),
              ],
            ),
            Slider(
              value: _targetPh,
              min: 5.0,
              max: 8.0,
              divisions: 30,
              activeColor: leafGreen,
              inactiveColor: leafGreen.withValues(alpha: 0.2),
              label: _targetPh.toStringAsFixed(1),
              onChanged: (v) => setState(() => _targetPh = v),
            ),
            const SizedBox(height: 12),

            // Soil drainage
            const Text('Soil Drainage',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                    color: evergreen)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _soilDrainage,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              items: const [
                DropdownMenuItem(value: 'Well-drained',
                    child: Text('Well-drained')),
                DropdownMenuItem(value: 'Moist', child: Text('Moist')),
                DropdownMenuItem(value: 'Sandy', child: Text('Sandy')),
                DropdownMenuItem(value: 'Clay', child: Text('Clay')),
                DropdownMenuItem(value: 'Loam', child: Text('Loam')),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _soilDrainage = v);
              },
            ),
            const SizedBox(height: 20),

            // Temperature
            Row(
              children: [
                const Text('Temperature (°C)',
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: evergreen)),
                const Spacer(),
                Text(
                  '${_temperatureC.round()}°C',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: leafGreen),
                ),
              ],
            ),
            Slider(
              value: _temperatureC,
              min: 5.0,
              max: 40.0,
              divisions: 35,
              activeColor: leafGreen,
              inactiveColor: leafGreen.withValues(alpha: 0.2),
              label: '${_temperatureC.round()}°C',
              onChanged: (v) => setState(() => _temperatureC = v),
            ),
            const SizedBox(height: 12),

            // Humidity
            Row(
              children: [
                const Text('Humidity (%)',
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: evergreen)),
                const Spacer(),
                Text(
                  '${_humidityPercent.round()}%',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: leafGreen),
                ),
              ],
            ),
            Slider(
              value: _humidityPercent,
              min: 20.0,
              max: 100.0,
              divisions: 80,
              activeColor: leafGreen,
              inactiveColor: leafGreen.withValues(alpha: 0.2),
              label: '${_humidityPercent.round()}%',
              onChanged: (v) => setState(() => _humidityPercent = v),
            ),
            const SizedBox(height: 16),

            // Notes
            const Text('Notes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                    color: evergreen)),
            const SizedBox(height: 8),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'e.g. Keep away from drafty windows',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 24),

            // Save button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: evergreen,
                  foregroundColor: const Color(0xFFF5F0E1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  final config = ZoneConfig(
                    sunExposure: _sunExposure,
                    targetPh: _targetPh,
                    soilDrainage: _soilDrainage,
                    temperatureC: _temperatureC,
                    humidityPercent: _humidityPercent.round(),
                    notes: _notesController.text.trim().isEmpty
                        ? null
                        : _notesController.text.trim(),
                  );
                  ref
                      .read(settingsProvider.notifier)
                      .setZoneConfig(widget.zone, config);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save Conditions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
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
}
