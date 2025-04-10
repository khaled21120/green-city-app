import 'package:flutter/material.dart';

abstract class MyColors {
  static const Color primary = Color(0xff4CAF50);
  static const Color primaryDark = Color(0xff1B5E20);
  static const Color primaryMid = Color(0xff2E7D32);
  static const Color scaffold = Color(0xffE8F5E9);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color darkGrey = Color(0xff343434);
  static const Color lightGrey = Color(0xffF5F5F5);
  static const Color grey = Color(0xffBEBEBE);
  static const Color accent = Color(0xff81D4FA);
  static const Color gradient1 = Color(0xff4CAF50);
  static const Color gradient2 = Color(0xff1E88E5);
  static const Color cardBG = Color(0xffF5F5F5);
  static const Color icons = Color(0xff81C784);
}

ThemeData lightThemeData = ThemeData(
  colorScheme: const ColorScheme(
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
    onSurface: MyColors.black,
    onError: MyColors.white,
    onTertiaryContainer: MyColors.white,
    brightness: Brightness.light,
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
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: MyColors.white,
    ),
    backgroundColor: MyColors.primary,
    elevation: 4,
    foregroundColor: MyColors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 3,
      side: const BorderSide(color: MyColors.black),
      backgroundColor: MyColors.primary,
      foregroundColor: MyColors.white,
      textStyle: const TextStyle(
        fontSize: 20,
        color: MyColors.white,
        fontWeight: FontWeight.w800,
      ),
    ),
  ),
);
