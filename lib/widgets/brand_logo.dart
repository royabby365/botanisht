import 'package:flutter/material.dart';

/// Brand wordmark for Botanisht.
///
/// Composes a detailed inline layout: "Botan" in deep forest green, a stylized
/// leaf vector token standing in for the character 'o', an italic lighter
/// "ish", and a trailing leaf flourish. Everything is wrapped in a [FittedBox]
/// with a fixed horizontal boundary so it can never overflow its container.
class BrandLogo extends StatelessWidget {
  final double maxWidth;

  const BrandLogo({super.key, this.maxWidth = 200});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Botan',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1B4332),
                letterSpacing: 0.5,
              ),
            ),
            // The 'o' — a stylized leaf/thumb token.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Icon(
                Icons.eco_rounded,
                color: const Color(0xFF2D6A4F),
                size: 26,
              ),
            ),
            Text(
              'ish',
              style: TextStyle(
                fontSize: 28,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                color: const Color(0xFF1B4332),
                letterSpacing: 1.5,
              ),
            ),
            // Trailing leaf flourish tracking right after the terminal 't'.
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Transform.rotate(
                angle: 0.4,
                child: Icon(
                  Icons.eco_rounded,
                  color: const Color(0xFF52B788),
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
