import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:botanisht/models/hydroponic_log.dart';
import 'package:botanisht/models/isar_app_settings.dart';
import 'package:botanisht/models/isar_user_plant.dart';
import 'package:botanisht/repository/plant_repository.dart';
import 'package:botanisht/repository/settings_repository.dart';

/// What an export/import bundle contains — used to preview counts before
/// committing to a file write or a database merge.
class GardenDataSummary {
  final int plantCount;
  final int logCount;
  final bool hasSettings;

  const GardenDataSummary({
    required this.plantCount,
    required this.logCount,
    required this.hasSettings,
  });

  bool get isEmpty => plantCount == 0 && logCount == 0 && !hasSettings;
}

/// Result of a completed import.
class GardenImportResult {
  final GardenDataSummary summary;
  final DateTime? exportedAt;

  const GardenImportResult({required this.summary, this.exportedAt});
}

/// Serialises the user's garden (plants, hydroponic logs and preferences) to a
/// portable JSON document and merges such documents back into Isar.
///
/// Export format:
/// ```json
/// {
///   "version": 1,
///   "exportedAt": "2026-08-14T12:00:00.000Z",
///   "plants": [...],
///   "logs": [...],
///   "settings": {...}
/// }
/// ```
///
/// Imports are *merge* operations: plants and logs are appended as brand-new
/// rows (fresh ids) and settings are merged field-by-field, so nothing already
/// in the garden is ever overwritten or deleted.
class GardenDataService {
  final PlantRepository _plantRepo;
  final SettingsRepository _settingsRepo;

  GardenDataService({
    PlantRepository? plantRepository,
    SettingsRepository? settingsRepository,
  })  : _plantRepo = plantRepository ?? PlantRepository(),
        _settingsRepo = settingsRepository ?? SettingsRepository();

  /// Counts what an export would contain right now.
  Future<GardenDataSummary> buildExportSummary() async {
    final plants = await _plantRepo.getUserPlantsSorted();
    final logs = await _plantRepo.getAllHydroponicLogs();
    return GardenDataSummary(
      plantCount: plants.length,
      logCount: logs.length,
      hasSettings: true,
    );
  }

  /// Builds the pretty-printed JSON document for the current garden.
  Future<String> buildExportJson() async {
    final plants = await _plantRepo.getUserPlantsSorted();
    final logs = await _plantRepo.getAllHydroponicLogs();
    final settings = await _settingsRepo.getSettings();
    final bundle = <String, dynamic>{
      'version': 1,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'plants': plants.map(_plantToJson).toList(),
      'logs': logs.map(_logToJson).toList(),
      'settings': _settingsToJson(settings),
    };
    return const JsonEncoder.withIndent('  ').convert(bundle);
  }

  /// Writes the current garden to a timestamped JSON file in the app's
  /// documents directory and returns the absolute file path.
  Future<String> exportToFile() async {
    final json = await buildExportJson();
    final dir = await getApplicationDocumentsDirectory();
    final now = DateTime.now();
    String two(int n) => n.toString().padLeft(2, '0');
    final stamp =
        '${now.year}${two(now.month)}${two(now.day)}'
        '_${two(now.hour)}${two(now.minute)}${two(now.second)}';
    final file = File('${dir.path}/botanisht_garden_export_$stamp.json');
    await file.writeAsString(json, flush: true);
    return file.path;
  }

  /// Validates [rawJson] without touching the database. Throws a
  /// [FormatException] with a user-friendly message when the text is not a
  /// recognisable Botanisht export.
  GardenDataSummary parseImport(String rawJson) {
    final decoded = _decodeBundle(rawJson);
    return GardenDataSummary(
      plantCount: (decoded['plants'] as List).length,
      logCount: (decoded['logs'] as List).length,
      hasSettings: decoded['settings'] is Map<String, dynamic>,
    );
  }

  /// Parses, validates and merges a Botanisht JSON export into the current
  /// garden. Plants and logs are appended with fresh ids; settings are merged
  /// field-by-field (imported values win where present).
  Future<GardenImportResult> importFromJson(String rawJson) async {
    final decoded = _decodeBundle(rawJson);
    final plantMaps =
        (decoded['plants'] as List).cast<Map<String, dynamic>>();
    final logMaps = (decoded['logs'] as List).cast<Map<String, dynamic>>();
    final settingsJson = decoded['settings'] as Map<String, dynamic>?;

    final plants = plantMaps.map(_plantFromJson).toList();
    final logs = logMaps.map(_logFromJson).toList();

    // Remap hydroponic log plantId references to the freshly inserted ids.
    final oldIds = plants.map((p) => p.id).toList();
    final inserted = await _plantRepo.importUserPlants(plants);
    final idMap = <int, int>{
      for (var i = 0; i < plants.length; i++) oldIds[i]: inserted[i].id,
    };
    for (final log in logs) {
      if (log.plantId != 0 && idMap.containsKey(log.plantId)) {
        log.plantId = idMap[log.plantId]!;
      }
    }
    await _plantRepo.importHydroponicLogs(logs);

    if (settingsJson != null) {
      await _mergeSettings(settingsJson);
    }

    return GardenImportResult(
      summary: GardenDataSummary(
        plantCount: plants.length,
        logCount: logs.length,
        hasSettings: settingsJson != null,
      ),
      exportedAt: DateTime.tryParse(decoded['exportedAt'] as String? ?? ''),
    );
  }

