import 'package:flutter/material.dart';
import 'package:botanisht/models/isar_user_plant.dart';

/// Garden overview summary card shown at the top of each zone tab.
/// Displays the zone name, plant count, and quick-view pills for each plant
/// matching the website mockup at botanisht.com.
class GardenOverviewCard extends StatelessWidget {
  final String zoneName;
  final List<UserPlant> plants;
  final int totalAcrossGarden;

  const GardenOverviewCard({
    super.key,
    required this.zoneName,
    required this.plants,
    this.totalAcrossGarden = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outline.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              Icon(Icons.eco_rounded, color: colors.primary, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _formatZoneName(zoneName),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
              ),
              // Plant count badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${plants.length} plant${plants.length == 1 ? '' : 's'}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Zone pills — wrap of plant name chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: plants.map((p) => _PlantPill(
              name: p.customName ?? 'Plant #${p.plantEntityId}',
              healthStatus: p.healthStatus,
            )).toList(),
          ),
        ],
      ),
    );
  }

  String _formatZoneName(String zone) {
    if (zone == 'uncategorized') return 'My Garden';
    const map = {
      'indoor': 'House Plants',
      'hydro': 'Hydroponic System',
      'kitchen': 'Kitchen Garden',
      'outdoor': 'Outdoor Beds',
      'garden': 'Garden Beds',
      'backyard': 'Backyard Beds',
      'balcony': 'Balcony Pots',
      'patio': 'Patio Planters',
      'yard': 'Yard',
    };
    return map[zone.toLowerCase()] ??
        zone[0].toUpperCase() + zone.substring(1);
  }
}

/// Small colored pill showing a plant's name and health status.
class _PlantPill extends StatelessWidget {
  final String name;
  final String? healthStatus;

  const _PlantPill({required this.name, this.healthStatus});

  @override
  Widget build(BuildContext context) {
    final emoji = _emojiForStatus(healthStatus);
    final color = _colorForStatus(healthStatus);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _emojiForStatus(String? status) {
    switch (status) {
      case 'healthy': return '🌿';
      case 'warning': return '⚠️';
      case 'critical': return '🔴';
      case 'dormant': return '💤';
      default: return '🪴';
    }
  }

  Color _colorForStatus(String? status) {
    switch (status) {
      case 'healthy': return const Color(0xFF2E7D4F);
      case 'warning': return const Color(0xFFE0913A);
      case 'critical': return const Color(0xFFD2553F);
      case 'dormant': return const Color(0xFF5A7A8A);
      default: return const Color(0xFF1B4332);
    }
  }
}