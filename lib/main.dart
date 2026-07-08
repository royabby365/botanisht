import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:botanisht/models/isar_plant_entity.dart';
import 'package:botanisht/models/hydroponic_log.dart';
import 'package:botanisht/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final dir = await getApplicationDocumentsDirectory();
  
  if (Isar.instanceNames.isEmpty) {
    await Isar.open(
      [PlantEntitySchema, HydroponicLogSchema],
      directory: dir.path,
      name: 'plant',
    );
  }

  runApp(const BotanishtApp());
}

class BotanishtApp extends StatelessWidget {
  const BotanishtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Botanisht',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
