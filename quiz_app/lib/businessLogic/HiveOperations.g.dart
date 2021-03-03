// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HiveOperations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final int typeId = 1;

  @override
  Person read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Person()
      ..name = fields[0] as String
      ..mathematics = (fields[1] as Map)?.cast<dynamic, dynamic>()
      ..literature = (fields[2] as Map)?.cast<dynamic, dynamic>()
      ..chemistry = (fields[3] as Map)?.cast<dynamic, dynamic>()
      ..crs = (fields[4] as Map)?.cast<dynamic, dynamic>()
      ..government = (fields[5] as Map)?.cast<dynamic, dynamic>()
      ..biology = (fields[6] as Map)?.cast<dynamic, dynamic>()
      ..physics = (fields[7] as Map)?.cast<dynamic, dynamic>();
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.mathematics)
      ..writeByte(2)
      ..write(obj.literature)
      ..writeByte(3)
      ..write(obj.chemistry)
      ..writeByte(4)
      ..write(obj.crs)
      ..writeByte(5)
      ..write(obj.government)
      ..writeByte(6)
      ..write(obj.biology)
      ..writeByte(7)
      ..write(obj.physics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
