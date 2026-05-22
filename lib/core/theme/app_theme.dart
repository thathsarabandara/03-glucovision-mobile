import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Core Colors - Light Mode
  static const Color background = Color(0xFFF7FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceHighlight = Color(0xFFE2E8F0);
  
  // Accents - Light Mode
  static const Color cyanAccent = Color(0xFF2563EB); // Primary Blue
  static const Color emeraldHealth = Color(0xFF22C55E); // Success (healthy)
  static const Color purpleAI = Color(0xFF14B8A6); // Accent Teal
  static const Color warning = Color(0xFFF59E0B); // Warning
  static const Color error = Color(0xFFEF4444); // Danger (glucose alert)

  // Typography - Light Mode
  static const Color textPrimary = Color(0xFF0F172A); // Text Primary
  static const Color textSecondary = Color(0xFF475569); // Text Secondary

  // Core Colors - Dark Mode
  static const Color backgroundDark = Color(0xFF0F172A); // Deep slate background
  static const Color surfaceDark = Color(0xFF1E293B); // Slate dark surface
  static const Color surfaceHighlightDark = Color(0xFF334155);

  // Accents - Dark Mode
  static const Color cyanAccentDark = Color(0xFF60A5FA); // Secondary Blue
  static const Color emeraldHealthDark = Color(0xFF22C55E); // Success (healthy)
  static const Color purpleAIDark = Color(0xFF14B8A6); // Accent Teal
  static const Color warningDark = Color(0xFFF59E0B); // Warning
  static const Color errorDark = Color(0xFFEF4444); // Danger (glucose alert)

  // Typography - Dark Mode
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,
      primaryColor: cyanAccent,
      colorScheme: const ColorScheme.light(
        primary: cyanAccent,
        secondary: emeraldHealth,
        tertiary: purpleAI,
        surface: surface,
        error: error,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData(brightness: Brightness.light).textTheme,
      ).copyWith(
        displayLarge: GoogleFonts.inter(color: textPrimary, fontWeight: FontWeight.w700),
        displayMedium: GoogleFonts.inter(color: textPrimary, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.inter(color: textPrimary, fontWeight: FontWeight.w400),
        bodyMedium: GoogleFonts.inter(color: textSecondary, fontWeight: FontWeight.w400),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: surfaceHighlight, width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(color: textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: emeraldHealth,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: surfaceHighlight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: surfaceHighlight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: cyanAccent),
        ),
        hintStyle: GoogleFonts.inter(color: textSecondary),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      primaryColor: cyanAccentDark,
      colorScheme: const ColorScheme.dark(
        primary: cyanAccentDark,
        secondary: emeraldHealthDark,
        tertiary: purpleAIDark,
        surface: surfaceDark,
        error: errorDark,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData(brightness: Brightness.dark).textTheme,
      ).copyWith(
        displayLarge: GoogleFonts.inter(color: textPrimaryDark, fontWeight: FontWeight.w700),
        displayMedium: GoogleFonts.inter(color: textPrimaryDark, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.inter(color: textPrimaryDark, fontWeight: FontWeight.w400),
        bodyMedium: GoogleFonts.inter(color: textSecondaryDark, fontWeight: FontWeight.w400),
      ),
      cardTheme: CardThemeData(
        color: surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: surfaceHighlightDark, width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimaryDark),
        titleTextStyle: TextStyle(color: textPrimaryDark, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: emeraldHealthDark,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: surfaceHighlightDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: surfaceHighlightDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: cyanAccentDark),
        ),
        hintStyle: GoogleFonts.inter(color: textSecondaryDark),
      ),
    );
  }
}
