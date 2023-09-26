import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progressive_overload/classes/exercise.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/capitalise.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/exercise_chooser.dart';
import 'package:progressive_overload/theme/dark_theme.dart';
import 'package:progressive_overload/util/device_specific.dart';

class AddExercise extends StatefulWidget {
  const AddExercise({super.key});

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _repsController.dispose();
    _setsController.dispose();
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
          Text(
            "Create an exercise",
            style: Font(size: 30),
          ),
          const Spacer(),
          const SizedBox(
            width: 20,
          )
        ]),
        backgroundColor: Colors.transparent,
      ),
      body: Column(children: [
        const Spacer(),
        BlurryButton(
            width: widthOfCurrentDevice(context) * 0.4,
            height: heightOfCurrentDevice(context) * 0.25,
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const ExerciseChooser()),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                  size: 75,
                ),
                Text(
                  "Choose an exercise",
                  style: Font(),
                  textAlign: TextAlign.center,
                )
              ],
            )),
        const Spacer(),
        Row(children: [
          Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Custom exercise:",
                style: Font(size: 22),
              ))
        ]),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Exercise name',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800]!),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _repsController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: 'Reps',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800]!),
                  ),
                ),
              ),
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _setsController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: 'Sets',
                hintStyle: TextStyle(color: Colors.grey[600]),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
              ),
            ),
          ]),
        ),
        const Spacer(),
        BlurryButton(
            height: heightOfCurrentDevice(context) * 0.125,
            width: widthOfCurrentDevice(context) * 0.8,
            onPressed: () {
              if (_nameController.text.isNotEmpty) {
                final newExercise = Exercise(
                  name: _nameController.text.capitalise(),
                  sets: int.tryParse(_setsController.text),
                  reps: int.tryParse(_repsController.text),
                );
                Navigator.pop(context, newExercise);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Name of the exercise must be supplied',
                      style: Font(size: 16),
                    ),
                    duration: const Duration(milliseconds: 1250),
                    showCloseIcon: true,
                    closeIconColor: Colors.red,
                  ),
                );
              }
            },
            child: Text(
              "Add",
              style: Font(),
            )),
        const Spacer(),
      ]),
    );
  }
}
