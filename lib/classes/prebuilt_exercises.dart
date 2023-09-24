import 'package:flutter/cupertino.dart';
import 'package:progressive_overload/classes/exercise.dart';

class PrebuiltExercises extends ChangeNotifier {
  late final List<Exercise> _exercisesList = [];

  PrebuiltExercises();

  Future<void> initialize() async {
    await formExercises();
  }

  Future<void> formExercises() async {
    //chest majors
    _exercisesList.add(
        createNewExercise("Bench", 0, 0, ["Chest", "Shoulders", "Triceps"]));
    _exercisesList.add(createNewExercise(
        "Close-grip Bench", 0, 0, ["Chest", "Shoulders", "Triceps"]));
    _exercisesList.add(
        createNewExercise("Push ups", 0, 0, ["Chest", "Shoulders", "Triceps"]));
    _exercisesList.add(createNewExercise("Cable flyes", 0, 0, ["Chest"]));
    _exercisesList.add(
        createNewExercise("Dips", 0, 0, ["Chest", "Shoulders", "Triceps"]));
    _exercisesList
        .add(createNewExercise("Cable crossover", 0, 0, ["Chest", "shoulder"]));
    _exercisesList.add(createNewExercise(
        "Incline DB press", 0, 0, ["Chest", "Shoulders", "Triceps"]));

    //shoulders majors
    _exercisesList.add(createNewExercise("Lateral raise", 0, 0, ["Shoulder"]));
    _exercisesList.add(
        createNewExercise("Overhead press", 0, 0, ["Shoulder", "Triceps"]));
    _exercisesList
        .add(createNewExercise("Face pull", 0, 0, ["Shoulder", "Back"]));
    _exercisesList
        .add(createNewExercise("Reverse Flyes", 0, 0, ["Shoulder", "Back"]));
    _exercisesList.add(
        createNewExercise("DB press", 0, 0, ["Chest", "Shoulders", "Triceps"]));
    _exercisesList.add(createNewExercise("Frontal raise", 0, 0, ["Shoulder"]));
    _exercisesList
        .add(createNewExercise("High pull", 0, 0, ["Shoulder", "Back"]));

    //back majors
    _exercisesList.add(createNewExercise("Shrugs", 0, 0, ["Back"]));
    _exercisesList.add(createNewExercise(
        "Lat pull down", 0, 0, ["Back", "Shoulders", "Biceps"]));

    //tricep majors
    notifyListeners();
  }

  List<Exercise> getExercisesByCategory(String category) {
    return _exercisesList.where((exercise) {
      return exercise.category!.contains(category);
    }).toList();
  }

  // void formShoulderExercises() {
  //   _shoulderExercises.add(createNewExercise("", 0, 0, ["Chest"]));
  //   _shoulderExercises.add(createNewExercise("", 0, 0, ["Chest"]));
  //   _shoulderExercises.add(createNewExercise("", 0, 0, ["Chest"]));
  //   _shoulderExercises.add(createNewExercise("", 0, 0, ["Chest"]));
  //   _shoulderExercises.add(createNewExercise("", 0, 0, ["Chest"]));
  //   _shoulderExercises.add(createNewExercise("", 0, 0, ["Chest"]));
  //   _shoulderExercises.add(createNewExercise("", 0, 0, ["Chest"]));
  //   _shoulderExercises.add(createNewExercise("", 0, 0, ["Chest"]));
  // }

  Exercise createNewExercise(
      String name, int? reps, int? sets, List<String> category) {
    return Exercise(name: name, reps: reps, sets: sets, category: category);
  }
}
