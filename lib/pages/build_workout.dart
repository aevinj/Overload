import 'package:flutter/material.dart';
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
        body: Row(children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Day:',
              style: Font(size: 20),
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
        ]));
  }
}
