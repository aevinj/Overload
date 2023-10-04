import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:progressive_overload/classes/day.dart';
import 'package:progressive_overload/classes/exercise.dart';
import 'package:progressive_overload/classes/user.dart';
import 'package:progressive_overload/classes/workout.dart';

class BoxManager extends ChangeNotifier {
  late Box<Workout> box;
  late Box<User> userBox;

  BoxManager();

  Future<bool> showOnboarding() async {
    if (await Hive.boxExists("user")) {
      await openUserBox();
      return false;
    } else {
      return true;
    }
  }

  Future<void> deleteUserBox() async {
    await Hive.deleteBoxFromDisk("user");
  }

  Future<void> initialize() async {
    await _openBox();
  }

  Future<void> _openBox() async {
    try {
      await Hive.openBox<Workout>("workouts");
    } catch (e) {
      Hive.close();
      await Hive.openBox<Workout>("workouts");
    }
    box = Hive.box<Workout>("workouts");
    notifyListeners();
  }

  Future<void> openUserBox() async {
    try {
      await Hive.openBox<User>("user");
    } catch (e) {
      Hive.close();
      await Hive.openBox<User>("user");
    }
    userBox = Hive.box<User>("user");
    notifyListeners();
  }

  String getUserName() {
    return userBox.getAt(0)?.name ?? "User";
  }

  Future<void> saveUser(User user) async {
    await userBox.add(user);
  }

  List<Workout> getWorkoutsAsList() {
    return box.values.toList();
  }

  Future<void> deleteAtIndex(int index) async {
    await box.deleteAt(index);
    notifyListeners();
  }

  void deleteExercise(Exercise exercise, int workoutIndex, String day) {
    var newWorkout = box.getAt(workoutIndex)!;
    newWorkout.days
        .firstWhere((d) => d.dayID == day)
        .exercises
        .remove(exercise);
    box.putAt(workoutIndex, newWorkout);
    notifyListeners();
  }

  void deleteDay(int workoutIndex, String day) {
    var newWorkout = box.getAt(workoutIndex)!;
    final dayToRemove = newWorkout.days.firstWhere((d) => d.dayID == day);
    newWorkout.days.remove(dayToRemove);
    box.putAt(workoutIndex, newWorkout);
    notifyListeners();
  }

  void modifySet(int workoutIndex, String day, String exerciseName, int value) {
    var newWorkout = box.getAt(workoutIndex)!;
    newWorkout.days
        .firstWhere((d) => d.dayID == day)
        .exercises
        .firstWhere((ex) => ex.name == exerciseName)
        .sets = value;
    box.putAt(workoutIndex, newWorkout);
    notifyListeners();
  }

  void modifyRep(int workoutIndex, String day, String exerciseName, int value) {
    var newWorkout = box.getAt(workoutIndex)!;
    newWorkout.days
        .firstWhere((d) => d.dayID == day)
        .exercises
        .firstWhere((ex) => ex.name == exerciseName)
        .reps = value;
    box.putAt(workoutIndex, newWorkout);
    notifyListeners();
  }

  void addExerciseToWorkout(int workoutIndex, String day, Exercise exercise) {
    var newWorkout = box.getAt(workoutIndex)!;

    if (!newWorkout.days.any((d) => d.dayID == day)) {
      final newDay = Day(dayID: day, exercises: []);
      newWorkout.days.add(newDay);
    }

    final existingExerciseIndex = newWorkout.days
        .firstWhere((d) => d.dayID == day)
        .exercises
        .indexWhere((ex) => ex.name == exercise.name);

    if (existingExerciseIndex != -1) {
      // If an exercise with the same name exists, replace it
      newWorkout.days
          .firstWhere((d) => d.dayID == day)
          .exercises[existingExerciseIndex] = exercise;
    } else {
      // Otherwise, add the new exercise to the day
      newWorkout.days.firstWhere((d) => d.dayID == day).exercises.add(exercise);
    }

    box.putAt(workoutIndex, newWorkout);
    notifyListeners();
  }

  Future<void> addWorkout(Workout workout) async {
    await box.add(workout);
    notifyListeners();
  }

  bool isDayEmpty(int workoutIndex, String day) {
    return !box.getAt(workoutIndex)!.days.any((d) => d.dayID == day);
  }

  Future<void> clearBox() async {
    await box.clear();
    notifyListeners();
  }

  bool dirtyBox() {
    for (final workout in box.values) {
      if (workout.days.isEmpty) {
        return true;
      }
    }
    return false;
  }

  void cleanBox() {
    List<int> keysToRemove = [];

    for (var i = 0; i < box.length; i++) {
      final workout = box.getAt(i) as Workout;
      if (workout.days.isEmpty) {
        keysToRemove.add(i);
      }
    }

    if (keysToRemove.isNotEmpty) {
      for (var key in keysToRemove) {
        box.deleteAt(key);
      }
    }

    notifyListeners();
  }
}
