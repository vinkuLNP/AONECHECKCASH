import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppSectionTitle extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final bool isPadding;
  final double fontSize;
  final Color titleColor;

  const AppSectionTitle({
    super.key,
    required this.title,
    this.isPadding = true,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 12,
    this.titleColor = AppColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadding ? const EdgeInsets.only(bottom: 8) : EdgeInsets.zero,
      child: AppText(
        text: title,
        color: titleColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
