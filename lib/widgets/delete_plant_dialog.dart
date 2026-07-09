import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/providers/plant_provider.dart';

/// Shows a confirmation dialog and, on confirm, deletes the plant and
/// refreshes every provider that derives its view of the garden.
///
/// [popDetail] should be true when called from the plant detail screen so the
/// user is returned to the garden instead of being left looking at a
/// "plant not found" loading state.
Future<void> confirmDeletePlant(
  BuildContext context,
  WidgetRef ref,
  UserPlant userPlant, {
  bool popDetail = false,
}) async {
  // Capture the app-level messenger up front so we can still toast even after
  // we navigate away from the current screen.
  final messenger = ScaffoldMessenger.of(context);
  final name = userPlant.customName ?? 'Plant';

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Delete plant?'),
      content: Text(
        'This will permanently remove "$name" from your garden. This cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Delete', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );

  if (confirmed != true) return;

  // Return to the garden first (if we came from the detail screen) so the user
  // never sees the detail screen's "plant not found" loading state.
  if (popDetail) Navigator.of(context).pop();

  // Delete in the background and refresh the garden list.
  await ref.read(userPlantNotifierProvider.notifier).delete(userPlant.id!);
  ref.invalidate(userPlantsProvider);
  ref.invalidate(userPlantsSortedProvider);
  ref.invalidate(plantsNeedingWaterProvider);
  messenger.showSnackBar(SnackBar(content: Text('$name deleted')));
}
