import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pp193/business/helpers/arguments.dart';
import 'package:pp193/business/services/navigation/route_names.dart';
import 'package:pp193/gen/assets.gen.dart';
import 'package:pp193/presentation/themes/custom_colors.dart';
import 'package:pp193/presentation/widgets/app_button.dart';
import 'package:pp193/presentation/widgets/page_view_wrapper.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  late final PageController _pageController;
  var _page = 0;
  var _pages = [];

  //first
  var _meditateReason = '';
  var _meditateLevel = '';

  void _init() {
    _pageController = PageController(initialPage: _page);
    _pages = [
      QuizFirstView(
        selectedItem: _meditateReason,
        onSelect: _selectReason,
      ),
      QuizSecondView(
        selectedItem: _meditateLevel,
        onSelect: _selectLevel,
      ),
      QuizThirdView(),
    ];
  }

  void _selectReason(String reason) {
    setState(() {
      _meditateReason = reason;
    });
    _updatePages();
  }

  void _selectLevel(String level) {
    setState(() {
      _meditateLevel = level;
    });
    _updatePages();
  }

  void _updatePages() {
    setState(() {
      _pages = [
        QuizFirstView(
          selectedItem: _meditateReason,
          onSelect: _selectReason,
        ),
        QuizSecondView(
          selectedItem: _meditateLevel,
          onSelect: _selectLevel,
        ),
        QuizThirdView(),
      ];
    });
  }

  Future<void> _next() async {
    if (_page <= 1) {
      _pageController.animateToPage(
        _page + 1,
        duration: const Duration(milliseconds: 150),
        curve: Curves.ease,
      );
    } else {
      Navigator.of(context).pushReplacementNamed(RouteNames.meditation,
          arguments: MeditationViewArgs(isFirstJoin: true));
    }
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
      body: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              ExpandablePageView(
                itemCount: _pages.length,
                itemBuilder: (BuildContext context, int page) {
                  return _pages[page];
                },
                controller: _pageController,
                onPageChanged: (int value) {
                  setState(() {
                    _page = value;
                  });
                },
                scrollPhysics: const NeverScrollableScrollPhysics(),
              ),
              const Spacer(),
              AppButton(
                label: _page <= 1 ? 'Next' : 'Start meditation',
                callback: _next,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizFirstView extends StatelessWidget {
  const QuizFirstView({super.key, required this.onSelect, required this.selectedItem});

  final Function(String reason) onSelect;
  final String selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Why did you choose to meditate?',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 32),
        QuizButton(
          label: 'Improved sleep',
          callback: onSelect,
          isActive: selectedItem == 'Improved sleep',
        ),
        const SizedBox(height: 8),
        QuizButton(
          label: 'Stress reduction',
          callback: onSelect,
          isActive: selectedItem == 'Stress reduction',
        ),
        const SizedBox(height: 8),
        QuizButton(
          label: 'Increased concentration',
          callback: onSelect,
          isActive: selectedItem == 'Increased concentration',
        ),
        const SizedBox(height: 8),
        QuizButton(
          label: 'Developing self-awareness',
          callback: onSelect,
          isActive: selectedItem == 'Developing self-awareness',
        ),
        const SizedBox(height: 8),
        QuizButton(
          label: 'Increasing the level of positivity',
          callback: onSelect,
          isActive: selectedItem == 'Increasing the level of positivity',
        ),
      ],
    );
  }
}

class QuizSecondView extends StatelessWidget {
  const QuizSecondView({super.key, required this.onSelect, required this.selectedItem});

  final Function(String) onSelect;
  final String selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'What is your level meditation?',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 32),
        QuizButton(
          label: 'Experienced',
          callback: onSelect,
          isActive: selectedItem == 'Experienced',
        ),
        const SizedBox(height: 8),
        QuizButton(
          label: 'Newcomer',
          callback: onSelect,
          isActive: selectedItem == 'Newcomer',
        ),
      ],
    );
  }
}

class QuizThirdView extends StatelessWidget {
  const QuizThirdView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        Image.asset(
          Assets.images.quizFinish.path,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 47),
        Text(
          'Start meditating to\nopen the door to new\npossibillities.',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class QuizButton extends StatelessWidget {
  const QuizButton({
    super.key,
    required this.label,
    required this.callback,
    required this.isActive,
  });

  final String label;
  final Function(String) callback;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 10,
      onPressed: () => callback(label),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).extension<CustomColors>()!.surface3!.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(isActive ? 1 : 0.4)),
            ),
            const Spacer(),
            SvgPicture.asset(isActive ? Assets.vectors.checkboxActive : Assets.vectors.checkbox)
          ],
        ),
      ),
    );
  }
}
