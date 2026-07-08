import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/models/plant.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/providers/hydroponic_provider.dart';
import 'package:botanisht/models/hydroponic_log.dart';

class PlantCard extends ConsumerWidget {
  final Plant? plant;
  final UserPlant? userPlant;
  final bool isUserPlant;
  final VoidCallback? onTap;
  final VoidCallback? onAddToGarden;
  final String? zone;

  const PlantCard({
    super.key,
    this.plant,
    this.userPlant,
    this.isUserPlant = false,
    this.onTap,
    this.onAddToGarden,
    this.zone,
  }) : assert(plant != null || userPlant != null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayPlant = plant;
    final displayUserPlant = userPlant;
    
    final name = isUserPlant 
        ? (displayUserPlant?.customName ?? 'Plant #${displayUserPlant?.plantEntityId}')
        : (displayPlant?.name ?? 'Unknown Plant');
    
    final scientificName = displayPlant?.scientificName;
    final category = zone ?? displayPlant?.category ?? displayUserPlant?.lightConditions?.toLowerCase() ?? 'indoor';
    final healthStatus = displayUserPlant?.healthStatus;
    final lastWatered = displayUserPlant?.lastWatered;
    final location = displayUserPlant?.location;
    final isPetSafe = displayPlant?.isPetSafe ?? displayUserPlant?.isPetSafe;
    
    final isHydro = category == 'hydro';
    final asyncHydroLog = isHydro
        ? ref.watch(latestLogForZoneProvider('hydro'))
        : const AsyncValue<HydroponicLog?>.data(null);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _CategoryBadge(category: category),
                  const SizedBox(width: 8),
                  if (isPetSafe != null) _PetSafetyBadge(isPetSafe: isPetSafe),
                  const Spacer(),
                  if (isUserPlant && healthStatus != null)
                    _HealthIndicator(status: healthStatus),
                  if (!isUserPlant)
                    _AddToGardenButton(onPressed: onAddToGarden),
                ],
              ),
              
              const SizedBox(height: 16),
              
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B4332).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: _buildPlantImage(category),
                ),
              ),
              
              const SizedBox(height: 16),
              
              Text(
                name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1B4332),
                ),
              ),
              if (scientificName != null) ...[
                const SizedBox(height: 4),
                Text(
                  scientificName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF1B4332).withOpacity(0.6),
                  ),
                ),
              ],
              if (location != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 14,
                      color: const Color(0xFF1B4332).withOpacity(0.5),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF1B4332).withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  _CareIndicator(
                    icon: Icons.water_drop_rounded,
                    label: 'Water',
                    value: _getWaterValue(displayPlant, displayUserPlant),
                    color: Colors.blue.shade600,
                    isHydro: isHydro,
                  ),
                  const SizedBox(width: 12),
                  _CareIndicator(
                    icon: Icons.wb_sunny_rounded,
                    label: 'Light',
                    value: _getLightValue(displayPlant),
                    color: Colors.amber.shade700,
                    isHydro: isHydro,
                  ),
                ],
              ),
              
              if (isHydro) ...[
                const SizedBox(height: 16),
                _HydroTelemetrySection(asyncHydroLog: asyncHydroLog),
              ],
              
              if (isUserPlant && lastWatered != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.water_drop_rounded,
                      size: 16,
                      color: Colors.blue.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Last watered ${_formatRelativeTime(lastWatered)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlantImage(String category) {
    final icons = {
      'indoor': Icons.park_rounded,
      'hydro': Icons.science_rounded,
      'kitchen': Icons.eco_rounded,
      'pollinator': Icons.bug_report_rounded,
      'native': Icons.landscape_rounded,
      'permeable': Icons.terrain_rounded,
      'bento': Icons.restaurant_rounded,
    };
    
    final icon = icons[category] ?? Icons.local_florist_rounded;
    final colors = {
      'indoor': const Color(0xFF2D6A4F),
      'hydro': Colors.blue.shade700,
      'kitchen': Colors.orange.shade700,
    };
    
    final color = colors[category] ?? const Color(0xFF1B4332);
    
    return Center(
      child: Icon(
        icon,
        size: 64,
        color: color.withOpacity(0.3),
      ),
    );
  }

  String _getWaterValue(Plant? plant, UserPlant? userPlant) {
    if (userPlant?.lastWatered != null) {
      final days = DateTime.now().difference(userPlant!.lastWatered!).inDays;
      if (days == 0) return 'Today';
      if (days == 1) return '1 day ago';
      return '$days days ago';
    }
    return plant?.waterRequirements?.first ?? 'Check needs';
  }

  String _getLightValue(Plant? plant) {
    final sun = plant?.sunRequirements?.first ?? 'Medium';
    if (sun.length > 15) return '${sun.substring(0, 15)}...';
    return sun;
  }

  String _formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'just now';
  }
}

