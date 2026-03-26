import 'package:a1_check_cashers/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double height;
  final FontStyle fontStyle;
  final TextDecoration? decoration;

  const AppText({
    super.key,
    required this.text,
    this.color,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.height = 1.5,
    this.fontStyle = FontStyle.normal,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: appTextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Theme.of(context).hintColor,
        height: height,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}