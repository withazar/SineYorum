import 'package:flutter/material.dart';
import 'package:sineyorum/core/constants/app_constants.dart';

class AppTheme {
  // Light Theme (for future use)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppConstants.primaryColor,
        secondary: AppConstants.secondaryColor,
        background: Colors.white,
        surface: Color(0xFFF5F5F5),
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onBackground: Colors.black,
        onSurface: Colors.black,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
          color: Colors.black,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
          color: Colors.black,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
          color: Colors.black,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
          color: Colors.black,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
          color: Colors.black,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
          color: Colors.black,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
          color: Colors.grey,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppConstants.primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppConstants.errorColor,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFFF5F5F5),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(8),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE0E0E0),
        thickness: 1,
        space: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // Dark Theme (Primary Theme for SineYorum)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppConstants.primaryColor,
        secondary: AppConstants.secondaryColor,
        background: AppConstants.backgroundColor,
        surface: AppConstants.surfaceColor,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onBackground: AppConstants.textColor,
        onSurface: AppConstants.textColor,
        error: AppConstants.errorColor,
      ),
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.surfaceColor,
        foregroundColor: AppConstants.textColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppConstants.textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
          color: AppConstants.textColor,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
          color: AppConstants.textColor,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
          color: AppConstants.textColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
          color: AppConstants.textColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
          color: AppConstants.textColor,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
          color: AppConstants.textColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
          color: AppConstants.textColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
          color: AppConstants.textColor,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
          color: AppConstants.textSecondaryColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppConstants.primaryColor,
          side: const BorderSide(color: AppConstants.primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppConstants.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppConstants.primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppConstants.errorColor,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
        hintStyle: const TextStyle(
          color: AppConstants.textSecondaryColor,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
        labelStyle: const TextStyle(
          color: AppConstants.textColor,
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardTheme(
        color: AppConstants.surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(8),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF333333),
        thickness: 1,
        space: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppConstants.surfaceColor,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: AppConstants.textSecondaryColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppConstants.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titleTextStyle: const TextStyle(
          color: AppConstants.textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        contentTextStyle: const TextStyle(
          color: AppConstants.textColor,
          fontSize: 16,
          fontFamily: 'Inter',
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppConstants.surfaceColor,
        contentTextStyle: const TextStyle(
          color: AppConstants.textColor,
          fontFamily: 'Inter',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppConstants.primaryColor,
        linearTrackColor: AppConstants.surfaceColor,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppConstants.surfaceColor,
        selectedColor: AppConstants.primaryColor,
        secondarySelectedColor: AppConstants.primaryColor,
        disabledColor: Colors.grey,
        labelStyle: const TextStyle(
          color: AppConstants.textColor,
          fontFamily: 'Inter',
        ),
        secondaryLabelStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Inter',
        ),
        brightness: Brightness.dark,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: AppConstants.surfaceColor,
        textColor: AppConstants.textColor,
        iconColor: AppConstants.primaryColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Custom text styles for specific use cases
  static TextStyle get movieTitleStyle {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
      color: AppConstants.textColor,
    );
  }

  static TextStyle get movieOverviewStyle {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      color: AppConstants.textSecondaryColor,
      height: 1.5,
    );
  }

  static TextStyle get ratingStyle {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Inter',
      color: AppConstants.primaryColor,
    );
  }

  static TextStyle get reviewContentStyle {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      color: AppConstants.textColor,
      height: 1.6,
    );
  }

  static TextStyle get spoilerWarningStyle {
    return const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
      color: AppConstants.warningColor,
    );
  }

  static TextStyle get premiumBadgeStyle {
    return const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w700,
      fontFamily: 'Inter',
      color: Colors.black,
      letterSpacing: 0.5,
    );
  }
}