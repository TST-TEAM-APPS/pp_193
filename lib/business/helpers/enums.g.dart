// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeekDayAdapter extends TypeAdapter<WeekDay> {
  @override
  final int typeId = 19;

  @override
  WeekDay read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WeekDay.mon;
      case 1:
        return WeekDay.tue;
      case 2:
        return WeekDay.wed;
      case 3:
        return WeekDay.thu;
      case 4:
        return WeekDay.fri;
      case 5:
        return WeekDay.sat;
      case 6:
        return WeekDay.sun;
      default:
        return WeekDay.mon;
    }
  }

  @override
  void write(BinaryWriter writer, WeekDay obj) {
    switch (obj) {
      case WeekDay.mon:
        writer.writeByte(0);
        break;
      case WeekDay.tue:
        writer.writeByte(1);
        break;
      case WeekDay.wed:
        writer.writeByte(2);
        break;
      case WeekDay.thu:
        writer.writeByte(3);
        break;
      case WeekDay.fri:
        writer.writeByte(4);
        break;
      case WeekDay.sat:
        writer.writeByte(5);
        break;
      case WeekDay.sun:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeekDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GenderAdapter extends TypeAdapter<Gender> {
  @override
  final int typeId = 29;

  @override
  Gender read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Gender.male;
      case 1:
        return Gender.female;
      default:
        return Gender.male;
    }
  }

  @override
  void write(BinaryWriter writer, Gender obj) {
    switch (obj) {
      case Gender.male:
        writer.writeByte(0);
        break;
      case Gender.female:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SegmentAdapter extends TypeAdapter<Segment> {
  @override
  final int typeId = 90;

  @override
  Segment read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Segment.done;
      case 1:
        return Segment.upcoming;
      case 2:
        return Segment.pastDue;
      case 3:
        return Segment.all;
      default:
        return Segment.done;
    }
  }

  @override
  void write(BinaryWriter writer, Segment obj) {
    switch (obj) {
      case Segment.done:
        writer.writeByte(0);
        break;
      case Segment.upcoming:
        writer.writeByte(1);
        break;
      case Segment.pastDue:
        writer.writeByte(2);
        break;
      case Segment.all:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SegmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
