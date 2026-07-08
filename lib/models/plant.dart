class Plant {
  final int id;
  final String name;
  final String? description;
  final String? scientificName;
  final String? imageUrl;
  final List<String>? sunRequirements;
  final List<String>? waterRequirements;
  final String? propagationMethod;
  final int? daysToHarvest;
  final List<String>? companions;
  final List<String>? antagonists;
  final String? spacing;
  final String? rowSpacing;
  final String? seedDepth;
  final String? sowMethod;
  final String? sowRightBeforeLastFrostDate;
  final String? sowLastBeforeLastFrostDate;
  final String? sowFirstAfterLastFrostDate;
  final String? sowLastAfterLastFrostDate;
  // App-specific fields
  final String? category; // indoor, kitchen, pollinator, or null
  final String? customName; // user-defined nickname
  final bool? isPetSafe; // true = safe for cats & dogs

  Plant({
    required this.id,
    required this.name,
    this.description,
    this.scientificName,
    this.imageUrl,
    this.sunRequirements,
    this.waterRequirements,
    this.propagationMethod,
    this.daysToHarvest,
    this.companions,
    this.antagonists,
    this.spacing,
    this.rowSpacing,
    this.seedDepth,
    this.sowMethod,
    this.sowRightBeforeLastFrostDate,
    this.sowLastBeforeLastFrostDate,
    this.sowFirstAfterLastFrostDate,
    this.sowLastAfterLastFrostDate,
    this.category,
    this.customName,
    this.isPetSafe,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>;
    return Plant(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: attributes['name'] as String,
      description: attributes['description'] as String?,
      scientificName: attributes['scientific_name'] as String?,
      imageUrl: attributes['photo_url'] as String?,
      sunRequirements: _parseStringList(attributes['sun_requirements']),
      waterRequirements: _parseStringList(attributes['water_requirements']),
      propagationMethod: attributes['propagation'] as String?,
      daysToHarvest: attributes['days_to_harvest'] as int?,
      companions: _parseStringList(attributes['companions']),
      antagonists: _parseStringList(attributes['antagonists']),
      spacing: attributes['spacing'] as String?,
      rowSpacing: attributes['row_spacing'] as String?,
      seedDepth: attributes['seed_depth'] as String?,
      sowMethod: attributes['sow_method'] as String?,
      sowRightBeforeLastFrostDate:
          attributes['sow_right_before_last_frost_date'] as String?,
      sowLastBeforeLastFrostDate:
          attributes['sow_last_before_last_frost_date'] as String?,
      sowFirstAfterLastFrostDate:
          attributes['sow_first_after_last_frost_date'] as String?,
      sowLastAfterLastFrostDate:
          attributes['sow_last_after_last_frost_date'] as String?,
      // API does not provide category/customName/isPetSafe
      category: null,
      customName: null,
      isPetSafe: null,
    );
  }

  static List<String>? _parseStringList(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      final List<String> parts = value
          .replaceAll('\n', ',')
          .replaceAll(';', ',')
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
      return parts.isEmpty ? null : parts;
    }
    if (value is List<dynamic>) {
      return (value as List<dynamic>)
          .map((e) => e.toString())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return null;
  }

  String get sunlight => sunRequirements?.join(', ') ?? 'N/A';
  String get watering => waterRequirements?.join(', ') ?? 'N/A';

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'scientificName': scientificName,
        'imageUrl': imageUrl,
        'sunRequirements': sunRequirements,
        'waterRequirements': waterRequirements,
        'propagationMethod': propagationMethod,
        'daysToHarvest': daysToHarvest,
        'companions': companions,
        'antagonists': antagonists,
        'spacing': spacing,
        'rowSpacing': rowSpacing,
        'seedDepth': seedDepth,
        'sowMethod': sowMethod,
        'sowRightBeforeLastFrostDate': sowRightBeforeLastFrostDate,
        'sowLastBeforeLastFrostDate': sowLastBeforeLastFrostDate,
        'sowFirstAfterLastFrostDate': sowFirstAfterLastFrostDate,
        'sowLastAfterLastFrostDate': sowLastAfterLastFrostDate,
        'category': category,
        'customName': customName,
        'isPetSafe': isPetSafe,
      };
}