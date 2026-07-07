import 'package:isar/isar.dart';

part 'isar_plant_entity.g.dart';

@collection
class PlantEntity {
  Id id = Isar.autoIncrement; // you can also keep the external id if needed

  String? name;
  String? description;
  String? scientificName;
  String? imageUrl;
  List<String>? sunRequirements;
  List<String>? waterRequirements;
  String? propagationMethod;
  int? daysToHarvest;
  List<String>? companions;
  List<String>? antagonists;
  String? spacing;
  String? rowSpacing;
  String? seedDepth;
  String? sowMethod;
  String? sowRightBeforeLastFrostDate;
  String? sowLastBeforeLastFrostDate;
  String? sowFirstAfterLastFrostDate;
  String? sowLastAfterLastFrostDate;

  // User‑specific fields
  String? category; // 'indoor', 'kitchen', 'pollinator'
  String? customName;

  // NEW: pet safety flag (true = safe for cats and dogs)
  bool? isPetSafe;

  PlantEntity();
}
