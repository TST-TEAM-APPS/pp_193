import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.callback,
    this.textStyle,
    this.color,
    this.width,
    this.height,
    this.withBorder,
    this.customLabel,
  });

  final String label;
  final Widget? customLabel;
  final VoidCallback? callback;
  final TextStyle? textStyle;
  final bool? withBorder;
  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: callback,
      padding: EdgeInsets.zero,
      minSize: 10,
      pressedOpacity: 0.7,
      child: Container(
        height: height ?? 48,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color ??
              Theme.of(context).colorScheme.primary.withOpacity(callback != null ? 1 : 0.5),
          borderRadius: BorderRadius.circular(16),
          border: withBorder != null
              ? withBorder!
                  ? Border.all(color: Colors.white, width: 1)
                  : null
              : null,
        ),
        child: Center(
          child: customLabel ??
              Text(
                label,
                style: textStyle ??
                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                textAlign: TextAlign.center,
              ),
        ),
      ),
    );
  }
}
