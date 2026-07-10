import 'package:flutter/material.dart';

/// Brand color palette for Botanisht — sourced 1:1 from the marketing site
/// (botanisht.com) design tokens so the app matches the website exactly.
///
/// Light mode  → "Natural Cream"   (warm off-white canvas, white cards)
/// Dark mode   → "Deep Evergreen"  (near-black green canvas, dark-green cards)
/// The site's accent is a forest-leaf green with a warm sun/amber for
/// highlights; there is no gold in the web palette, so the legacy gold accent
/// is replaced by the site's `--sun` amber.
class BotanishtPalette {
  // Light ("Natural Cream") surfaces.
  static const Color creamBg = Color(0xFFFBFAF4);
  static const Color creamSurface = Color(0xFFFFFFFF);
  static const Color creamTint = Color(0xFFF1F5EC);

  // Dark ("Deep Evergreen") surfaces.
  static const Color evergreenBg = Color(0xFF0E1712);
  static const Color evergreenSurface = Color(0xFF15211A);
  static const Color evergreenTint = Color(0xFF131E17);

  // Ink (text).
  static const Color ink = Color(0xFF16271C);
  static const Color inkSoft = Color(0xFF4D5F53);
  static const Color inkFaint = Color(0xFF7C8B80);
  static const Color inkOnDark = Color(0xFFEAF2EC);
  static const Color inkSoftOnDark = Color(0xFFA9BCAE);
  static const Color inkFaintOnDark = Color(0xFF789085);

  // Leaf greens.
  static const Color leaf = Color(0xFF2E7D4F);
  static const Color leafDeep = Color(0xFF1B5E3F);
  static const Color leafBright = Color(0xFF4CAF6D);
  static const Color leafOnDark = Color(0xFF5CC98A);
  static const Color leafBrightOnDark = Color(0xFF6FD79A);
  static const Color leafSoft = Color(0xFFE4F1E8);
  static const Color leafSoftOnDark = Color(0xFF16301F);

  // Lines / borders.
  static const Color line = Color(0xFFE3E9DC);
  static const Color lineOnDark = Color(0xFF243328);

  // Sun / amber accent (the site's `--sun`).
  static const Color sun = Color(0xFFE0913A);
  static const Color sunSoft = Color(0xFFF6D79A);
  static const Color sunOnDark = Color(0xFFF0A94E);
  static const Color sunSoftOnDark = Color(0xFF4A361C);

  // Status.
  static const Color warn = Color(0xFFD98A2B);
  static const Color danger = Color(0xFFD2553F);

