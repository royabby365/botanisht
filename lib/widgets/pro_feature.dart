import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// Simple Pro feature flag — set to true when the user "upgrades" via the
/// honor-system donation button.
final isProProvider = StateProvider<bool>((ref) => false);

/// Free users see the first [freeCatalogLimit] plants; Pro unlocks the full
/// catalog. Basil (index 1) stays in the free tier so onboarding demos work.
const int freeCatalogLimit = 25;

/// Opens the Botanisht Pro upgrade sheet from anywhere.
/// Shows the honor-system donation CTA, or a "you're Pro" confirmation
/// when already unlocked.
void showBotanishtUpgradeSheet(BuildContext context, WidgetRef ref) {
  final theme = Theme.of(context);
  const gold = Color(0xFFD4A843);
  const bmcUrl = 'https://buymeacoffee.com/royabby';
  final isPro = ref.read(isProProvider);

  showModalBottomSheet<void>(
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
            child: Icon(
              isPro ? Icons.verified_rounded : Icons.workspace_premium_rounded,
              color: gold,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isPro ? 'You\'re Botanisht Pro' : 'Botanisht Pro',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isPro
                ? 'XP, levels, streaks, and the full catalog are unlocked.\nThanks for supporting the garden! 🌿'
                : 'XP & levels • Care streaks • Garden score\nExpanded catalog with 121+ plants',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isPro
                ? 'Pro unlocks instantly on this device. '
                    'Restoring after a reinstall is coming soon.'
                : 'Botanisht Pro is unlocked on the honor system.\n'
                    'If you find it useful, consider a donation!',
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
                if (!isPro) {
                  ref.read(isProProvider.notifier).state = true;
                }
                Navigator.pop(ctx);
                if (!isPro) {
                  launchUrl(Uri.parse(bmcUrl),
                      mode: LaunchMode.externalApplication);
                }
              },
              icon: Icon(isPro ? Icons.check_rounded : Icons.coffee_rounded),
              label: Text(
                isPro
                    ? 'Done'
                    : 'Upgrade to Pro for a donation of your choosing',
              ),
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
    const gold = Color(0xFFD4A843);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => showBotanishtUpgradeSheet(context, ref),
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
}