import 'package:isar/isar.dart';
import 'package:botanisht/models/isar_plant_entity.dart';
import 'package:botanisht/models/plant.dart';
import 'package:botanisht/models/hydroponic_log.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/services/plant_api_service.dart';

/// Thresholds for plant level progression.
const _xpToLevel = [
  0, 50, 120, 220, 350, 520, 730, 980, 1280, 1630, 2030,
  2480, 2980, 3530, 4130, 4780, 5480, 6230, 7030, 7880,
];

int _computeLevel(int xp) {
  for (int i = _xpToLevel.length - 1; i >= 1; i--) {
    if (xp >= _xpToLevel[i]) return i + 1;
  }
  return 1;
}

/// Date-only (no time) today, for streak comparisons.
DateTime _today() {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day);
}

/// Updates [plant]'s streak fields given a care action on [actionDate] and
/// returns the number of XP to award for this action (separate from streak
/// XP, which is handled inside this method).
int _updateStreaks(UserPlant plant, DateTime actionDate) {
  final today = _today();
  final actionDay = DateTime(actionDate.year, actionDate.month, actionDate.day);
  final lastDay = plant.lastCareDate;

  int streakXp = 0;

  if (lastDay == null) {
    // First care action ever.
    plant.careStreak = 1;
    plant.wateringStreak = 1;
    streakXp = 5; // First-care bonus.
  } else {
    final diff = actionDay.difference(lastDay).inDays;
    if (diff == 1) {
      // Consecutive day — increment streak.
      plant.careStreak += 1;
      // Streak milestone bonus every 7 days.
      if (plant.careStreak > 0 && plant.careStreak % 7 == 0) {
        streakXp = 25;
      }
    } else if (diff == 0) {
      // Same day — keep streak, no bonus.
    } else {
      // Gap of 2+ days — streak broken.
      plant.careStreak = 1;
      plant.wateringStreak = 1;
    }
  }

  plant.lastCareDate = actionDay;
  return streakXp;
}

/// Adds [xp] to the plant, checking for level-up.
void _awardXp(UserPlant plant, int xp) {
  plant.xp += xp;
  final newLevel = _computeLevel(plant.xp);
  if (newLevel > plant.level) {
    plant.level = newLevel;
  }
}

/// Copy gamification fields from source to target.
void _copyGamification(UserPlant target, UserPlant source) {
  target.xp = source.xp;
  target.level = source.level;
  target.wateringStreak = source.wateringStreak;
  target.careStreak = source.careStreak;
  target.lastCareDate = source.lastCareDate;
}

class PlantRepository {
  PlantRepository() {
    _init();
  }

  late final Isar _isar;
  late final PlantApiService _apiService;

  Future<void> _init() async {
    // Get the Isar instance that was already opened in main.dart
    _isar = Isar.getInstance('plant')!;
    _apiService = PlantApiService();
  }

  Future<Plant?> getPlant(int id) async {
    return await _apiService.getPlant(id);
  }

  Future<List<Plant>> getAllPlants() async {
    final entities = await _isar.plantEntitys.where().findAll();
    return entities.map(_entityToPlant).toList();
  }

  Future<List<Plant>> getPlantsByCategory(String category) async {
    final entities = await _isar.plantEntitys
        .filter()
        .categoryEqualTo(category)
        .findAll();
    return entities.map(_entityToPlant).toList();
  }

  Future<void> savePlant(Plant plant) async {
    await _apiService.putPlant(plant);
  }

  Stream<HydroponicLog?> watchLatestHydroponicLog() {
    return _isar.hydroponicLogs
        .where()
        .sortByTimestampDesc()
        .limit(1)
        .watch(fireImmediately: true)
        .map((list) => list.isNotEmpty ? list.first : null);
  }

  Stream<HydroponicLog?> watchLatestHydroponicLogForZone(String zone) {
    return _isar.hydroponicLogs
        .filter()
        .zoneEqualTo(zone)
        .sortByTimestampDesc()
        .limit(1)
        .watch(fireImmediately: true)
        .map((list) => list.isNotEmpty ? list.first : null);
  }

  Stream<List<HydroponicLog>> watchHydroponicLogsForZone(String zone) {
    return _isar.hydroponicLogs
        .filter()
        .zoneEqualTo(zone)
        .sortByTimestampDesc()
        .watch(fireImmediately: true);
  }

