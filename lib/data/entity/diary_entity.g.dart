// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiaryEntityAdapter extends TypeAdapter<DiaryEntity> {
  @override
  final int typeId = 33;

  @override
  DiaryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiaryEntity(
      title: fields[0] as String,
      note: fields[1] as String,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DiaryEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
