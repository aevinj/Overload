import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              var workouts = box.values.toList();

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
                            confirmDismiss: (direction) async {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    icon: const Icon(
                                      CupertinoIcons.trash,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.grey[900],
                                    title: Text(
                                      "Delete ${workout.name}?",
                                      style: Font(),
                                    ),
                                    content: Text(
                                      "Are you sure you want to delete ${workout.name} permanently?",
                                      style: Font(size: 16),
                                    ),
                                    actions: [
                                      BlurryButton(
                                        width: 100,
                                        height: 50,
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: Font(size: 16),
                                        ),
                                      ),
                                      BlurryButton(
                                        color: Colors.red,
                                        width: 100,
                                        height: 50,
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text(
                                          "Delete",
                                          style: Font(size: 16),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return confirmed ?? false;
                            },
                            onDismissed: (direction) async {
                              HapticFeedback.mediumImpact();
                              final box = Hive.box<Workout>("workouts");
                              await box.deleteAt(index);
                              workouts = box.values.toList();
                              if (workouts.isEmpty){
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
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
                                    "${workout.name} - ${workout.split} - ${workout.days.length} day(s)",
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
