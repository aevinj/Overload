import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload/box_manager.dart';
import 'package:progressive_overload/classes/day.dart';
import 'package:progressive_overload/classes/exercise.dart';
import 'package:progressive_overload/classes/workout.dart';
import 'package:progressive_overload/pages/landing.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(DayAdapter());
  //TODO: put openBox in a try clause and if it fails, delete the box from disk first then openBox again
  final boxManager = BoxManager();
  await boxManager.initialize();
  
  runApp(
    ChangeNotifierProvider<BoxManager>(
      create: (_) => boxManager,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Landing());
  }
}
