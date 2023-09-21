import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
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
  }
}
