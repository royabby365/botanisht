import 'package:isar/isar.dart';

part 'hydroponic_log.g.dart';

@collection
class HydroponicLog {
  Id id = Isar.autoIncrement;

  int plantId = 0;

  // Zone for filtering (indoor, hydro, kitchen, pollinator, native, permeable, bento)
  String? zone;

  double? waterPH;
  double? nutrientTds;
  int? pumpCycleMinutes;
  double? temperature;
  double? humidity;
  double? lightHours;
  DateTime timestamp = DateTime.now();
  String? notes;

  HydroponicLog();
}