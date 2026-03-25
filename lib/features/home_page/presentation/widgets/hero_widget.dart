import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/input_fields.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final zipController = TextEditingController();
    return Container(
      color: AppColors.heroWidgetBackground,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            text: AppStrings.heroTitle,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 1.2,
            color: AppColors.primary,
          ),

          const SizedBox(height: 12),

          const AppText(
            text: AppStrings.heroSubtitle,
            fontSize: 15,
            height: 1.5,
            color: AppColors.textLight,
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                AppInputField(
                  label: "",
                  controller: zipController,
                  hint: AppStrings.enterZip,
                  isDense: true,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 14),

                AppButton(
                  text: AppStrings.findStore,
                  icon: const Icon(Icons.location_on, color: Colors.white),
                  onPressed: () {},
                ),

                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Icon(Icons.near_me, size: 18, color: AppColors.primary),
                      SizedBox(width: 6),
                      AppText(
                        text: AppStrings.useMyLocation,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          AppButton(
            text: AppStrings.getDirections,
            isOutlined: true,
            borderColor: AppColors.primary,
            textColor: AppColors.primary,
            outlinedColor: AppColors.heroWidgetBackground,
            icon: const Icon(Icons.location_on, color: AppColors.primary),
          ),
          const SizedBox(height: 12),

          AppButton(
            text: AppStrings.callNow,
            isOutlined: true,
            outlinedColor: AppColors.heroWidgetBackground,
            borderColor: AppColors.primary,
            icon: const Icon(Icons.phone, color: AppColors.primary),
          ),
          const SizedBox(height: 18),

          const Center(
            child: AppText(
              text: AppStrings.tagline,
              fontSize: 13,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
