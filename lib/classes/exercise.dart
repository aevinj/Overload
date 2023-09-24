import 'package:hive/hive.dart';

part 'exercise.g.dart';

@HiveType(typeId: 1)
class Exercise {
  @HiveField(0)
  String name;

  @HiveField(1)
  int? sets;
  
  @HiveField(2)
  int? reps;

  @HiveField(3)
  String? duration;

  @HiveField(4)
  List<String>? category;

  Exercise({required this.name, this.sets, this.reps, this.duration, this.category});
}