  // High-contrast accessibility scheme (WCAG AAA).
  static const Color hcBg = Color(0xFF000000);
  static const Color hcSurface = Color(0xFF0A0A0A);
  static const Color hcText = Color(0xFFFFFFFF);
  static const Color hcAccent = Color(0xFFFFD60A);

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

/// Builds the typography for every theme: [Fraunces] (a warm display serif)
/// for headings and [Inter] for body/UI — exactly matching botanisht.com.
TextTheme _botanicTextTheme({
  required Color bodyColor,
  required Color displayColor,
  FontWeight displayWeight = FontWeight.w600,
  FontWeight bodyWeight = FontWeight.w400,
  double displayLarge = 64,
  double displayMedium = 48,
  double displaySmall = 36,
  double headlineLarge = 32,
  double headlineMedium = 24,
  double headlineSmall = 20,
  double titleLarge = 20,
  double titleMedium = 16,
  double titleSmall = 14,
  double bodyLarge = 16,
  double bodyMedium = 14,
  double bodySmall = 12,
  double labelLarge = 16,
  double labelMedium = 14,
  double labelSmall = 11,
}) {
  final base = ThemeData.light().textTheme.apply(
        bodyColor: bodyColor,
        displayColor: displayColor,
      );
  TextStyle? f(TextStyle? s, String family, double size, FontWeight w) =>
      s?.copyWith(
        fontFamily: family,
        fontSize: size,
        fontWeight: w,
        letterSpacing: -0.5,
      );
  return base.copyWith(
    displayLarge: f(base.displayLarge, 'Fraunces', displayLarge, displayWeight),
    displayMedium: f(base.displayMedium, 'Fraunces', displayMedium, displayWeight),
    displaySmall: f(base.displaySmall, 'Fraunces', displaySmall, displayWeight),
    headlineLarge: f(base.headlineLarge, 'Fraunces', headlineLarge, displayWeight),
    headlineMedium: f(base.headlineMedium, 'Fraunces', headlineMedium, displayWeight),
    headlineSmall: f(base.headlineSmall, 'Fraunces', headlineSmall, displayWeight),
    titleLarge: f(base.titleLarge, 'Fraunces', titleLarge, displayWeight),
    titleMedium: f(base.titleMedium, 'Fraunces', titleMedium, displayWeight),
    titleSmall: f(base.titleSmall, 'Fraunces', titleSmall, displayWeight),
    bodyLarge: f(base.bodyLarge, 'Inter', bodyLarge, bodyWeight),
    bodyMedium: f(base.bodyMedium, 'Inter', bodyMedium, bodyWeight),
    bodySmall: f(base.bodySmall, 'Inter', bodySmall, bodyWeight),
    labelLarge: f(base.labelLarge, 'Inter', labelLarge,
        bodyWeight == FontWeight.w400 ? FontWeight.w600 : bodyWeight),
    labelMedium: f(base.labelMedium, 'Inter', labelMedium, bodyWeight),
    labelSmall: f(base.labelSmall, 'Inter', labelSmall, bodyWeight),
  );
}

/// Natural Cream — the default light theme. Matches the botanisht.com light
/// presentation: warm off-white canvas, white elevated cards with soft
/// green-tinted shadows, leaf-green primary, and a sun/amber accent.
ThemeData buildCreamTheme() {
  const bg = BotanishtPalette.creamBg;
  const surface = BotanishtPalette.creamSurface;
  const tint = BotanishtPalette.creamTint;
  const ink = BotanishtPalette.ink;
  const inkSoft = BotanishtPalette.inkSoft;
  const leaf = BotanishtPalette.leaf;
  const leafDeep = BotanishtPalette.leafDeep;
  const leafSoft = BotanishtPalette.leafSoft;
  const sun = BotanishtPalette.sun;
  const line = BotanishtPalette.line;

  final text = _botanicTextTheme(bodyColor: ink, displayColor: ink);
  final colorScheme = ColorScheme.light(
    primary: leaf,
    onPrimary: Colors.white,
    primaryContainer: leafSoft,
    onPrimaryContainer: leafDeep,
    secondary: sun,
    onSecondary: ink,
    surface: surface,
    onSurface: ink,
    onSurfaceVariant: inkSoft,
    outline: line,
    error: BotanishtPalette.danger,
    onError: Colors.white,
  ).copyWith(
    surfaceContainerHighest: tint,
    secondaryContainer: BotanishtPalette.sunSoft,
    onSecondaryContainer: leafDeep,
    outlineVariant: line,
    shadow: Color(0x1A14281C),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: bg,
    appBarTheme: AppBarTheme(
      backgroundColor: bg,
      foregroundColor: ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: text.titleLarge?.copyWith(fontSize: 28),
      iconTheme: const IconThemeData(color: leaf, size: 28),
    ),
    cardTheme: CardTheme(
      color: surface,
      elevation: 2,
      shadowColor: Color(0x1A14281C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: leaf,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: leaf.withOpacity(0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(
            fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: leaf,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: leafSoft,
      selectedColor: leaf,
      labelStyle: const TextStyle(color: leafDeep, fontWeight: FontWeight.w500),
      secondaryLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: tint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: leaf, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: TextStyle(color: inkSoft),
    ),
    textTheme: text,
    iconTheme: const IconThemeData(color: leaf, size: 24),
    dividerTheme: DividerThemeData(
      color: line.withOpacity(0.6),
      thickness: 1,
      space: 24,
    ),
  );
}

/// Deep Evergreen — the dark theme. Matches the botanisht.com dark
/// presentation: near-black green canvas, dark-green elevated cards with a
/// hairline border, a brighter leaf-green primary, and a brighter sun accent.
ThemeData buildEvergreenTheme() {
  const bg = BotanishtPalette.evergreenBg;
  const surface = BotanishtPalette.evergreenSurface;
  const tint = BotanishtPalette.evergreenTint;
  const ink = BotanishtPalette.inkOnDark;
  const inkSoft = BotanishtPalette.inkSoftOnDark;
  const leaf = BotanishtPalette.leafOnDark;
  const leafSoft = BotanishtPalette.leafSoftOnDark;
  const sun = BotanishtPalette.sunOnDark;
  const line = BotanishtPalette.lineOnDark;

  final text = _botanicTextTheme(bodyColor: ink, displayColor: ink);
  final colorScheme = ColorScheme.dark(
    primary: leaf,
    onPrimary: bg,
    primaryContainer: leafSoft,
    onPrimaryContainer: leaf,
    secondary: sun,
    onSecondary: bg,
    surface: surface,
    onSurface: ink,
    onSurfaceVariant: inkSoft,
    outline: line,
    error: BotanishtPalette.danger,
    onError: Colors.white,
  ).copyWith(
    surfaceContainerHighest: tint,
    secondaryContainer: BotanishtPalette.sunSoftOnDark,
    onSecondaryContainer: bg,
    outlineVariant: line,
    shadow: Color(0x66000000),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: bg,
    appBarTheme: AppBarTheme(
      backgroundColor: bg,
      foregroundColor: ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: text.titleLarge?.copyWith(fontSize: 28),
      iconTheme: const IconThemeData(color: leaf, size: 28),
    ),
    cardTheme: CardTheme(
      color: surface,
      elevation: 0,
      shadowColor: Color(0x66000000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: line, width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: leaf,
        foregroundColor: bg,
        elevation: 0,
        shadowColor: leaf.withOpacity(0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(
            fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: leaf,
      foregroundColor: bg,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: leafSoft,
      selectedColor: leaf,
      labelStyle: const TextStyle(color: leaf, fontWeight: FontWeight.w500),
      secondaryLabelStyle: const TextStyle(color: bg, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: tint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: leaf, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: TextStyle(color: inkSoft),
    ),
    textTheme: text,
    iconTheme: const IconThemeData(color: leaf, size: 24),
    dividerTheme: DividerThemeData(
      color: line.withOpacity(0.6),
      thickness: 1,
      space: 24,
    ),
  );
}

/// High Contrast — a maximal-accessibility scheme (WCAG AAA). Pure black
/// canvas, pure white text, and a bright gold accent for unambiguous
/// separation. Borders and font weights are emphasised for legibility.
ThemeData buildHighContrastTheme() {
  const bg = BotanishtPalette.hcBg;
  const surface = BotanishtPalette.hcSurface;
  const ink = BotanishtPalette.hcText;
  const accent = BotanishtPalette.hcAccent;

  final text = _botanicTextTheme(
    bodyColor: ink,
    displayColor: ink,
    displayWeight: FontWeight.w800,
    bodyWeight: FontWeight.w700,
  );
  final colorScheme = ColorScheme.dark(
    primary: accent,
    onPrimary: Colors.black,
    secondary: ink,
    onSecondary: Colors.black,
    surface: surface,
    onSurface: ink,
    onSurfaceVariant: ink,
    outline: ink,
    error: BotanishtPalette.danger,
    onError: Colors.white,
  ).copyWith(
    surfaceContainerHighest: surface,
    secondaryContainer: accent,
    onSecondaryContainer: Colors.black,
    outlineVariant: ink,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: bg,
    appBarTheme: AppBarTheme(
      backgroundColor: bg,
      foregroundColor: ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: text.titleLarge?.copyWith(fontSize: 28),
      iconTheme: const IconThemeData(color: ink, size: 28),
    ),
    cardTheme: CardTheme(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: ink, width: 2),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accent,
        foregroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: const BorderSide(color: ink, width: 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(
            fontFamily: 'Inter', fontSize: 17, fontWeight: FontWeight.w800),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accent,
      foregroundColor: Colors.black,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: ink, width: 2),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: bg,
      selectedColor: accent,
      labelStyle: const TextStyle(color: ink, fontWeight: FontWeight.w700),
      secondaryLabelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
        side: const BorderSide(color: ink, width: 2),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: ink, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: accent, width: 3),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: TextStyle(color: ink.withOpacity(0.7)),
    ),
    textTheme: text,
    iconTheme: const IconThemeData(color: ink, size: 24),
    dividerTheme: const DividerThemeData(
      color: ink,
      thickness: 2,
      space: 24,
    ),
  );
}
