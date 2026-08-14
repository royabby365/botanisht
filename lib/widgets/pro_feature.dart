import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// Simple Pro feature flag — set to true when the user "upgrades" via the
/// honor-system donation button.
final isProProvider = StateProvider<bool>((ref) => false);

/// Wraps gamified content — shows the real widget when Pro is enabled,
/// otherwise displays a clean teaser card with a lock icon and upgrade prompt.
class ProFeature extends ConsumerWidget {
  final Widget child;
  final String title;
  final String teaser;

  const ProFeature({
    super.key,
    required this.child,
    this.title = 'Pro Feature',
    this.teaser = 'Unlock XP, levels, streaks, and garden stats with Botanisht Pro',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPro = ref.watch(isProProvider);
    if (isPro) return child;
    return _buildLocked(context, ref);
  }

  Widget _buildLocked(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gold = const Color(0xFFD4A843);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showUpgradeSheet(context, ref),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: gold.withValues(alpha: 0.3), width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: gold.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.star_rounded, color: gold, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: gold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      teaser,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.lock_outline_rounded, color: gold, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showUpgradeSheet(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final gold = const Color(0xFFD4A843);
    const bmcUrl = 'https://buymeacoffee.com/royabby';

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: gold.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.workspace_premium_rounded, color: gold, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              'Botanisht Pro',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'XP & levels • Care streaks • Garden score\nExpanded catalog with 70+ plants',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Botanisht Pro is unlocked on the honor system.\nIf you find it useful, consider a donation!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 12,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  ref.read(isProProvider.notifier).state = true;
                  Navigator.pop(ctx);
                  launchUrl(Uri.parse(bmcUrl), mode: LaunchMode.externalApplication);
                },
                icon: const Icon(Icons.coffee_rounded),
                label: const Text('Upgrade to Pro for a donation of your choosing'),
                style: FilledButton.styleFrom(
                  backgroundColor: gold,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Maybe later'),
            ),
          ],
        ),
      ),
    );
  }
}