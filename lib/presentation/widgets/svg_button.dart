import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgButton extends StatelessWidget {
  const SvgButton({super.key, required this.svgAsset, required this.callback});

  final String svgAsset;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 10,
      onPressed: callback,
      child: SvgPicture.asset(svgAsset),
    );
  }
}
