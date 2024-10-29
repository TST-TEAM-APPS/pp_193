import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pp193/presentation/themes/custom_colors.dart';

class DefaultThemeGetter {
  static ThemeData get() {
    const primary = Color(0xFF6D57FF);
    const primaryLight = Colors.black;
    const primaryDark = Colors.black;
    const onBackground = Color(0xFF242424);
    const surface = Color(0xFF242424);
    const customColorsExtension = CustomColors.light;

    return ThemeData(
      primaryColor: primary,
      primaryColorLight: primaryLight,
      primaryColorDark: primaryDark,
      textTheme: TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'SFProText',
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
          displayMedium: TextStyle(
            fontFamily: 'SFProText',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.33,
          ),
          displaySmall: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.34,
          ),
          headlineMedium: GoogleFonts.jost(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'SFProText',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.37,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.34,
          ),
          titleMedium: GoogleFonts.rubik(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            height: 1.0,
          ),
          titleSmall: const TextStyle(
            fontFamily: 'Verdana',
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          titleLarge: GoogleFonts.rubik(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.0,
          ),
          labelSmall: TextStyle(
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
            height: 1.2,
          ),
          labelMedium: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 1.1,
          ),
          labelLarge: TextStyle(
            fontFamily: 'SFProText',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.28,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            height: 1.34,
          )).apply(
        bodyColor: onBackground,
        displayColor: onBackground,
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            const Size(
              double.infinity,
              48.0,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return primary.withOpacity(0.3);
              }
              return primary;
            },
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(
                double.infinity,
                53.0,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            side: MaterialStateProperty.all(
              const BorderSide(color: primary),
            )),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        customColorsExtension,
      ],
      colorScheme: const ColorScheme(
        primary: primary,
        primaryContainer: primaryDark,
        secondary: Color(0xFF2274F1),
        surface: surface,
        onSurface: Color(0xFF313131),
        background: Color(0xFF171334),
        secondaryContainer: Color(0xFF34C85A),
        onBackground: onBackground,
        error: Colors.white,
        onError: Colors.white,
        brightness: Brightness.light,
        onPrimary: Color(0xFFFFFFFF),
        onSecondary: Color(0xFF171E2D),
      ),
    );
  }
}
