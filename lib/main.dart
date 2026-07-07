import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:botanisht/screens/home_screen.dart';
import 'package:botanisht/models/isar_plant_entity.dart';

Future<void> _initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  await Isar.open(
    [PlantEntitySchema],
    directory: dir.path,
    // instanceName: 'plant', // optional, default is empty string
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeIsar();
  runApp(
    ProviderScope(
      child: const BotanishtApp(),
    ),
  );
}

class BotanishtApp extends StatelessWidget {
  const BotanishtApp({Key? key}) : super(key: key);

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