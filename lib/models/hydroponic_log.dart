import 'package:isar/isar.dart';

part 'hydroponic_log.g.dart';

@collection
class HydroponicLog {
  Id id = Isar.autoIncrement;

  int plantId = 0;

  double? waterPH;
  double? nutrientTds;
  int? pumpCycleMinutes;
  DateTime timestamp = DateTime.now();
  String? notes;

  HydroponicLog();
}