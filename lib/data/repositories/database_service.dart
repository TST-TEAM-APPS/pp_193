import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pp193/business/models/diary.dart';
import 'package:pp193/business/models/meditation.dart';
import 'package:pp193/data/entity/diary_entity.dart';
import 'package:pp193/data/entity/duration_adaper.dart';
import 'package:pp193/data/entity/meditation_entity.dart';

class DatabaseService {
  late final Box<dynamic> _common;
  late final Box<MeditationEntity> _meditations;
  late final Box<DiaryEntity> _diary;

  Future<DatabaseService> init() async {
    await Hive.initFlutter();
    final appDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);

    Hive.registerAdapter(MeditationEntityAdapter());
    Hive.registerAdapter(DiaryEntityAdapter());
    Hive.registerAdapter(DurationAdapter());

    _common = await Hive.openBox('_common');
    _meditations = await Hive.openBox('_meditations');
    _diary = await Hive.openBox('_diary');

    return this;
  }

  //MEDITATIONS
  Future<void> addMeditation(Meditation meditation) async =>
      await _meditations.add(MeditationEntity.fromOriginal(meditation));
  Future<void> deleteMeditation(int index) async => _meditations.deleteAt(index);
  List<Meditation> get meditations =>
      _meditations.values.map((e) => Meditation.fromEntity(e)).toList();

  //DIARY
  Future<void> addDiary(Diary diary) async =>
      await _diary.add(DiaryEntity.fromOriginal(diary));
  Future<void> deleteDiary(int index) async => _diary.deleteAt(index);
  List<Diary> get diary =>
      _diary.values.map((e) => Diary.fromEntity(e)).toList();

  //COMMON
  void put(String key, dynamic value) => _common.put(key, value);
  dynamic get(String key) => _common.get(key);
}
