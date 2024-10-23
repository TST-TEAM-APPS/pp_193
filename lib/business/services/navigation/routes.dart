import 'package:flutter/cupertino.dart';
import 'package:pp193/business/helpers/arguments.dart';
import 'package:pp193/business/services/navigation/route_names.dart';
import 'package:pp193/presentation/pages/agreement_view.dart';
import 'package:pp193/presentation/pages/diary/pages/add_diary_view.dart';
import 'package:pp193/presentation/pages/main/pages/main_view.dart';
import 'package:pp193/presentation/pages/meditation/pages/meditation_view.dart';
import 'package:pp193/presentation/pages/onboarding_view.dart';
import 'package:pp193/presentation/pages/privacy_view.dart';
import 'package:pp193/presentation/pages/quiz/pages/quiz_view.dart';
import 'package:pp193/presentation/pages/settings_view.dart';
import 'package:pp193/presentation/pages/splash_view.dart';

typedef ScreenBuilding = Widget Function(BuildContext context);

class Routes {
  static Map<String, ScreenBuilding> get(BuildContext context) {
    return {
      RouteNames.onboarding: (context) => const OnboardingView(),
      RouteNames.splash: (context) => const SplashView(),

      RouteNames.quiz: (context) => const QuizView(),
      RouteNames.meditation: (context) {
        final arguments = ModalRoute.of(context)!.settings.arguments as MeditationViewArgs;
        return MeditationView(arguments: arguments);
      },
      RouteNames.addDiary: (context) {
        final arguments = ModalRoute.of(context)!.settings.arguments as AddDiaryViewArgs;
        return AddDiaryView(arguments: arguments);
      },
      RouteNames.main: (context) => const MainView(),
      RouteNames.settings: (context) => const SettingsView(),
      RouteNames.privacy: (context) => const PrivacyView(),
      RouteNames.agreement: (context) => AgreementView.create(context),
    };
  }
}
