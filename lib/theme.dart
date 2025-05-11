import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micha_core/micha_core.dart';

// DRW corporate design
const _primaryColor = Color(0xffa60430);
const _accentColor = Color(0xffedd7d5);
const _surfaceColor = Colors.white;

// not defined in corporate design
const _onLightColor = Color(0xff4d4d4d);
const _onDarkColor = Colors.white;

final theme = ThemeData.from(
  textTheme: GoogleFonts.firaSansTextTheme(),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: _primaryColor,
    onPrimary: _onDarkColor,
    secondary: _accentColor,
    onSecondary: _onLightColor,
    error: _primaryColor,
    onError: _onDarkColor,
    // reduced opacity to show the background image behind cards
    surface: _surfaceColor.withAlpha(216),
    onSurface: _onLightColor,
  ),
).copyWith(
  iconTheme: const IconThemeData(
    color: _onLightColor,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
  scaffoldBackgroundColor: Colors.transparent,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    toolbarHeight: 64,
    backgroundColor: _primaryColor,
    foregroundColor: _onDarkColor,
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(50),
      ),
    ),
    titleTextStyle: TextStyle(
      color: _onDarkColor,
    ),
  ),
  extensions: [
    const LinkThemeData(
      color: Color(0xff0086BB),
      underlined: true,
    ),
    const SpinnerThemeData(
      size: 256,
    ),
  ],
);
