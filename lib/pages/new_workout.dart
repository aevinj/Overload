import 'package:flutter/material.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/theme/dark_theme.dart';

class NewWorkout extends StatefulWidget {
  const NewWorkout({super.key});

  @override
  State<NewWorkout> createState() => _NewWorkoutState();
}

class _NewWorkoutState extends State<NewWorkout> {
  String selectedOption = 'Option 1';
  final TextEditingController _daysController = TextEditingController();

  @override
  void dispose() {
    _daysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const Text(
              'Enter Number of Days In Cycle:',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _daysController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter days',
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Select an Option:',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            DropdownButton<String>(
              dropdownColor: Colors.grey[900],
              style: const TextStyle(color: Colors.white),
              value: selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
              items: <String>['Option 1', 'Option 2', 'Option 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: BlurryButton(
                  width: 200,
                  height: 100,
                  onPressed: () {print(_daysController.text);},
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
