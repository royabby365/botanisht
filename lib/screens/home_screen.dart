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
import 'package:botanisht/screens/hydroponic_log_screen.dart';
import 'package:botanisht/screens/diagnostics_screen.dart';
import 'package:botanisht/screens/plant_profiles_screen.dart';
import 'package:botanisht/screens/companion_alerts_screen.dart';
import 'package:botanisht/core/theme/app_theme.dart';
import 'package:botanisht/widgets/pro_feature.dart';

/// Shows the zone settings bottom sheet.
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

  void _showAddPlantDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddPlantBottomSheet(),
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUserPlants = ref.watch(userPlantsProvider);
    final weatherAsync = ref.watch(weatherAlertProvider);
    final alert = weatherAsync.value;
    final locationReady = ref.watch(gardenLocationReadyProvider);
    ref.watch(weatherAutoRefreshProvider);

    return asyncUserPlants.when(
      data: (userPlants) {
        final Map<String, List<UserPlant>> zoneGroups = {};
        for (final p in userPlants) {
          final z = (p.zone ?? 'uncategorized').toLowerCase().trim();
          zoneGroups.putIfAbsent(z, () => []).add(p);
        }
        final zones = zoneGroups.keys.toList()..sort();
        
        // Capture instance methods for use in closures
        void showZoneSettings(BuildContext ctx, String zone) => this._showZoneSettingsSheet(ctx, ref, zone);
        void showAddPlant(BuildContext ctx) => this._showAddPlantDialog(ctx, ref);

        return Scaffold(
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
              // Pro pill — opens the upgrade sheet (honor system)
              Consumer(
                builder: (ctx, ref, _) {
                  final isPro = ref.watch(isProProvider);
                  const gold = Color(0xFFD4A843);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => showBotanishtUpgradeSheet(ctx, ref),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isPro
                              ? gold
                              : gold.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: gold.withValues(alpha: isPro ? 1 : 0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isPro
                                  ? Icons.workspace_premium_rounded
                                  : Icons.workspace_premium_outlined,
                              size: 15,
                              color: isPro ? Colors.white : gold,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isPro ? 'PRO' : 'Pro',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                color: isPro ? Colors.white : gold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
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
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: RefreshIndicator(
            onRefresh: () async => ref.invalidate(userPlantsProvider),
            child: CustomScrollView(
              slivers: [
                // Hero Garden Selector — matches website "Backyard Beds"
                SliverToBoxAdapter(child: _GardenHeroSelector(
                  zones: zones, 
                  userPlants: userPlants, 
                  zoneGroups: zoneGroups,
                  onAddPlant: () => showAddPlant(context),
                  onZoneSettings: (ctx, zone) => showZoneSettings(ctx, zone),
                )),
                
                // Quick Actions Row
                SliverToBoxAdapter(child: _QuickActionsRow()),
                
                // Garden Score
                const SliverToBoxAdapter(child: GardenScoreCard()),
                
                // Pro Gamification — XP & Streaks (teaser for free, live for Pro)
                const SliverToBoxAdapter(child: _ProGamificationSection()),
                
                // Weather Alert
                if (alert != null) SliverToBoxAdapter(child: _WeatherAlertCard(alert: alert)),
                
                // Location Hint
                if (!locationReady) const SliverToBoxAdapter(child: _GardenLocationHint()),
                
                // Feature Cards Grid (matching website's feature illustrations)
                SliverToBoxAdapter(child: _FeatureCardsGrid(
                  zones: zones, 
                  zoneGroups: zoneGroups, 
                  userPlants: userPlants, 
                  hasAlert: alert != null
                )),
                
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddPlantDialog(context, ref),
            icon: const Icon(Icons.add_rounded),
            label: const Text(
              'Add Plant',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            tooltip: 'Add plant',
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
      delegate: PlantSearchDelegate(fullCatalog: ref.read(isProProvider)),
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

  static const int _kTotalPlants = 121;

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
                  // Inter (not Fraunces): small serif sizes render with
                  // uneven/wide letter spacing — the sidebar kerning issue.
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                      ),
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
            // ChoiceChips (same as onboarding) so 'Evergreen' never squishes:
            // chips size to their content and wrap instead of being forced
            // into equal thirds of the drawer width.
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final (value, label)
                    in [(0, 'System'), (1, 'Cream'), (2, 'Evergreen')])
                  ChoiceChip(
                    label: Text(
                      label,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    selected: settings.themeMode == value,
                    onSelected: (_) => notifier.setThemeMode(value),
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
    final theme = Theme.of(context);
    final leaf = BotanishtPalette.leaf;
    final leafDeep = BotanishtPalette.leafDeep;
    final leafBright = BotanishtPalette.leafBright;
    final creamBg = BotanishtPalette.creamBg;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: creamBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
                  color: BotanishtPalette.line,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Title — Fraunces serif from theme
            Text(
              '${_pretty(widget.zone)} Conditions',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: leafDeep,
              ),
            ),
            const SizedBox(height: 24),

            // Sun exposure
            _sectionHeader(icon: Icons.wb_sunny_outlined, label: 'Sun Exposure', color: leafDeep),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              selected: {_sunExposure},
              onSelectionChanged: (v) =>
                  setState(() => _sunExposure = v.first),
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: BotanishtPalette.leafSoft,
                selectedForegroundColor: leafDeep,
                foregroundColor: BotanishtPalette.inkSoft,
              ),
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
            const SizedBox(height: 24),

            // Target pH
            _sliderSection(
              icon: Icons.science_outlined,
              label: 'Target Soil pH',
              value: _targetPh.toStringAsFixed(1),
              color: leafDeep,
              accent: leafBright,
              slider: Slider(
                value: _targetPh,
                min: 5.0,
                max: 8.0,
                divisions: 30,
                activeColor: leafBright,
                inactiveColor: BotanishtPalette.leafSoft,
                label: _targetPh.toStringAsFixed(1),
                onChanged: (v) => setState(() => _targetPh = v),
              ),
            ),

            // Soil drainage
            _sectionHeader(icon: Icons.water_drop_outlined, label: 'Soil Drainage', color: leafDeep),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _soilDrainage,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: BotanishtPalette.line),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: BotanishtPalette.line),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                filled: true,
                fillColor: BotanishtPalette.creamSurface,
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
            const SizedBox(height: 24),

            // Temperature
            _sliderSection(
              icon: Icons.thermostat_outlined,
              label: 'Temperature (°C)',
              value: '${_temperatureC.round()}°C',
              color: leafDeep,
              accent: leafBright,
              slider: Slider(
                value: _temperatureC,
                min: 5.0,
                max: 40.0,
                divisions: 35,
                activeColor: leafBright,
                inactiveColor: BotanishtPalette.leafSoft,
                label: '${_temperatureC.round()}°C',
                onChanged: (v) => setState(() => _temperatureC = v),
              ),
            ),

            // Humidity
            _sliderSection(
              icon: Icons.water_outlined,
              label: 'Humidity (%)',
              value: '${_humidityPercent.round()}%',
              color: leafDeep,
              accent: leafBright,
              slider: Slider(
                value: _humidityPercent,
                min: 20.0,
                max: 100.0,
                divisions: 80,
                activeColor: leafBright,
                inactiveColor: BotanishtPalette.leafSoft,
                label: '${_humidityPercent.round()}%',
                onChanged: (v) => setState(() => _humidityPercent = v),
              ),
            ),
            const SizedBox(height: 16),

            // Notes
            _sectionHeader(icon: Icons.edit_note_outlined, label: 'Notes', color: leafDeep),
            const SizedBox(height: 8),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'e.g. Keep away from drafty windows',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: BotanishtPalette.line),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: BotanishtPalette.line),
                ),
                contentPadding: const EdgeInsets.all(16),
                filled: true,
                fillColor: BotanishtPalette.creamSurface,
              ),
            ),
            const SizedBox(height: 24),

            // Save button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: leaf,
                  foregroundColor: BotanishtPalette.creamSurface,
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
                child: Text(
                  'Save Conditions',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: BotanishtPalette.creamSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _sliderSection({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Color accent,
    required Widget slider,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        slider,
        const SizedBox(height: 16),
      ],
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

/// ============================================================================
/// NEW WIDGETS FOR WEBSITE-MATCHING HOME SCREEN
/// ============================================================================

/// Hero Garden Selector — "Backyard Beds" style from website
class _GardenHeroSelector extends StatelessWidget {
  final List<String> zones;
  final List<UserPlant> userPlants;
  final Map<String, List<UserPlant>> zoneGroups;
  final VoidCallback onAddPlant;
  final Function(BuildContext, String) onZoneSettings;

  const _GardenHeroSelector({
    required this.zones,
    required this.userPlants,
    required this.zoneGroups,
    required this.onAddPlant,
    required this.onZoneSettings,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (userPlants.isEmpty) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow,
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Botanical illustration placeholder
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.local_florist_rounded,
                size: 60,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome to Your Garden',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Start by adding your first plant.\nWe\'ll help you track watering, companions,\nand growing conditions.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onAddPlant,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add Your First Plant'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ),
      );
    }

    // Find the main garden zone
    final mainZone = zones.firstWhere(
      (z) => _outdoorZones.any((o) => z.contains(o)),
      orElse: () => zones.first,
    );
    final mainPlants = zoneGroups[mainZone] ?? [];
    final plantCount = userPlants.length;
    const totalCatalog = 121;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with garden name
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.grass_rounded,
                  color: colorScheme.onPrimaryContainer,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Backyard Beds',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      '$plantCount of $totalCatalog plants in your garden',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit_rounded, color: colorScheme.onSurfaceVariant),
                onPressed: () => onZoneSettings(context, mainZone),
                tooltip: 'Edit garden settings',
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Plant preview row - horizontal scroll
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: (mainPlants.length > 5 ? 5 : mainPlants.length) + 1,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                if (index == (mainPlants.length > 5 ? 5 : mainPlants.length)) {
                  return _AddPlantPreviewCard(onAddPlant: onAddPlant);
                }
                final plant = mainPlants[index];
                return _PlantPreviewCard(userPlant: plant);
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Preview card for a plant in the garden hero
class _PlantPreviewCard extends StatelessWidget {
  final UserPlant userPlant;

  const _PlantPreviewCard({required this.userPlant});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final healthColor = _healthColor(userPlant.healthStatus, colorScheme);
    final name = userPlant.customName ?? 'Unnamed Plant';
    
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => UserPlantDetailScreen(plantId: userPlant.id)),
      ),
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _plantIcon(userPlant),
                color: colorScheme.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: healthColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                userPlant.healthStatus ?? 'healthy',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: healthColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _healthColor(String? status, ColorScheme scheme) {
    switch (status) {
      case 'healthy': return scheme.primary;
      case 'warning': return scheme.secondary;
      case 'critical': return scheme.error;
      case 'dormant': return scheme.onSurfaceVariant;
      default: return scheme.primary;
    }
  }

  IconData _plantIcon(UserPlant p) {
    final name = (p.customName ?? '').toLowerCase();
    if (name.contains('tomato')) return Icons.agriculture_rounded;
    if (name.contains('basil') || name.contains('herb')) return Icons.eco_rounded;
    if (name.contains('pepper')) return Icons.local_fire_department_rounded;
    if (name.contains('lettuce') || name.contains('greens')) return Icons.grass_rounded;
    return Icons.local_florist_rounded;
  }
}

/// Add plant preview card
class _AddPlantPreviewCard extends StatelessWidget {
  final VoidCallback onAddPlant;

  const _AddPlantPreviewCard({required this.onAddPlant});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return GestureDetector(
      onTap: onAddPlant,
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.4),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_rounded,
                color: colorScheme.onPrimaryContainer,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add Plant',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Quick Actions Row - matches website feature cards.
/// 2x2 grid so every label fits on a single line (no wrapping).
class _QuickActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _QuickActionCard(
                  icon: Icons.science_rounded,
                  label: 'Hydroponic Log',
                  color: Theme.of(context).colorScheme.primary,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HydroponicLogScreen()),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickActionCard(
                  icon: Icons.analytics_rounded,
                  label: 'Diagnostics',
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DiagnosticsScreen()),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _QuickActionCard(
                  icon: Icons.eco_rounded,
                  label: 'Plant Profiles',
                  color: const Color(0xFF52B788),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PlantProfilesScreen()),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickActionCard(
                  icon: Icons.warning_amber_rounded,
                  label: 'Companion Alerts',
                  color: const Color(0xFFD98A2B),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CompanionAlertsScreen()),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Feature Cards Grid - matches website's illustrated feature cards
class _FeatureCardsGrid extends StatelessWidget {
  final List<String> zones;
  final Map<String, List<UserPlant>> zoneGroups;
  final List<UserPlant> userPlants;
  final bool hasAlert;

  const _FeatureCardsGrid({
    required this.zones,
    required this.zoneGroups,
    required this.userPlants,
    required this.hasAlert,
  });

  static IconData _zoneIcon(String z) {
    final lower = z.toLowerCase();
    if (lower.contains('indoor')) return Icons.home_rounded;
    if (lower.contains('outdoor') || lower.contains('garden') || lower.contains('bed')) return Icons.grass_rounded;
    if (lower.contains('hydro')) return Icons.science_rounded;
    if (lower.contains('greenhouse')) return Icons.eco_rounded;
    if (lower.contains('balcony')) return Icons.balcony_rounded;
    if (lower.contains('kitchen')) return Icons.kitchen_rounded;
    return Icons.local_florist_rounded;
  }

  static String _pretty(String z) {
    return z
        .split(' ')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Only show if user has plants
    if (userPlants.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Garden Features',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.1,
            children: [
              // Zone Overview Card
              _IllustratedFeatureCard(
                illustration: Icons.grass_rounded,
                title: 'Zone Overview',
                subtitle: '${zones.length} zones • ${userPlants.length} plants',
                color: colorScheme.primary,
                onTap: () => _showZoneOverviewDialog(context),
              ),
              // Watering Schedule
              _IllustratedFeatureCard(
                illustration: Icons.water_drop_rounded,
                title: 'Watering Schedule',
                subtitle: _wateringSummary(),
                color: Colors.blue.shade600,
                onTap: () => _showWateringSchedule(context),
              ),
              // Companion Planting
              _IllustratedFeatureCard(
                illustration: Icons.handshake_rounded,
                title: 'Companions',
                subtitle: _companionSummary(),
                color: Color(0xFF52B788),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CompanionAlertsScreen()),
                ),
              ),
              // Hydroponic
              _IllustratedFeatureCard(
                illustration: Icons.science_rounded,
                title: 'Hydroponic Log',
                subtitle: _hydroSummary(),
                color: Colors.teal.shade600,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HydroponicLogScreen()),
                ),
              ),
              // Diagnostics
              _IllustratedFeatureCard(
                illustration: Icons.analytics_rounded,
                title: 'Diagnostics',
                subtitle: 'Health & environment insights',
                color: colorScheme.secondary,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DiagnosticsScreen()),
                ),
              ),
              // Weather
              _IllustratedFeatureCard(
                illustration: hasAlert ? Icons.storm_rounded : Icons.wb_sunny_rounded,
                title: 'Weather Alerts',
                subtitle: hasAlert ? 'Active alert' : 'No active alerts',
                color: hasAlert ? Colors.red.shade600 : Colors.amber.shade700,
                onTap: () => _showWeatherDetails(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _wateringSummary() {
    int dueSoon = 0;
    for (final p in userPlants) {
      if (p.nextWateringDue != null && p.nextWateringDue!.isBefore(DateTime.now().add(const Duration(hours: 24)))) {
        dueSoon++;
      }
    }
    return dueSoon > 0 ? '$dueSoon due in 24h' : 'All caught up';
  }

  String _companionSummary() {
    int clashes = 0;
    for (final zonePlants in zoneGroups.values) {
      for (final p in zonePlants) {
        final neighbors = zonePlants
            .where((n) => n.id != p.id)
            .map((n) => n.customName ?? 'Plant')
            .toList();
        final advice = CompanionRules.evaluate(p.customName ?? 'Plant', neighbors);
        if (advice != null && advice.isWarning) clashes++;
      }
    }
    return clashes > 0 ? '$clashes clash${clashes > 1 ? 'es' : ''} detected' : 'All harmonious';
  }

  String _hydroSummary() {
    int hydroCount = userPlants.where((p) => (p.zone ?? '').toLowerCase() == 'hydro').length;
    return hydroCount > 0 ? '$hydroCount hydro plant${hydroCount > 1 ? 's' : ''}' : 'No hydro setup';
  }

  void _showZoneOverviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Zone Overview'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: zones.length,
            itemBuilder: (ctx, i) {
              final zone = zones[i];
              final plants = zoneGroups[zone] ?? [];
              return ListTile(
                leading: Icon(_zoneIcon(zone), color: Theme.of(context).colorScheme.primary),
                title: Text(_pretty(zone)),
                trailing: Text('${plants.length} plants'),
                onTap: () => Navigator.pop(ctx),
              );
            },
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }

  void _showWateringSchedule(BuildContext context) {
    final duePlants = userPlants.where((p) => 
      p.nextWateringDue != null && p.nextWateringDue!.isBefore(DateTime.now().add(const Duration(days: 7)))
    ).toList()
      ..sort((a, b) => (a.nextWateringDue ?? DateTime.now()).compareTo(b.nextWateringDue ?? DateTime.now()));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Upcoming Watering'),
        content: SizedBox(
          width: double.maxFinite,
          child: duePlants.isEmpty
              ? const Center(child: Text('All plants watered!'))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: duePlants.length,
                  itemBuilder: (ctx, i) {
                    final p = duePlants[i];
                    final due = p.nextWateringDue!;
                    final hoursUntil = due.difference(DateTime.now()).inHours;
                    return ListTile(
                      leading: Icon(Icons.water_drop_rounded, color: Theme.of(context).colorScheme.primary),
                      title: Text(p.customName ?? 'Unnamed'),
                      subtitle: Text(hoursUntil <= 0 ? 'Overdue' : '$hoursUntil hours'),
                      trailing: Text('${p.wateringIntervalHours}h interval'),
                    );
                  },
                ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }

  void _showWeatherDetails(BuildContext context) {
    // Placeholder - could show full weather dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Weather details coming soon')),
    );
  }
}

