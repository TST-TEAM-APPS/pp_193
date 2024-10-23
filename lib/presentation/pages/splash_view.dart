import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pp193/business/helpers/dialog_helper.dart';
import 'package:pp193/business/services/navigation/route_names.dart';
import 'package:pp193/business/services/config_service.dart';
import 'package:pp193/data/repositories/database_keys.dart';
import 'package:pp193/data/repositories/database_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _databaseService = GetIt.instance<DatabaseService>();
  final _configService = GetIt.instance<ConfigService>();
  final _connectivity = Connectivity();

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    await _initConnectivity(
      () async => await DialogHelper.showNoInternetDialog(context),
    );
    
    _navigate();
  }

  Future<void> _initConnectivity(Future<void> Function() callback) async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        await callback.call();
        return;
      }
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }
  }

  Future<void> _navigate() async {
    final seenAppReview =
        _databaseService.get(DatabaseKeys.seenAppReview) ?? false;
    FlutterNativeSplash.remove();
    if (!seenAppReview) {
      InAppReview.instance.requestReview();
      _databaseService.put(DatabaseKeys.seenAppReview, true);
    }

    if (_configService.useMock) {
      final seenOnboarding =
          _databaseService.get(DatabaseKeys.seenOnboarding) ?? false;
      if (!seenOnboarding) {
        _databaseService.put(DatabaseKeys.seenOnboarding, true);

        Navigator.of(context).pushReplacementNamed(RouteNames.onboarding);
      } else {
        Navigator.of(context).pushReplacementNamed(RouteNames.main);
      }
    } else {
      Navigator.of(context).pushReplacementNamed(RouteNames.privacy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}
