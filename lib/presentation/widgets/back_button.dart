import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pp193/gen/assets.gen.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.callback});

  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 10,
      onPressed: callback ?? () => Navigator.of(context).pop(),
      child: SvgPicture.asset(Assets.vectors.back),
    );
  }
}
