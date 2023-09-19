import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload/classes/day.dart';
import 'package:progressive_overload/classes/exercise.dart';
import 'package:progressive_overload/classes/workout.dart';
import 'package:progressive_overload/pages/landing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(DayAdapter());
  await Hive.openBox<Workout>('workouts');
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Landing()
    );
  }
}
