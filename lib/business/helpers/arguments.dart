import 'package:pp193/presentation/pages/main/controllers/main_controller.dart';

class MeditationViewArgs {
  bool isFirstJoin;

  MeditationViewArgs({required this.isFirstJoin});
}

class AddDiaryViewArgs {
  final MainController controller;

  AddDiaryViewArgs({required this.controller});
}