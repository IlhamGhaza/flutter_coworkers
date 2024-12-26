import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primary = Color(0xff4e40f6);
  static const btnSecondary = Color(0xffF2F2F2);
  static const border = Color(0xffeaeaea);
  static const text = Color(0xffa7a8b3);
  static const bgHeader = Color(0xffB3DCF2);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: primary,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: Colors.black87,
      displayColor: Colors.black,
    ),
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: btnSecondary,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primary,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      color: Colors.grey[850],
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: Colors.white70,
      displayColor: Colors.white,
    ),
    colorScheme: ColorScheme.dark(
      primary: primary,
      secondary: btnSecondary,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primary,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
