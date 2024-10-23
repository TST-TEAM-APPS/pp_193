import 'package:hive/hive.dart';
import 'package:pp193/business/models/diary.dart';

part 'diary_entity.g.dart';

@HiveType(typeId: 33)
class DiaryEntity extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String note;
  @HiveField(2)
  DateTime date;

  DiaryEntity({required this.title, required this.note, required this.date});

  factory DiaryEntity.fromOriginal(Diary original) => DiaryEntity(
        title: original.title,
        note: original.note,
        date: original.date,
      );
}
