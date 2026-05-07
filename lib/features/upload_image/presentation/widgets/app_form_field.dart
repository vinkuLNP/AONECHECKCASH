import 'package:a1_check_cashers/core/app_widgets/input_fields.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;

  final int? maxLength;

  const AppFormField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.maxLines,
    this.minLines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return AppInputField(
      label: label,
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      labelFontSize: 12,
      maxLines: maxLines,
      minLines: minLines,
      fillColor: Colors.white.withValues(alpha: readOnly ? 0.4 : 0.8),
      focusColor: Colors.white,
      borderColor: AppColors.primary.withValues(alpha: .35),
      labelColor: AppColors.primary,
      fillTextField: true,
      maxLength: maxLength,

    );
  }
}
