// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialty.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpecialtyAdapter extends TypeAdapter<Specialty> {
  @override
  final int typeId = 2;

  @override
  Specialty read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Specialty(
      name: fields[0] as String,
      priority: fields[1] as int,
      fees: fields[2] as int,
      duration: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Specialty obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.priority)
      ..writeByte(2)
      ..write(obj.fees)
      ..writeByte(3)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecialtyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
