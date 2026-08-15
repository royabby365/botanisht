import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/providers/hydroponic_provider.dart';
import 'package:botanisht/providers/plant_provider.dart' as plant_provider;
import 'package:botanisht/models/isar_user_plant.dart';

class DiagnosticsScreen extends ConsumerWidget {
  const DiagnosticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncZones = ref.watch(plant_provider.uniqueZonesProvider);
    final asyncPlants = ref.watch(plant_provider.userPlantsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnostics'),
        centerTitle: false,
      ),
      body: asyncZones.when(
        data: (zones) => asyncPlants.when(
          data: (plants) {
            if (plants.isEmpty) {
              return _EmptyDiagnostics(onAddPlant: () => _showAddPlantDialog(context, ref));
            }
            
            final zonesWithPlants = _groupPlantsByZone(plants);
            
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _OverallHealthCard(plants: plants),
                const SizedBox(height: 16),
                ...zonesWithPlants.entries.map((entry) => _ZoneDiagnosticsCard(
                  zoneName: entry.key,
                  plants: entry.value,
                )).toList(),
              ],
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

  Map<String, List<UserPlant>> _groupPlantsByZone(List<UserPlant> plants) {
    final map = <String, List<UserPlant>>{};
    for (final plant in plants) {
      final zone = (plant.zone ?? 'uncategorized').toLowerCase();
      map.putIfAbsent(zone, () => []).add(plant);
    }
    return map;
  }

  void _showAddPlantDialog(BuildContext context, WidgetRef ref) {
    // Navigate to add plant screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Use the + button on Home to add plants')),
    );
  }
}

class _OverallHealthCard extends StatelessWidget {
  final List<UserPlant> plants;

  const _OverallHealthCard({required this.plants});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final healthy = plants.where((p) => p.healthStatus == 'healthy').length;
    final warning = plants.where((p) => p.healthStatus == 'warning').length;
    final critical = plants.where((p) => p.healthStatus == 'critical').length;
    final total = plants.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overall Garden Health', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _HealthStat(
                    label: 'Healthy',
                    count: healthy,
                    color: const Color(0xFF2E7D4F),
                    icon: Icons.check_circle_rounded,
                  ),
                ),
                Expanded(
                  child: _HealthStat(
                    label: 'Warning',
                    count: warning,
                    color: const Color(0xFFE0913A),
                    icon: Icons.warning_amber_rounded,
                  ),
                ),
                Expanded(
                  child: _HealthStat(
                    label: 'Critical',
                    count: critical,
                    color: const Color(0xFFD2553F),
                    icon: Icons.error_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: total > 0 ? healthy / total : 0,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF2E7D4F)),
            ),
            const SizedBox(height: 8),
            Text(
              '$healthy of $total plants thriving',
              style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _HealthStat extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final IconData icon;

  const _HealthStat({required this.label, required this.count, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text('$count', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700, color: color)),
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }
}

class _ZoneDiagnosticsCard extends StatelessWidget {
  final String zoneName;
  final List<UserPlant> plants;

  const _ZoneDiagnosticsCard({required this.zoneName, required this.plants});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final healthy = plants.where((p) => p.healthStatus == 'healthy').length;
    final warning = plants.where((p) => p.healthStatus == 'warning').length;
    final critical = plants.where((p) => p.healthStatus == 'critical').length;
    final total = plants.length;

    String prettyZone(String z) {
      const map = {
        'indoor': 'Indoor',
        'hydro': 'Hydroponic',
        'kitchen': 'Kitchen Garden',
        'pollinator': 'Pollinator Patch',
        'native': 'Native Bed',
        'permeable': 'Permeable Bed',
        'bento': 'Bento Box',
        'balcony': 'Balcony',
        'patio': 'Patio',
        'yard': 'Yard',
      };
      return map[z] ?? z[0].toUpperCase() + z.substring(1);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.landscape_rounded, color: colorScheme.onPrimaryContainer, size: 24),
                ),
                const SizedBox(width: 12),
                Text(prettyZone(zoneName), style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _MiniStat(count: healthy, color: const Color(0xFF2E7D4F), label: 'Healthy'),
                const SizedBox(width: 16),
                _MiniStat(count: warning, color: const Color(0xFFE0913A), label: 'Warning'),
                const SizedBox(width: 16),
                _MiniStat(count: critical, color: const Color(0xFFD2553F), label: 'Critical'),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: plants.map((p) => _PlantHealthChip(plant: p)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final int count;
  final Color color;
  final String label;

  const _MiniStat({required this.count, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$count', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: color)),
        Text(label, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }
}

class _PlantHealthChip extends StatelessWidget {
  final UserPlant plant;

  const _PlantHealthChip({required this.plant});

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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            plant.customName ?? 'Unnamed',
            style: theme.textTheme.labelMedium?.copyWith(color: statusColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _EmptyDiagnostics extends StatelessWidget {
  final VoidCallback onAddPlant;

  const _EmptyDiagnostics({required this.onAddPlant});

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
              child: Icon(Icons.analytics_rounded, size: 60, color: colorScheme.primary),
            ),
            const SizedBox(height: 24),
            Text('No Plants to Diagnose', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Text('Add plants to your garden to see health diagnostics by zone.', style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            FilledButton.icon(onPressed: onAddPlant, icon: const Icon(Icons.add_rounded), label: const Text('Add Your First Plant')),
          ],
        ),
      ),
    );
  }
}