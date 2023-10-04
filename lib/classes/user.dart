import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 4)
class User {
  @HiveField(0)
  String name;

  @HiveField(1)
  int? age;

  @HiveField(2)
  int? height;

  @HiveField(3)
  int? weight;

  @HiveField(4)
  int? setLimit;

  User({required this.name, this.age, this.height, this.weight, this.setLimit});
}