  /// Stream of ALL hydroponic logs across all zones
  Stream<List<HydroponicLog>> watchAllHydroponicLogs() {
    return _isar.hydroponicLogs
        .where()
        .sortByTimestampDesc()
        .watch(fireImmediately: true);
  }

  // User Plant methods
  Stream<List<UserPlant>> watchUserPlants() {
    return _isar.userPlants
        .where()
        .sortByAcquiredDateDesc()
        .watch(fireImmediately: true);
  }

  Future<List<UserPlant>> getUserPlantsSorted() async {
    return await _isar.userPlants
        .where()
        .sortByAcquiredDateDesc()
        .findAll();
  }

  Future<List<UserPlant>> getPlantsNeedingWater() async {
    final now = DateTime.now();
    final allPlants = await _isar.userPlants.where().findAll();
    return allPlants.where((p) {
      if (p.lastWatered == null) return true;
      final diff = now.difference(p.lastWatered!).inHours;
      return diff >= p.wateringIntervalHours;
    }).toList();
  }

  Future<void> addUserPlantFromEntity(
    int plantEntityId, {
    String? customName,
    String? location,
    String? potSize,
    String? soilType,
    DateTime? acquiredDate,
    String? source,
    String? zone,
  }) async {
    final userPlant = UserPlant()
      ..plantEntityId = plantEntityId
      ..customName = customName
      ..location = location
      ..potSize = potSize
      ..soilType = soilType
      ..acquiredDate = acquiredDate ?? DateTime.now()
      ..source = source
      ..zone = zone ?? 'indoor'
      ..quantity = 1
      ..healthStatus = 'healthy'
      ..healthNotes = []
      ..photoPaths = []
      ..tags = [];

    // Starting XP bonus for adding a plant.
    _awardXp(userPlant, 10);

    await _isar.writeTxn(() => _isar.userPlants.put(userPlant));
  }

  Future<void> addCustomUserPlant({
    required String name,
    String? customName,
    String? location,
    String? potSize,
    String? soilType,
    DateTime? acquiredDate,
    String? source,
    String? lightConditions,
    String? temperatureRange,
    String? humidityLevel,
    int? lightExposure,
    bool? isPetSafe,
    List<String>? tags,
    String? zone,
    int quantity = 1,
    int wateringIntervalHours = 24,
  }) async {
    final userPlant = UserPlant()
      ..customName = customName ?? name
      ..location = location
      ..potSize = potSize
      ..soilType = soilType
      ..acquiredDate = acquiredDate ?? DateTime.now()
      ..source = source
      ..zone = zone ?? 'indoor'
      ..quantity = quantity
      ..lightConditions = lightConditions
      ..lightExposure = lightExposure ?? 0
      ..temperatureRange = temperatureRange
      ..humidityLevel = humidityLevel
      ..isPetSafe = isPetSafe
      ..tags = tags ?? []
      ..healthStatus = 'healthy'
      ..healthNotes = []
      ..wateringIntervalHours = wateringIntervalHours
      ..photoPaths = [];

    _awardXp(userPlant, 10);

    await _isar.writeTxn(() => _isar.userPlants.put(userPlant));
  }

  Future<void> updateUserPlant(UserPlant plant) async {
    await _isar.writeTxn(() => _isar.userPlants.put(plant));
  }

  Future<void> deleteUserPlant(int id) async {
    await _isar.writeTxn(() => _isar.userPlants.delete(id));
  }

  /// Adjust the quantity of a specific crop (e.g. from the card stepper) and
  /// persist it inside an immediate write transaction.
  Future<void> setQuantity(int id, int quantity) async {
    final plant = await _isar.userPlants.get(id);
    if (plant == null) return;
    plant.quantity = quantity.clamp(1, 9999);
    await _isar.writeTxn(() => _isar.userPlants.put(plant));
  }

  /// Distinct, normalized zone names present across the user's garden.
  Future<List<String>> getUniqueZones() async {
    final all = await _isar.userPlants.where().findAll();
    final zones = <String>{};
    for (final p in all) {
      final z = (p.zone ?? 'uncategorized').toLowerCase();
      zones.add(z);
    }
    return zones.toList()..sort();
  }

