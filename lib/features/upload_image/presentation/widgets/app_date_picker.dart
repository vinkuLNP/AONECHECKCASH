import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppDatePickerField extends StatelessWidget {
  final DateTime selectedDate;
  final bool enabled;
  final ValueChanged<DateTime> onDateSelected;

  const AppDatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !enabled
          ? null
          : () async {
              final picked = await showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                initialDate: selectedDate,
              );

              if (picked != null) {
                onDateSelected(picked);
              }
            },

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

        decoration: BoxDecoration(
          color: enabled ? Colors.white : Colors.white.withValues(alpha: 0.5),

          borderRadius: BorderRadius.circular(18),

          border: Border.all(color: AppColors.primary.withValues(alpha: .35)),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            AppText(
              text:
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",

              color: AppColors.primary,
              fontSize: 16,
            ),

            const Icon(Icons.calendar_month, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
