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
  static const Color cardBG = Color(0xFFF5FBF5);
  static const Color cardBorder = Color(0x1A2E7D32);
  static const Color icons = Color(0xFF388E3C);
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
      elevation: 2,
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
