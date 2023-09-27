import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload/pages/homepage.dart';
import 'package:progressive_overload/util/box_manager.dart';
import 'package:progressive_overload/classes/day.dart';
import 'package:progressive_overload/classes/exercise.dart';
import 'package:progressive_overload/util/prebuilt_exercises.dart';
import 'package:progressive_overload/classes/workout.dart';
import 'package:progressive_overload/theme/dark_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(DayAdapter());
  final boxManager = BoxManager();
  final prebuiltExercises = PrebuiltExercises();

  // Create a Future that represents async initialization tasks
  final Future<List> initializationFuture = Future.wait([
    boxManager.initialize(),
    prebuiltExercises.initialize(),
  ]);

  runApp(
    ChangeNotifierProvider<PrebuiltExercises>(
      create: (_) => prebuiltExercises,
      child: ChangeNotifierProvider<BoxManager>(
        create: (_) => boxManager,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
            future: initializationFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading screen while waiting
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: darkBackground(),
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                // Handle initialization errors here
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    body: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ),
                );
              } else {
                // Initialization is complete, show main app
                return const MyApp();
              }
            },
          ),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
