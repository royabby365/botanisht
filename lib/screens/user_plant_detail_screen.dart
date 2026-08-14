import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/providers/plant_provider.dart';
import 'package:botanisht/widgets/delete_plant_dialog.dart';
import 'package:botanisht/widgets/care_task_checklist.dart';
import 'package:botanisht/widgets/garden_score_card.dart';
import 'package:botanisht/widgets/pro_feature.dart';

class UserPlantDetailScreen extends ConsumerWidget {
  final int plantId;

  const UserPlantDetailScreen({super.key, required this.plantId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUserPlants = ref.watch(userPlantsProvider);
    final repo = ref.read(plantRepositoryProvider);

    // Resolve the live plant from the Isar-backed stream so any persisted
    // change (e.g. health status) is reflected immediately without reverting.
    final userPlant = asyncUserPlants.when<UserPlant?>(
      data: (list) {
        for (final p in list) {
          if (p.id == plantId) return p;
        }
        return null;
      },
      loading: () => null,
      error: (_, __) => null,
    );

    if (userPlant == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Plant Details')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(userPlant.customName ?? 'Plant Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userPlant.isPetSafe != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildPetSafetyBadge(context, userPlant.isPetSafe!),
              ),
            // Care task checklist
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CareTaskChecklist(
                title: '${userPlant.customName ?? 'Plant'} — Care Tasks',
                tasks: CareTaskChecklist.fromUserPlant(
                  userPlant,
                  onWater: () {
                    repo.recordWatering(userPlant.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('💧 Watering recorded! +10 XP')),
                    );
                  },
                  onFertilize: () {
                    repo.recordFertilizing(userPlant.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('🧪 Fertilizing recorded! +15 XP')),
                    );
                  },
                  onPrune: () {
                    repo.recordPruning(userPlant.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('✂️ Pruning recorded! +10 XP')),
                    );
                  },
                ),
              ),
            ),
            // Gamification: XP, level, streak (Pro)
            ProFeature(
              title: 'Plant Growth',
              teaser: 'Track this plant\'s XP, level, and care streaks with Botanisht Pro',
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildGamificationSection(context, userPlant),
              ),
            ),
            _buildSection(context, 'Basic Info', [
              _buildDetailRow(context, Icons.health_and_safety, 'Health',
                  userPlant.healthStatus?.capitalize() ?? 'Unknown'),
              _buildDetailRow(context, Icons.location_on, 'Location',
                  _resolveLocation(userPlant)),
              _buildDetailRow(
                  context,
                  Icons.water_drop,
                  'Last Watered',
                  userPlant.lastWatered?.toLocal().toString().split(' ')[0] ??
                      'Never'),
              _buildDetailRow(
                  context,
                  Icons.grass,
                  'Last Fertilized',
                  userPlant.lastFertilized?.toLocal().toString().split(' ')[0] ??
                      'Never'),
              _buildDetailRow(
                  context,
                  Icons.content_cut,
                  'Last Pruned',
                  userPlant.lastPruned?.toLocal().toString().split(' ')[0] ??
                      'Never'),
              if (userPlant.potSize != null)
                _buildDetailRow(context, Icons.straighten, 'Pot Size', userPlant.potSize!),
              if (userPlant.soilType != null)
                _buildDetailRow(context, Icons.landscape, 'Soil Type', userPlant.soilType!),
              if (userPlant.lightConditions != null)
                _buildDetailRow(
                    context,
                    Icons.wb_sunny, 'Light', userPlant.lightConditions!),
              if (userPlant.temperatureRange != null)
                _buildDetailRow(
                    context,
                    Icons.thermostat, 'Temperature', userPlant.temperatureRange!),
              if (userPlant.humidityLevel != null)
                _buildDetailRow(
                    context,
                    Icons.water, 'Humidity', userPlant.humidityLevel!),
              if (userPlant.source != null)
                _buildDetailRow(context, Icons.shopping_bag, 'Source', userPlant.source!),
              if (userPlant.acquiredDate != null)
                _buildDetailRow(
                    context,
                    Icons.calendar_today,
                    'Acquired',
                    '${userPlant.acquiredDate!.day}/${userPlant.acquiredDate!.month}/${userPlant.acquiredDate!.year}'),
              if (userPlant.tags != null && userPlant.tags!.isNotEmpty)
                _buildDetailRow(
                    context,
                    Icons.tag, 'Tags', userPlant.tags!.join(', ')),
            ]),
            const SizedBox(height: 24),
            _buildSection(context, 'Care History', [
              if (userPlant.healthNotes != null &&
                  userPlant.healthNotes!.isNotEmpty)
                ...userPlant.healthNotes!.asMap().entries.map((entry) =>
                    _buildHistoryItem(context,
                        entry.key + 1, entry.value, Icons.health_and_safety, Theme.of(context).colorScheme.error)),
              if (userPlant.lastWatered != null)
                _buildHistoryItem(context, 0,
                    'Watered ${userPlant.lastWatered!.toLocal().toString().split(' ')[0]}',
                    Icons.water_drop, Theme.of(context).colorScheme.primary),
              if (userPlant.lastFertilized != null)
                _buildHistoryItem(context, 0,
                    'Fertilized ${userPlant.lastFertilized!.toLocal().toString().split(' ')[0]}',
                    Icons.grass, Theme.of(context).colorScheme.secondary),
              if (userPlant.lastPruned != null)
                _buildHistoryItem(context, 0,
                    'Pruned ${userPlant.lastPruned!.toLocal().toString().split(' ')[0]}',
                    Icons.content_cut, Theme.of(context).colorScheme.primary),
            ]),
            const SizedBox(height: 24),
            _buildSection(context, 'Measurements', [
              if (userPlant.heightCm != null)
                _buildDetailRow(context, Icons.height, 'Height', '${userPlant.heightCm} cm'),
              if (userPlant.widthCm != null)
                _buildDetailRow(
                    context,
                    Icons.horizontal_rule, 'Width', '${userPlant.widthCm} cm'),
              if (userPlant.lastMeasured != null)
                _buildDetailRow(context, Icons.date_range, 'Last Measured',
                    userPlant.lastMeasured!.toLocal().toString().split(' ')[0]),
            ]),
            const SizedBox(height: 24),
            _buildSection(context, 'Actions', [
              _buildActionButton(context, 'Water', Icons.water_drop, () {
                repo.recordWatering(userPlant.id);
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('💧 +10 XP — Watering recorded!')));
              }),
              _buildActionButton(context, 'Fertilize', Icons.grass, () {
                repo.recordFertilizing(userPlant.id);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('🧪 +15 XP — Fertilizing recorded!')));
              }),
              _buildActionButton(context, 'Prune', Icons.content_cut, () {
                repo.recordPruning(userPlant.id);
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('✂️ +10 XP — Pruning recorded!')));
              }),
              _buildActionButton(context, 'Health', Icons.health_and_safety, () {
                _showHealthDialog(context, ref, userPlant);
              }),
              _buildDeleteButton(context, () {
                confirmDeletePlant(context, ref, userPlant, popDetail: true);
              }),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildGamificationSection(BuildContext context, UserPlant plant) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Level color
    final Color levelColor;
    if (plant.level >= 15) {
      levelColor = const Color(0xFFFFD700);
    } else if (plant.level >= 10) {
      levelColor = const Color(0xFFC0C0C0);
    } else if (plant.level >= 5) {
      levelColor = const Color(0xFFCD7F32);
    } else {
      levelColor = colorScheme.primary;
    }

    // XP progress
    final currentThreshold = xpForCurrentLevel(plant.xp);
    final nextThreshold = xpForNextLevel(plant.xp);
    final progress = nextThreshold > currentThreshold
        ? (plant.xp - currentThreshold) / (nextThreshold - currentThreshold)
        : 0.0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              levelColor.withValues(alpha: 0.06),
              levelColor.withValues(alpha: 0.01),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: levelColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: levelColor, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${plant.level}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: levelColor,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Level ${plant.level} — ${plant.customName ?? 'Plant'}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: progress.clamp(0.0, 1.0),
                          backgroundColor: levelColor.withValues(alpha: 0.12),
                          valueColor: AlwaysStoppedAnimation<Color>(levelColor),
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${plant.xp} XP — ${nextThreshold - plant.xp} to next level',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Streak info row
            Row(
              children: [
                _buildStreakItem(
                  context,
                  Icons.local_fire_department,
                  'Care Streak',
                  '${plant.careStreak} days',
                  plant.careStreak >= 7 ? Colors.deepOrange : (plant.careStreak >= 3 ? Colors.orange : Colors.grey),
                ),
                const SizedBox(width: 16),
                _buildStreakItem(
                  context,
                  Icons.water_drop,
                  'Water Streak',
                  '${plant.wateringStreak} days',
                  plant.wateringStreak >= 7 ? Colors.blue : Colors.blue.shade300,
                ),
                const SizedBox(width: 16),
                _buildStreakItem(
                  context,
                  Icons.emoji_events,
                  'Total XP',
                  '${plant.xp} XP',
                  levelColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakItem(BuildContext context, IconData icon, String label, String value, Color color) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: theme.colorScheme.onSurface,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetSafetyBadge(BuildContext context, bool isPetSafe) {
    final theme = Theme.of(context);
    final bg = isPetSafe ? theme.colorScheme.primary : theme.colorScheme.error;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isPetSafe ? '🐾 Pet Safe' : '⚠️ Toxic to Pets',
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    if (children.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(height: 12),
        Card(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: children),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.onSurfaceVariant, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(
    BuildContext context,
    int index,
    String text,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
          style: theme.elevatedButtonTheme.style,
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context, VoidCallback onPressed) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(Icons.delete_rounded, color: theme.colorScheme.error),
          label: Text(
            'Delete Plant',
            style: TextStyle(color: theme.colorScheme.error),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: theme.colorScheme.error),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
      ),
    );
  }

  String _resolveLocation(UserPlant userPlant) {
    if (userPlant.location != null && userPlant.location!.trim().isNotEmpty) {
      return userPlant.location!;
    }
    return _zoneDisplayName(userPlant.zone);
  }

  String _zoneDisplayName(String? zone) {
    if (zone == null || zone.isEmpty) return 'Unassigned';
    const labels = <String, String>{
      'kitchen': 'Kitchen Garden',
      'hydro': 'Hydroponic Rack',
      'hydroponic': 'Hydroponic Rack',
      'indoor': 'Indoor',
      'garden': 'Garden',
      'outdoor': 'Outdoor',
      'balcony': 'Balcony',
      'patio': 'Patio',
      'yard': 'Yard',
      'backyard': 'Yard',
    };
    final label = labels[zone.toLowerCase()];
    if (label != null) return label;
    return zone[0].toUpperCase() + zone.substring(1);
  }

  void _showHealthDialog(
      BuildContext context, WidgetRef ref, UserPlant userPlant) {
    String selectedStatus = userPlant.healthStatus ?? 'healthy';
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Update Health Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedStatus,
                decoration: const InputDecoration(labelText: 'Health Status'),
                items: ['healthy', 'warning', 'critical', 'dormant']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s.capitalize())))
                    .toList(),
                onChanged: (value) => setDialogState(() => selectedStatus = value!),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  labelText: 'Note (optional)',
                  hintText: 'e.g., Yellow leaves on lower branches',
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await ref
                    .read(userPlantNotifierProvider.notifier)
                    .updateHealthStatus(
                        userPlant.id, selectedStatus, noteController.text);
                // Ensure the list/detail streams refresh with the new value.
                ref.invalidate(userPlantsProvider);
                ref.invalidate(userPlantsSortedProvider);
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
