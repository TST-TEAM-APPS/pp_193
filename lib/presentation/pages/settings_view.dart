import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pp193/business/helpers/dialog_helper.dart';
import 'package:pp193/business/helpers/email_helper.dart';
import 'package:pp193/business/services/navigation/route_names.dart';
import 'package:pp193/gen/assets.gen.dart';
import 'package:pp193/presentation/pages/agreement_view.dart';
import 'package:pp193/presentation/themes/custom_colors.dart';
import 'package:pp193/presentation/widgets/app_button.dart';
import 'package:pp193/presentation/widgets/app_text_field.dart';
import 'package:pp193/presentation/widgets/back_button.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  void _showAppVersionDialog(BuildContext context) => DialogHelper.showAppVersionDialog(context);

  void _showContactTable(BuildContext context) {
    final subjectController = TextEditingController();
    final textController = TextEditingController();
    var buttonState = false;

    Future<void> _send() async => await EmailHelper.launchEmailSubmission(
          toEmail: 'loganmartinm0x4@hotmail.com',
          subject: subjectController.text,
          body: textController.text,
          errorCallback: () {},
          doneCallback: () {},
        );

    DialogHelper.showCustomModalPopup(context, StatefulBuilder(
      builder: (BuildContext context, Function(Function()) setState) {
        void updateButtonState() {
          if (subjectController.text.isNotEmpty && textController.text.isNotEmpty) {
            setState(
              () => buttonState = true,
            );
          } else {
            setState(
              () => buttonState = false,
            );
          }
        }

        subjectController.addListener(updateButtonState);
        textController.addListener(updateButtonState);

        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(34),
                topLeft: Radius.circular(34),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'Contact developer',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 20),
                AppTextField(
                  controller: subjectController,
                  placeholder: 'Message subject',
                  smallPlaceholder: true,
                ),
                const SizedBox(height: 20),
                AppTextField(
                  controller: textController,
                  placeholder: 'Message text',
                  smallPlaceholder: true,
                ),
                const SizedBox(height: 40),
                AppButton(label: 'Send', callback: buttonState ? _send : null),
              ],
            ),
          ),
        );
      },
    ), true);
  }

  Future<void> _rate() async {
    if (await InAppReview.instance.isAvailable()) {
      await InAppReview.instance.requestReview();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const AppBackButton(),
                  const Spacer(),
                  Text(
                    'Settings',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  const Spacer(),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 27),
              Text(
                'Feedback and support',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).extension<CustomColors>()!.surface3!.withOpacity(0.4)),
              ),
              const SizedBox(height: 8),
              SettingsItem(label: 'Contact us', callback: () => _showContactTable(context)),
              const SizedBox(height: 8),
              SettingsItem(label: 'Feedback', callback: _rate),
              const SizedBox(height: 8),
              Text(
                'About the program',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).extension<CustomColors>()!.surface3!.withOpacity(0.4)),
              ),
              const SizedBox(height: 8),
              SettingsItem(label: 'Version', callback: () => _showAppVersionDialog(context)),
              const SizedBox(height: 8),
              SettingsItem(
                label: 'Privacy Policy',
                callback: () => Navigator.of(context).pushNamed(RouteNames.agreement,
                    arguments: AgreementViewArguments(agreementType: AgreementType.privacy)),
              ),
              const SizedBox(height: 8),
              SettingsItem(
                  label: 'Terms of Use',
                  callback: () => Navigator.of(context).pushNamed(RouteNames.agreement,
                      arguments: AgreementViewArguments(agreementType: AgreementType.terms))),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, required this.label, required this.callback});

  final String label;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: callback,
      padding: EdgeInsets.zero,
      minSize: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).extension<CustomColors>()!.surface3!.withOpacity(0.08),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
            const Spacer(),
            SvgPicture.asset(Assets.vectors.chevronRight),
          ],
        ),
      ),
    );
  }
}
