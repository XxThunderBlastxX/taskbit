import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ///Colors
  static const Color kPurpleColor = Color(0xFFCDB4DB);
  static const Color kBabyPinkColor = Color(0xFFFFC8DD);
  static const Color kPinkColor = Color(0xFFFFAFCC);
  static const Color kLightBlueColor = Color(0xFFBDE0FE);
  static const Color kBlueColor = Color(0xFFA2D2FF);

  /// Global app theme
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF8EDEB),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 47.h,
      titleTextStyle: GoogleFonts.bungee(
        fontSize: 24.sp,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
    ),
    fontFamily: GoogleFonts.bungee().fontFamily,
    tabBarTheme: TabBarTheme(
      indicatorColor: Colors.black87,
      labelColor: Colors.black87,
      unselectedLabelColor: Colors.black54,
      labelStyle: GoogleFonts.bungee(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.bungee(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      labelPadding: EdgeInsets.only(bottom: 6.h),
      splashFactory: InkRipple.splashFactory,
      indicatorSize: TabBarIndicatorSize.label,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.bungee(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      bodyMedium: GoogleFonts.bungee(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      bodySmall: GoogleFonts.bungee(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      labelLarge: GoogleFonts.bungee(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      labelMedium: GoogleFonts.bungee(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      labelSmall: GoogleFonts.bungee(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    ),
  );
}
