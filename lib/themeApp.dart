import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0XFF334756),
    primaryColor: Color(0XFFFCC434),
    accentColor: Color(0XFFFCC434),
    cardColor: Color(0XFF506D84),
    bottomAppBarColor: Color(0XFF082032),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.varelaRound(color: Colors.white),
      bodyText2: GoogleFonts.varelaRound(color: Colors.black),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0XFFf1f1f0),
    primaryColor: Color(0XFF5089C6),
    accentColor: Color(0XFF5089C6),
    cardColor: Colors.white,
    bottomAppBarColor: Colors.white,
    textTheme: TextTheme(
      bodyText1: GoogleFonts.varelaRound(color: Colors.black),
      bodyText2: GoogleFonts.varelaRound(color: Colors.white),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
