import 'package:isar/isar.dart';

part 'hydroponic_log.g.dart';

@collection
class HydroponicLog {
  Id id = Isar.autoIncrement;

  int? plantId;

  double? waterPH;
  double? nutrientTds;
  int? pumpCycleMinutes;
  DateTime? timestamp;
  String? notes;

  HydroponicLog();
}