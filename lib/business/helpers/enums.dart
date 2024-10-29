import 'package:hive/hive.dart';

part 'enums.g.dart';

@HiveType(typeId: 19)
enum WeekDay {
  @HiveField(0)
  mon,
  @HiveField(1)
  tue,
  @HiveField(2)
  wed,
  @HiveField(3)
  thu,
  @HiveField(4)
  fri,
  @HiveField(5)
  sat,
  @HiveField(6)
  sun;
}

@HiveType(typeId: 29)
enum Gender {
  @HiveField(0)
  male,
  @HiveField(1)
  female,
}

enum Meal { breakfast, lunch, dinner, snack }

@HiveType(typeId: 90)
enum Segment {
  @HiveField(0)
  done('Done'),
  @HiveField(1)
  upcoming('Upcoming'),
  @HiveField(2)
  pastDue('Past Due'),
  @HiveField(3)
  all('Show all');

  final String label;

  const Segment(this.label);
}

enum SortType {
  desTime('In descending of time'),
  ascTime('In ascending of time'),
  desMood('In descending of mood'),
  ascMood('In ascending of mood');

  final String label;

  const SortType(this.label);
}
