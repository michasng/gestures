import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// DRW corporate design
final primaryColor = Color(0xffa60430);
final accentColor = Color(0xffedd7d5);
// final surfaceColor = Color(0xfff0f0ed);
// final surfaceColor2 = Color(0xffe1e1dd);
const backgroundColor = Colors.white;

// not defined in corporate design
const onLightColor = Color(0xff4d4d4d);
const onDarkColor = Colors.white;

final theme = ThemeData.from(
  textTheme: GoogleFonts.firaSansTextTheme(),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: onDarkColor,
    secondary: accentColor,
    onSecondary: onLightColor,
    error: primaryColor,
    onError: onDarkColor,
    background: backgroundColor,
    onBackground: onLightColor,
    // using backgroundColor as surfaceColor, because of the BG image
    surface: backgroundColor.withAlpha(216),
    onSurface: onLightColor,
  ),
).copyWith(
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
  scaffoldBackgroundColor: Colors.transparent,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    toolbarHeight: 64,
    backgroundColor: primaryColor,
    foregroundColor: onDarkColor,
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(50),
      ),
    ),
    titleTextStyle: TextStyle(
      color: onDarkColor,
    ),
  ),
);
