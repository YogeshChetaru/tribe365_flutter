import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  primaryColor: const Color(0xFFEB1C24),
  secondaryHeaderColor:const Color(0xFFEB1C24),
  brightness: Brightness.light,
  highlightColor: Colors.white,
  hintColor: const Color(0xFF9E9E9E),
  splashColor: Colors.white,
  colorScheme: const ColorScheme.light(
    error: Color(0xFFFF5A5A),
    primary: Color(0xFFEB1C24),
    secondary: Color(0xffEB1C24),
    tertiary: Color(0xFFF9D4A8),
    tertiaryContainer: Color(0xFFADC9F3),
    onTertiaryContainer: Color(0xFF33AF74),
    primaryContainer: Color(0xFF9AECC6),
    secondaryContainer: Color(0xFFF2F2F2),
    surface: Color(0xFFFFFFFF),
    surfaceTint: Color(0xff0da470),
    onPrimary: Color(0xff12d28a),
    onSecondary: Color(0xFFFC9926),
    onSecondaryContainer: Color(0xFFF3F9FF),
    outline: Color(0xff2C66B4),
    onTertiary: Color(0xFFE9F3FF),
  ),

  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);