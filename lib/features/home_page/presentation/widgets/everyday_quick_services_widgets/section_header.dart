import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        AppText(
          text: AppStrings.moreEverydayServices,
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: AppColors.textDark,
        ),
        SizedBox(height: 8),
        AppText(
          text: AppStrings.everydayServicesSubtitle,
          fontSize: 16,
          height: 1.5,
          color: AppColors.textLight,
        ),
      ],
    );
  }
}
