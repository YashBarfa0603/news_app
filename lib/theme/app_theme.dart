import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF0052FF);
  static const Color backgroundIvory = Color(0xFFF9FAFB);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A1C1E);
  static const Color textGrey = Color(0xFF4B5563);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundIvory,
    colorScheme: ColorScheme.light(
      primary: primaryBlue,
      surface: surfaceWhite,
      onSurface: textDark,
      secondary: textGrey,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: textGrey,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        color: textGrey,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceWhite,
      elevation: 0,
      iconTheme: const IconThemeData(color: textDark),
      titleTextStyle: GoogleFonts.plusJakartaSans(
        color: textDark,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardThemeData(
      color: surfaceWhite,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
