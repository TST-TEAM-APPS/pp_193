import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp193/presentation/themes/custom_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.prefix,
    this.suffix,
    this.borderColor,
    this.bgColor,
    this.maxLength,
    this.maxLines,
    this.onChanged,
    this.keyboardType,
    this.textColor,
    this.smallPlaceholder,
  });

  final TextEditingController controller;
  final String placeholder;
  final Widget? prefix;
  final Widget? suffix;
  final Color? borderColor;
  final Color? bgColor;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Function(String value)? onChanged;
  final Color? textColor;
  final bool? smallPlaceholder;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      keyboardType: keyboardType,
      suffix: suffix,
      prefix: prefix,
      maxLength: maxLength ?? 16,
      maxLines: maxLines ?? 1,
      placeholder: placeholder,
      onChanged: onChanged,
      padding: const EdgeInsets.all(10),
      placeholderStyle: smallPlaceholder != null
          ? Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: textColor?.withOpacity(0.5) ??
                  Theme.of(context).extension<CustomColors>()!.surface3!.withOpacity(0.4))
          : Theme.of(context).textTheme.displayMedium!.copyWith(
              color: textColor?.withOpacity(0.5) ??
                  Theme.of(context).extension<CustomColors>()!.surface3!.withOpacity(0.4)),
      style: smallPlaceholder != null
          ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: textColor ?? Theme.of(context).extension<CustomColors>()!.surface3,
              )
          : Theme.of(context).textTheme.displayMedium!.copyWith(
                color: textColor ?? Theme.of(context).extension<CustomColors>()!.surface3,
              ),
      decoration: BoxDecoration(color: Colors.transparent),
    );
  }
}
