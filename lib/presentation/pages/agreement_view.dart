import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pp193/business/helpers/email_helper.dart';
import 'package:pp193/business/helpers/text_helper.dart';
import 'package:pp193/business/services/navigation/route_names.dart';
import 'package:pp193/gen/assets.gen.dart';
import 'package:pp193/presentation/widgets/app_button.dart';

enum AgreementType {
  privacy,
  terms,
}

class AgreementView extends StatefulWidget {
  final AgreementViewArguments arguments;

  const AgreementView({super.key, required this.arguments});

  factory AgreementView.create(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as AgreementViewArguments;
    return AgreementView(arguments: arguments);
  }

  @override
  State<AgreementView> createState() => _AgreementViewState();
}

class _AgreementViewState extends State<AgreementView> {
  AgreementType get _agreementType => widget.arguments.agreementType;

  bool get _usePrivacyAgreement => widget.arguments.usePrivacyAgreement;

  String get _agreementText =>
      _agreementType == AgreementType.privacy ? TextHelper.privacy : TextHelper.terms;

  String get _title => _agreementType == AgreementType.privacy ? 'Privacy Policy' : 'Terms Of Use';

  void _accept() {
    Navigator.of(context).pushReplacementNamed(RouteNames.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_usePrivacyAgreement)
                      Text(
                        _title,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Theme.of(context).colorScheme.onBackground),
                      )
                    else
                      Row(
                        children: [
                          CupertinoButton(
                            minSize: 10,
                            padding: EdgeInsets.zero,
                            child: SvgPicture.asset(Assets.vectors.back),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const Spacer(),
                          Text(
                            _agreementType == AgreementType.privacy
                                ? 'Privacy Policy'
                                : 'Terms of Use',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          const Spacer(),
                          const SizedBox(width: 30),
                        ],
                      ),
                    const SizedBox(height: 13),
                    Expanded(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            bottom: _usePrivacyAgreement ? 90 : 60,
                          ),
                          physics: const BouncingScrollPhysics(),
                          child: MarkdownBody(
                            styleSheet: MarkdownStyleSheet(
                              p: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                  ),
                              a: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                  ),
                              code: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                  ),
                              checkbox: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                  ),
                              em: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                  ),
                              del: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                  ),
                              listBullet: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                  ),
                              h1: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                  ),
                              h2: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                  ),
                              h3: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5)),
                              h4: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                  ),
                            ),
                            data: _agreementText,
                            onTapLink: (text, href, title) => EmailHelper.launchEmailSubmission(
                              toEmail: 'loganmartinm0x4@hotmail.com',
                              subject: '',
                              body: '',
                              errorCallback: () {},
                              doneCallback: () {},
                            ),
                            selectable: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_usePrivacyAgreement)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AppButton(
                      label: 'Accept app privacy',
                      callback: _accept,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AgreementViewArguments {
  final AgreementType agreementType;
  final bool usePrivacyAgreement;

  AgreementViewArguments({
    required this.agreementType,
    this.usePrivacyAgreement = false,
  });
}
