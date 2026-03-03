import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Palette de couleurs EduGuinée (Moderne et Professionnelle)
  static const Color primaryColor = Color(0xFF0F172A); // Bleu Nuit Profond (Confiance, Sérieux)
  static const Color secondaryColor = Color(0xFFFACC15); // Or / Jaune (Réussite, Guinée)
  static const Color accentColor = Color(0xFFEF4444); // Rouge (Action, Guinée)
  
  static const Color backgroundLight = Color(0xFFF8FAFC); // Gris Ardoise très clair
  static const Color surfaceLight = Colors.white;
  static const Color textMain = Color(0xFF1E293B); // Gris foncé
  static const Color textSub = Color(0xFF64748B); // Gris moyen

  // Dégradés
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFACC15), Color(0xFFEAB308)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundLight,
      
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        error: accentColor,
        background: backgroundLight,
        surface: surfaceLight,
      ),

      // Typographie Moderne (Poppins + Inter)
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 32, fontWeight: FontWeight.bold, color: textMain
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 24, fontWeight: FontWeight.w600, color: textMain
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 20, fontWeight: FontWeight.w600, color: textMain
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16, fontWeight: FontWeight.w400, color: textMain
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w400, color: textSub
        ),
      ),

      // Boutons modernes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: primaryColor.withOpacity(0.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: GoogleFonts.poppins(
            fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5
          ),
        ),
      ),

      // Cards modernes avec ombre douce
      // Cards modernes avec ombre douce
      cardTheme: CardThemeData(
        color: surfaceLight,
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.all(8),
      ),

      // Decorations des champs de saisie
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: secondaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: accentColor, width: 1),
        ),
        hintStyle: GoogleFonts.inter(color: textSub.withOpacity(0.5), fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: textMain),
        titleTextStyle: GoogleFonts.poppins(
          color: textMain, fontSize: 18, fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
