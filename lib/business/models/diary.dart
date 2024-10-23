import 'package:equatable/equatable.dart';
import 'package:pp193/data/entity/diary_entity.dart';

class Diary extends Equatable {
  String title;
  String note;
  DateTime date;

  Diary({required this.title, required this.note, required this.date});

  factory Diary.fromEntity(DiaryEntity entity) => Diary(
        title: entity.title,
        note: entity.note,
        date: entity.date,
      );

  @override
  List<Object?> get props => [title, note, date];
}
