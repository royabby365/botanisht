import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:botanisht/core/theme/app_theme.dart';
import 'package:botanisht/models/hydroponic_log.dart';
import 'package:botanisht/models/isar_app_settings.dart';
import 'package:botanisht/models/isar_plant_entity.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/providers/plant_provider.dart';
import 'package:botanisht/providers/settings_provider.dart';
import 'package:botanisht/repository/plant_repository.dart';
import 'package:botanisht/screens/home_screen.dart';
import 'package:botanisht/screens/onboarding_screen.dart';
import 'package:botanisht/screens/splash_screen.dart';

late final Isar isarInstance;

Future<void> _initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  isarInstance = await Isar.open(
    [
      PlantEntitySchema,
      HydroponicLogSchema,
      UserPlantSchema,
      AppSettingsSchema,
    ],
    directory: dir.path,
    name: 'plant',
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeIsar();

  // First-run gate: if the user has not completed the onboarding tutorial yet
  // (or no settings row exists), route them to the tutorial. Otherwise boot
  // straight to the main dashboard.
  final settings = await isarInstance.appSettings.where().findFirst();
  final isFirstRun = settings?.isFirstRun ?? true;

  runApp(
    ProviderScope(
      overrides: [
        plantRepositoryProvider.overrideWithValue(PlantRepository()),
      ],
      child: BotanishtApp(isFirstRun: isFirstRun),
    ),
  );
}

class BotanishtApp extends ConsumerWidget {
  final bool isFirstRun;

  const BotanishtApp({super.key, required this.isFirstRun});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final theme = resolveTheme(
      themeMode: settings.themeMode,
      highContrast: settings.highContrast,
    );

    return MaterialApp(
      title: 'Botanisht',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: isFirstRun ? const OnboardingScreen() : const SplashScreen(),
    );
  }
}
