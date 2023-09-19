import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:progressive_overload/classes/workout.dart';

class ViewWorkoutsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Workouts"),
      ),
      body: FutureBuilder(
        future: Hive.openBox<Workout>(
            "workouts"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              final box = Hive.box<Workout>(
                  "workouts");
              final workouts = box.values.toList();

              if (workouts.isEmpty) {
                return const Center(
                  child: Text("No workouts available."),
                );
              }

              return ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  final workout = workouts[index];
                  return ListTile(
                    title: Text(workout.name),
                    // You can add more details of the workout here
                  );
                },
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
