import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    this.surface2,
    this.surface3,
    this.onBackground,
  });

  final Color? surface2;
  final Color? surface3;
  final Color? onBackground;

  @override
  CustomColors copyWith({
    Color? surface2,
    Color? surface3,
    Color? onBackground,
  }) {
    return CustomColors(
      surface2: surface2 ?? this.surface2,
      surface3: surface3 ?? this.surface3,
      onBackground: onBackground ?? this.onBackground,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      surface2: Color.lerp(surface2, other.surface2, t)!,
      surface3: Color.lerp(surface3, other.surface3, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
    );
  }

  static const light = CustomColors(
    surface2: Color(0xFFB6BFD5),
    surface3: Color(0xFFFAFAFA),
    onBackground: Color(0xFF1E1B32),
  );
}