  Future<void> recordWatering(int id, {String? notes, double? amount}) async {
    final plant = await _isar.userPlants.get(id);
    if (plant != null) {
      final now = DateTime.now();
      plant.lastWatered = now;
      plant.healthNotes ??= [];
      if (notes != null && notes.isNotEmpty) {
        plant.healthNotes!.add('Watered: $notes');
      }
      // Gamification: watering streak + XP.
      if (plant.wateringStreak > 0) {
        // Only increment watering streak separately if it's a new day.
        final today = _today();
        if (plant.lastCareDate == null || today.difference(plant.lastCareDate!).inDays >= 1) {
          plant.wateringStreak += 1;
        }
      } else {
        plant.wateringStreak = 1;
      }
      _awardXp(plant, 10);
      final bonus = _updateStreaks(plant, now);
      if (bonus > 0) _awardXp(plant, bonus);
      await _isar.writeTxn(() => _isar.userPlants.put(plant));
    }
  }

  Future<void> recordFertilizing(int id, {String? notes, String? fertilizerType}) async {
    final plant = await _isar.userPlants.get(id);
    if (plant != null) {
      final now = DateTime.now();
      plant.lastFertilized = now;
      plant.healthNotes ??= [];
      if (notes != null && notes.isNotEmpty) {
        plant.healthNotes!.add('Fertilized: $notes${fertilizerType != null ? ' ($fertilizerType)' : ''}');
      }
      _awardXp(plant, 15);
      final bonus = _updateStreaks(plant, now);
      if (bonus > 0) _awardXp(plant, bonus);
      await _isar.writeTxn(() => _isar.userPlants.put(plant));
    }
  }

  Future<void> recordPruning(int id, {String? notes}) async {
    final plant = await _isar.userPlants.get(id);
    if (plant != null) {
      final now = DateTime.now();
      plant.lastPruned = now;
      plant.healthNotes ??= [];
      if (notes != null && notes.isNotEmpty) {
        plant.healthNotes!.add('Pruned: $notes');
      }
      _awardXp(plant, 10);
      final bonus = _updateStreaks(plant, now);
      if (bonus > 0) _awardXp(plant, bonus);
      await _isar.writeTxn(() => _isar.userPlants.put(plant));
    }
  }

  Future<void> updateHealthStatus(int id, String status, String note) async {
    final plant = await _isar.userPlants.get(id);
    if (plant == null) return;

    final wasCritical = plant.healthStatus == 'critical';
    final wasWarning = plant.healthStatus == 'warning';

    final updated = UserPlant()
      ..id = plant.id
      ..plantEntityId = plant.plantEntityId
      ..customName = plant.customName
      ..location = plant.location
      ..potSize = plant.potSize
      ..soilType = plant.soilType
      ..acquiredDate = plant.acquiredDate
      ..source = plant.source
      ..wateringSchedule = plant.wateringSchedule
      ..fertilizingSchedule = plant.fertilizingSchedule
      ..pruningSchedule = plant.pruningSchedule
      ..healthStatus = status
      ..healthNotes = [...?plant.healthNotes, '$status: $note']
      ..lastWatered = plant.lastWatered
      ..wateringIntervalHours = plant.wateringIntervalHours
      ..lastFertilized = plant.lastFertilized
      ..lastPruned = plant.lastPruned
      ..wateringReminderEnabled = plant.wateringReminderEnabled
      ..fertilizingReminderEnabled = plant.fertilizingReminderEnabled
      ..pruningReminderEnabled = plant.pruningReminderEnabled
      ..lightConditions = plant.lightConditions
      ..lightExposure = plant.lightExposure
      ..temperatureRange = plant.temperatureRange
      ..humidityLevel = plant.humidityLevel
      ..isPetSafe = plant.isPetSafe
      ..heightCm = plant.heightCm
      ..widthCm = plant.widthCm
      ..lastMeasured = plant.lastMeasured
      ..photoPaths = plant.photoPaths
      ..zone = plant.zone
      ..quantity = plant.quantity
      ..tags = plant.tags
      // Gamification: carry forward.
      ..xp = plant.xp
      ..level = plant.level
      ..wateringStreak = plant.wateringStreak
      ..careStreak = plant.careStreak
      ..lastCareDate = plant.lastCareDate;

    // XP bonus for improving health.
    if (wasCritical && status == 'warning') {
      _awardXp(updated, 25);
    } else if ((wasCritical || wasWarning) && status == 'healthy') {
      _awardXp(updated, 15);
    } else {
      _awardXp(updated, 2);
    }

    await _isar.writeTxn(() => _isar.userPlants.put(updated));
  }

