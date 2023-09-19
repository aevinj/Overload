import 'package:flutter/material.dart';
import 'package:progressive_overload/classes/day.dart';
import 'package:progressive_overload/classes/exercise.dart';
import 'package:progressive_overload/classes/workout.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/capitalise.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/theme/dark_theme.dart';

class WorkoutViewer extends StatefulWidget {
  final Workout workout;

  const WorkoutViewer({super.key, required this.workout});

  @override
  State<WorkoutViewer> createState() => _WorkoutViewerState();
}

class _WorkoutViewerState extends State<WorkoutViewer> {
  String _selectedDay = "Monday";

  void removeExercise(Exercise exercise) {
    setState(() {
      final selectedDay =
          widget.workout.days.firstWhere((day) => day.dayID == _selectedDay);

      selectedDay.exercises.remove(exercise);

      if (selectedDay.exercises.isEmpty) {
        widget.workout.days.remove(selectedDay);
      }
    });
  }

  void handleOptionChange(String? value) {
    if (value is String) {
      setState(() {
        _selectedDay = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.workout.name.capitalise(),
          style: Font(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
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
                  dropdownColor: Colors.grey[700],
                  focusColor: Colors.purple[900],
                  iconEnabledColor: Colors.purpleAccent[700],
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
            BlurryButton(
              width: 300,
              height: 300,
              onPressed: () {},
              child: ListView.builder(
                itemCount: widget.workout.days.length,
                itemBuilder: (BuildContext context, int index) {
                  Day day = widget.workout.days[index];

                  // Check if the day matches the selected option
                  if (day.dayID == _selectedDay) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: day.exercises.map((Exercise exercise) {
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          key: Key(exercise
                              .name), // Use a unique key for each exercise
                          onDismissed: (direction) {
                            // Remove the exercise from the workout
                            removeExercise(exercise);
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    exercise.name,
                                    style: Font(),
                                  ),
                                  Text(
                                    "${exercise.reps ?? 'N/A'}x${exercise.sets ?? 'N/A'}",
                                    style: Font(
                                        size: 16, color: Colors.grey[600]!),
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
          ],
        ),
      ),
    );
  }
}
