import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pp193/business/services/navigation/navigation_observer.dart';
import 'package:pp193/business/services/navigation/route_names.dart';
import 'package:pp193/business/services/navigation/routes.dart';
import 'package:pp193/business/services/config_service.dart';
import 'package:pp193/business/services/service_locator.dart';


// import 'firebase_options.dart';
import 'presentation/themes/app_theme.dart';


Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await _initApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(AppInfo(
    data: await AppInfoData.get(),
    child: const HomeScheduler(),
  ));
}

Future<void> _initApp() async {
  await ServiceLocator.setup();
  addLifecycleHandler();
}

class HomeScheduler extends StatelessWidget {
  const HomeScheduler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation Serenity',
      routes: Routes.get(context),
      initialRoute: RouteNames.splash,
      navigatorObservers: [
        CustomNavigatorObserver(),
      ],
      debugShowCheckedModeBanner: false,
      theme: DefaultThemeGetter.get(),
    );
  }
}

void addLifecycleHandler() {
  WidgetsBinding.instance.addObserver(
    AppLifecycleListener(onDetach: GetIt.instance<ConfigService>().closeClient),
  );
}
