import 'package:flutter/material.dart';

/// The official Botanisht wordmark (real artwork, `assets/data/logo_wordmark.png`).
///
/// Renders the full brand lockup — "Botanisht" with the thumbs-up 'B', leaf
/// dot over the 'i', and the tagline "BEGINNER-FRIENDLY GARDENING & SMART
/// CARE" — on its baked-in warm-cream background (#F5F5ED, matching the app's
/// Cream theme).
///
/// Because the PNG has an opaque cream background, it is always shown inside
/// a softly rounded card so the cream reads as intentional on both the Cream
/// and Evergreen themes (no harsh square edges against dark green).
class WordmarkLogo extends StatelessWidget {
  /// Width of the logo in logical pixels (height follows the 1067:502 ratio).
  final double width;

  const WordmarkLogo({super.key, this.width = 260});

  @override
  Widget build(BuildContext context) {
    final radius = Theme.of(context).brightness == Brightness.dark
        ? BorderRadius.circular(18.0)
        : BorderRadius.circular(14.0);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F5EC), // blend edge against logo's cream
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
                alpha: Theme.of(context).brightness == Brightness.dark
                    ? 0.35
                    : 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Image.asset(
        'assets/data/logo_wordmark.png',
        width: width,
        fit: BoxFit.fitWidth,
        semanticLabel: 'Botanisht',
      ),
    );
  }
}
