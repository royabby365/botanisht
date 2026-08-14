import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/hydroponic_provider.dart';

/// A card that displays the latest hydroponic telemetry (pH and TDS)
/// as a polished metric grid with OPTIMAL/CAUTION status badges,
/// matching the botanisht.com website mockup.
class HydroponicDashboardCard extends ConsumerWidget {
  const HydroponicDashboardCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final asyncLog = ref.watch(latestLogForZoneProvider('hydro'));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.science_rounded, color: colors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  'Hydroponic Log',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to log entry screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Manual log entry coming soon')),
                    );
                  },
                  icon: const Icon(Icons.add_rounded, size: 16),
                  label: const Text('Log', style: TextStyle(fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Data grid
            asyncLog.when(
              data: (log) {
                if (log == null) {
                  return _buildEmptyState(context);
                }
                return _buildMetricGrid(context, log);
              },
              loading: () => const SizedBox(
                height: 80,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
              error: (e, _) => _buildErrorState(context, e.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outline.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(Icons.sensors_off_rounded, size: 36, color: colors.onSurfaceVariant.withOpacity(0.5)),
          const SizedBox(height: 12),
          Text(
            'No readings yet',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Start tracking your hydro system — no hardware required',
            style: TextStyle(
              fontSize: 12,
              color: colors.onSurfaceVariant.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricGrid(BuildContext context, dynamic log) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final ph = log.waterPH;
    final tds = log.nutrientTds;
    final temp = log.temperature;
    final humidity = log.humidity;
    final lightHours = log.lightHours;
    final timestamp = log.timestamp;

    final phOptimal = ph != null && ph >= 5.5 && ph <= 6.5;
    final tdsOptimal = tds != null && tds >= 800 && tds <= 1500;
    final tempDisplay = temp != null ? '${temp.toStringAsFixed(1)}°' : '--';
    final humidityDisplay = humidity != null ? '${humidity.round()}' : '--';
    final lightDisplay = lightHours != null ? '${lightHours.toStringAsFixed(0)}h' : '--';

    return Column(
      children: [
        // Metric grid — matching the website mockup
        Row(
          children: [
            Expanded(child: _DashboardMetric(
              label: 'pH',
              value: ph != null ? ph.toStringAsFixed(2) : '--',
              unit: '',
              isOptimal: phOptimal,
            )),
            const SizedBox(width: 12),
            Expanded(child: _DashboardMetric(
              label: 'TDS',
              value: tds != null ? '${tds.round()}' : '--',
              unit: 'ppm',
              isOptimal: tdsOptimal,
            )),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _DashboardMetric(
              label: 'Temp',
              value: tempDisplay,
              unit: 'C',
              isOptimal: temp != null && temp >= 18 && temp <= 28,
            )),
            const SizedBox(width: 12),
            Expanded(child: _DashboardMetric(
              label: 'Humidity',
              value: humidityDisplay,
              unit: '%',
              isOptimal: humidity != null && humidity >= 50 && humidity <= 80,
            )),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _DashboardMetric(
              label: 'Light',
              value: lightDisplay,
              unit: '',
              isOptimal: lightHours != null && lightHours >= 6,
            )),
            const Expanded(child: SizedBox()),
          ],
        ),
        const SizedBox(height: 16),
        // Timestamp row
        Row(
          children: [
            Icon(Icons.access_time_rounded, size: 14, color: colors.onSurfaceVariant),
            const SizedBox(width: 6),
            Text(
              'Logged ${_formatTimestamp(timestamp)}',
              style: TextStyle(
                fontSize: 12,
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.error.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colors.error, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Could not load telemetry',
              style: TextStyle(color: colors.error),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

/// Large metric card with OPTIMAL/CAUTION status badge.
class _DashboardMetric extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final bool isOptimal;

  const _DashboardMetric({
    required this.label,
    required this.value,
    required this.unit,
    required this.isOptimal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final statusColor = isOptimal ? const Color(0xFF2E7D4F) : const Color(0xFFE0913A);
    final statusBg = isOptimal ? const Color(0xFF2E7D4F).withOpacity(0.1) : const Color(0xFFE0913A).withOpacity(0.1);
    final statusLabel = isOptimal ? 'OPTIMAL' : 'CAUTION';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colors.onSurfaceVariant,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),
                if (unit.isNotEmpty)
                  TextSpan(
                    text: ' $unit',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isOptimal ? Icons.check_circle_rounded : Icons.warning_amber_rounded,
                  size: 12,
                  color: statusColor,
                ),
                const SizedBox(width: 4),
                Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}