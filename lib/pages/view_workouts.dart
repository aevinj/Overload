import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:progressive_overload/classes/workout.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/theme/dark_theme.dart';

class ViewWorkoutsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("View Workouts"),
      ),
      body: FutureBuilder(
        future: Hive.openBox<Workout>("workouts"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: Font(),
                ),
              );
            } else {
              final box = Hive.box<Workout>("workouts");
              final workouts = box.values.toList();

              if (workouts.isEmpty) {
                return const Center(
                  child: Text("No workouts available."),
                );
              }

              return Center(
                child: BlurryButton(
                  width: 350,
                  height: 600,
                  onPressed: () {},
                  child: ListView.builder(
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                    final workout = workouts[index];
                    return ListTile(
                      title: Text("${workout.name} - ${workout.days.length} day(s) split", style: Font(size: 20),),
                      onTap: () {},
                    );
                  },
                  ),
                ),
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
