import 'package:hive/hive.dart';
import 'package:progressive_overload/classes/exercise.dart';

part 'day.g.dart';

@HiveType(typeId: 2)
class Day {
  @HiveField(0)
  String dayID;

  @HiveField(1)
  List<Exercise> exercises;

  Day({ required this.dayID, required this.exercises });
}