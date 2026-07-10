import 'package:flutter/material.dart';

/// Brand color palette for Botanisht.
///
/// Centralised so the cream / evergreen / high-contrast themes and the
/// onboarding carousel stay visually consistent. All values are derived from
/// the established Botanisht identity: deep-forest green, warm gold, and a
/// soft natural cream.
class BotanishtPalette {
  // Core brand colors.
  static const Color primaryGreen = Color(0xFF1B4332);
  static const Color secondaryGreen = Color(0xFF2D6A4F);
  static const Color accentGold = Color(0xFFD4A843);
  static const Color lightGreen = Color(0xFF52B788);

  // Surfaces.
  static const Color creamBackground = Color(0xFFF5F0E1);
  static const Color cardDarkGreen = Color(0xFF0F2D1F);

  // Text.
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnCream = Color(0xFF1B4332);
  static const Color textSecondaryOnDark = Color(0xFFB8D4C8);

  // High-contrast accessibility scheme.
  static const Color highContrastBackground = Color(0xFF000000);
  static const Color highContrastSurface = Color(0xFF0A0A0A);
  static const Color highContrastGold = Color(0xFFFFD60A);
  static const Color highContrastText = Color(0xFFFFFFFF);

  const BotanishtPalette._();
}

/// Resolves the active [ThemeData] from persisted [AppSettings] values.
///
/// [themeMode] follows the model convention:
///  * `0` — System default (renders as Natural Cream for a calm first impression)
///  * `1` — Natural Cream (light)
///  * `2` — Deep Evergreen (dark)
///
/// When [highContrast] is `true` a dedicated high-contrast scheme is returned
/// regardless of the base mode, satisfying WCAG AAA contrast requirements for
/// senior-first accessibility.
ThemeData resolveTheme({
  required int themeMode,
  required bool highContrast,
  bool systemIsDark = false,
}) {
  if (highContrast) return buildHighContrastTheme();
  // `System` follows the device ambient brightness: Deep Evergreen (dark)
  // when the platform reports dark, otherwise Natural Cream (light).
  final effectiveDark = themeMode == 2 || (themeMode == 0 && systemIsDark);
  return effectiveDark ? buildEvergreenTheme() : buildCreamTheme();
}

/// Natural Cream — the default light theme. Warm, paper-like background with
/// deep-forest green text and gold accents.
ThemeData buildCreamTheme() {
  const primaryGreen = BotanishtPalette.primaryGreen;
  const secondaryGreen = BotanishtPalette.secondaryGreen;
  const accentGold = BotanishtPalette.accentGold;
  const creamBackground = BotanishtPalette.creamBackground;
  const cardDarkGreen = BotanishtPalette.cardDarkGreen;

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      primary: primaryGreen,
      secondary: secondaryGreen,
      tertiary: accentGold,
      surface: creamBackground,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: primaryGreen,
    ),
    scaffoldBackgroundColor: creamBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: creamBackground,
      foregroundColor: primaryGreen,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: primaryGreen,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      iconTheme: IconThemeData(color: primaryGreen, size: 28),
    ),
    cardTheme: CardTheme(
      color: cardDarkGreen,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentGold,
        foregroundColor: primaryGreen,
        elevation: 2,
        shadowColor: accentGold.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentGold,
      foregroundColor: primaryGreen,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: secondaryGreen.withOpacity(0.15),
      selectedColor: secondaryGreen,
      labelStyle: const TextStyle(
        color: primaryGreen,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: secondaryGreen, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: TextStyle(color: primaryGreen.withOpacity(0.5)),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: primaryGreen,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        color: primaryGreen,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: primaryGreen,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: primaryGreen, fontSize: 16),
      bodyMedium: TextStyle(color: primaryGreen, fontSize: 14),
    ),
    iconTheme: const IconThemeData(color: primaryGreen, size: 24),
    dividerTheme: DividerThemeData(
      color: primaryGreen.withOpacity(0.1),
      thickness: 1,
      space: 24,
    ),
  );
}

/// Deep Evergreen — the dark theme. A calming forest-green canvas with gold
/// accents and high legibility for low-light environments.
ThemeData buildEvergreenTheme() {
  const primaryGreen = BotanishtPalette.primaryGreen;
  const secondaryGreen = BotanishtPalette.secondaryGreen;
  const accentGold = BotanishtPalette.accentGold;
  const background = BotanishtPalette.cardDarkGreen;
  const surface = BotanishtPalette.primaryGreen;

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: secondaryGreen,
      brightness: Brightness.dark,
      primary: accentGold,
      secondary: secondaryGreen,
      tertiary: BotanishtPalette.lightGreen,
      surface: surface,
      onPrimary: primaryGreen,
      onSecondary: Colors.white,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      iconTheme: IconThemeData(color: accentGold, size: 28),
    ),
    cardTheme: CardTheme(
      color: surface,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentGold,
        foregroundColor: primaryGreen,
        elevation: 2,
        shadowColor: accentGold.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentGold,
      foregroundColor: primaryGreen,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: secondaryGreen.withOpacity(0.25),
      selectedColor: accentGold,
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: const TextStyle(
        color: primaryGreen,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: accentGold, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: const TextStyle(color: Colors.white70),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: BotanishtPalette.textSecondaryOnDark, fontSize: 14),
    ),
    iconTheme: const IconThemeData(color: accentGold, size: 24),
    dividerTheme: DividerThemeData(
      color: Colors.white.withOpacity(0.12),
      thickness: 1,
      space: 24,
    ),
  );
}

/// High Contrast — a maximal-accessibility scheme (WCAG AAA). Pure black
/// canvas, pure white text, and a bright gold accent for unambiguous
/// separation. Borders and font weights are emphasised for legibility.
ThemeData buildHighContrastTheme() {
  const background = BotanishtPalette.highContrastBackground;
  const surface = BotanishtPalette.highContrastSurface;
  const gold = BotanishtPalette.highContrastGold;
  const white = BotanishtPalette.highContrastText;

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: gold,
      secondary: white,
      tertiary: gold,
      surface: surface,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: white,
      outline: white,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      foregroundColor: white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: white,
        fontSize: 28,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
      iconTheme: IconThemeData(color: white, size: 28),
    ),
    cardTheme: CardTheme(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: white, width: 2),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: gold,
        foregroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: white, width: 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: gold,
      foregroundColor: Colors.black,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: white, width: 2),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: background,
      selectedColor: gold,
      labelStyle: const TextStyle(
        color: white,
        fontWeight: FontWeight.w700,
      ),
      secondaryLabelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: white, width: 2),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: white, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: gold, width: 3),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: TextStyle(color: white.withOpacity(0.7)),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: white,
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        color: white,
        fontSize: 24,
        fontWeight: FontWeight.w800,
      ),
      titleLarge: TextStyle(
        color: white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: TextStyle(color: white, fontSize: 17),
      bodyMedium: TextStyle(color: white, fontSize: 15),
    ),
    iconTheme: const IconThemeData(color: white, size: 24),
    dividerTheme: const DividerThemeData(
      color: white,
      thickness: 2,
      space: 24,
    ),
  );
}
