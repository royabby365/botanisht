import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:botanisht/screens/home_screen.dart';
import 'package:botanisht/screens/splash_screen.dart';
import 'package:botanisht/models/isar_plant_entity.dart';
import 'package:botanisht/models/hydroponic_log.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/repository/plant_repository.dart';
import 'package:botanisht/providers/plant_provider.dart';

late final Isar isarInstance;

Future<void> _initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  isarInstance = await Isar.open(
    [PlantEntitySchema, HydroponicLogSchema, UserPlantSchema],
    directory: dir.path,
    name: 'plant',
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeIsar();
  
  runApp(
    ProviderScope(
      overrides: [
        plantRepositoryProvider.overrideWithValue(PlantRepository()),
      ],
      child: const BotanishtApp(),
    ),
  );
}

class BotanishtApp extends StatelessWidget {
  const BotanishtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Botanisht',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const SplashScreen(),
    );
  }

  ThemeData _buildTheme() {
    const Color primaryGreen = Color(0xFF1B4332);
    const Color secondaryGreen = Color(0xFF2D6A4F);
    const Color accentGold = Color(0xFFD4A843);
    const Color creamBackground = Color(0xFFF5F0E1);
    const Color cardDarkGreen = Color(0xFF0F2D1F);
    const Color textPrimary = Color(0xFFFFFFFF);
    const Color textSecondary = Color(0xFFB8D4C8);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: secondaryGreen,
        tertiary: accentGold,
        surface: creamBackground,
        background: creamBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: primaryGreen,
        onBackground: primaryGreen,
      ),
      scaffoldBackgroundColor: creamBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: creamBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: primaryGreen,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        iconTheme: const IconThemeData(color: primaryGreen, size: 28),
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
        bodyLarge: TextStyle(
          color: primaryGreen,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: primaryGreen,
          fontSize: 14,
        ),
      ),
      iconTheme: const IconThemeData(
        color: primaryGreen,
        size: 24,
      ),
      dividerTheme: DividerThemeData(
        color: primaryGreen.withOpacity(0.1),
        thickness: 1,
        space: 24,
      ),
    );
  }
}