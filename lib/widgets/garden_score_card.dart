import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/providers/plant_provider.dart';
import 'package:botanisht/core/theme/app_theme.dart';

/// XP thresholds for each level.
const List<int> xpToLevel = [
  0, 50, 120, 220, 350, 520, 730, 980, 1280, 1630, 2030,
  2480, 2980, 3530, 4130, 4780, 5480, 6230, 7030, 7880,
];

int xpForCurrentLevel(int xp) {
  for (int i = xpToLevel.length - 1; i >= 1; i--) {
    if (xp >= xpToLevel[i]) return xpToLevel[i];
  }
  return 0;
}

int xpForNextLevel(int xp) {
  for (int i = 1; i < xpToLevel.length; i++) {
    if (xp < xpToLevel[i]) return xpToLevel[i];
  }
  // Beyond max table: progressive formula
  final offset = xpToLevel.last;
  final lastLevel = xpToLevel.length;
  final idx = (xp - offset) ~/ 130 + lastLevel;
  return offset + ((idx - lastLevel) * 130);
}

int currentLevelFromXp(int xp) {
  for (int i = xpToLevel.length - 1; i >= 1; i--) {
    if (xp >= xpToLevel[i]) return i + 1;
  }
  return 1;
}

/// Calculates the garden-wide stats from all user plants.
class GardenStats {
  final int totalPlants;
  final int totalXp;
  final int averageLevel;
  final int healthyCount;
  final int warningCount;
  final int criticalCount;
  final int dormantCount;
  final int totalStreakDays;

  GardenStats({
    required this.totalPlants,
    required this.totalXp,
    required this.averageLevel,
    required this.healthyCount,
    required this.warningCount,
    required this.criticalCount,
    required this.dormantCount,
    required this.totalStreakDays,
  });

  /// Best streak across all plants.
  int get bestStreak => totalStreakDays; // simplified — computed per garden

  /// Garden score: weighted health + level bonuses.
  int get gardenScore {
    final healthScore = (healthyCount * 100) +
        (warningCount * 40) +
        (criticalCount * 10) +
        (dormantCount * 25);
    final levelBonus = averageLevel * 20;
    return healthScore + levelBonus;
  }

  factory GardenStats.fromPlants(List<UserPlant> plants) {
    if (plants.isEmpty) {
      return GardenStats(
        totalPlants: 0,
        totalXp: 0,
        averageLevel: 1,
        healthyCount: 0,
        warningCount: 0,
        criticalCount: 0,
        dormantCount: 0,
        totalStreakDays: 0,
      );
    }

    int totalXp = 0;
    int totalLevels = 0;
    int healthy = 0, warning = 0, critical = 0, dormant = 0;
    int totalStreak = 0;

    for (final p in plants) {
      totalXp += p.xp;
      totalLevels += p.level;
      totalStreak += p.careStreak;
      switch (p.healthStatus) {
        case 'healthy':
          healthy++;
          break;
        case 'warning':
          warning++;
          break;
        case 'critical':
          critical++;
          break;
        case 'dormant':
          dormant++;
          break;
      }
    }

    return GardenStats(
      totalPlants: plants.length,
      totalXp: totalXp,
      averageLevel: (totalLevels / plants.length).round(),
      healthyCount: healthy,
      warningCount: warning,
      criticalCount: critical,
      dormantCount: dormant,
      totalStreakDays: totalStreak,
    );
  }
}

class GardenScoreCard extends ConsumerWidget {
  const GardenScoreCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userPlantsAsync = ref.watch(userPlantsProvider);

    return userPlantsAsync.when(
      data: (plants) {
        final stats = GardenStats.fromPlants(plants);
        return _buildScoreCard(context, theme, stats);
      },
      loading: () => _buildShimmer(context, theme),
      error: (e, _) => SizedBox.shrink(),
    );
  }

  Widget _buildScoreCard(BuildContext context, ThemeData theme, GardenStats stats) {
    final colorScheme = theme.colorScheme;
    final hasPlants = stats.totalPlants > 0;

    // Compute aggregate XP progress
    final currentThreshold = xpForCurrentLevel(stats.totalXp);
    final nextThreshold = xpForNextLevel(stats.totalXp);
    final progress = nextThreshold > currentThreshold
        ? (stats.totalXp - currentThreshold) / (nextThreshold - currentThreshold)
        : 0.0;
    final gardenLevel = currentLevelFromXp(stats.totalXp);

    // Best streak
    final bestStreak = stats.bestStreak;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              colorScheme.primary.withValues(alpha: 0.08),
              colorScheme.primary.withValues(alpha: 0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Garden Score + score badge
            Row(
              children: [
                Icon(Icons.emoji_nature, color: colorScheme.primary, size: 22),
                const SizedBox(width: 8),
                Text(
                  'Garden Score',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                if (hasPlants) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${stats.gardenScore}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                // Best streak badge
                if (bestStreak >= 7)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Colors.deepOrange.withValues(alpha: 0.3), width: 0.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_fire_department,
                            size: 14, color: Colors.deepOrange),
                        const SizedBox(width: 2),
                        Text(
                          '$bestStreak🔥',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (hasPlants) ...[
              const SizedBox(height: 12),

              // XP progress bar for aggregated garden
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  backgroundColor: colorScheme.primary.withValues(alpha: 0.10),
                  valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Garden Lv.$gardenLevel — ${stats.totalXp} XP · ${nextThreshold - stats.totalXp} XP to next level',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),

              // Health distribution
              Row(
                children: [
                  _HealthPill('Healthy', stats.healthyCount, colorScheme.primary, Icons.check_circle),
                  if (stats.warningCount > 0) ...[
                    const SizedBox(width: 6),
                    _HealthPill('Warning', stats.warningCount, Colors.orange, Icons.warning_amber),
                  ],
                  if (stats.criticalCount > 0) ...[
                    const SizedBox(width: 6),
                    _HealthPill('Critical', stats.criticalCount, Colors.redAccent, Icons.report),
                  ],
                  if (stats.dormantCount > 0) ...[
                    const SizedBox(width: 6),
                    _HealthPill('Dormant', stats.dormantCount, Colors.grey, Icons.nights_stay),
                  ],
                ],
              ),
              const SizedBox(height: 12),

              // Stats row
              Row(
                children: [
                  _StatChip(Icons.eco, '${stats.totalPlants}', 'Plants', colorScheme),
                  const SizedBox(width: 12),
                  _StatChip(Icons.auto_awesome, '${stats.totalXp}', 'Total XP', colorScheme),
                  const SizedBox(width: 12),
                  _StatChip(Icons.trending_up, 'Lv.${stats.averageLevel}', 'Avg Level', colorScheme),
                ],
              ),
            ] else ...[
              const SizedBox(height: 12),
              Text(
                'Add your first plant to see your Garden Score!',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer(BuildContext context, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
    );
  }
}

class _HealthPill extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final IconData icon;

  const _HealthPill(this.label, this.count, this.color, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 3),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final ColorScheme colorScheme;

  const _StatChip(this.icon, this.value, this.label, this.colorScheme);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: colorScheme.primary),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}