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
      color: AppColors.heroColor,
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

          Row(
            children: [
              Flexible(
                flex: 2,
                child: AppInputField(
                  label: "",
                  fillColor: AppColors.whiteColor.withValues(alpha: 0.7),
                  borderColor: AppColors.whiteColor.withValues(alpha: 0.7),
                  focusColor: AppColors.whiteColor.withValues(alpha: 0.7),
                  controller: zipController,
                  hint: AppStrings.enterZip,
                  isDense: true,
                  keyboardType: TextInputType.number,
                ),
              ),

              const SizedBox(width: 10),

              Flexible(
                flex: 1,
                child: AppButton(text: AppStrings.findStore, onPressed: () {}),
              ),
            ],
          ),
          const SizedBox(height: 6),

          GestureDetector(
            onTap: () {},
            child: const Row(
              children: [
                Icon(Icons.location_on, size: 16, color: AppColors.primary),
                SizedBox(width: 6),
                AppText(
                  text: AppStrings.useMyLocation,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                  fontSize: 13,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: AppStrings.getDirections,
                  isOutlined: true,
                  borderColor: AppColors.primary,
                  textColor: AppColors.whiteColor,
                  outlinedColor: AppColors.primary,
                  icon: const Icon(
                    Icons.location_on,
                    color: AppColors.whiteColor,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppButton(
                  text: AppStrings.callNow,
                  isOutlined: true,
                  textColor: AppColors.whiteColor,
                  outlinedColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  icon: const Icon(
                    Icons.phone,
                    color: AppColors.whiteColor,
                    size: 18,
                  ),
                ),
              ),
            ],
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
