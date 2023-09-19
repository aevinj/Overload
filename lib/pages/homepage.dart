import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload/classes/workout.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/new_workout.dart';
import 'package:progressive_overload/pages/view_workouts.dart';
import 'package:progressive_overload/theme/dark_theme.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: Font()),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: darkBackground(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          BlurryButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => ViewWorkoutsPage()),
              );
            },
            width: 250,
            height: 150,
            child: Text(
              "View Workouts",
              style: Font(),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          BlurryButton(
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => const NewWorkout()));
            },
            width: 250,
            height: 150,
            child: Text(
              "New workout",
              style: Font(),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          BlurryButton(
            onPressed: () async {
              final box = await Hive.openBox<Workout>(
                  "workouts");
              await box.clear();

              await box.close();
              print("done");
            },
            width: 250,
            height: 150,
            child: Text(
              "Delete all workouts",
              style: Font(),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    );
  }
}
