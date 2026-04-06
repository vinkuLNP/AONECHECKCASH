import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusColor;
  final String? hint;
  final int? maxLength;
  final int? maxLines;
  final FocusNode? focusNode;
  final VoidCallback? onTap;

  final AutovalidateMode? autovalidateMode;

  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final bool isDense;
  const AppInputField({
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters = const [],
    this.onChanged,
    this.hint,
    this.maxLength,
    this.onTap,
    this.focusNode,
    this.autovalidateMode,
    this.maxLines,
    super.key,
    this.onFieldSubmitted,
    this.isDense = false,
    this.readOnly = false,
    this.fillColor,
    this.borderColor,
    this.focusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isDense) ...[
          AppText(text: label, fontWeight: FontWeight.w400, fontSize: 14),
          const SizedBox(height: 8),
        ],
        TextFormField(
          focusNode: focusNode,
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          autovalidateMode: autovalidateMode,
          controller: controller,
          style: appTextStyle(
            fontSize: isDense ? 14 : 12,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          keyboardType: keyboardType,
          readOnly: readOnly,
          maxLength: maxLength,
          maxLines: maxLength != null ? 1 : maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            counterText: '',
            hintText: hint,
            filled: isDense || readOnly,
            fillColor:
                fillColor ??
                (isDense
                    ? Colors.white
                    : readOnly
                    ? Theme.of(context).highlightColor.withValues(alpha: 0.4)
                    : Theme.of(context).hintColor),
            errorStyle: appTextStyle(fontSize: 12, color: AppColors.primary),
            hintStyle: appTextStyle(
              fontSize: 13,
              color: const Color(0xFF9CA3AF),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color:
                    borderColor ??
                    (isDense ? const Color(0xFFE5E7EB) : Colors.grey),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: focusColor ?? AppColors.authThemeColor,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: isDense
                  ? 16
                  : maxLines != null
                  ? 4
                  : 0,
            ),
          ),

          validator: validator,
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }
}

class AppPasswordField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback? onTap;
  final Function(String?)? onFieldSubmitted;
  final int? maxLength;
  final int? maxLines;
  final AutovalidateMode? autovalidateMode;
  final VoidCallback onToggle;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  const AppPasswordField({
    required this.label,
    required this.controller,
    required this.obscure,
    required this.onToggle,
    this.validator,
    this.maxLength,
    this.maxLines,
    this.autovalidateMode,
    this.focusNode,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: label, fontWeight: FontWeight.w400, fontSize: 14),

        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          onTap: onTap,
          maxLength: maxLength,
          maxLines: maxLength != null ? 1 : maxLines,
          autovalidateMode: autovalidateMode,
          onChanged: onChanged,
          style: appTextStyle(fontSize: 12),
          decoration: InputDecoration(
            counterText: '',
            filled: false,
            hintText: '******',
            hintStyle: appTextStyle(fontSize: 12, color: Colors.grey),
            errorStyle: appTextStyle(fontSize: 12, color: AppColors.primary),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.authThemeColor, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 0,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withValues(alpha: 0.6)
                    : Colors.black.withValues(alpha: 0.6),
              ),
              onPressed: onToggle,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
