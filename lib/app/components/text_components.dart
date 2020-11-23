import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextComponents {
  static textWithGoogleFont({text, color, fontSize}) {
    return Text(text,
        style: GoogleFonts.overpass(
            fontWeight: FontWeight.w600, fontSize: fontSize, color: color));
  }
}
