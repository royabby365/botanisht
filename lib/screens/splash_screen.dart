import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:botanisht/models/plant.dart';
import 'package:botanisht/providers/plant_provider.dart';
import 'package:botanisht/screens/home_screen.dart';
import 'package:botanisht/widgets/wordmark_logo.dart';

/// Launch screen shown until the app is actually ready: the Isar-backed
/// garden list and the cached plant catalog have both loaded their first
/// values. A short minimum-visibility floor keeps the leaf bar from flashing.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _proceedWhenReady();
  }

  Future<void> _proceedWhenReady() async {
    // Keep the splash on screen at least this long so it feels intentional.
    final minSplash = Future.delayed(const Duration(milliseconds: 700));

    // Wait for the real first-data loads the home screen depends on.
    final readiness = Future.wait<void>([
      _whenNotLoading(plantListNotifierProvider),
      ref.read(userPlantsProvider.future).then((_) {}),
      ref.read(allPlantsProvider.future).then((_) {}),
    ]).timeout(
      const Duration(seconds: 8),
      onTimeout: () => <void>[],
    );

    await Future.wait([minSplash, readiness]);
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  /// Completes once [provider]'s AsyncValue leaves the loading state
  /// (i.e. its first real value/error has arrived).
  Future<void> _whenNotLoading(
    ProviderListenable<AsyncValue<List<Plant>>> provider,
  ) {
    final completer = Completer<void>();
    final sub = ref.listenManual<AsyncValue<List<Plant>>>(
      provider,
      (_, next) {
        if (!next.isLoading && !completer.isCompleted) completer.complete();
      },
      fireImmediately: true,
    );
    completer.future.whenComplete(sub.close);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = theme.scaffoldBackgroundColor;
    final primary = theme.colorScheme.primary;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WordmarkLogo(width: 230),
            const SizedBox(height: 30),
            SizedBox(
              width: 240,
              child: LeafLoadingBar(
                leafCount: 7,
                color: primary,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Growing your garden…',
              style: TextStyle(
                color: onSurface.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A progress indicator built from a row of leaf icons that fill from left to
/// right and loop, evoking a "loading bar made of leaves".
class LeafLoadingBar extends StatefulWidget {
  final int leafCount;
  final Color color;

  const LeafLoadingBar({super.key, this.leafCount = 7, this.color = const Color(0xFF1B4332)});

  @override
  State<LeafLoadingBar> createState() => _LeafLoadingBarState();
}

class _LeafLoadingBarState extends State<LeafLoadingBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final progress = _controller.value; // 0.0 -> 1.0
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.leafCount, (i) {
            final leafProgress = progress * widget.leafCount - i;
            final filled = leafProgress >= 1.0;
            final partial = leafProgress > 0.0 && leafProgress < 1.0;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: SvgPicture.asset(
                'assets/data/leaf_mark.svg',
                width: 22,
                height: 22,
                color: filled
                    ? widget.color
                    : partial
                        ? widget.color.withOpacity(leafProgress.clamp(0.0, 1.0))
                        : widget.color.withOpacity(0.22),
              ),
            );
          }),
        );
      },
    );
  }
}
