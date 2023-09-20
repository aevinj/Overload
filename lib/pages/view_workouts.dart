import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:progressive_overload/classes/workout.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/workout.dart';
import 'package:progressive_overload/theme/dark_theme.dart';

class ViewWorkoutsPage extends StatelessWidget {
  const ViewWorkoutsPage({super.key});

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
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.clear_circled,
                          color: Colors.white,
                          size: 200,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "No workouts found",
                          style: Font(color: Colors.white),
                        )
                      ]),
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
                      return Column(
                        children: [
                          Dismissible(
                            direction: DismissDirection.endToStart,
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              final box = Hive.box<Workout>("workouts");
                              box.deleteAt(index);
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20.0),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 36.0,
                              ),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "${workout.name} - ${workout.days.length} day(s) split",
                                    style: Font(size: 20),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => WorkoutViewer(
                                          workout: workout,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const Divider(
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
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
