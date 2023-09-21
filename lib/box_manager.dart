import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:progressive_overload/classes/exercise.dart';
import 'package:progressive_overload/classes/workout.dart';

class BoxManager extends ChangeNotifier {
  late Box<Workout> box;

  BoxManager();

   Future<void> initialize() async {
    await _openBox();
  }

  Future<void> _openBox() async {
    await Hive.openBox<Workout>("workouts");
    box = Hive.box<Workout>("workouts");
    notifyListeners();
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
    newWorkout.days[_convertDayToDayIndex(day)].exercises.remove(exercise);
    box.putAt(workoutIndex, newWorkout);
    notifyListeners();
  }

  void deleteDay(int workoutIndex, String day) {
    var newWorkout = box.getAt(workoutIndex)!;
    newWorkout.days.removeAt(_convertDayToDayIndex(day));
    box.putAt(workoutIndex, newWorkout);
    notifyListeners();
  }

  int _convertDayToDayIndex(String day) {
    if (day == "Monday") {
      return 0;
    } else if (day == "Tuesday") {
      return 1;
    } else if (day == "Wednesday") {
      return 2;
    } else if (day == "Thursday") {
      return 3;
    } else if (day == "Friday") {
      return 4;
    } else if (day == "Saturday") {
      return 5;
    } else if (day == "Sunday") {
      return 6;
    }
    return -1;
  }
}
