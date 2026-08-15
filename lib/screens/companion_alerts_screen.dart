import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/providers/plant_provider.dart' as plant_provider;
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/data/companion_rules.dart';
import 'package:botanisht/screens/user_plant_detail_screen.dart';

class CompanionAlertsScreen extends ConsumerWidget {
  const CompanionAlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPlants = ref.watch(plant_provider.userPlantsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Companion & Clash Alerts'),
        centerTitle: false,
      ),
      body: asyncPlants.when(
        data: (userPlants) {
          if (userPlants.isEmpty) {
            return _EmptyState();
          }

          // Group by zone
          final Map<String, List<UserPlant>> zoneGroups = {};
          for (final p in userPlants) {
            final z = (p.zone ?? 'uncategorized').toLowerCase().trim();
            zoneGroups.putIfAbsent(z, () => []).add(p);
          }

          // Analyze companions/clashes per zone
          final List<_ZoneAnalysis> analyses = [];
          for (final entry in zoneGroups.entries) {
            final zone = entry.key;
            final plants = entry.value;
            final analysis = _analyzeZone(zone, plants);
            if (analysis.hasAlerts || analysis.companions.isNotEmpty) {
              analyses.add(analysis);
            }
          }

          if (analyses.isEmpty) {
            return _AllHarmonious();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: analyses.length,
            itemBuilder: (context, index) => _ZoneAnalysisCard(analysis: analyses[index]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  _ZoneAnalysis _analyzeZone(String zone, List<UserPlant> plants) {
    final List<_CompanionPair> companions = [];
    final List<_ClashPair> clashes = [];
    final List<_MissingCompanion> missing = [];

    for (int i = 0; i < plants.length; i++) {
      final plant = plants[i];
      final name = plant.customName ?? 'Plant';
      final neighbors = plants
          .where((n) => n.id != plant.id)
          .map((n) => n.customName ?? 'Plant')
          .toList();

      final advice = CompanionRules.evaluate(name, neighbors);
      if (advice != null) {
        if (advice.isWarning) {
                // Warning - this is a clash
                clashes.add(_ClashPair(
                  plant: plant,
                  clashWith: _DummyPlant(customName: 'Incompatible plant'),
                  reason: advice.message,
                ));
              } else {
                // Tip - this is a companion benefit
                companions.add(_CompanionPair(
                  plant: plant,
                  companionWith: _DummyPlant(customName: 'Companion plant'),
                  benefit: advice.message,
                ));
              }
      }
    }

    // Check for missing companions (plants that could benefit from companions)
    for (final plant in plants) {
      final name = (plant.customName ?? '').toLowerCase();
      if (name.contains('tomato') && !plants.any((p) => (p.customName ?? '').toLowerCase().contains('basil'))) {
        missing.add(_MissingCompanion(
          plant: plant, 
          missing: 'Basil', 
          benefit: 'Basil repels thrips and improves tomato flavor and growth',
        ));
      }
      if (name.contains('beans') && !plants.any((p) => (p.customName ?? '').toLowerCase().contains('corn'))) {
        missing.add(_MissingCompanion(
          plant: plant, 
          missing: 'Corn', 
          benefit: 'Corn provides support for climbing beans',
        ));
      }
    }

    return _ZoneAnalysis(
      zone: zone,
      companions: companions,
      clashes: clashes,
      missing: missing,
    );
  }
}

class _ZoneAnalysis {
  final String zone;
  final List<_CompanionPair> companions;
  final List<_ClashPair> clashes;
  final List<_MissingCompanion> missing;

  _ZoneAnalysis({
    required this.zone,
    required this.companions,
    required this.clashes,
    required this.missing,
  });

  bool get hasAlerts => clashes.isNotEmpty || missing.isNotEmpty;
}

class _CompanionPair {
  final UserPlant plant;
  final UserPlant companionWith;
  final String benefit;

  _CompanionPair({required this.plant, required this.companionWith, required this.benefit});
}

class _ClashPair {
  final UserPlant plant;
  final UserPlant clashWith;
  final String reason;

  _ClashPair({required this.plant, required this.clashWith, required this.reason});
}

class _MissingCompanion {
  final UserPlant plant;
  final String missing;
  final String benefit;

  _MissingCompanion({required this.plant, required this.missing, required this.benefit});
}

class _DummyPlant extends UserPlant {
  _DummyPlant({String? customName}) {
    this.customName = customName;
  }
}

class _ZoneAnalysisCard extends StatelessWidget {
  final _ZoneAnalysis analysis;

  const _ZoneAnalysisCard({required this.analysis});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.grass_rounded, color: colorScheme.onPrimaryContainer, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  _prettyZone(analysis.zone),
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                if (analysis.clashes.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${analysis.clashes.length} clash${analysis.clashes.length > 1 ? 'es' : ''}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onErrorContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            
            if (analysis.clashes.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('⚠️ Clashes Detected', style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.error,
              )),
              const SizedBox(height: 8),
              ...analysis.clashes.map((c) => _ClashTile(clash: c)).toList(),
            ],

            if (analysis.companions.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('✅ Happy Companions', style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2E7D4F),
              )),
              const SizedBox(height: 8),
              ...analysis.companions.map((c) => _CompanionTile(pair: c)).toList(),
            ],

            if (analysis.missing.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('💡 Suggested Companions', style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFFE0913A),
              )),
              const SizedBox(height: 8),
              ...analysis.missing.map((m) => _MissingTile(missing: m)).toList(),
            ],
          ],
        ),
      ),
    );
  }

  String _prettyZone(String z) {
    final map = {
      'indoor': 'Indoor',
      'kitchen': 'Kitchen Garden',
      'hydro': 'Hydroponic',
      'pollinator': 'Pollinator Garden',
      'outdoor': 'Outdoor',
      'garden': 'Garden',
      'balcony': 'Balcony',
      'patio': 'Patio',
      'yard': 'Yard',
    };
    return map[z] ?? (z[0].toUpperCase() + z.substring(1));
  }
}

