import 'package:hive/hive.dart';
import 'package:progressive_overload/classes/day.dart';

part 'workout.g.dart';

@HiveType(typeId: 3)
class Workout {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<Day> days;

  @HiveField(2)
  String split;

  Workout.empty({required this.name, required this.split}) : days = [];

  Workout({ required this.name, required this.days, required this.split });
}