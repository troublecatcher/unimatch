// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UniversityAdapter extends TypeAdapter<University> {
  @override
  final int typeId = 1;

  @override
  University read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return University(
      name: fields[0] as String,
      location: fields[1] as String,
      description: fields[2] as String?,
      stars: fields[3] as int?,
      pros: (fields[4] as List?)?.cast<String>(),
      cons: (fields[5] as List?)?.cast<String>(),
      specialties: (fields[6] as List?)?.cast<Specialty>(),
    );
  }

  @override
  void write(BinaryWriter writer, University obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.location)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.stars)
      ..writeByte(4)
      ..write(obj.pros)
      ..writeByte(5)
      ..write(obj.cons)
      ..writeByte(6)
      ..write(obj.specialties);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UniversityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
