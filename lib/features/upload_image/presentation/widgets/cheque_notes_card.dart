import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class ChequeNotesCard extends StatelessWidget {
  final String notes;
  const ChequeNotesCard({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: AppStrings.notesComments,
            color: AppColors.secondaryText,
            fontSize: 12,
          ),
          const SizedBox(height: 6),
          AppText(text: notes, color: AppColors.primaryText),
        ],
      ),
    );
  }
}
