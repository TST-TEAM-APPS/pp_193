import 'package:equatable/equatable.dart';
import 'package:pp193/data/entity/meditation_entity.dart';

class Meditation extends Equatable {
  int mood;
  Duration duration;

  Meditation({required this.mood, required this.duration});

  factory Meditation.fromEntity(MeditationEntity entity) => Meditation(
        mood: entity.mood,
        duration: entity.duration,
      );

  int compareTo(Meditation other) {
    return mood.compareTo(other.mood);
  }

  @override
  List<Object?> get props => [mood, duration];
}