  Future<void> recordMeasurement(int id, {double? heightCm, double? widthCm}) async {
    final plant = await _isar.userPlants.get(id);
    if (plant != null) {
      if (heightCm != null) plant.heightCm = heightCm;
      if (widthCm != null) plant.widthCm = widthCm;
      plant.lastMeasured = DateTime.now();
      _awardXp(plant, 5);
      await _isar.writeTxn(() => _isar.userPlants.put(plant));
    }
  }

  Future<void> addPhoto(int id, String photoPath) async {
    final plant = await _isar.userPlants.get(id);
    if (plant != null) {
      plant.photoPaths ??= [];
      plant.photoPaths!.add(photoPath);
      _awardXp(plant, 2);
      await _isar.writeTxn(() => _isar.userPlants.put(plant));
    }
  }

  // ---------------------------------------------------------------------------
  // Data portability (export / import)
  // ---------------------------------------------------------------------------

  /// All hydroponic readings, newest first.
  Future<List<HydroponicLog>> getAllHydroponicLogs() async {
    return await _isar.hydroponicLogs
        .where()
        .sortByTimestampDesc()
        .findAll();
  }

  /// Adds a new hydroponic log entry.
  Future<void> addHydroponicLog(HydroponicLog log) async {
    await _isar.writeTxn(() => _isar.hydroponicLogs.put(log));
  }

  /// Inserts imported plants as brand-new rows (fresh ids) so an import never
  /// overwrites an existing garden. Returns the inserted plants with their
  /// new ids so callers can remap foreign keys (e.g. hydroponic log plantId).
  Future<List<UserPlant>> importUserPlants(List<UserPlant> plants) async {
    if (plants.isEmpty) return const <UserPlant>[];
    final existing = await _isar.userPlants.where().findAll();
    var nextId = existing.fold<int>(0, (max, p) => p.id > max ? p.id : max) + 1;
    final inserted = <UserPlant>[];
    await _isar.writeTxn(() async {
      for (final plant in plants) {
        plant.id = nextId++;
        await _isar.userPlants.put(plant);
        inserted.add(plant);
      }
    });
    return inserted;
  }

  /// Inserts imported hydroponic logs as brand-new rows (fresh ids).
  Future<List<HydroponicLog>> importHydroponicLogs(
      List<HydroponicLog> logs) async {
    if (logs.isEmpty) return const <HydroponicLog>[];
    final existing = await _isar.hydroponicLogs.where().findAll();
    var nextId = existing.fold<int>(0, (max, l) => l.id > max ? l.id : max) + 1;
    final inserted = <HydroponicLog>[];
    await _isar.writeTxn(() async {
      for (final log in logs) {
        log.id = nextId++;
        await _isar.hydroponicLogs.put(log);
        inserted.add(log);
      }
    });
    return inserted;
  }

  void dispose() {
    _apiService.close();
  }

  Plant _entityToPlant(PlantEntity e) => Plant(
        id: e.id,
        name: e.name ?? '',
        description: e.description,
        scientificName: e.scientificName,
        imageUrl: e.imageUrl,
        sunRequirements: e.sunRequirements,
        waterRequirements: e.waterRequirements,
        propagationMethod: e.propagationMethod,
        daysToHarvest: e.daysToHarvest,
        companions: e.companions,
        antagonists: e.antagonists,
        spacing: e.spacing,
        rowSpacing: e.rowSpacing,
        seedDepth: e.seedDepth,
        sowMethod: e.sowMethod,
        sowRightBeforeLastFrostDate: e.sowRightBeforeLastFrostDate,
        sowLastBeforeLastFrostDate: e.sowLastBeforeLastFrostDate,
        sowFirstAfterLastFrostDate: e.sowFirstAfterLastFrostDate,
        sowLastAfterLastFrostDate: e.sowLastAfterLastFrostDate,
        category: e.category,
        customName: e.customName,
        isPetSafe: e.isPetSafe,
      );
}