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

class BotanishtApp extends ConsumerStatefulWidget {
  final bool isFirstRun;

  const BotanishtApp({super.key, required this.isFirstRun});

  @override
  ConsumerState<BotanishtApp> createState() => _BotanishtAppState();
}

/// Holds the root [MaterialApp] and reacts instantly to OS dark/light toggles
/// so `System` theme mode tracks the device's ambient brightness.
class _BotanishtAppState extends ConsumerState<BotanishtApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Rebuild the moment the platform brightness flips (e.g. system Dark Mode).
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    // Explicitly read the system's ambient brightness. Map to Deep Evergreen
    // (dark) when the platform is dark, otherwise Natural Cream (light).
    final systemBrightness =
        MediaQuery.maybePlatformBrightnessOf(context) ??
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final systemIsDark = systemBrightness == Brightness.dark;

    final theme = resolveTheme(
      themeMode: settings.themeMode,
      highContrast: settings.highContrast,
      systemIsDark: systemIsDark,
    );

    return MaterialApp(
      title: 'Botanisht',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: widget.isFirstRun ? const OnboardingScreen() : const SplashScreen(),
    );
  }
}
