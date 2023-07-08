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
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.roboto(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      bodySmall: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      labelLarge: GoogleFonts.roboto(
        fontSize: 24.sp,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
      labelMedium: GoogleFonts.roboto(
        fontSize: 20.sp,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
      labelSmall: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
    ),
  );
}
