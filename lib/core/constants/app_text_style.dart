import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

TextStyle appTextStyle({
  double? fontSize,
  Color? color,
  FontWeight fontWeight = FontWeight.normal,
  FontStyle fontStyle = FontStyle.normal,
  TextDecoration? decoration,
  Color? decorationColor,
  double height = 1.4,
}) {
  return GoogleFonts.poppins(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    height: height,
    decoration: decoration,
    decorationColor: decorationColor,
  );
}
