import 'package:flutter/material.dart';
import 'package:progressive_overload/components/blurred_button.dart';
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
        child: Column(children: [
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                BlurryButton(
                    height: 200,
                    width: 200,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: const Image(
                            image: AssetImage("assets/chest.png"),
                            width: 150,
                            height: 125,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "Chest",
                          style: Font(),
                        )
                      ],
                    )),
                const SizedBox(
                  width: 20,
                ),
                BlurryButton(
                    height: 200,
                    width: 200,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: const Image(
                            image: AssetImage("assets/abs.png"),
                            width: 150,
                            height: 125,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "Abs",
                          style: Font(),
                        )
                      ],
                    )),
                const SizedBox(
                  width: 20,
                ),
                BlurryButton(
                    height: 200,
                    width: 200,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: const Image(
                            image: AssetImage("assets/chest.png"),
                            width: 150,
                            height: 125,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "Shoulders",
                          style: Font(),
                        )
                      ],
                    )),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
