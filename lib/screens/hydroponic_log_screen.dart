import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/models/hydroponic_log.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/providers/hydroponic_provider.dart';
import 'package:botanisht/providers/plant_provider.dart' as plant_provider;
import 'package:botanisht/repository/plant_repository.dart';
import 'package:intl/intl.dart';

class HydroponicLogScreen extends ConsumerWidget {
  const HydroponicLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncLogs = ref.watch(hydroponicLogsProvider);
    final asyncPlants = ref.watch(plant_provider.userPlantsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hydroponic Log'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => _showAddLogDialog(context, ref, asyncPlants.value ?? []),
            tooltip: 'Add log entry',
          ),
        ],
      ),
      body: asyncLogs.when(
        data: (logs) {
          if (logs.isEmpty) {
            return _EmptyState(
              onAdd: () => _showAddLogDialog(context, ref, asyncPlants.value ?? []),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return _HydroponicLogCard(log: log);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading logs: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddLogDialog(context, ref, asyncPlants.value ?? []),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  void _showAddLogDialog(BuildContext context, WidgetRef ref, List<UserPlant> plants) {
    final hydroPlants = plants.where((p) => (p.zone ?? '').toLowerCase() == 'hydro').toList();
    if (hydroPlants.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add a hydroponic plant first')),
      );
      return;
    }

    UserPlant? selectedPlant = hydroPlants.first;
    final phController = TextEditingController();
    final tdsController = TextEditingController();
    final pumpController = TextEditingController();
    final tempController = TextEditingController();
    final humidityController = TextEditingController();
    final lightController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('New Hydroponic Log'),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<UserPlant>(
                    value: selectedPlant,
                    decoration: const InputDecoration(labelText: 'Plant'),
                    items: hydroPlants.map((p) => DropdownMenuItem(
                      value: p,
                      child: Text(p.customName ?? 'Unnamed'),
                    )).toList(),
                    onChanged: (v) => setState(() => selectedPlant = v),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: phController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Water pH',
                      hintText: '5.5 - 6.5',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: tdsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Nutrient TDS (PPM)',
                      hintText: '600 - 1000',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: pumpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Pump Cycle (minutes)',
                      hintText: '15 - 30',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: tempController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Temperature (°C)',
                      hintText: '18 - 22',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: humidityController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Humidity (%)',
                      hintText: '60 - 80',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: lightController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Light Hours',
                      hintText: '12 - 16',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: notesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      hintText: 'Nutrient changes, observations...',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            FilledButton(
              onPressed: () async {
                final ph = double.tryParse(phController.text);
                final tds = int.tryParse(tdsController.text);
                final pump = int.tryParse(pumpController.text);
                final temp = double.tryParse(tempController.text);
                final humidity = double.tryParse(humidityController.text);
                final light = double.tryParse(lightController.text);
                
                final log = HydroponicLog()
                  ..plantId = selectedPlant!.id
                  ..zone = selectedPlant?.zone ?? 'hydro'
                  ..waterPH = ph
                  ..nutrientTds = tds?.toDouble()
                  ..pumpCycleMinutes = pump
                  ..temperature = temp
                  ..humidity = humidity
                  ..lightHours = light
                  ..notes = notesController.text.trim().isEmpty ? null : notesController.text.trim()
                  ..timestamp = DateTime.now();

                // Use repository directly to add
                final repo = ref.read(plantRepositoryProvider);
                await repo.addHydroponicLog(log);
                
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HydroponicLogCard extends StatelessWidget {
  final HydroponicLog log;

  const _HydroponicLogCard({required this.log});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
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
                  child: Icon(Icons.science_rounded, color: colorScheme.onPrimaryContainer, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plant #${log.plantId}',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        DateFormat('MMM d, yyyy • h:mm a').format(log.timestamp),
                        style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (log.waterPH != null)
                  _MetricChip(
                    label: 'pH',
                    value: log.waterPH!.toStringAsFixed(1),
                    status: _getPhStatus(log.waterPH!),
                    icon: Icons.science_rounded,
                  ),
                if (log.nutrientTds != null)
                  _MetricChip(
                    label: 'TDS',
                    value: log.nutrientTds!.toStringAsFixed(0),
                    status: _getTdsStatus(log.nutrientTds!.toInt()),
                    icon: Icons.opacity_rounded,
                    suffix: 'ppm',
                  ),
                if (log.pumpCycleMinutes != null)
                  _MetricChip(
                    label: 'Pump',
                    value: log.pumpCycleMinutes.toString(),
                    status: _MetricStatus.good,
                    icon: Icons.timer_rounded,
                    suffix: 'min',
                  ),
                if (log.temperature != null)
                  _MetricChip(
                    label: 'Temp',
                    value: log.temperature!.toStringAsFixed(1),
                    status: _getTempStatus(log.temperature!),
                    icon: Icons.thermostat_rounded,
                    suffix: '°C',
                  ),
                if (log.humidity != null)
                  _MetricChip(
                    label: 'Humidity',
                    value: log.humidity!.toStringAsFixed(0),
                    status: _getHumidityStatus(log.humidity!),
                    icon: Icons.water_drop_rounded,
                    suffix: '%',
                  ),
                if (log.lightHours != null)
                  _MetricChip(
                    label: 'Light',
                    value: log.lightHours!.toStringAsFixed(1),
                    status: _MetricStatus.good,
                    icon: Icons.wb_sunny_rounded,
                    suffix: 'h',
                  ),
              ],
            ),
            if (log.notes != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.notes_rounded, size: 18, color: colorScheme.onSurfaceVariant),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        log.notes!,
                        style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  _MetricStatus _getPhStatus(double ph) {
    if (ph >= 5.5 && ph <= 6.5) return _MetricStatus.good;
    if (ph >= 5.0 && ph <= 7.0) return _MetricStatus.warning;
    return _MetricStatus.critical;
  }

  _MetricStatus _getTdsStatus(int tds) {
    if (tds >= 500 && tds <= 1200) return _MetricStatus.good;
    if (tds >= 300 && tds <= 1500) return _MetricStatus.warning;
    return _MetricStatus.critical;
  }

  _MetricStatus _getTempStatus(double temp) {
    if (temp >= 18 && temp <= 24) return _MetricStatus.good;
    if (temp >= 15 && temp <= 28) return _MetricStatus.warning;
    return _MetricStatus.critical;
  }

  _MetricStatus _getHumidityStatus(double humidity) {
    if (humidity >= 50 && humidity <= 80) return _MetricStatus.good;
    if (humidity >= 40 && humidity <= 90) return _MetricStatus.warning;
    return _MetricStatus.critical;
  }
}

enum _MetricStatus { good, warning, critical }

class _MetricChip extends StatelessWidget {
  final String label;
  final String value;
  final _MetricStatus status;
  final IconData icon;
  final String? suffix;

  const _MetricChip({
    required this.label,
    required this.value,
    required this.status,
    required this.icon,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    Color statusColor;
    Color bgColor;
    switch (status) {
      case _MetricStatus.good:
        statusColor = const Color(0xFF2E7D4F);
        bgColor = const Color(0xFFE4F1E8);
        break;
      case _MetricStatus.warning:
        statusColor = const Color(0xFFE0913A);
        bgColor = const Color(0xFFF6D79A);
        break;
      case _MetricStatus.critical:
        statusColor = const Color(0xFFD2553F);
        bgColor = const Color(0xFFFDEAE6);
        break;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: statusColor),
              const SizedBox(width: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$value${suffix != null ? ' $suffix' : ''}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyState({required this.onAdd});

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
              child: Icon(Icons.science_rounded, size: 60, color: colorScheme.primary),
            ),
            const SizedBox(height: 24),
            Text(
              'No Hydroponic Logs Yet',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Track pH, TDS, pump cycles, temperature,\nhumidity, and light hours for your hydroponic plants.',
              style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add First Log'),
            ),
          ],
        ),
      ),
    );
  }
}