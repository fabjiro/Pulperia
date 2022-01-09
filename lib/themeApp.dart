import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pulperia/pages/PageMap/utils.dart';

// ignore: non_constant_identifier_names
final ThemeApp = LightMode();

class DarkMode {
  final colorPrimario = Color(0XFFFCC434);
  final colorBrightness = Brightness.light;
  final colorFondo = Color(0XFF334756);
  final colorCard = Color(0XFF506D84);
  final colorTitle = Color(0XFFFFFFFF);
  final colorTitleInvert = Colors.black;

  final colorSubTitle = Color(0XFFFFFFFF);
  final colorBootomNavBar = Color(0XFF082032);

  final String mapStyle = Utils.mapDark;
}

class LightMode {
  final colorBrightness = Brightness.dark;
  final colorPrimario = Color(0XFF5089C6);
  final colorFondo = Color(0XFFf1f1f0);
  final colorCard = Colors.white;
  final colorTitle = Colors.black;
  final colorTitleInvert = Colors.white;
  final colorSubTitle = Colors.black.withOpacity(.5);
  final colorBootomNavBar = Colors.white;

  final String mapStyle = Utils.maplihg;
}
