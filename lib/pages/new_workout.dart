import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/build_workout.dart';
import 'package:progressive_overload/theme/dark_theme.dart';

class NewWorkout extends StatefulWidget {
  const NewWorkout({super.key});

  @override
  State<NewWorkout> createState() => _NewWorkoutState();
}

class _NewWorkoutState extends State<NewWorkout> {
  String selectedOption = 'Push Pull Legs';
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkBackground(),
      appBar: AppBar(
        title: const Text('New Workout'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter Name Of Workout:',
              style: Font(size: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Name your workout',
                  hintStyle: const TextStyle(color: Colors.white),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800]!),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Text(
              'Choose a split:',
              style: Font(size: 20),
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
                items: <String>['Push Pull Legs', 'Arnold', 'Custom']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: BlurryButton(
                  width: 200,
                  height: 100,
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => BuildWorkout(title: _nameController.text, split: selectedOption,)));
                  },
                  child: Text(
                    "Confirm",
                    style: Font(),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
