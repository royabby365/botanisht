// ignore_for_file: constant_identifier_names

import 'package:isar/isar.dart';

part 'isar_care_log.g.dart';

@collection
class CareLog {
  Id id = Isar.autoIncrement;

  int? plantId; // reference to Plant.id
  String? actionType; // e.g., 'watering', 'fertilizing', 'pruning'
  DateTime? timestamp;
  String? notes;

  // Optional backlink to Plant
  // final plant = IsarLink<Plant>();
}