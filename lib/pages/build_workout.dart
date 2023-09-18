import 'package:flutter/material.dart';
import 'package:progressive_overload/classes/day.dart';
import 'package:progressive_overload/classes/exercise.dart';
import 'package:progressive_overload/classes/workout.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/theme/dark_theme.dart';

class BuildWorkout extends StatefulWidget {
  final String title;
  final String split;

  BuildWorkout({Key? key, String? title, required this.split})
      : title = title?.isEmpty == true ? 'New workout' : title!,
        super(key: key);

  @override
  State<BuildWorkout> createState() => _BuildWorkoutState();
}

class _BuildWorkoutState extends State<BuildWorkout> {
  String selectedOption = 'Monday';
  late Workout workout;

  @override
  void initState() {
    super.initState();
    workout = tempWorkouts();
  }

  Workout tempWorkouts() {
    List<Exercise> ex = [];
    Exercise e =
        Exercise(name: "Push ups", sets: 3, reps: 8, duration: "1 minute");
    ex.add(e);
    Day d = Day(dayID: "Monday", exercises: ex);
    List<Day> days = [d];
    return Workout(name: widget.title, days: days);
  }

  @override
  Widget build(BuildContext context) {
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
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Day:',
                  style: Font(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: DropdownButton<String>(
                  dropdownColor: Colors.grey[900],
                  style: const TextStyle(color: Colors.white),
                  value: selectedOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption = newValue!;
                    });
                  },
                  items: <String>[
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ]),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Text(
                  "Selected workouts:",
                  style: Font(),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BlurryButton(
              width: 300,
              height: 300,
              onPressed: () {},
              child: ListView.builder(
                itemCount: workout
                    .days.length, // Use the number of days in the workout
                itemBuilder: (BuildContext context, int index) {
                  Day day = workout.days[index];

                  // Check if the day matches the selected option
                  if (day.dayID == selectedOption) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: day.exercises.map((Exercise exercise) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Exercise: ${exercise.name}", style: Font()),
                            Text("Sets: ${exercise.sets ?? 'N/A'}",
                                style: Font()),
                            Text("Reps: ${exercise.reps ?? 'N/A'}",
                                style: Font()),
                            const Divider(
                                color: Colors
                                    .white), // Add a divider between exercises
                          ],
                        );
                      }).toList(),
                    );
                  } else {
                    return const SizedBox
                        .shrink(); // Return an empty SizedBox if the day doesn't match
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
                    onPressed: () {},
                    child: Flexible(
                      child: Text(
                        "Add more",
                        style: Font(),
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                      ),
                    )),
                BlurryButton(
                    width: 150,
                    height: 100,
                    onPressed: () {},
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