/// Illustrated Feature Card matching website design
class _IllustratedFeatureCard extends StatelessWidget {
  final IconData illustration;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _IllustratedFeatureCard({
    required this.illustration,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow,
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Botanical illustration area
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(illustration, color: color, size: 26),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.chevron_right_rounded, color: colorScheme.onSurfaceVariant, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Keep existing _WeatherAlertCard and _GardenLocationHint classes...
// They are already defined later in the file, just need to make sure they're not duplicated

/// Pro gamification — per-plant XP, level, and care streak progress.
/// Free users see a ProFeature teaser card; Pro users see live progress.
class _ProGamificationSection extends ConsumerWidget {
  const _ProGamificationSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantsAsync = ref.watch(userPlantsProvider);
    final plants = plantsAsync.value ?? const <UserPlant>[];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ProFeature(
        title: 'XP & Levels',
        teaser: 'Track XP, levels, and care streaks for every plant with Botanisht Pro',
        child: _buildProContent(context, ref, plants),
      ),
    );
  }

  Widget _buildProContent(BuildContext context, WidgetRef ref, List<UserPlant> plants) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const gold = Color(0xFFD4A843);

    if (plants.isEmpty) {
      return const SizedBox.shrink();
    }

    final visible = plants.take(6).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: gold.withValues(alpha: 0.4), width: 1),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: gold.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.star_rounded, color: gold, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'XP & Streaks',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: gold,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'PRO',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final plant in visible) ...[
            _PlantXpRow(plant: plant),
            if (plant != visible.last) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _PlantXpRow extends StatelessWidget {
  final UserPlant plant;

  const _PlantXpRow({required this.plant});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final level = currentLevelFromXp(plant.xp);
    final current = xpForCurrentLevel(plant.xp);
    final next = xpForNextLevel(plant.xp);
    final progress = (next - current) <= 0
        ? 1.0
        : ((plant.xp - current) / (next - current)).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                'Lv$level',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                plant.customName ?? 'Plant #${plant.plantEntityId}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (plant.careStreak > 0)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_fire_department_rounded,
                      size: 15, color: Color(0xFFD98A2B)),
                  const SizedBox(width: 2),
                  Text(
                    '${plant.careStreak}d',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFD98A2B),
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: colorScheme.surfaceContainerHighest,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          '${plant.xp} / $next XP',
          style: TextStyle(
            fontSize: 11,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
