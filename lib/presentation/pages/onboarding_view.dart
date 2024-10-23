import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:pp193/business/services/navigation/route_names.dart';
import 'package:pp193/data/repositories/database_keys.dart';
import 'package:pp193/data/repositories/database_service.dart';
import 'package:pp193/gen/assets.gen.dart';
import 'package:pp193/presentation/pages/agreement_view.dart';
import 'package:pp193/presentation/widgets/app_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController controller = PageController();
  final database = GetIt.instance.get<DatabaseService>();
  var step = 0;
  final List<Map<String, dynamic>> content = [
    {
      'text': "Find your path to serenity.",
      'subtext': "Track your meditation practice to see how it\nimpacts your well-being.",
      'background': Assets.images.onb1,
    },
    {
      'text': "Build a meditation habit.",
      'subtext': "Our app helps you make meditation\nan essential part of your life.",
      'background': Assets.images.onb2,
    },
  ];

  void nextPage(BuildContext context) {
    final seenQuiz = database.get(DatabaseKeys.seenQuiz) ?? false;
    if (controller.page == 1.0) {
      if (!seenQuiz) {
        database.put(DatabaseKeys.seenQuiz, true);
        Navigator.of(context).pushReplacementNamed(RouteNames.quiz);
      } else {
        Navigator.of(context).pushReplacementNamed(RouteNames.main);
      }
    } else {
      controller.nextPage(duration: const Duration(milliseconds: 150), curve: Curves.fastOutSlowIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            PageView.builder(
              controller: controller,
              itemCount: content.length,
              onPageChanged: (int index) {
                setState(() {
                  step = index;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingContent(
                  text: content[index]['text'],
                  subtext: content[index]['subtext'],
                  background: content[index]['background'],
                  controller: controller,
                  step: step,
                );
              },
            ),
            Positioned(
              bottom: 20,
              left: 28,
              right: 28,
              child: Column(
                children: [
                  AppButton(
                    label: step == 1 ? "Get started" : 'Next',
                    width: MediaQuery.of(context).size.width - 32,
                    callback: () => nextPage(context),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        minSize: 10,
                        onPressed: () => Navigator.of(context).pushNamed(RouteNames.agreement,
                            arguments: AgreementViewArguments(agreementType: AgreementType.terms)),
                        child: Text(
                          'Terms of Use',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4)),
                        ),
                      ),
                      Text(
                        ' / ',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4)),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        minSize: 10,
                        onPressed: () => Navigator.of(context).pushNamed(RouteNames.agreement,
                            arguments:
                                AgreementViewArguments(agreementType: AgreementType.privacy)),
                        child: Text(
                          'Privacy Policy',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.text,
    required this.subtext,
    required this.background,
    required this.controller,
    required this.step,
  });

  final String text;
  final String subtext;
  final AssetGenImage background;
  final PageController controller;
  final int step;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.14),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: Image.asset(
                background.path,
              ),
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),
            Center(
              child: Text(
                subtext,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5)),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