class _CategoryBadge extends StatelessWidget {
  final String category;
  
  const _CategoryBadge({required this.category});

  @override
  Widget build(BuildContext context) {
    final config = _getCategoryConfig(category);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: config.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: config.color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config.icon, size: 14, color: config.color),
          const SizedBox(width: 6),
          Text(
            config.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: config.color,
            ),
          ),
        ],
      ),
    );
  }

  _CategoryConfig _getCategoryConfig(String category) {
    switch (category) {
      case 'indoor':
        return _CategoryConfig(
          label: 'INDOOR',
          icon: Icons.park_rounded,
          color: const Color(0xFF1B4332),
        );
      case 'hydro':
        return _CategoryConfig(
          label: 'HYDRO',
          icon: Icons.science_rounded,
          color: Colors.blue.shade700,
        );
      case 'kitchen':
        return _CategoryConfig(
          label: 'KITCHEN',
          icon: Icons.eco_rounded,
          color: Colors.orange.shade700,
        );
      case 'pollinator':
        return _CategoryConfig(
          label: 'POLLINATOR',
          icon: Icons.bug_report_rounded,
          color: Colors.purple.shade700,
        );
      case 'native':
        return _CategoryConfig(
          label: 'NATIVE',
          icon: Icons.landscape_rounded,
          color: Colors.brown.shade700,
        );
      case 'permeable':
        return _CategoryConfig(
          label: 'PERMEABLE',
          icon: Icons.terrain_rounded,
          color: Colors.teal.shade700,
        );
      case 'bento':
        return _CategoryConfig(
          label: 'BENTO',
          icon: Icons.restaurant_rounded,
          color: Colors.pink.shade700,
        );
      default:
        return _CategoryConfig(
          label: category.toUpperCase(),
          icon: Icons.local_florist_rounded,
          color: const Color(0xFF1B4332),
        );
    }
  }
}

class _CategoryConfig {
  final String label;
  final IconData icon;
  final Color color;
  
  const _CategoryConfig({
    required this.label,
    required this.icon,
    required this.color,
  });
}

