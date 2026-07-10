import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:botanisht/models/plant.dart';
import 'package:botanisht/providers/plant_provider.dart';

/// Slide-up sheet shown when a user taps a plant in search (the main
/// SearchDelegate or the Add-Plant sheet). It surfaces the plant's taxonomy,
/// reference image, and a care summary, then offers a single "Add to Garden"
/// action that persists the plant into Isar.
class PlantPreviewSheet extends ConsumerWidget {
  final Plant plant;

  const PlantPreviewSheet({super.key, required this.plant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasImage = plant.imageUrl != null && plant.imageUrl!.isNotEmpty;
    final isPetSafe = plant.isPetSafe;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return DraggableScrollableSheet(
      initialChildSize: 0.72,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scroll) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          controller: scroll,
          padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: 96,
                      height: 96,
                      child: hasImage
                          ? CachedNetworkImage(
                              imageUrl: plant.imageUrl!,
                              fit: BoxFit.cover,
                              placeholder: (c, u) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (c, u, e) => const Icon(
                                  Icons.local_florist_rounded,
                                  size: 48),
                            )
                          : const Icon(Icons.local_florist_rounded, size: 48),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plant.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (plant.scientificName != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              plant.scientificName!,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isPetSafe != null) ...[
                const SizedBox(height: 16),
                _PetBadge(isPetSafe: isPetSafe),
              ],
              const SizedBox(height: 20),
              _AttrRow(
                icon: Icons.wb_sunny_rounded,
                label: 'Light',
                value: plant.sunlight,
              ),
              _AttrRow(
                icon: Icons.water_drop_rounded,
                label: 'Water',
                value: plant.watering,
              ),
              if (isPetSafe != null)
                _AttrRow(
                  icon: Icons.pets_rounded,
                  label: 'Pet Safety',
                  value: isPetSafe ? 'Safe for pets' : 'Toxic to pets',
                ),
              if (plant.description != null) ...[
                const SizedBox(height: 16),
                Text(
                  plant.description!,
                  style: const TextStyle(fontSize: 15, height: 1.4),
                ),
              ],
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final zone = (plant.category != null &&
                            ['indoor', 'hydro', 'kitchen']
                                .contains(plant.category))
                        ? plant.category
                        : 'indoor';
                    ref.read(userPlantNotifierProvider.notifier).addCustom(
                          name: plant.name,
                          customName: null,
                          lightConditions:
                              plant.sunlight != 'N/A' ? plant.sunlight : null,
                          isPetSafe: plant.isPetSafe,
                          zone: zone,
                        );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added ${plant.name} to garden!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Add to Garden'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PetBadge extends StatelessWidget {
  final bool isPetSafe;
  const _PetBadge({required this.isPetSafe});
  @override
  Widget build(BuildContext context) {
    final bg = isPetSafe ? const Color(0xFF388E3C) : const Color(0xFFD32F2F);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: bg.withOpacity(0.5)),
      ),
      child: Text(
        isPetSafe ? '🐾 Pet Safe' : '⚠️ Toxic to Pets',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _AttrRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _AttrRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 22, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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
