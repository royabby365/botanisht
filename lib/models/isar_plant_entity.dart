import 'package:isar/isar.dart';

part 'isar_plant_entity.g.dart';

@collection
class PlantEntity {
  Id id = Isar.autoIncrement; // you can also use null = Isar.autoIncrement

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
  String? category; // e.g., 'indoorJungle', 'kitchenGarden', etc.
  String? customName;

  // PET SAFETY FLAG (true = safe for cats & dogs)
  bool? isPetSafe;

  PlantEntity();
}