import 'package:catering_service_app/src/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTheme {
  ThemeData lightMode = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      background: Color(0xFFfbfbf2),
      // background: Color.fromARGB(255, 240, 239, 232),
      primary: AppColor.purpleColor,
      secondary: AppColor.roseColor,
    ),
  );

  ThemeData darkMode = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        background: AppColor.darkColor,
        primary: AppColor.purpleColor,
        secondary: AppColor.roseColor,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.raleway(
          fontSize: 45,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        displayMedium: GoogleFonts.raleway(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        displaySmall: GoogleFonts.raleway(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        headlineLarge: GoogleFonts.raleway(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.raleway(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        headlineSmall: GoogleFonts.raleway(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleLarge: GoogleFonts.raleway(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleMedium: GoogleFonts.raleway(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        titleSmall: GoogleFonts.raleway(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.raleway(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.raleway(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white.withOpacity(0.5),
        ),
        bodySmall: GoogleFonts.raleway(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        labelLarge: GoogleFonts.raleway(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelMedium: GoogleFonts.raleway(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        labelSmall: GoogleFonts.raleway(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColor.darkColor.withOpacity(0.3);
              }
              return Colors.transparent; // Customize the button color
            },
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            GoogleFonts.raleway(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColor.purpleColor.withOpacity(0.5),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey;
              }
              return Colors.white; // Customize the button text color
            },
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: AppColor.purpleColor.withOpacity(0.5),
              width: 1,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  8.0), // Adjust the borderRadius value as needed
            ),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColor.purpleColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide.none,
        labelStyle: GoogleFonts.raleway(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColor.purpleColor.withOpacity(0.7),
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      ));
}
