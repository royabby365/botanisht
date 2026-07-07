import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hydroponic_log.dart';
import '../providers/hydroponic_provider.dart';

/// A card that displays the latest hydroponic telemetry (pH and TDS)
/// in a clean, high‑contrast, technical layout.
class HydroponicDashboardCard extends ConsumerWidget {
  const HydroponicDashboardCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncLog = ref.watch(hydroponicLatestProvider);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Hydroponic Telemetry',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            // Data rows
            asyncLog.when(
              data: (log) {
                if (log == null) {
                  return const Text(
                    'No data yet',
                    style: TextStyle(color: Colors.grey),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MetricRow(
                      label: 'pH',
                      value: log.waterPH != null
                          ? log.waterPH!.toStringAsFixed(2)
                          : '–',
                      unit: '',
                    ),
                    const SizedBox(height: 8),
                    _MetricRow(
                      label: 'TDS',
                      value: log.nutrientTds != null ? '${(log.nutrientTds!.round())} ppm' : '–',
                      unit: '',
                    ),
                    const SizedBox(height: 8),
                    _MetricRow(
                      label: 'Pump Cycle',
                      value:
                          log.pumpCycleMinutes != null
                              ? '${log.pumpCycleMinutes} min'
                              : '–',
                      unit: '',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Updated: ${log.timestamp.toLocal()}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text(
                'Error: $e',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper widget for a single metric line.
class _MetricRow extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const _MetricRow({
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          '$value$unit',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}