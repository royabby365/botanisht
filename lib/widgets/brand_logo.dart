import 'package:flutter/material.dart';

/// Knocks out the logo's baked-in near-white background block so the green
/// artwork floats cleanly on any surface — the dark-green app bar, the cream
/// settings drawer, and the splash screen.
///
/// The source asset (`assets/data/IMG_20260707_171423.png`) is forest-green
/// artwork on an off-white (~250,250,242) rectangle. This matrix maps
/// near-white pixels to transparent while preserving the green logo:
///   A' = 255*? no — alpha row: A' = -(R + G + B) + 700, clamped to [0,255].
/// Near-white (sum ≥ 700) collapses to fully transparent; the green logo
/// (sum ≈ 256–510) stays fully opaque.
///
/// NOTE: `BlendMode.multiply` was deliberately *not* used — it would also
/// tint/darken the green logo itself, whereas this keys out only the white
/// background.
const ColorFilter logoWhiteBackgroundKnockout = ColorFilter.matrix(<double>[
  1, 0, 0, 0, 0, //
  0, 1, 0, 0, 0, //
  0, 0, 1, 0, 0, //
  -1, -1, -1, 0, 700,
]);

/// Brand wordmark for Botanisht.
///
/// Renders the definitive uploaded logo asset
/// (`assets/data/IMG_20260707_171423.png`). Its size is derived from the
/// device's screen metrics — and clamped to the available parent width — so it
/// scales proportionally across phones, tablets, and the settings drawer
/// instead of using a fixed box that could overflow the 28px boundary. The
/// baked-in white background is dropped via [logoWhiteBackgroundKnockout].
class BrandLogo extends StatelessWidget {
  /// Optional explicit size overrides. When omitted, the logo is sized
  /// proportionally to the screen while preserving its intrinsic aspect
  /// ratio (591 x 201).
  final double? height;
  final double? width;

  const BrandLogo({super.key, this.height, this.width});

  // Intrinsic logo dimensions used to preserve the aspect ratio.
  static const double _aspect = 591 / 201;

  @override
  Widget build(BuildContext context) {
    final image = ColorFiltered(
      colorFilter: logoWhiteBackgroundKnockout,
      child: Image.asset(
        'assets/data/IMG_20260707_171423.png',
        fit: BoxFit.contain,
        alignment: Alignment.centerLeft,
      ),
    );

    // Explicit overrides take precedence and still respect the aspect ratio
    // when only one dimension is supplied.
    if (width != null && height != null) {
      return SizedBox(width: width, height: height, child: image);
    }
    if (width != null) {
      final w = width!;
      return SizedBox(width: w, height: w / _aspect, child: image);
    }
    if (height != null) {
      final h = height!;
      return SizedBox(width: h * _aspect, height: h, child: image);
    }

    // Dynamic, screen-proportional sizing: start from ~42% of the screen
    // width, keep it within sane bounds, and never let it exceed 70% of the
    // parent's available width so it can't overflow the AppBar or drawer.
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenW = MediaQuery.of(context).size.width;
        var w = (screenW * 0.42).clamp(120.0, 260.0);
        if (w > constraints.maxWidth * 0.7) w = constraints.maxWidth * 0.7;
        final h = w / _aspect;
        return SizedBox(width: w, height: h, child: image);
      },
    );
  }
}
