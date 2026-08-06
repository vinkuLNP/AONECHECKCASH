import 'package:a1_check_cashers/core/app_widgets/input_fields.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppFormField extends StatelessWidget {
    final GlobalKey? fieldKey;
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;
  const AppFormField({
    super.key,
        this.fieldKey,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.validator,
    this.inputFormatters,
    this.focusNode,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: fieldKey,
      child: AppInputField(
        label: label,
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        
        labelFontSize: 12,
        maxLines: maxLines,
        focusNode: focusNode,
        autovalidateMode: autovalidateMode,
        minLines: minLines,
        fillColor: Colors.white.withValues(alpha: readOnly ? 0.4 : 0.8),
        borderColor: AppColors.primary.withValues(alpha: .35),
        labelColor: AppColors.black,
        fillTextField: true,
        maxLength: maxLength,
        validator: validator,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
