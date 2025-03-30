import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class MyStyle {
  static TextStyle title14(BuildContext context) {
    return GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle title16(BuildContext context) {
    return GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle title18(BuildContext context) {
    return GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle title20(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  static TextStyle title25(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 25,
      fontWeight: FontWeight.w900,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  static TextStyle title30(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 30,
      fontWeight: FontWeight.w900,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
