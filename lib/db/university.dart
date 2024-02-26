import 'package:hive/hive.dart';
import 'package:unimatch/db/specialty.dart';

part 'university.g.dart';

@HiveType(typeId: 1)
class University {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String location;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final int? stars;
  @HiveField(4)
  final List<String>? pros;
  @HiveField(5)
  final List<String>? cons;
  @HiveField(6)
  final List<Specialty>? specialties;

  University(
      {required this.name,
      required this.location,
      this.description,
      required this.stars,
      this.pros,
      this.cons,
      this.specialties});

  University copyWith({
    String? name,
    String? location,
    String? description,
    int? stars,
    List<String>? pros,
    List<String>? cons,
    List<Specialty>? specialties,
  }) {
    return University(
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      stars: stars ?? this.stars,
      pros: pros ?? this.pros,
      cons: cons ?? this.cons,
      specialties: specialties ?? this.specialties,
    );
  }
}
