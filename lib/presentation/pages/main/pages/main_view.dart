import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pp193/business/helpers/arguments.dart';
import 'package:pp193/business/helpers/date_helper.dart';
import 'package:pp193/business/models/diary.dart';
import 'package:pp193/business/models/meditation.dart';
import 'package:pp193/business/services/navigation/route_names.dart';
import 'package:pp193/gen/assets.gen.dart';
import 'package:pp193/presentation/pages/main/controllers/main_controller.dart';
import 'package:pp193/presentation/themes/custom_colors.dart';
import 'package:pp193/presentation/widgets/page_view_wrapper.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final PageController _pageController;
  late final MainController _mainController;

  var _tab = 0;
  var _tabs = <Widget>[];

  void _init() {
    _pageController = PageController(initialPage: _tab);
    _mainController = MainController();
    _tabs = [
      MeditationList(meditations: _mainController.value.meditations),
      DiaryList(controller: _mainController),
    ];
  }

  void _refresh() {
    setState(() {
      _tabs = [
        MeditationList(meditations: _mainController.value.meditations),
        DiaryList(controller: _mainController),
      ];
    });
  }

  Future<void> _switchTab(int switched) async {
    await _pageController.animateToPage(
      switched,
      duration: const Duration(milliseconds: 150),
      curve: Curves.ease,
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 16),
          color: Theme.of(context).colorScheme.background,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 10,
                  child: Text(
                    'Settings',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  onPressed: () => Navigator.of(context).pushNamed(RouteNames.settings),
                ),
                const SizedBox(height: 11),
                Container(
                  height: 132,
                  width: MediaQuery.of(context).size.width - 32,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: Assets.images.meditationPerson.image().image, fit: BoxFit.cover)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Start your\nmeditation\ntoday',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          minSize: 10,
                          onPressed: () => Navigator.of(context).pushNamed(RouteNames.meditation,
                              arguments: MeditationViewArgs(isFirstJoin: false)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).colorScheme.primary),
                            child: Text(
                              'Start meditation',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  height: 28,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          minSize: 10,
                          onPressed: () => _switchTab(0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: _tab == 0
                                  ? Theme.of(context)
                                      .extension<CustomColors>()!
                                      .surface3!
                                      .withOpacity(0.08)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Assets.vectors.meditation,
                                    color: _tab == 0
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .extension<CustomColors>()!
                                            .surface3!
                                            .withOpacity(0.4),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Meditation',
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                          color: _tab == 0
                                              ? Theme.of(context).colorScheme.primary
                                              : Theme.of(context)
                                                  .extension<CustomColors>()!
                                                  .surface3!
                                                  .withOpacity(0.4),
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          minSize: 10,
                          onPressed: () => _switchTab(1),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: _tab == 1
                                  ? Theme.of(context)
                                      .extension<CustomColors>()!
                                      .surface3!
                                      .withOpacity(0.08)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Assets.vectors.diary,
                                    color: _tab == 1
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .extension<CustomColors>()!
                                            .surface3!
                                            .withOpacity(0.4),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'My diary',
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                          color: _tab == 1
                                              ? Theme.of(context).colorScheme.primary
                                              : Theme.of(context)
                                                  .extension<CustomColors>()!
                                                  .surface3!
                                                  .withOpacity(0.4),
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                ExpandablePageView(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return _tabs[index];
                  },
                  controller: _pageController,
                  onPageChanged: (int value) {
                    setState(() {
                      _tab = value;
                    });
                  },
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MeditationList extends StatelessWidget {
  const MeditationList({super.key, required this.meditations});

  final List<Meditation> meditations;

  @override
  Widget build(BuildContext context) {
    return meditations.isNotEmpty
        ? Column(
            children: List.generate(
                meditations.length, (index) => MeditationContainer(meditation: meditations[index])),
          )
        : Text(
            'Your don’t have any meditation sessions, to start meditating, tap on the “Start meditation” button.',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).extension<CustomColors>()!.surface3!.withOpacity(0.4)),
          );
  }
}

class MeditationContainer extends StatelessWidget {
  const MeditationContainer({super.key, required this.meditation});

  final Meditation meditation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).extension<CustomColors>()!.surface3!.withOpacity(0.08),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset(
              'assets/images/smile_${meditation.mood + 1}.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Your mood after\nmeditation',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).extension<CustomColors>()!.surface3!.withOpacity(0.4)),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Time meditation',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).extension<CustomColors>()!.surface3!.withOpacity(0.4)),
              ),
              Text(
                '${meditation.duration.inMinutes < 10 ? '0${meditation.duration.inMinutes}' : meditation.duration.inMinutes}:${(meditation.duration.inSeconds % 60) < 10 ? '0${meditation.duration.inSeconds % 60}' : meditation.duration.inSeconds % 60}',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class DiaryList extends StatelessWidget {
  const DiaryList({super.key, required this.controller});

  final MainController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        return Column(
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.14),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(Assets.vectors.notePlus),
                      const SizedBox(width: 8),
                      Text(
                        'New diary',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Theme.of(context).colorScheme.primary),
                      )
                    ],
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).pushNamed(RouteNames.addDiary,
                  arguments: AddDiaryViewArgs(controller: controller)),
            ),
            const SizedBox(height: 16),
            state.diary.isEmpty
                ? Text(
                    'Your have no notes added, to add a note click on the “New diary” button.',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context)
                            .extension<CustomColors>()!
                            .surface3!
                            .withOpacity(0.4)),
                  )
                : Column(
                    children: List.generate(state.diary.length,
                        (index) => DiaryContainer(diary: state.diary[index])),
                  )
          ],
        );
      },
    );
  }
}

class DiaryContainer extends StatelessWidget {
  const DiaryContainer({super.key, required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(Assets.vectors.file),
              const SizedBox(width: 8),
              Text(
                diary.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).extension<CustomColors>()!.surface3!.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              diary.note,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).extension<CustomColors>()!.surface3!.withOpacity(0.4)),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SvgPicture.asset(Assets.vectors.calendar),
              const SizedBox(width: 4),
              Text(
                DateHelper.formatDate(diary.date),
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).extension<CustomColors>()!.surface3!.withOpacity(0.4)),
              )
            ],
          )
        ],
      ),
    );
  }
}