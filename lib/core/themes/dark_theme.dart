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
  static const Color cardBG = Color(0xff1E1E1E);
  static const Color icons = Color(0xff81C784);
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
    error: Colors.redAccent,
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
  dialogTheme: const DialogTheme(backgroundColor: MyColors.primary),
  scaffoldBackgroundColor: MyColors.scaffold,
  cardTheme: CardTheme(
    color: MyColors.cardBG,
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  drawerTheme: const DrawerThemeData(backgroundColor: MyColors.scaffold),
  appBarTheme: const AppBarTheme(
    // titleTextStyle: MyStyle.title20(context),
    backgroundColor: MyColors.primary,
    elevation: 4,
    foregroundColor: MyColors.white,
  ),
);