  // ---------------------------------------------------------------------------
  // Parsing / validation
  // ---------------------------------------------------------------------------

  Map<String, dynamic> _decodeBundle(String rawJson) {
    final Object? decoded;
    try {
      decoded = jsonDecode(rawJson);
    } on FormatException {
      throw const FormatException(
          'The pasted text is not valid JSON. Paste a complete Botanisht export and try again.');
    }
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException(
          'The JSON must be an object at the top level (starts with "{").');
    }
    if (decoded['version'] != 1) {
      throw FormatException(
          'Unsupported export version: ${decoded['version']} (expected 1).');
    }
    final plants = decoded['plants'];
    final logs = decoded['logs'];
    if (plants is! List || plants.any((e) => e is! Map<String, dynamic>)) {
      throw const FormatException(
          'The "plants" field must be a list of objects.');
    }
    if (logs is! List || logs.any((e) => e is! Map<String, dynamic>)) {
      throw const FormatException('The "logs" field must be a list of objects.');
    }
    return decoded;
  }

  Future<void> _mergeSettings(Map<String, dynamic> json) async {
    final current = await _settingsRepo.getSettings();
    final merged = AppSettings()
      ..id = current.id
      ..themeMode = _int(json['themeMode']) ?? current.themeMode
      ..highContrast = _bool(json['highContrast']) ?? current.highContrast
      ..units = _int(json['units']) ?? current.units
      ..temperatureScale =
          _int(json['temperatureScale']) ?? current.temperatureScale
      ..gardenZipCode =
          json['gardenZipCode'] as String? ?? current.gardenZipCode
      ..zoneConfigs =
          _zoneConfigsFromJson(json['zoneConfigs']) ?? current.zoneConfigs
      // Install-state / transient cache fields stay local.
      ..isFirstRun = current.isFirstRun
      ..lastWeatherFetch = current.lastWeatherFetch
      ..cachedWeatherMessage = current.cachedWeatherMessage
      ..cachedWeatherPlantNames = current.cachedWeatherPlantNames;
    await _settingsRepo.saveSettings(merged);
  }

  // ---------------------------------------------------------------------------
  // Serialisation helpers
  // ---------------------------------------------------------------------------

  Map<String, dynamic> _plantToJson(UserPlant p) => {
        'id': p.id,
        if (p.plantEntityId != null) 'plantEntityId': p.plantEntityId,
        'customName': p.customName,
        'location': p.location,
        'potSize': p.potSize,
        'soilType': p.soilType,
        'zone': p.zone,
        'quantity': p.quantity,
        'acquiredDate': p.acquiredDate?.toIso8601String(),
        'source': p.source,
        'wateringSchedule': p.wateringSchedule,
        'fertilizingSchedule': p.fertilizingSchedule,
        'pruningSchedule': p.pruningSchedule,
        'healthStatus': p.healthStatus,
        'healthNotes': p.healthNotes,
        'lastWatered': p.lastWatered?.toIso8601String(),
        'wateringIntervalHours': p.wateringIntervalHours,
        'lastFertilized': p.lastFertilized?.toIso8601String(),
        'lastPruned': p.lastPruned?.toIso8601String(),
        'wateringReminderEnabled': p.wateringReminderEnabled,
        'fertilizingReminderEnabled': p.fertilizingReminderEnabled,
        'pruningReminderEnabled': p.pruningReminderEnabled,
        'lightConditions': p.lightConditions,
        'lightExposure': p.lightExposure,
        'temperatureRange': p.temperatureRange,
        'humidityLevel': p.humidityLevel,
        'isPetSafe': p.isPetSafe,
        'heightCm': p.heightCm,
        'widthCm': p.widthCm,
        'lastMeasured': p.lastMeasured?.toIso8601String(),
        'photoPaths': p.photoPaths,
        'tags': p.tags,
        'xp': p.xp,
        'level': p.level,
        'wateringStreak': p.wateringStreak,
        'careStreak': p.careStreak,
        'lastCareDate': p.lastCareDate?.toIso8601String(),
      };

  Map<String, dynamic> _logToJson(HydroponicLog l) => {
        'id': l.id,
        'plantId': l.plantId,
        'zone': l.zone,
        'waterPH': l.waterPH,
        'nutrientTds': l.nutrientTds,
        'pumpCycleMinutes': l.pumpCycleMinutes,
        'temperature': l.temperature,
        'humidity': l.humidity,
        'lightHours': l.lightHours,
        'timestamp': l.timestamp.toIso8601String(),
        'notes': l.notes,
      };

  Map<String, dynamic> _settingsToJson(AppSettings s) => {
        'themeMode': s.themeMode,
        'highContrast': s.highContrast,
        'units': s.units,
        'temperatureScale': s.temperatureScale,
        'gardenZipCode': s.gardenZipCode,
        'zoneConfigs': _zoneConfigsToJson(s.zoneConfigs),
      };

  UserPlant _plantFromJson(Map<String, dynamic> json) => UserPlant()
    ..id = 0
    ..plantEntityId = _int(json['plantEntityId'])
    ..customName = json['customName'] as String?
    ..location = json['location'] as String?
    ..potSize = json['potSize'] as String?
    ..soilType = json['soilType'] as String?
    ..zone = json['zone'] as String?
    ..quantity = _int(json['quantity']) ?? 1
    ..acquiredDate = _dt(json['acquiredDate'])
    ..source = json['source'] as String?
    ..wateringSchedule = json['wateringSchedule'] as String?
    ..fertilizingSchedule = json['fertilizingSchedule'] as String?
    ..pruningSchedule = json['pruningSchedule'] as String?
    ..healthStatus = json['healthStatus'] as String?
    ..healthNotes = _strList(json['healthNotes'])
    ..lastWatered = _dt(json['lastWatered'])
    ..wateringIntervalHours = _int(json['wateringIntervalHours']) ?? 24
    ..lastFertilized = _dt(json['lastFertilized'])
    ..lastPruned = _dt(json['lastPruned'])
    ..wateringReminderEnabled =
        _bool(json['wateringReminderEnabled']) ?? true
    ..fertilizingReminderEnabled =
        _bool(json['fertilizingReminderEnabled']) ?? true
    ..pruningReminderEnabled =
        _bool(json['pruningReminderEnabled']) ?? false
    ..lightConditions = json['lightConditions'] as String?
    ..lightExposure = _int(json['lightExposure']) ?? 0
    ..temperatureRange = json['temperatureRange'] as String?
    ..humidityLevel = json['humidityLevel'] as String?
    ..isPetSafe = _bool(json['isPetSafe'])
    ..heightCm = _dbl(json['heightCm'])
    ..widthCm = _dbl(json['widthCm'])
    ..lastMeasured = _dt(json['lastMeasured'])
    ..photoPaths = _strList(json['photoPaths'])
    ..tags = _strList(json['tags'])
    ..xp = _int(json['xp']) ?? 0
    ..level = _int(json['level']) ?? 1
    ..wateringStreak = _int(json['wateringStreak']) ?? 0
    ..careStreak = _int(json['careStreak']) ?? 0
    ..lastCareDate = _dt(json['lastCareDate']);

  HydroponicLog _logFromJson(Map<String, dynamic> json) => HydroponicLog()
    ..id = 0
    ..plantId = _int(json['plantId']) ?? 0
    ..zone = json['zone'] as String?
    ..waterPH = _dbl(json['waterPH'])
    ..nutrientTds = _dbl(json['nutrientTds'])
    ..pumpCycleMinutes = _int(json['pumpCycleMinutes'])
    ..temperature = _dbl(json['temperature'])
    ..humidity = _dbl(json['humidity'])
    ..lightHours = _dbl(json['lightHours'])
    ..timestamp = _dt(json['timestamp']) ?? DateTime.now()
    ..notes = json['notes'] as String?;

  // ---------------------------------------------------------------------------
  // Loose JSON → Dart converters (tolerant of hand-edited exports)
  // ---------------------------------------------------------------------------

  static DateTime? _dt(Object? v) =>
      v is String ? DateTime.tryParse(v) : null;

  static int? _int(Object? v) =>
      v is int ? v : (v is num ? v.toInt() : null);

  static double? _dbl(Object? v) => v is num ? v.toDouble() : null;

  static bool? _bool(Object? v) => v is bool ? v : null;

  static List<String>? _strList(Object? v) =>
      v is List ? v.whereType<String>().toList() : null;

  /// Decodes the stored zoneConfigs JSON string so the export is human
  /// readable; falls back to the raw string when it isn't valid JSON.
  static Object? _zoneConfigsToJson(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      return jsonDecode(raw);
    } catch (_) {
      return raw;
    }
  }

  /// Re-encodes a decoded zoneConfigs map (or passes a raw string through).
  static String? _zoneConfigsFromJson(Object? value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is Map) return jsonEncode(value);
    return null;
  }
}
