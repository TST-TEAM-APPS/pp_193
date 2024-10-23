import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:pp193/business/models/meditation.dart';
import 'package:pp193/data/repositories/database_service.dart';

class MeditationController extends ValueNotifier<MeditationControllerState> {
  MeditationController({required this.duration}) : super(MeditationControllerState.initial()) {
    _init();
  }

  final _database = GetIt.instance.get<DatabaseService>();
  final Duration duration;

  Timer? timer;
  Timer? globalTimer;

  void _init() {
    value = value.copyWith(duration: duration);
    _start();
  }

  void _start() {
    globalTimer = Timer(value.duration, _finish);
    value = value.copyWith(inProgress: true, needNotification: false);
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) => _timerHandle());
  }

  void _timerHandle() {
    var nextSec = value.passedSec + 1;
    if (nextSec % 60 == 0) {
      value = value.copyWith(passedMin: value.passedMin + 1, passedSec: 0);
    } else {
      value = value.copyWith(passedSec: value.passedSec + 1);
    }
  }

  void resume() {
    value = value.copyWith(inProgress: true);
    var seconds = duration.inSeconds % 60 - value.passedSec;
    var minutes = duration.inMinutes - value.passedMin;
    globalTimer = Timer(Duration(minutes: minutes, seconds: seconds), _finish);
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timers) => _timerHandle());
  }

  void pause() {
    value = value.copyWith(inProgress: false);
    timer?.cancel();
    timer = null;
    globalTimer?.cancel();
    globalTimer = null;
  }

  void reset() {
    value = value.copyWith(inProgress: false, passedSec: 0, passedMin: 0,  needNotification: false);
    timer?.cancel();
    timer = null;
    globalTimer?.cancel();
    globalTimer = null;
    value = value.copyWith(inProgress: true);
    globalTimer = Timer(value.duration, _finish);
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timers) => _timerHandle());
  }

  void _finish() {
    timer?.cancel();
    globalTimer?.cancel();
    timer = null;
    globalTimer = null;
    value = value.copyWith(inProgress: false, needNotification: true);
  }

  Future<void> leave(int mood) async {
    final overMeditation = Meditation(mood: mood, duration: value.duration);
    await _database.addMeditation(overMeditation);
  }

  void refresh() => _init();
}

class MeditationControllerState {
  final Duration duration;
  final int passedSec;
  final int passedMin;
  final bool inProgress;
  final bool needNotification;

  const MeditationControllerState({
    required this.duration,
    required this.passedSec,
    required this.passedMin,
    required this.inProgress,
    required this.needNotification,
  });

  factory MeditationControllerState.initial() => const MeditationControllerState(
        duration: Duration(),
        passedSec: 0,
        passedMin: 0,
        inProgress: false,
        needNotification: false,
      );

  MeditationControllerState copyWith({
    Duration? duration,
    int? passedSec,
    int? passedMin,
    bool? inProgress,
    bool? needNotification,
  }) =>
      MeditationControllerState(
        duration: duration ?? this.duration,
        passedSec: passedSec ?? this.passedSec,
        passedMin: passedMin ?? this.passedMin,
        inProgress: inProgress ?? this.inProgress,
        needNotification: needNotification ?? this.needNotification,
      );
}
