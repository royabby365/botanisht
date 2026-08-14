import 'package:flutter/material.dart';
import 'package:botanisht/models/isar_user_plant.dart';

/// A data model for a single generated care task.
class CareTask {
  final String id;
  final String title;
  final String? subtitle;
  final IconData icon;
  final bool isCompleted;
  final bool isWarning;
  final VoidCallback? onTap;

  const CareTask({
    required this.id,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.isCompleted,
    this.isWarning = false,
    this.onTap,
  });
}

/// Per-plant care checklist card — derives actionable tasks from the plant's
/// current state (last watered / fertilized / pruned times, health status).
/// Matches the website mockup showing completed ✓ and warning ! tasks.
class CareTaskChecklist extends StatelessWidget {
  final List<CareTask> tasks;
  final String? title;

  const CareTaskChecklist({
    super.key,
    required this.tasks,
    this.title,
  });

  /// Factory to generate [CareTask]s from a [UserPlant].
  static List<CareTask> fromUserPlant(UserPlant plant, {VoidCallback? onWater, VoidCallback? onFertilize, VoidCallback? onPrune}) {
    final tasks = <CareTask>[];
    final now = DateTime.now();

    // Watering task
    if (plant.lastWatered != null) {
      final daysSinceWatered = now.difference(plant.lastWatered!).inDays;
      if (daysSinceWatered <= 1) {
        tasks.add(CareTask(
          id: 'watered-${plant.id}',
          title: 'Water ${plant.customName ?? 'Plant'}',
          subtitle: 'Done ${daysSinceWatered == 0 ? 'today' : 'yesterday'}',
          icon: Icons.water_drop_rounded,
          isCompleted: true,
          onTap: onWater,
        ));
      } else {
        tasks.add(CareTask(
          id: 'needs-water-${plant.id}',
          title: 'Water ${plant.customName ?? 'Plant'}',
          subtitle: '${daysSinceWatered} days since last watering',
          icon: Icons.water_drop_rounded,
          isCompleted: false,
          isWarning: daysSinceWatered > 3,
          onTap: onWater,
        ));
      }
    } else {
      tasks.add(CareTask(
        id: 'water-setup-${plant.id}',
        title: 'Water ${plant.customName ?? 'Plant'}',
        subtitle: 'No watering history yet',
        icon: Icons.water_drop_rounded,
        isCompleted: false,
        onTap: onWater,
      ));
    }

    // Fertilizing task
    if (plant.lastFertilized != null) {
      final daysSinceFert = now.difference(plant.lastFertilized!).inDays;
      if (daysSinceFert <= 7) {
        tasks.add(CareTask(
          id: 'fertilized-${plant.id}',
          title: 'Fertilize ${plant.customName ?? 'Plant'}',
          subtitle: 'Done ${daysSinceFert == 0 ? 'today' : '$daysSinceFert days ago'}',
          icon: Icons.grass,
          isCompleted: true,
          onTap: onFertilize,
        ));
      } else {
        tasks.add(CareTask(
          id: 'needs-fertilize-${plant.id}',
          title: 'Fertilize ${plant.customName ?? 'Plant'}',
          subtitle: '${daysSinceFert} days since last fertilizing',
          icon: Icons.grass,
          isCompleted: false,
          isWarning: daysSinceFert > 30,
          onTap: onFertilize,
        ));
      }
    }

    // Pruning task
    if (plant.lastPruned != null) {
      final daysSincePrune = now.difference(plant.lastPruned!).inDays;
      if (daysSincePrune <= 14) {
        tasks.add(CareTask(
          id: 'pruned-${plant.id}',
          title: 'Prune ${plant.customName ?? 'Plant'}',
          subtitle: 'Done ${daysSincePrune == 0 ? 'today' : '$daysSincePrune days ago'}',
          icon: Icons.content_cut,
          isCompleted: true,
          onTap: onPrune,
        ));
      } else {
        tasks.add(CareTask(
          id: 'needs-prune-${plant.id}',
          title: 'Prune ${plant.customName ?? 'Plant'}',
          subtitle: '${daysSincePrune} days since last pruning',
          icon: Icons.content_cut,
          isCompleted: false,
          isWarning: daysSincePrune > 60,
          onTap: onPrune,
        ));
      }
    }

    // Health status warning
    if (plant.healthStatus == 'warning') {
      tasks.add(CareTask(
        id: 'health-warning-${plant.id}',
        title: '${plant.customName ?? 'Plant'} needs attention',
        subtitle: 'Health status is WARNING',
        icon: Icons.health_and_safety,
        isCompleted: false,
        isWarning: true,
      ));
    } else if (plant.healthStatus == 'critical') {
      tasks.add(CareTask(
        id: 'health-critical-${plant.id}',
        title: '${plant.customName ?? 'Plant'} needs urgent care',
        subtitle: 'Health status is CRITICAL — check immediately',
        icon: Icons.dangerous_rounded,
        isCompleted: false,
        isWarning: true,
      ));
    } else if (plant.healthStatus == 'healthy') {
      tasks.add(CareTask(
        id: 'health-healthy-${plant.id}',
        title: '${plant.customName ?? 'Plant'} is healthy',
        subtitle: 'Keep up the good care!',
        icon: Icons.check_circle_rounded,
        isCompleted: true,
      ));
    }

    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (tasks.isEmpty) return const SizedBox.shrink();

    final overdue = tasks.where((t) => !t.isCompleted && t.isWarning).length;
    final done = tasks.where((t) => t.isCompleted).length;
    final pending = tasks.where((t) => !t.isCompleted && !t.isWarning).length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outline.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with summary
          Row(
            children: [
              Icon(Icons.checklist_rounded, color: colors.primary, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title ?? 'Today\'s Care Tasks',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
              ),
              // Summary badges
              if (done > 0)
                _SummaryBadge(
                  label: '$done done',
                  color: const Color(0xFF2E7D4F),
                ),
              if (pending > 0) ...[
                const SizedBox(width: 6),
                _SummaryBadge(
                  label: '$pending pending',
                  color: colors.primary,
                ),
              ],
              if (overdue > 0) ...[
                const SizedBox(width: 6),
                _SummaryBadge(
                  label: '$overdue!',
                  color: colors.error,
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          // Task list
          ...tasks.map((task) => _CareTaskRow(task: task)),
        ],
      ),
    );
  }
}

class _SummaryBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _SummaryBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _CareTaskRow extends StatelessWidget {
  final CareTask task;

  const _CareTaskRow({required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final tileColor = task.isWarning && !task.isCompleted
        ? colors.error.withOpacity(0.06)
        : Colors.transparent;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: tileColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: task.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                // Status icon
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: task.isCompleted
                        ? const Color(0xFF2E7D4F).withOpacity(0.12)
                        : task.isWarning
                            ? colors.error.withOpacity(0.12)
                            : colors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    task.isCompleted
                        ? Icons.check_rounded
                        : task.isWarning
                            ? Icons.warning_amber_rounded
                            : task.icon,
                    size: 16,
                    color: task.isCompleted
                        ? const Color(0xFF2E7D4F)
                        : task.isWarning
                            ? colors.error
                            : colors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                // Task text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: task.isCompleted
                              ? colors.onSurfaceVariant
                              : colors.onSurface,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      if (task.subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          task.subtitle!,
                          style: TextStyle(
                            fontSize: 12,
                            color: colors.onSurfaceVariant.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (task.onTap != null && !task.isCompleted)
                  Icon(Icons.chevron_right_rounded, size: 18, color: colors.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}