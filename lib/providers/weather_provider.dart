import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/providers/plant_provider.dart';
import 'package:botanisht/services/weather_alert_service.dart';

final weatherServiceProvider = Provider((ref) => WeatherAlertService());

/// Derives a contextual weather advisory for the user's garden.
///
/// Recomputes whenever the garden stream emits (add/remove/zone change) or the
/// forecast asset changes. Returns `null` when the weather is benign or no
/// outdoor plants are at risk.
final weatherAlertProvider = FutureProvider<WeatherAlert?>((ref) async {
  final plants = ref.watch(userPlantsProvider).valueOrNull ?? [];
  return ref.read(weatherServiceProvider).evaluate(plants);
});
