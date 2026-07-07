import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:botanisht/screens/home_screen.dart';

Future<void> _initializeIsar() async {
  if (!(await Isar.instanceNames()).contains('plant')) {
    final dir = await getApplicationDocumentsDirectory();
    await Isar.openInstance(
      'plant',
      [PlantEntitySchema],
      directory: dir.path,
    );
  }
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
