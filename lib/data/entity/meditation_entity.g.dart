// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeditationEntityAdapter extends TypeAdapter<MeditationEntity> {
  @override
  final int typeId = 0;

  @override
  MeditationEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeditationEntity(
      mood: fields[0] as int,
      duration: fields[1] as Duration,
    );
  }

  @override
  void write(BinaryWriter writer, MeditationEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.mood)
      ..writeByte(1)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeditationEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
