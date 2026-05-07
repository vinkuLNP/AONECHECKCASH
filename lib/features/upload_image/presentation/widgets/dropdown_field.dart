import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppDropdownField<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final String Function(T item) labelBuilder;

  final ValueChanged<T?>? onChanged;

  const AppDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onChanged == null;
    return DropdownButtonFormField<T>(
      initialValue: value,

      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: AppText(
            text: labelBuilder(item),
            color: isDisabled
                ? AppColors.primary.withValues(alpha: 0.5)
                : AppColors.primary,
          ),
        );
      }).toList(),

      onChanged: onChanged,

      decoration: InputDecoration(
        filled: true,

        fillColor: isDisabled
            ? Colors.white.withValues(alpha: 0.5)
            : Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: AppColors.primary.withValues(alpha: .35),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: AppColors.primary.withValues(alpha: .35),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: AppColors.primary.withValues(alpha: .35),
          ),
        ),
      ),
    );
  }
}
