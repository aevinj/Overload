import 'package:flutter/material.dart';
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
  String selectedOption = '1';
  List<List<String>> workouts = [
    ['bench', 'squat', 'shrugs', 'push ups', 'pull ups', 'skullcrushers'],
    ['bench', 'squat'],
    ['shrugs', 'push ups'],
    ['pull ups', 'skullcrushers'],
    [],
    [],
    []
  ];

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
        body: Column(children: [
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
                items: <String>['1', '2', '3', '4', '5', '6', '7']
                    .map<DropdownMenuItem<String>>((String value) {
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
              height: 200,
              onPressed: () {},
              child: ListView(
                children: workouts[int.parse(selectedOption) -1]
                    .expand((item) => [
                          Text(item, style: Font(size: 20)),
                          Divider(color: Colors.grey[400]),
                        ])
                    .toList(),
              )),
          const SizedBox(
            height: 30,
          ),
          BlurryButton(
              width: 200,
              height: 100,
              onPressed: () {},
              child: Text(
                "Add more",
                style: Font(),
              ))
        ]));
  }
}
