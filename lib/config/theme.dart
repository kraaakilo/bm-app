import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildThemeData({Brightness brightness = Brightness.light}) {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: mainColor,
      brightness: brightness,
    ),
    textTheme: GoogleFonts.interTextTheme(),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
    useMaterial3: false,
  );
}

MaterialColor mainColor = const MaterialColor(0xFF3B82F6, <int,Color>{
  50: Color(0xFFF6F9FF),
  100: Color(0xFFECF3FF),
  200: Color(0xFFCEE0FD),
  300: Color(0xFFAFCCFC),
  400: Color(0xFF76A8F9),
  500: Color(_maincolorPrimaryValue),
  600: Color(0xFF3574DB),
  700: Color(0xFF244E94),
  800: Color(0xFF1B3B6F),
  900: Color(0xFF122648),
});
const int _maincolorPrimaryValue = 0xFFED1F24;