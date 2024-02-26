import 'package:hive/hive.dart';

part 'specialty.g.dart';

@HiveType(typeId: 2)
class Specialty {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int priority;
  @HiveField(2)
  final int fees;
  @HiveField(3)
  final int duration;

  Specialty(
      {required this.name,
      required this.priority,
      required this.fees,
      required this.duration});
}
