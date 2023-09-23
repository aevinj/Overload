import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progressive_overload/box_manager.dart';
import 'package:progressive_overload/classes/day.dart';
import 'package:progressive_overload/classes/exercise.dart';
import 'package:progressive_overload/classes/workout.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/edit_reps_sets_modal.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/add_exercise.dart';
import 'package:progressive_overload/theme/dark_theme.dart';
import 'package:provider/provider.dart';

class BuildWorkout extends StatefulWidget {
  final String title;
  final String split;

  const BuildWorkout({Key? key, required this.title, required this.split})
      : super(key: key);

  @override
  State<BuildWorkout> createState() => _BuildWorkoutState();
}

class _BuildWorkoutState extends State<BuildWorkout> {
  String _selectedDay = 'Monday';
  late Workout workout;

  void handleOptionChange(String? value) {
    if (value is String) {
      setState(() {
        _selectedDay = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    workout = Workout.empty(name: widget.title, split: widget.split);
  }

  void addExerciseToDay(Exercise newExercise, String dayID) {
    setState(() {
      final day = workout.days.firstWhere(
        (day) => day.dayID == dayID,
        orElse: () {
          // If the day doesn't exist, create a new one
          final newDay = Day(dayID: dayID, exercises: []);
          workout.days.add(newDay);
          return newDay;
        },
      );

      final existingExerciseIndex = day.exercises
          .indexWhere((exercise) => exercise.name == newExercise.name);

      if (existingExerciseIndex != -1) {
        // If an exercise with the same name exists, replace it
        day.exercises[existingExerciseIndex] = newExercise;
      } else {
        // Otherwise, add the new exercise to the day
        day.exercises.add(newExercise);
      }
    });
  }

  void removeExercise(Exercise exercise) {
    setState(() {
      final selectedDay =
          workout.days.firstWhere((day) => day.dayID == _selectedDay);

      selectedDay.exercises.remove(exercise);

      if (selectedDay.exercises.isEmpty) {
        workout.days.remove(selectedDay);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final boxManager = Provider.of<BoxManager>(context);

    return Scaffold(
        backgroundColor: darkBackground(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            widget.title,
            style: Font(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Day:',
                  style: Font(),
                ),
              ),
              SizedBox(
                width: 200,
                child: DropdownButton(
                  dropdownColor: Colors.grey[900],
                  focusColor: Colors.purple[900],
                  iconEnabledColor: Colors.deepPurple,
                  iconSize: 42.0,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                        value: "Monday",
                        child: Text(
                          "Monday",
                          style: Font(size: 20),
                        )),
                    DropdownMenuItem(
                        value: "Tuesday",
                        child: Text(
                          "Tuesday",
                          style: Font(size: 20),
                        )),
                    DropdownMenuItem(
                        value: "Wednesday",
                        child: Text(
                          "Wednesday",
                          style: Font(size: 20),
                        )),
                    DropdownMenuItem(
                        value: "Thursday",
                        child: Text(
                          "Thursday",
                          style: Font(size: 20),
                        )),
                    DropdownMenuItem(
                        value: "Friday",
                        child: Text(
                          "Friday",
                          style: Font(size: 20),
                        )),
                    DropdownMenuItem(
                        value: "Saturday",
                        child: Text(
                          "Saturday",
                          style: Font(size: 20),
                        )),
                    DropdownMenuItem(
                        value: "Sunday",
                        child: Text(
                          "Sunday",
                          style: Font(size: 20),
                        )),
                  ],
                  value: _selectedDay,
                  onChanged: (value) => handleOptionChange(value),
                ),
              ),
            ]),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Selected exercises:",
                  style: Font(),
                ),
                Text(
                  "Reps x Sets",
                  style: Font(size: 20, color: Colors.grey[400]!),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BlurryButton(
              width: 300,
              height: 300,
              onPressed: () {},
              child: workout.days.isEmpty
                  ? Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          const Icon(
                            CupertinoIcons.clear_circled,
                            color: Colors.white,
                            size: 150,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "No Exercises found",
                            style: Font(color: Colors.white),
                          )
                        ]))
                  : !workout.days.any((day) => day.dayID == _selectedDay)
                      ? Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              const Icon(
                                CupertinoIcons.clear_circled,
                                color: Colors.white,
                                size: 150,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                "No Exercises found",
                                style: Font(color: Colors.white),
                              )
                            ]))
                      : ListView.builder(
                          itemCount: workout.days.length,
                          itemBuilder: (BuildContext context, int index) {
                            Day day = workout.days[index];

                            // Check if the day matches the selected option
                            if (day.dayID == _selectedDay) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    day.exercises.map((Exercise exercise) {
                                  return Dismissible(
                                    direction: DismissDirection.endToStart,
                                    key: Key(exercise
                                        .name), // Use a unique key for each exercise
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
                                              "Delete ${exercise.name}?",
                                              style: Font(),
                                            ),
                                            content: Text(
                                              "Are you sure you want to delete ${exercise.name} from ${workout.name}?",
                                              style: Font(size: 16),
                                            ),
                                            actions: [
                                              BlurryButton(
                                                width: 100,
                                                height: 50,
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
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
                                                  Navigator.of(context)
                                                      .pop(true);
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
                                    onDismissed: (direction) {
                                      HapticFeedback.mediumImpact();
                                      removeExercise(exercise);
                                    },
                                    background: Container(
                                      color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 36.0,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              exercise.name,
                                              style: Font(),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                int setCount =
                                                    exercise.sets ?? 0;

                                                int repCount =
                                                    exercise.reps ?? 0;

                                                showModalBottomSheet(
                                                  enableDrag: false,
                                                  backgroundColor:
                                                      Colors.grey[900],
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return ModalSheetContent(
                                                      initialSetCount: setCount,
                                                      onSetCountChanged:
                                                          (newSetCount) {
                                                        setState(() {
                                                          workout.days
                                                              .firstWhere((day) =>
                                                                  day.dayID ==
                                                                  _selectedDay)
                                                              .exercises
                                                              .firstWhere(
                                                                  (ex) =>
                                                                      ex.name ==
                                                                      exercise
                                                                          .name)
                                                              .sets = newSetCount;
                                                        });
                                                      },
                                                      initialRepsCount:
                                                          repCount,
                                                      onRepsCountChanged:
                                                          (newRepCount) {
                                                        setState(() {
                                                          workout.days
                                                              .firstWhere((day) =>
                                                                  day.dayID ==
                                                                  _selectedDay)
                                                              .exercises
                                                              .firstWhere(
                                                                  (ex) =>
                                                                      ex.name ==
                                                                      exercise
                                                                          .name)
                                                              .reps = newRepCount;
                                                        });
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text(
                                                //TODO: instead of "" replace with duration
                                                exercise.reps == null ||
                                                        exercise.sets == null
                                                    ? "0x0"
                                                    : "${exercise.reps}x${exercise.sets}",
                                                style: Font(
                                                    size: 16,
                                                    color: Colors.grey[600]!),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlurryButton(
                  width: 150,
                  height: 100,
                  onPressed: () async {
                    final Exercise? newExercise = await Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const AddExercise()),
                    );

                    if (newExercise != null) {
                      addExerciseToDay(newExercise, _selectedDay);
                    }
                  },
                  child: Flexible(
                    child: Text(
                      "Add more",
                      style: Font(),
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                BlurryButton(
                    width: 150,
                    height: 100,
                    onPressed: () async {
                      await boxManager.addWorkout(workout);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    child: Flexible(
                      child: Text(
                        "Save & exit",
                        style: Font(),
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            )
          ]),
        ));
  }
}
