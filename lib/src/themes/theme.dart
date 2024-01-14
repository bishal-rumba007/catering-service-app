import 'package:catering_service_app/src/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    splashColor: AppColor.primaryRed.withOpacity(0.5),
    colorScheme: const ColorScheme.light(
      background: AppColor.backGroundColor,
      primary: AppColor.primaryRed,
      secondary: AppColor.secondaryColor,
    ),
    iconTheme: const IconThemeData(
      color: AppColor.primaryRed,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 42.sp,
        fontWeight: FontWeight.w900,
        color: AppColor.darkColor,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 40.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.darkColor,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.darkColor,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: AppColor.darkColor,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.darkColor,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColor.darkColor,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColor.darkColor,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.darkColor,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.darkColor,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColor.darkColor,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.darkColor.withOpacity(0.7),
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.darkColor,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: AppColor.darkColor,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.darkColor,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.darkColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColor.greyColor.withOpacity(0.5);
            }
            return Colors.transparent;
          },
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: AppColor.darkColor,
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
          const BorderSide(
            color: AppColor.greyColor,
            width: 1,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50.h),
          textStyle:  GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: Colors.white,
          ),
          backgroundColor: AppColor.primaryRed,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        )
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
      EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColor.greyColor, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColor.greyColor.withOpacity(0.8), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColor.primaryRed, width: 1.5),
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.darkColor.withOpacity(0.6),
      ),
      floatingLabelStyle: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColor.primaryRed,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColor.setOrange, width: 1.5),
      ),
      errorStyle: GoogleFonts.inter(
        fontSize: 14.sp,
        color: Colors.red,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            textStyle: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600
            )
        )
    ),

    listTileTheme: const ListTileThemeData(
        style: ListTileStyle.drawer
    ),

    dropdownMenuTheme: DropdownMenuThemeData()
);
