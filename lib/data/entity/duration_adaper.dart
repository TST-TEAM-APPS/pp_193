import 'package:hive/hive.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  int typeId = 99; // or whatever free id you have

  Duration read(BinaryReader reader) {
    return Duration(seconds: reader.read());
  }

  void write(BinaryWriter writer, Duration obj){
    writer.write(obj.inSeconds);
  }
}