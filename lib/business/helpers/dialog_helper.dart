import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:pp193/business/helpers/email_helper.dart';
import 'package:pp193/business/services/navigation/route_names.dart';
import 'package:pp193/presentation/widgets/app_text_field.dart';
import 'package:pp193/presentation/widgets/back_button.dart';

class DialogHelper {
  static Future<void> showNoInternetDialog(BuildContext context) async => await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text(
              'You have lost your internet connection. Please check your settings and try again.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteNames.splash,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      );

  static Future<void> showFeedbackDialog(BuildContext context) async {
    final subjectField = TextEditingController();
    final textField = TextEditingController();

    Future<void> send() async => await EmailHelper.launchEmailSubmission(
          toEmail: 'loganmartinm0x4@hotmail.com',
          subject: subjectField.text,
          body: textField.text,
          errorCallback: () {},
          doneCallback: () {},
        );

    await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Feedback'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBackButton(),
            AppTextField(
              placeholder: 'Subject',
              controller: subjectField,
            ),
            AppTextField(
              placeholder: 'Message',
              controller: textField,
            ),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('Send'),
            onPressed: () {
              send();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  static Future<void> showPrivacyAgreementDialog(
    BuildContext context, {
    VoidCallback? yes,
    VoidCallback? no,
  }) async {
    await showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Dear user!'),
        content: const Text(
            'We would be very grateful if you would read the policy of our application and accept the consent. Do you want to continue?'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('YES'),
            onPressed: () {
              Navigator.of(context).pop();
              yes?.call();
            },
          ),
          CupertinoDialogAction(
            child: const Text('NO'),
            onPressed: () {
              Navigator.of(context).pop();
              no?.call();
            },
          ),
        ],
      ),
    );
  }

  static Future<void> showErrorDialog(BuildContext context, String error) async =>
      await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text(error),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  // static Future<void> showFeedbackDialog(BuildContext context) async {
  //   final subjectField = TextEditingController();
  //   final textField = TextEditingController();
  //
  //   Future<void> _send() async => await EmailHelper.launchEmailSubmission(
  //     toEmail: 'a.aaqib.hussain@erksup.online',
  //     subject: subjectField.text,
  //     body: textField.text,
  //     errorCallback: () {},
  //     doneCallback: () {},
  //   );
  //
  //   await showCupertinoDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (context) => Container(
  //       child: CupertinoAlertDialog(
  //         title: const Text('Feedback'),
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             AppBackButton(
  //               color: Theme.of(context).colorScheme.onBackground,
  //             ),
  //             AppTextField(
  //               type: AppTextFieldType.textField,
  //               title: 'Subject',
  //               controller: subjectField,
  //               color: Theme.of(context).colorScheme.onBackground,
  //               validatorCondition: (String value) {
  //                 if (value.length < 4) {
  //                   return false;
  //                 }
  //                 return true;
  //               },
  //             ),
  //             AppTextField(
  //               type: AppTextFieldType.textField,
  //               title: 'Message',
  //               controller: textField,
  //               color: Theme.of(context).colorScheme.onBackground,
  //               validatorCondition: (String value) {
  //                 if (value.length < 4) {
  //                   return false;
  //                 }
  //                 return true;
  //               },
  //             ),
  //           ],
  //         ),
  //         actions: <Widget>[
  //           CupertinoDialogAction(
  //             child: const Text('Send'),
  //             onPressed: () {
  //               _send();
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  static Future<void> showCustomDialog(
          {required BuildContext context,
          required String title,
          String? content,
          VoidCallback? submit,
          VoidCallback? cancel}) async =>
      await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content ?? ''),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Yes'),
              onPressed: () {
                submit?.call();
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('No'),
              onPressed: () {
                cancel?.call();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );


  static Future<void> showDeleteDialog(BuildContext context,
          {required VoidCallback onConfirm,
          required String deleteMessage,
          String? deleteSubMessage}) async =>
      await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: Text(deleteMessage),
          content: Text(deleteSubMessage ?? 'Please confirm'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Yes'),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  static Future<void> showConfirmDialog(BuildContext context,
          {required VoidCallback onConfirm, required String message}) async =>
      await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Please confirm'),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('No', style: TextStyle(color: Colors.cyan)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );



  static void showCustomModalPopup(BuildContext context, Widget child, bool? barrierDismissible) {
    showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (BuildContext context) => Container(
        // height: 216,
        padding: const EdgeInsets.only(top: 6.0),

        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
            // bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
        // Provide a background color for the popup.
        color: Colors.transparent,
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  static Future<void> showAppVersionDialog(BuildContext context) async {
    final info = AppInfo.of(context);
    await showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: Text(info.package.appName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Operating system: ${info.platform.operatingSystem}'),
            SizedBox(height: 8),
            Text('Installer store: ${info.package.installerStore ?? '-'}'),
            SizedBox(height: 8),
            Text('Version: ${info.package.versionWithoutBuild}'),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              'OK',
              style: TextStyle().copyWith(color: CupertinoColors.activeBlue),
            ),
            onPressed: Navigator.of(context).pop,
          ),
        ],
      ),
    );
  }
}
