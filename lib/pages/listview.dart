import 'package:flutter/material.dart';
import 'package:progressive_overload/classes/prebuilt_exercises.dart';
import 'package:provider/provider.dart';

class ListofStuff extends StatefulWidget {
  const ListofStuff({super.key});

  @override
  State<ListofStuff> createState() => _ListofStuffState();
}

class _ListofStuffState extends State<ListofStuff> {
  @override
  Widget build(BuildContext context) {
    final CE = Provider.of<PrebuiltExercises>(context);
    final chestExercises = CE.getExercisesByCategory("Chest");
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Chest Exercises"),
      ),
      body: ListView.builder(
        itemCount: chestExercises.length,
        itemBuilder: (context, index) {
          final exercise = chestExercises[index];
          return ListTile(
            title: Text(exercise.name),
            subtitle: Text("Sets: ${exercise.sets}, Reps: ${exercise.reps}"),
          );
        },
      ),
    );
  }
}
