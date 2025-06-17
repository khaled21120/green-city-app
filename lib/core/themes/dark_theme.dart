import 'package:flutter/material.dart';

abstract class MyColors {
  static const Color primary = Color(0xff4CAF50);
  static const Color primaryDark = Color(0xff1B5E20);
  static const Color primaryMid = Color(0xff2E7D32);
  static const Color scaffold = Color(0xff121212); // Dark background
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color grey = Color(0xffBEBEBE);
  static const Color darkGrey = Color(0xff343434);
  static const Color accent = Color(0xff81D4FA);
  static const Color gradient1 = Color(0xff4CAF50);
  static const Color gradient2 = Color(0xff1E88E5);
  static const Color cardBG = Color(0xFF1E1E1E);
  static const Color cardBorder = Color(0xFF383838);
  static const Color icons = Color(0xFF00E676);
}

ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: MyColors.primary,
    primaryContainer: MyColors.primaryDark,
    secondary: MyColors.accent,
    secondaryContainer: MyColors.primaryMid,
    tertiary: MyColors.primaryMid,
    onTertiary: MyColors.grey,
    surface: MyColors.cardBG,
    error: Colors.red,
    onPrimary: MyColors.white,
    onSecondary: MyColors.black,
    onSurface: MyColors.white,
    onTertiaryContainer: MyColors.black,
    onError: MyColors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: MyColors.primary,
      foregroundColor: MyColors.white,
      textStyle: const TextStyle(
        fontSize: 20,
        color: MyColors.white,
        fontWeight: FontWeight.w800,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 3,
      side: const BorderSide(color: MyColors.white),
    ),
  ),
  dialogTheme: const DialogThemeData(backgroundColor: MyColors.primary),
  scaffoldBackgroundColor: MyColors.scaffold,
  cardTheme: CardThemeData(
    color: MyColors.cardBG,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: MyColors.cardBorder, width: 0.5),
    ),
  ),
  drawerTheme: const DrawerThemeData(backgroundColor: MyColors.cardBG),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: MyColors.white,
    ),
    backgroundColor: MyColors.primary,
    elevation: 4,
    foregroundColor: MyColors.white,
  ),
);
