import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pp193/business/helpers/arguments.dart';
import 'package:pp193/business/helpers/dialog_helper.dart';
import 'package:pp193/business/services/navigation/route_names.dart';
import 'package:pp193/gen/assets.gen.dart';
import 'package:pp193/presentation/pages/meditation/controllers/meditation_controller.dart';
import 'package:pp193/presentation/widgets/app_button.dart';
import 'package:pp193/presentation/widgets/back_button.dart';
import 'package:pp193/presentation/widgets/page_view_wrapper.dart';
import 'package:pp193/presentation/widgets/svg_button.dart';

class MeditationView extends StatefulWidget {
  const MeditationView({super.key, required this.arguments});

  final MeditationViewArgs arguments;

  @override
  State<MeditationView> createState() => _MeditationViewState();
}

class _MeditationViewState extends State<MeditationView> {
  late final PageController _pageController;
  MeditationController? _meditationController;
  var _page = 0;
  var _pages = [];

  //timer
  Duration? timer;

  void _init() {
    _pageController = PageController(initialPage: _page);
    setState(() {
      _pages = [
        TimerSetWidget(onTimerChange: _changeTimer, onStart: _start, onBack: _back),
        ProgressMeditationView(controller: _meditationController)
      ];
    });
  }

  void _refresh() {
    setState(() {
      _pages = [
        TimerSetWidget(
          onTimerChange: _changeTimer,
          onStart: _start,
          onBack: _back,
        ),
        ProgressMeditationView(controller: _meditationController)
      ];
    });
  }

  void _changeTimer(Duration value) {
    setState(() {
      timer = value;
    });
  }

  Future<void> _start() async {
    _meditationController = MeditationController(duration: timer!)
      ..addListener(_notificationHandler);
    _refresh();
    await _pageController.animateToPage(
      _page + 1,
      duration: const Duration(milliseconds: 150),
      curve: Curves.ease,
    );
  }

  void _notificationHandler() {
    if (_meditationController!.value.needNotification) {
      _pushNotification();
    }
  }

  void _pushNotification() {
    DialogHelper.showCustomModalPopup(
      context,
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'How do you feel after meditation?',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: List.generate(
                5,
                (index) => SmileContainer(
                  assetPath: 'assets/images/smile_${index + 1}.png',
                  callback: () => _leave(index),
                ),
              ),
            )
          ],
        ),
      ),
      false,
    );
  }

  Future<void> _leave(int medMood) async {
    await _meditationController!.leave(medMood);
    Navigator.of(context).pushReplacementNamed(RouteNames.main);
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _back() {
    if (widget.arguments.isFirstJoin) {
      Navigator.of(context).pushReplacementNamed(RouteNames.main);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        color: Theme.of(context).colorScheme.background,
        padding: EdgeInsets.symmetric(horizontal: _page == 0 ? 16 : 0),
        child: SafeArea(
          child: ExpandablePageView(
            itemCount: 2,
            itemBuilder: (context, index) {
              return _pages[index];
            },
            controller: _pageController,
            onPageChanged: (int value) {
              setState(() {
                _page = value;
              });
            },
            scrollPhysics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}

class TimerSetWidget extends StatelessWidget {
  const TimerSetWidget({
    super.key,
    required this.onTimerChange,
    required this.onStart,
    required this.onBack,
  });

  final Function(Duration) onTimerChange;
  final VoidCallback onStart;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            AppBackButton(callback: onBack),
            const Spacer(),
            Text('Start meditation',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
            const Spacer(),
            const SizedBox(width: 24),
          ],
        ),
        const SizedBox(height: 27),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF747480).withOpacity(0.08),
          ),
          child: CupertinoTheme(
            data: const CupertinoThemeData(
              brightness: Brightness.dark,
            ),
            child: CupertinoTimerPicker(
              onTimerDurationChanged: onTimerChange,
              backgroundColor: Colors.transparent,
              mode: CupertinoTimerPickerMode.ms,
            ),
          ),
        ),
        const SizedBox(height: 16),
        AppButton(
          label: 'Start',
          callback: onStart,
        ),
      ],
    );
  }
}

class ProgressMeditationView extends StatefulWidget {
  const ProgressMeditationView({super.key, this.controller});

  final MeditationController? controller;

  @override
  State<ProgressMeditationView> createState() => _ProgressMeditationViewState();
}

class _ProgressMeditationViewState extends State<ProgressMeditationView> {
  bool _reminder = false;

  void _switchReminder() {
    setState(() {
      _reminder = !_reminder;
    });
  }

  String formatTimer(int value) {
    if (value < 10) {
      return '0$value';
    } else {
      return value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller!,
      builder: (context, state, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 0, 0, 0.00),
                Color(0xFF6D57FF),
              ],
            ),
            color: Color(0xFF111111),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 7),
              Row(
                children: [
                  TimerButton(
                    callback: _switchReminder,
                    child: Text(
                      'Reminder text',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  const Spacer(),
                  TimerButton(
                    child: Text(
                      'Reset',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    callback: () => widget.controller!.reset(),
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 150),
                curve: Curves.ease,
                child: SizedBox(
                  height: _reminder ? 160 : 0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 23),
                    child: Text(
                      'Bring your attention to your breath. Feel the flow of air entering and leaving your body. Allow yourself to simply be in the present moment, observing each inhale and exhale, without trying to change or control anything.',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4)),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  '${formatTimer(state.passedMin)} : ${formatTimer(state.passedSec)}',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const Spacer(),
              SvgButton(
                svgAsset: state.inProgress ? Assets.vectors.pause : Assets.vectors.play,
                callback: () {
                  state.inProgress ? widget.controller!.pause() : widget.controller!.resume();
                },
              ),
              const SizedBox(height: 63),
              TimerButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.vectors.arrowLeft),
                    const SizedBox(width: 8),
                    Text(
                      'Back to Home',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ],
                ),
                callback: () => Navigator.of(context).pushReplacementNamed(RouteNames.main),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}

class TimerButton extends StatelessWidget {
  const TimerButton({super.key, required this.child, required this.callback});

  final Widget child;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 10,
      onPressed: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF222222),
        ),
        child: child,
      ),
    );
  }
}

class SmileContainer extends StatelessWidget {
  const SmileContainer({super.key, required this.assetPath, required this.callback});

  final String assetPath;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 10,
      onPressed: callback,
      child: SizedBox(
        height: 64,
        width: 64,
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
