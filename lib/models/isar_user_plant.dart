import 'package:isar/isar.dart';

part 'isar_user_plant.g.dart';

@collection
class UserPlant {
  Id id = Isar.autoIncrement;

  // Reference to the cached plant (optional - user can add custom plants too)
  int? plantEntityId;

  // User-specific info
  String? customName;
  String? location; // e.g., "Living room shelf", "Backyard raised bed", "Balcony pot"
  String? potSize; // e.g., "6 inch", "10 gallon"
  String? soilType; // e.g., "Cactus mix", "Potting soil + perlite"

  // Zone / bed assignment (e.g., 'indoor', 'hydro', 'kitchen', or a custom
  // zone name). The setter normalises casing + whitespace so grouping and
  // filtering are never defeated by 'Indoor' vs 'indoor' vs ' Indoor '.
  String? _zone;
  String? get zone => _zone;
  set zone(String? value) => _zone = value?.toLowerCase().trim();

  // How many of this exact crop the user is growing in this zone.
  int quantity = 1;

  // Acquisition info
  DateTime? acquiredDate;
  String? source; // "Nursery", "Gift", "Propagation", "Seeds", "Wild"

  // Care schedule (stored as JSON or structured)
  String? wateringSchedule; // JSON: {"frequency": 7, "amount": "1 cup", "notes": "..."}
  String? fertilizingSchedule; // JSON
  String? pruningSchedule; // JSON

  // Health tracking
  String? healthStatus; // "healthy", "warning", "critical", "dormant"
  List<String>? healthNotes; // User observations
  DateTime? lastWatered;
  DateTime? lastFertilized;
  DateTime? lastPruned;

  // Reminders
  bool wateringReminderEnabled = true;
  bool fertilizingReminderEnabled = true;
  bool pruningReminderEnabled = false;

  // Environment
  String? lightConditions; // "Full sun", "Partial shade", "Indirect light", "Grow light"
  // Structured light exposure selector: 0 = Low Light, 1 = Medium Light,
  // 2 = Bright Direct, 3 = Grow Lights.
  int lightExposure = 0;
  String? temperatureRange; // e.g., "65-75°F"
  String? humidityLevel; // "Low", "Medium", "High"

  // Pet safety (user override)
  bool? isPetSafe;

  // Growth tracking
  double? heightCm;
  double? widthCm;
  DateTime? lastMeasured;

  // Photos (stored as local file paths or base64)
  List<String>? photoPaths;

  // Tags for filtering
  List<String>? tags; // ["succulent", "beginner", "gift", "propagation"]

  UserPlant();
}