class _CareIndicator extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isHydro;
  
  const _CareIndicator({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.isHydro = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: color.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _PetSafetyBadge extends StatelessWidget {
  final bool isPetSafe;

  const _PetSafetyBadge({required this.isPetSafe});

  @override
  Widget build(BuildContext context) {
    final color = isPetSafe ? Colors.green.shade700 : Colors.orange.shade700;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: (isPetSafe ? Colors.green : Colors.orange).withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPetSafe ? Icons.pets_rounded : Icons.warning_amber_rounded,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            isPetSafe ? 'Pet Safe' : 'Toxic to Pets',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _HydroTelemetrySection extends ConsumerWidget {
  final AsyncValue<HydroponicLog?> asyncHydroLog;

  const _HydroTelemetrySection({required this.asyncHydroLog});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return asyncHydroLog.when(
      data: (log) {
        if (log == null) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Row(
              children: [
                Icon(Icons.sensors_off_rounded, color: Colors.blue.shade300, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No live telemetry',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Text(
                        'Connect sensors to see pH & TDS',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Add Sensor'),
                ),
              ],
            ),
          );
        }
        
        final ph = log.waterPH;
        final tds = log.nutrientTds;
        final pump = log.pumpCycleMinutes;
        final timestamp = log.timestamp;
        
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0F2D1F),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.sensors_rounded, color: const Color(0xFFD4A843), size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Live Telemetry',
                    style: TextStyle(
                      color: const Color(0xFFD4A843),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Updated ${_formatTimestamp(timestamp)}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _TelemetryCard(
                    label: 'pH',
                    value: ph != null ? ph.toStringAsFixed(2) : '--',
                    unit: '',
                    color: Colors.cyan.shade300,
                    isOptimal: ph != null && ph >= 5.5 && ph <= 6.5,
                  ),
                  const SizedBox(width: 12),
                  _TelemetryCard(
                    label: 'TDS',
                    value: tds != null ? '${tds.round()}' : '--',
                    unit: 'ppm',
                    color: Colors.amber.shade300,
                    isOptimal: tds != null && tds >= 800 && tds <= 1500,
                  ),
                  const SizedBox(width: 12),
                  _TelemetryCard(
                    label: 'Pump',
                    value: pump != null ? '$pump' : '--',
                    unit: 'min',
                    color: Colors.blue.shade300,
                    isOptimal: pump != null,
                  ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
      error: (e, _) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade300),
            const SizedBox(width: 12),
            Text('Telemetry error', style: TextStyle(color: Colors.red.shade700)),
          ],
        ),
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

class _TelemetryCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;
  final bool isOptimal;
  
  const _TelemetryCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
    required this.isOptimal,
  });
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isOptimal ? color.withOpacity(0.5) : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withOpacity(0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (unit.isNotEmpty)
                    TextSpan(
                      text: ' $unit',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Icon(
              isOptimal ? Icons.check_circle_rounded : Icons.warning_amber_rounded,
              size: 14,
              color: isOptimal ? Colors.green.shade300 : Colors.orange.shade300,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddToGardenButton extends StatelessWidget {
  final VoidCallback? onPressed;
  
  const _AddToGardenButton({this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFD4A843).withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD4A843).withOpacity(0.3)),
          ),
          child: Icon(
            Icons.add_rounded,
            size: 20,
            color: const Color(0xFFD4A843),
          ),
        ),
      ),
    );
  }
}

class _HealthIndicator extends StatelessWidget {
  final String status;
  
  const _HealthIndicator({required this.status});
  
  @override
  Widget build(BuildContext context) {
    final config = _getHealthConfig(status);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: config.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: config.color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config.icon, size: 12, color: config.color),
          const SizedBox(width: 4),
          Text(
            config.label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: config.color,
            ),
          ),
        ],
      ),
    );
  }
  
  _HealthConfig _getHealthConfig(String status) {
    switch (status) {
      case 'healthy':
        return _HealthConfig(
          label: 'HEALTHY',
          icon: Icons.check_circle_rounded,
          color: Colors.green.shade700,
        );
      case 'warning':
        return _HealthConfig(
          label: 'WARNING',
          icon: Icons.warning_amber_rounded,
          color: Colors.orange.shade700,
        );
      case 'critical':
        return _HealthConfig(
          label: 'CRITICAL',
          icon: Icons.dangerous_rounded,
          color: Colors.red.shade700,
        );
      case 'dormant':
        return _HealthConfig(
          label: 'DORMANT',
          icon: Icons.bedtime_rounded,
          color: Colors.blue.shade700,
        );
      default:
        return _HealthConfig(
          label: 'UNKNOWN',
          icon: Icons.help_outline_rounded,
          color: Colors.grey.shade600,
        );
    }
  }
}

class _HealthConfig {
  final String label;
  final IconData icon;
  final Color color;
  
  const _HealthConfig({
    required this.label,
    required this.icon,
    required this.color,
  });
}