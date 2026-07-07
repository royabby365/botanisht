import 'package:isar/isar.dart';

part 'isar_plant.g.dart';

@collection
class Plant {
  Id id = Isar.autoIncrement; // you can also use null = Isar.autoIncrement

  String? name;
  String? description;
  String? scientificName;
  String? imageUrl;
  // Store as comma-separated string or use link? We'll store as List<String> using Isar's List property
  // Isar supports List<String> directly.
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

  // Custom fields for app
  String? customName; // user-defined name or nickname
  String? category; // indoor, kitchen, pollinator

  // For linking to care logs (optional)
  // final careLogs = IsarLinks<CareLog>();
}