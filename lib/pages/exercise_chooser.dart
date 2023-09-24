import 'package:flutter/material.dart';
import 'package:progressive_overload/components/exercise_category_cell.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/theme/dark_theme.dart';

class ExerciseChooser extends StatefulWidget {
  const ExerciseChooser({super.key});

  @override
  State<ExerciseChooser> createState() => _ExerciseChooserState();
}

class _ExerciseChooserState extends State<ExerciseChooser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground(),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Choose an exercise",
            style: Font(),
          )),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Text(
                "Upper body:",
                style: Font(size: 26),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ExerciseCategoryCell(
                    categoryName: "Chest", imgPath: "assets/chest.png"),
                SizedBox(
                  width: 20,
                ),
                ExerciseCategoryCell(
                    categoryName: "Abs", imgPath: "assets/abs.png"),
                SizedBox(
                  width: 20,
                ),
                ExerciseCategoryCell(
                    categoryName: "Shoulders", imgPath: "assets/shoulders.png"),
                SizedBox(
                  width: 20,
                ),
                ExerciseCategoryCell(
                    categoryName: "Arms", imgPath: "assets/arms.png"),
                SizedBox(
                  width: 20,
                ),
                ExerciseCategoryCell(
                    categoryName: "Back", imgPath: "assets/back.png"),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Text(
                "Lower body:",
                style: Font(),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ExerciseCategoryCell(
                    categoryName: "Legs", imgPath: "assets/legs.png"),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ]),
      ),
    );
  }
}