class _ClashTile extends StatelessWidget {
  final _ClashPair clash;

  const _ClashTile({required this.clash});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: colorScheme.error, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${clash.plant.customName ?? 'Plant'} has a clash',
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  clash.reason,
                  style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Icon(Icons.warning_amber_rounded, color: colorScheme.error, size: 20),
        ],
      ),
    );
  }
}

class _CompanionTile extends StatelessWidget {
  final _CompanionPair pair;

  const _CompanionTile({required this.pair});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D4F).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2E7D4F).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: const Color(0xFF2E7D4F), shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${pair.plant.customName ?? 'Plant'} has a companion benefit',
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  pair.benefit,
                  style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Icon(Icons.handshake_rounded, color: const Color(0xFF2E7D4F), size: 20),
        ],
      ),
    );
  }
}

class _MissingTile extends StatelessWidget {
  final _MissingCompanion missing;

  const _MissingTile({required this.missing});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE0913A).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0913A).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: const Color(0xFFE0913A), shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${missing.plant.customName ?? 'Plant'} needs ${missing.missing}',
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  missing.benefit,
                  style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Icon(Icons.add_circle_outline_rounded, color: const Color(0xFFE0913A), size: 20),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
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
              child: Icon(Icons.handshake_rounded, size: 60, color: colorScheme.primary),
            ),
            const SizedBox(height: 24),
            Text('No Plants to Analyze', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Text('Add plants to your garden to see companion and clash alerts.', style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _AllHarmonious extends StatelessWidget {
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
                color: const Color(0xFF2E7D4F).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_circle_rounded, size: 60, color: const Color(0xFF2E7D4F)),
            ),
            const SizedBox(height: 24),
            Text('All Harmonious!', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700, color: const Color(0xFF2E7D4F)), textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Text('Your plants are happy together. No clashes detected.', style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}