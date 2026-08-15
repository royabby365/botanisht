import 'package:flutter/material.dart';

/// Brand logo for Botanisht.
///
/// Renders the stylized word "Botanisht" where the letter **O is a green
/// thumb** (so it reads "B[thumb]tanisht" — a play on "botanist" for a
/// beginner-friendly gardening app) and "ish" is italicized, with a small
/// leaf at the end. Colors follow the active theme: brand deep-forest green
/// on light surfaces, bright leaf green on dark surfaces (so the wordmark is
/// always easy to read — e.g. on the dark first-run onboarding).
class AppLogo extends StatelessWidget {
  final double fontSize;

  const AppLogo({super.key, this.fontSize = 26});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final brandGreen = isDark
        ? const Color(0xFF5CC98A)
        : const Color(0xFF1B4332);
    final textStyle = TextStyle(
      color: brandGreen,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
    );

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(text: 'B', style: textStyle),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Icon(
                  Icons.thumb_up_rounded,
                  size: 28,
                  color: brandGreen,
                ),
              ),
            ),
            TextSpan(text: 'tan', style: textStyle),
            TextSpan(
              text: 'ish',
              style: textStyle.copyWith(fontStyle: FontStyle.italic),
            ),
            TextSpan(text: 't', style: textStyle),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Icon(
                  Icons.eco_rounded,
                  size: 24,
                  color: brandGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
