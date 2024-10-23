import 'package:hive/hive.dart';
import 'package:pp193/business/models/meditation.dart';

part 'meditation_entity.g.dart';

@HiveType(typeId: 0)
class MeditationEntity extends HiveObject {
  @HiveField(0)
  int mood;
  @HiveField(1)
  Duration duration;

  MeditationEntity({required this.mood, required this.duration});

  factory MeditationEntity.fromOriginal(Meditation original) => MeditationEntity(
        mood: original.mood,
        duration: original.duration,
      );
}
