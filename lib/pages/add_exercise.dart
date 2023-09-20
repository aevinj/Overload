import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progressive_overload/classes/exercise.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/capitalise.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/theme/dark_theme.dart';

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
          backgroundColor: Colors.transparent,
          title: Text(
            "New exercise",
            style: Font(),
          )),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        BlurryButton(
            width: 200,
            height: 200,
            onPressed: () {},
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
        const SizedBox(
          height: 30,
        ),
        Row(children: [
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Custom exercise:",
                style: Font(size: 22),
              ))
        ]),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            TextField(
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
            const SizedBox(
              height: 30,
            ),
            TextField(
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
            const SizedBox(
              height: 30,
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
        const SizedBox(
          height: 25,
        ),
        BlurryButton(
            height: 75,
            width: 150,
            onPressed: () {
              final newExercise = Exercise(
                name: _nameController.text.capitalise(),
                sets: int.tryParse(_setsController.text),
                reps: int.tryParse(_repsController.text),
              );
              Navigator.pop(context, newExercise);
            },
            child: Text(
              "Add",
              style: Font(),
            ))
      ]),
    );
  }
}
