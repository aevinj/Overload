import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/capitalise.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/build_workout.dart';
import 'package:progressive_overload/theme/dark_theme.dart';
import 'package:progressive_overload/util/device_specific.dart';

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
        leadingWidth: 20,
        iconTheme: const IconThemeData(size: 30, color: Colors.white),
        title: Row(children: [
          const Spacer(),
          Text('New Workout', style: Font(size: 30),),
          const Spacer(),
          const SizedBox(
            width: 20,
          )
        ]),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'Enter Name Of Workout:',
              style: Font(size: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'New workout',
                hintStyle: TextStyle(color: Colors.grey[600]),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose a split:',
                  style: Font(size: 20),
                ),
                DropdownButton<String>(
                  dropdownColor: Colors.grey[900],
                  focusColor: Colors.purple[900],
                  iconEnabledColor: Colors.deepPurple,
                  iconSize: 42.0,
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
                      child: Text(
                        value,
                        style: Font(size: 20),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: BlurryButton(
                  width: widthOfCurrentDevice(context) * 0.5,
                  height: heightOfCurrentDevice(context) * 0.15,
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => BuildWorkout(
                                  title: _nameController.text.isEmpty
                                      ? "New workout"
                                      : _nameController.text.capitalise(),
                                  split: selectedOption,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Next",
                        style: Font(),
                      ),
                      const SizedBox(width: 10,),
                      const Icon(CupertinoIcons.arrow_right,
                      color: Colors.white,
                      size: 30,)
                    ],
                  )),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
