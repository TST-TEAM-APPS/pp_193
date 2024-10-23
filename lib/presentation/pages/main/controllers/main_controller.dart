import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:pp193/business/models/diary.dart';
import 'package:pp193/business/models/meditation.dart';
import 'package:pp193/data/repositories/database_service.dart';

class MainController extends ValueNotifier<MainControllerState> {
  MainController() : super(MainControllerState.initial()) {
    _init();
  }

  final _database = GetIt.instance.get<DatabaseService>();


  void _init() {
    final meditations = _database.meditations;
    final diary = _database.diary;
    value = value.copyWith(meditations: meditations, diary: diary);
  }

  Future<void> addDiary(Diary diary) async {
    await _database.addDiary(diary);
    refresh();
  }

  void refresh() => _init();
}

class MainControllerState {
  final List<Meditation> meditations;
  final List<Diary> diary;

  const MainControllerState({
    required this.meditations,
    required this.diary,
  });

  factory MainControllerState.initial() => const MainControllerState(
    meditations: [],
    diary: [],
  );

  MainControllerState copyWith({
    List<Meditation>? meditations,
    List<Diary>? diary,
  }) =>
      MainControllerState(
        meditations: meditations ?? this.meditations,
        diary: diary ?? this.diary,
      );
}
