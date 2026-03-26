import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';

class AutoServicesSection extends StatelessWidget {
  const AutoServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: AppStrings.a1Auto,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),

          const SizedBox(height: 10),

          AppText(
            text: AppStrings.autoTitle,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF111827),
          ),

          const SizedBox(height: 12),

          AppText(
            text: AppStrings.autoDescription,
            fontSize: 15,
            color: const Color(0xFF4B5563),
          ),

          const SizedBox(height: 20),

          Column(
            children: [
              AppButton(text: AppStrings.viewAutoServices, onPressed: () {}),

              const SizedBox(height: 12),

              AppButton(
                text: AppStrings.learnMore,
                isOutlined: true,
                borderColor: AppColors.primary,
                textColor: AppColors.primary,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
